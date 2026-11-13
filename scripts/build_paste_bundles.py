#!/usr/bin/env python3
"""Build the round bundles in scripts/gov/paste from scripts/paste_bundles.json.

A bundle is one PowerShell text (Windows PowerShell 5.1) that the PFM copies from its raw page, pastes into
Windows PowerShell ISE and runs with F5 (ISSM approved paste and run in writing, PFM 2026-11-12). It is a
bootstrapper for fast test rounds (PFM 1A, 6A: function over form):
  1. asks for the DODID (window field, or Read-Host in text mode; empty = profile folder);
  2. makes each task folder under C:\\Users\\<DODID>\\OneDrive - United States Air Force\\90-161.Z if missing and
     writes every file (text: same content as UTF-8 with BOM and CRLF; binary: byte-exact from base64);
  3. runs the steps one by one (each a runner file, as a child powershell.exe with -Id and -NoPause), with a live
     log, DODID masked, and PASS/FAIL counts per step;
  4. writes Rounds\\90161Z-<round>-results-r1.zip (the collect files + summary) and offers the summary for the
     clipboard.
It runs only the steps embedded in it and never fetches code (PFM 3A). If no window can open (no Windows Forms),
it runs the same steps as text.
Text files are embedded as readable single-quoted here-strings, so the PFM and the ISSM can read the code.
The build id (first 8 hex of the sha256 of the bundle body) shows in the window title and the summary.
Usage: python3 scripts/build_paste_bundles.py [--check]   (--check: exit 1 if a bundle is out of date)
"""
import base64, hashlib, json, sys, textwrap
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TEXT = {'.ps1', '.json', '.txt', '.md', '.csv'}


def here(text):
    text = text.replace('\r\n', '\n')
    if text.endswith('\n'):
        text = text[:-1]
    for line in text.split('\n'):
        if line.startswith("'@"):
            raise SystemExit("cannot embed: a line starts with '@")
    if any(ord(c) > 127 for c in text):
        raise SystemExit('cannot embed: non-ASCII text (keep sources ASCII)')
    return "@'\n" + text + "\n'@"


def q(s):
    return "'" + s.replace("'", "''") + "'"


ENGINE = r'''
# ---------------- round runner (generated; same engine in every round bundle) ----------------
function Get-Secret([string]$Id, [string]$Leaf) {
  @($Id, $Leaf, $env:USERNAME) | Where-Object { $_ -and $_.Length -ge 4 } | Sort-Object -Unique | Sort-Object Length -Descending
}
function ConvertTo-Masked([string]$Text) {
  foreach ($x in $script:secret) { $Text = $Text -replace [regex]::Escape($x), '<DODID>' }
  return $Text
}
function Resolve-Base([string]$Typed) {
  $leaf = ''
  if ($env:USERPROFILE) { $leaf = Split-Path -Leaf $env:USERPROFILE }
  $id = ([string]$Typed).Trim()
  if (-not $id) { $id = $leaf }
  $script:secret = Get-Secret $id $leaf
  if ($id -notmatch '^[A-Za-z0-9._-]{4,}$') { throw 'DODID not valid: use the folder name under C:\Users (4 or more letters, digits, dot, dash or underscore).' }
  $oneDrive = Join-Path (Join-Path $usersRoot $id) 'OneDrive - United States Air Force'
  if (-not (Test-Path -LiteralPath $oneDrive -PathType Container)) { throw 'FOLDER not found: C:\Users\<DODID>\OneDrive - United States Air Force. Check the DODID.' }
  $script:dodid = $id
  return (Join-Path $oneDrive '90-161.Z')
}
function Write-BundleFile([string]$Base, [scriptblock]$Say) {
  $utf8Bom = New-Object System.Text.UTF8Encoding $true
  foreach ($f in $files) {
    $dir = Join-Path $Base $f.Dir
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
    $path = Join-Path $dir $f.Name
    if ($f.Kind -eq 'text') { [System.IO.File]::WriteAllText($path, (($f.Data -replace "`r?`n", "`r`n") + "`r`n"), $utf8Bom) }
    else { [System.IO.File]::WriteAllBytes($path, [System.Convert]::FromBase64String(($f.Data -replace '\s', ''))) }
    & $Say ('WROTE ' + $f.Dir + '\' + $f.Name + ' src-sha256=' + $f.Sha)
  }
}
function Invoke-RoundStep([string]$Base, $Step, [scriptblock]$Say, [scriptblock]$Tick) {
  $exe = 'powershell.exe'
  if (-not (Get-Command $exe -ErrorAction SilentlyContinue)) { $exe = 'pwsh' }
  $dir = Join-Path $Base $Step.Dir
  $psi = New-Object System.Diagnostics.ProcessStartInfo
  $psi.FileName = $exe
  $psi.Arguments = '-NoProfile -ExecutionPolicy Bypass -File "' + (Join-Path $dir $Step.File) + '" -Id "' + $script:dodid + '" -NoPause'
  $psi.WorkingDirectory = $dir
  $psi.UseShellExecute = $false; $psi.CreateNoWindow = $true
  $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError = $true
  $r = @{ Pass = 0; Fail = 0; Exit = $null }
  $p = [System.Diagnostics.Process]::Start($psi)
  $script:child = $p
  $deadline = (Get-Date).AddMinutes($stepMinutes)
  $errTask = $p.StandardError.ReadToEndAsync()
  $lineTask = $p.StandardOutput.ReadLineAsync()
  while ($true) {
    while (-not $lineTask.Wait(150)) {
      & $Tick
      if ((Get-Date) -gt $deadline) { try { $p.Kill() } catch { $null = $_ }; $r.Fail++; & $Say ('STOPPED: step took more than ' + $stepMinutes + ' minutes; ended it'); break }
    }
    if (-not $lineTask.IsCompleted) { break }
    $line = $lineTask.Result
    if ($null -eq $line) { break }
    $line = ConvertTo-Masked $line
    if ($line -match '(^|\s)PASS(\s|$)') { $r.Pass++ }
    if ($line -match '(^|\s)(FAIL|FORMAT-FAIL|RENDER-ERROR|MEASURE-ERROR|STOPPED:)(\s|$)') { $r.Fail++ }
    & $Say $line
    $lineTask = $p.StandardOutput.ReadLineAsync()
  }
  $p.WaitForExit()
  $script:child = $null
  foreach ($e in @(([string]$errTask.Result) -split "`r?`n" | Where-Object { $_ })) { $r.Fail++; & $Say ('ERR ' + (ConvertTo-Masked $e)) }
  $r.Exit = $p.ExitCode
  return $r
}
function Get-StepLine($Step, $R) {
  $state = 'OK'
  if ($R.Fail -gt 0 -or $R.Exit -ne 0) { $state = 'CHECK' }
  return ($Step.Name + ': ' + $state + ' (PASS ' + $R.Pass + ', FAIL ' + $R.Fail + ', exit ' + $R.Exit + ')')
}
function Export-RoundZip([string]$Base, [string[]]$Summary) {
  $out = Join-Path $Base 'Rounds'
  if (-not (Test-Path -LiteralPath $out -PathType Container)) { [void](New-Item -ItemType Directory -Path $out -Force) }
  $sumPath = Join-Path $out ('90161Z-' + $round + '-summary-r1.txt')
  [System.IO.File]::WriteAllText($sumPath, (($Summary -join "`r`n") + "`r`n"), (New-Object System.Text.UTF8Encoding $true))
  $have = New-Object System.Collections.Generic.List[string]
  $have.Add($sumPath)
  $missing = @()
  foreach ($c in $collect) {
    $p = Join-Path (Join-Path $Base $c.Dir) $c.Name
    if (Test-Path -LiteralPath $p -PathType Leaf) { $have.Add($p) } else { $missing += ($c.Dir + '\' + $c.Name) }
  }
  $zip = Join-Path $out ('90161Z-' + $round + '-results-r1.zip')
  Compress-Archive -LiteralPath $have.ToArray() -DestinationPath $zip -Force
  return @{ Zip = $zip; Count = $have.Count; Missing = $missing }
}
function Get-RoundPlan([string]$Typed) {
  # What this round writes, before it runs (PFM 13 Nov: show the impact). Shows <DODID>, never the number.
  $leaf = ''
  if ($env:USERPROFILE) { $leaf = Split-Path -Leaf $env:USERPROFILE }
  $id = ([string]$Typed).Trim(); $who = '<DODID you typed>'
  if (-not $id) { $id = $leaf; $who = '<your profile folder>' }
  $base = Join-Path (Join-Path (Join-Path $usersRoot $id) 'OneDrive - United States Air Force') '90-161.Z'
  $shown = $usersRoot + '\' + $who + '\OneDrive - United States Air Force\90-161.Z'
  $found = Test-Path -LiteralPath (Split-Path -Parent $base) -PathType Container
  $lines = @('WRITES TO ' + $shown + $(if ($found) { '' } else { '   (OneDrive folder NOT found: check the DODID)' }))
  foreach ($f in $files) {
    $p = Join-Path (Join-Path $base $f.Dir) $f.Name
    $lines += ('  ' + $f.Dir + '\' + $f.Name + $(if (Test-Path -LiteralPath $p -PathType Leaf) { '   (replaces the file there)' } else { '   (new)' }))
  }
  $lines += ('  Rounds\90161Z-' + $round + '-results-r1.zip and -summary-r1.txt   (results)')
  $lines += 'Folders are made when missing. Files of the same name are replaced. Nothing else is changed, moved or deleted.'
  $lines += 'Steps then write their own results and PDFs into these task folders.'
  return @{ Shown = $shown; Found = $found; Lines = $lines }
}
function Invoke-Round([string]$Typed, [bool[]]$Selected, [scriptblock]$Say, [scriptblock]$Tick, [scriptblock]$OnStep) {
  $base = Resolve-Base $Typed
  & $Say ('ROUND ' + $round + ' build ' + $buildId + ' -> ' + (ConvertTo-Masked $base))
  Write-BundleFile $base $Say
  $summary = @('ROUND ' + $round + ' build ' + $buildId + ' ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
  for ($k = 0; $k -lt $steps.Count; $k++) {
    if (-not $Selected[$k]) { $summary += ($steps[$k].Name + ': skipped'); continue }
    & $Say ('STEP ' + $steps[$k].Name + ' running (Word steps can take minutes)...')
    $r = Invoke-RoundStep $base $steps[$k] $Say $Tick
    $line = Get-StepLine $steps[$k] $r
    $summary += $line
    & $Say $line
    & $OnStep $k $line
  }
  $z = Export-RoundZip $base $summary
  $summary += ('ZIP ' + (Split-Path -Leaf $z.Zip) + ' files=' + $z.Count + ' missing=' + @($z.Missing).Count + $(if (@($z.Missing).Count) { ' (' + ($z.Missing -join ', ') + ')' } else { '' }))
  [void](Export-RoundZip $base $summary)   # rewrite so the summary inside the zip has the ZIP line
  & $Say $summary[-1]
  & $Say ('Saved in ' + (ConvertTo-Masked (Split-Path -Parent $z.Zip)) + '. E-mail the zip.')
  return ,$summary
}

$script:secret = @(); $script:dodid = ''; $script:child = $null; $stepMinutes = 30
$gui = $true
try { Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing } catch { $gui = $false }
if ($gui) {
  try {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = '90-161.Z runner - ' + $round + ' - build ' + $buildId
    $form.Size = New-Object System.Drawing.Size(860, 640)
    $form.StartPosition = 'CenterScreen'
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Text = 'DODID (empty = profile folder):'; $lbl.Location = New-Object System.Drawing.Point(10, 14); $lbl.AutoSize = $true
    $idBox = New-Object System.Windows.Forms.TextBox
    $idBox.Location = New-Object System.Drawing.Point(200, 10); $idBox.Width = 200; $idBox.UseSystemPasswordChar = $true
    $where = New-Object System.Windows.Forms.Label
    $where.Location = New-Object System.Drawing.Point(10, 42); $where.Size = New-Object System.Drawing.Size(820, 20)
    $list = New-Object System.Windows.Forms.CheckedListBox
    $list.Location = New-Object System.Drawing.Point(10, 68); $list.Size = New-Object System.Drawing.Size(820, 90); $list.CheckOnClick = $true
    foreach ($s in $steps) { [void]$list.Items.Add($s.Name, $true) }
    $log = New-Object System.Windows.Forms.TextBox
    $log.Location = New-Object System.Drawing.Point(10, 168); $log.Size = New-Object System.Drawing.Size(820, 376)
    $log.Multiline = $true; $log.ScrollBars = 'Both'; $log.WordWrap = $false; $log.ReadOnly = $true
    $log.Font = New-Object System.Drawing.Font('Consolas', 9)
    $run = New-Object System.Windows.Forms.Button
    $run.Text = 'Run'; $run.Location = New-Object System.Drawing.Point(10, 556); $run.Width = 120
    $copy = New-Object System.Windows.Forms.Button
    $copy.Text = 'Copy summary'; $copy.Location = New-Object System.Drawing.Point(140, 556); $copy.Width = 120; $copy.Enabled = $false
    $form.Controls.AddRange(@($lbl, $idBox, $where, $list, $log, $run, $copy))
    $showPlan = { $plan = Get-RoundPlan $idBox.Text; $where.Text = 'Writes to: ' + $plan.Shown + $(if ($plan.Found) { '' } else { '   (NOT found: check the DODID)' }); $plan }
    $idBox.Add_TextChanged({ [void](& $showPlan) })
    $first = & $showPlan
    $log.Text = (($first.Lines + @('', 'Press Run to start. Uncheck a step to skip it.')) -join "`r`n") + "`r`n"

    $script:lastSummary = @()
    $say = { param($t) try { $log.AppendText($t + "`r`n"); [System.Windows.Forms.Application]::DoEvents() } catch { Write-Host $t } }
    $tick = { [System.Windows.Forms.Application]::DoEvents() }
    $onStep = { param($k, $line) $list.Items[$k] = $line; $list.SetItemChecked($k, $true) }
    $run.Add_Click({
      $run.Enabled = $false; $copy.Enabled = $false
      $sel = @(); for ($k = 0; $k -lt $steps.Count; $k++) { $sel += $list.GetItemChecked($k) }
      try { $script:lastSummary = Invoke-Round $idBox.Text $sel $say $tick $onStep; $copy.Enabled = $true }
      catch { & $say ('STOPPED: ' + (ConvertTo-Masked ([string]$_))) }
      $run.Enabled = $true
    })
    $copy.Add_Click({
      try { [System.Windows.Forms.Clipboard]::SetText(($script:lastSummary -join "`r`n")); & $say 'Summary copied. Paste it into the e-mail body.' }
      catch { & $say ('Clipboard busy; press Copy summary again. (' + $_.Exception.Message + ')') }
    })
    $form.Add_FormClosing({ if ($script:child -and -not $script:child.HasExited) { try { $script:child.Kill() } catch { $null = $_ } } })
    [void]$form.ShowDialog()
    return
  } catch { $gui = $false; Write-Host ('No window (' + $_.Exception.Message + '); text mode.') }
}
try {
  $say = { param($t) Write-Host $t }
  $typed = [string](Read-Host 'DODID (press Enter to use this computer''s profile folder)')
  foreach ($l in (Get-RoundPlan $typed).Lines) { Write-Host $l }
  $sel = @(); foreach ($s in $steps) { $sel += $true }
  $sum = Invoke-Round $typed $sel $say { } { }
  if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) { try { Set-Clipboard -Value ($sum -join "`r`n"); Write-Host 'Summary copied to the clipboard.' } catch { Write-Host 'Clipboard not available.' } }
} catch {
  Write-Host ''
  Write-Host ('STOPPED: ' + (ConvertTo-Masked ([string]$_)))
}
'''


def build(b):
    parts = []
    for f in b['files']:
        src = ROOT / f['src']
        data = src.read_bytes()
        sha = hashlib.sha256(data).hexdigest()[:12]
        if src.suffix.lower() in TEXT:
            body, kind = here(data.decode('ascii')), 'text'
        else:
            b64 = base64.b64encode(data).decode('ascii')
            body, kind = "@'\n" + '\n'.join(textwrap.wrap(b64, 100)) + "\n'@", 'base64'
        parts.append("$files += @{ Dir = %s; Name = %s; Kind = '%s'; Sha = '%s'; Data = %s }"
                     % (q(f['dir']), q(src.name), kind, sha, body))
    steps = ['$steps += @{ Name = %s; Dir = %s; File = %s }' % (q(s['name']), q(s['dir']), q(s['file'])) for s in b['steps']]
    for s in b['steps']:
        assert any(f['dir'] == s['dir'] and Path(f['src']).name == s['file'] for f in b['files']), s
    collect = ['$collect += @{ Dir = %s; Name = %s }' % (q(c['dir']), q(c['name'])) for c in b['collect']]
    body = ('$round = %s\n$usersRoot = \'C:\\Users\'\n$files = @()\n%s\n$steps = @()\n%s\n$collect = @()\n%s\n%s'
            % (q(b['round']), '\n'.join(parts), '\n'.join(steps), '\n'.join(collect), ENGINE))
    build_id = hashlib.sha256(body.encode('ascii')).hexdigest()[:8]
    head = ('<#\n  90-161.Z round bundle: %s.\n'
            '  GENERATED by scripts/build_paste_bundles.py from scripts/paste_bundles.json; do not edit.\n'
            '  How to run: open Windows PowerShell ISE, File > New, paste all of this text into the script pane, press F5.\n'
            '  A window opens: DODID (empty = profile folder), Run. It writes the files below into the task folders under\n'
            '  C:\\Users\\<DODID>\\OneDrive - United States Air Force\\90-161.Z (replacing older copies), runs the steps,\n'
            '  and saves Rounds\\90161Z-%s-results-r1.zip. No download, no admin rights, nothing outside that folder.\n'
            '#>\n$buildId = \'%s\'\n' % (b['title'], b['round'], build_id))
    return head + body


def main():
    check = '--check' in sys.argv
    m = json.loads((ROOT / 'scripts/paste_bundles.json').read_text())
    stale = 0
    for b in m['bundles']:
        out = ROOT / b['out']
        text = build(b)
        if check:
            if not out.exists() or out.read_bytes() != text.encode('ascii'):
                print('STALE ' + b['out']); stale += 1
            continue
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_bytes(text.encode('ascii'))
        print('BUILT %s bytes=%d files=%d steps=%d' % (b['out'], len(text), len(b['files']), len(b['steps'])))
    if check:
        print('PASTE bundles=%d stale=%d' % (len(m['bundles']), stale))
        sys.exit(1 if stale else 0)


if __name__ == '__main__':
    main()
