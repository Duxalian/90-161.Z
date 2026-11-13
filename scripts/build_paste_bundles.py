#!/usr/bin/env python3
"""Build the round bundles in scripts/gov/paste from scripts/paste_bundles.json.

A bundle is one PowerShell text (Windows PowerShell 5.1) that the PFM copies from its raw page, pastes into
Windows PowerShell ISE and runs with F5 (ISSM approved paste and run in writing, PFM 2026-11-12). It is a
bootstrapper for fast test rounds (PFM 1A, 6A: function over form):
  1. uses the Windows profile folder as the DODID (no question: PFM 13 Nov, the empty-box default worked);
  2. makes each task folder under C:\\Users\\<DODID>\\OneDrive - United States Air Force\\90-161.Z if missing and
     writes every file (text: same content as UTF-8 with BOM and CRLF; binary: byte-exact from base64);
  3. runs the steps one by one (each a runner file, as a child powershell.exe with -Id and -NoPause), with a live
     log, DODID masked, and PASS/FAIL counts per step;
  4. writes a results folder Rounds\\<round> with one report file (summary + full masked log) and copies of the
     collect files (PDFs), ready to attach to one e-mail (no zip: zips do not cross the boundary, PFM 13 Nov);
  5. makes an Outlook draft (classic Outlook, COM): subject = summary line 1, body = the rest, every results file
     attached, To empty, never sent (R05, PFM 13 Nov). If no draft can be made, it opens the results folder and puts
     the summary on the clipboard instead (R04 behavior).
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
  if (-not (Test-Path -LiteralPath $oneDrive -PathType Container)) { throw 'FOLDER not found: C:\Users\<profile folder>\OneDrive - United States Air Force. OneDrive is not set up in this Windows profile.' }
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
function Add-RunLog([string]$T) { if ($null -ne $script:runLog) { $script:runLog.Add($T) } }
function Export-RoundResult([string]$Base, [string[]]$Summary) {
  # One folder of plain files to attach to one e-mail (zips do not cross the boundary, PFM 13 Nov).
  $out = Join-Path (Join-Path $Base 'Rounds') $round
  if (-not (Test-Path -LiteralPath $out -PathType Container)) { [void](New-Item -ItemType Directory -Path $out -Force) }
  $count = 1; $missing = @()
  foreach ($c in $collect) {
    $old = Join-Path $out $c.Name
    if (Test-Path -LiteralPath $old -PathType Leaf) { Remove-Item -LiteralPath $old -Force }   # an older copy of the same name must not be sent again
    $p = Join-Path (Join-Path $Base $c.Dir) $c.Name
    if (Test-Path -LiteralPath $p -PathType Leaf) { Copy-Item -LiteralPath $p -Destination (Join-Path $out $c.Name) -Force; $count++ } else { $missing += ($c.Dir + '\' + $c.Name) }
  }
  $report = Join-Path $out ('90161Z-' + $round + '-report-r1.txt')
  $body = @($Summary) + @('', '---------------- full log ----------------') + @($script:runLog)
  [System.IO.File]::WriteAllText($report, (($body -join "`r`n") + "`r`n"), (New-Object System.Text.UTF8Encoding $true))
  return @{ Dir = $out; Count = $count; Missing = $missing }
}
function Get-RoundPlan([string]$Typed) {
  # What this round writes, before it runs (PFM 13 Nov: show the impact). Shows <DODID>, never the number.
  $leaf = ''
  if ($env:USERPROFILE) { $leaf = Split-Path -Leaf $env:USERPROFILE }
  $id = ([string]$Typed).Trim(); $who = '<DODID you typed>'
  if (-not $id) { $id = $leaf; $who = '<your profile folder>' }
  if (-not $id) { $id = 'no-profile-folder' }   # USERPROFILE unset: the plan says NOT found instead of failing
  $base = Join-Path (Join-Path (Join-Path $usersRoot $id) 'OneDrive - United States Air Force') '90-161.Z'
  $shown = $usersRoot + '\' + $who + '\OneDrive - United States Air Force\90-161.Z'
  $found = Test-Path -LiteralPath (Split-Path -Parent $base) -PathType Container
  $lines = @('WRITES TO ' + $shown + $(if ($found) { '' } else { '   (OneDrive folder NOT found in this Windows profile)' }))
  foreach ($f in $files) {
    $p = Join-Path (Join-Path $base $f.Dir) $f.Name
    $lines += ('  ' + $f.Dir + '\' + $f.Name + $(if (Test-Path -LiteralPath $p -PathType Leaf) { '   (replaces the file there)' } else { '   (new)' }))
  }
  $lines += ('  Rounds\' + $round + '\   (results folder: one report file + copies of the PDFs, to attach to one e-mail)')
  $lines += 'Folders are made when missing. Files of the same name are replaced. Nothing else is changed, moved or deleted.'
  $lines += 'Steps then write their own results and PDFs into these task folders.'
  return @{ Shown = $shown; Found = $found; Lines = $lines }
}
function Save-RoundDraft([string]$Dir, [string[]]$Summary) {
  # R05 (PFM 13 Nov): one Outlook draft with subject, body and every results file. To stays empty. Never sent:
  # this code has no Send call (tests/run.sh checks). Classic Outlook only (new Outlook has no COM): else fall back.
  if ($env:OS -ne 'Windows_NT') { return 'not Windows' }
  try {
    $ol = New-Object -ComObject Outlook.Application
    $m = $ol.CreateItem(0)
    $m.Subject = $Summary[0]
    $m.Body = ((@($Summary | Select-Object -Skip 1) + @('', 'Window: ')) -join "`r`n")
    foreach ($f in @(Get-ChildItem -LiteralPath $Dir -File)) { [void]$m.Attachments.Add($f.FullName) }
    $m.Display()   # first: if it fails, nothing is left in Drafts
    $m.Save()
    return ''
  } catch { return (ConvertTo-Masked $_.Exception.Message) }
}
function Invoke-Round([string]$Typed, [bool[]]$Selected, [scriptblock]$Say, [scriptblock]$Tick, [scriptblock]$OnStep) {
  $script:runLog = New-Object System.Collections.Generic.List[string]
  $base = Resolve-Base $Typed
  # Line 1 is the e-mail subject (PFM 13 Nov): paste the summary into the body, then cut line 1 into the subject.
  $summary = @(('90161Z ' + $round), ('ROUND ' + $round + ' build ' + $buildId + ' ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')))
  try {
  & $Say ('ROUND ' + $round + ' build ' + $buildId + ' -> ' + (ConvertTo-Masked $base))
  Write-BundleFile $base $Say
  for ($k = 0; $k -lt $steps.Count; $k++) {
    if (-not $Selected[$k]) { $summary += ($steps[$k].Name + ': skipped'); continue }
    & $Say ('STEP ' + $steps[$k].Name + ' running (Word steps can take minutes)...')
    $r = Invoke-RoundStep $base $steps[$k] $Say $Tick
    $line = Get-StepLine $steps[$k] $r
    $summary += $line
    & $Say $line
    & $OnStep $k $line
  }
  } catch {
    # A run that stops midway still leaves a report to send (summary so far + the log up to the stop).
    $summary += ('STOPPED: ' + (ConvertTo-Masked ([string]$_)))
    [void](Export-RoundResult $base $summary)
    throw
  }
  $z = Export-RoundResult $base $summary
  $summary += ('RESULTS Rounds\' + $round + ' files=' + $z.Count + ' missing=' + @($z.Missing).Count + $(if (@($z.Missing).Count) { ' (' + ($z.Missing -join ', ') + ')' } else { '' }))
  & $Say $summary[-1]
  [void](Export-RoundResult $base $summary)   # rewrite so the report holds the RESULTS line
  $script:resultsDir = $z.Dir
  & $Say ''
  if (@($summary | Where-Object { $_ -match ': CHECK \(' }).Count -gt 0 -or @($z.Missing).Count -gt 0) {
    & $Say 'NOTE: some steps say CHECK or files are missing (see RESULTS above). Send the results anyway; they show what went wrong.'
  }
  # Both modes end the same way (PFM 13 Nov: fewest steps). R05: an Outlook draft with everything in it;
  # if Outlook cannot make one, the folder opens and the summary is on the clipboard (R04 behavior).
  $why = Save-RoundDraft $z.Dir $summary
  $script:draftMade = (-not $why)
  if ($script:draftMade) {
    & $Say ('DONE. An Outlook draft is open: subject 90161Z ' + $round + ', the summary and all ' + $z.Count + ' files are in it. To is empty.')
    & $Say 'In the draft: change the "Window:" line if anything overlapped, type the To address, then Send.'
  } else {
    & $Say ('Outlook draft not made (' + $why + ').')
    & $Say ('DONE. The results folder Rounds\' + $round + ' opens now and the summary is on the clipboard.')
    & $Say ('New e-mail: paste into the body, cut the first line (90161Z ' + $round + ') into the subject, attach all ' + $z.Count + ' files in the folder.')
  }
  return ,$summary
}

$script:secret = @(); $script:dodid = ''; $script:child = $null; $script:runLog = $null; $script:resultsDir = ''; $script:draftMade = $false; $script:textMode = $false; $stepMinutes = 30
$gui = $true
try { Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing } catch { $gui = $false }
if ($gui) {
  try {
    # Layout follows the font and screen scaling (R02: in ISE, which is DPI-aware, fixed pixel positions overlapped):
    # one column of rows, each control on its own row; the log takes the spare height.
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $form = New-Object System.Windows.Forms.Form
    $form.Text = '90-161.Z runner - ' + $round + ' - build ' + $buildId
    $form.SuspendLayout()
    $form.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96); $form.AutoScaleMode = 'Dpi'   # sizes below are at 100 % scaling
    $form.Font = New-Object System.Drawing.Font('Segoe UI', 9)
    $form.ClientSize = New-Object System.Drawing.Size(900, 640); $form.MinimumSize = New-Object System.Drawing.Size(640, 480)
    $form.StartPosition = 'CenterScreen'
    $grid = New-Object System.Windows.Forms.TableLayoutPanel
    $grid.Dock = 'Fill'; $grid.Padding = New-Object System.Windows.Forms.Padding(10); $grid.ColumnCount = 1; $grid.RowCount = 4
    [void]$grid.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle('Percent', 100)))
    foreach ($h in 'AutoSize', 'AutoSize', 'Percent', 'AutoSize') { [void]$grid.RowStyles.Add((New-Object System.Windows.Forms.RowStyle($h, 100))) }
    $where = New-Object System.Windows.Forms.Label
    $where.AutoSize = $false; $where.Dock = 'Fill'; $where.AutoEllipsis = $true; $where.Height = ($where.Font.Height * 2) + 4; $where.Margin = New-Object System.Windows.Forms.Padding(3, 6, 3, 6)
    $list = New-Object System.Windows.Forms.CheckedListBox
    $list.Anchor = 'Left, Right'; $list.CheckOnClick = $true; $list.IntegralHeight = $false
    foreach ($s in $steps) { [void]$list.Items.Add($s.Name, $true) }
    $list.Height = ($list.ItemHeight * [math]::Max(3, $steps.Count + 1)) + 6
    $log = New-Object System.Windows.Forms.TextBox
    $log.Dock = 'Fill'; $log.Multiline = $true; $log.ScrollBars = 'Both'; $log.WordWrap = $false; $log.ReadOnly = $true
    $log.Font = New-Object System.Drawing.Font('Consolas', 9)
    $buttons = New-Object System.Windows.Forms.FlowLayoutPanel
    $buttons.AutoSize = $true; $buttons.WrapContents = $true; $buttons.Dock = 'Fill'
    $run = New-Object System.Windows.Forms.Button
    $run.Text = 'Run'; $run.AutoSize = $true; $run.MinimumSize = New-Object System.Drawing.Size(110, 0)
    $copy = New-Object System.Windows.Forms.Button
    $copy.Text = 'Copy summary'; $copy.AutoSize = $true; $copy.MinimumSize = New-Object System.Drawing.Size(110, 0); $copy.Enabled = $false
    $open = New-Object System.Windows.Forms.Button
    $open.Text = 'Open results folder'; $open.AutoSize = $true; $open.MinimumSize = New-Object System.Drawing.Size(110, 0); $open.Enabled = $false
    $buttons.Controls.AddRange(@($run, $copy, $open))
    $row = 0; foreach ($c in @($where, $list, $log, $buttons)) { $grid.Controls.Add($c, 0, $row); $row++ }
    $form.Controls.Add($grid)
    $form.ResumeLayout($false); $form.PerformLayout()
    # Enter starts the run (PFM 13 Nov). No DODID box: the profile folder is used (PFM 13 Nov). Focus starts on Run.
    $form.AcceptButton = $run
    $form.Add_Shown({ $run.Focus() | Out-Null })
    $first = Get-RoundPlan ''
    $where.Text = 'Writes to: ' + $first.Shown + $(if ($first.Found) { '' } else { '   (NOT found: OneDrive is not set up in this Windows profile)' })
    $howTo = @('HOW TO USE', '  1. Check the "Writes to" line above. If it says NOT found, stop and send that line.',
      '  2. Press Enter or Run. Word steps take a few minutes; keep this window open until it says DONE.',
      '  3. At DONE an Outlook draft opens with the subject, summary and all files. Fix the "Window:" line, add To, Send.',
      '     If Outlook cannot make the draft: the results folder opens and the summary is on the clipboard (paste into a',
      '     new e-mail body, cut the first line into the subject, attach all files). The buttons copy and open again.',
      '  Uncheck a step to skip it. Closing the window stops a running step.', '')
    $log.Text = (($howTo + $first.Lines) -join "`r`n") + "`r`n"

    $script:lastSummary = @()
    $say = { param($t) Add-RunLog $t; try { $log.AppendText($t + "`r`n"); [System.Windows.Forms.Application]::DoEvents() } catch { Write-Host $t } }
    $tick = { [System.Windows.Forms.Application]::DoEvents() }
    $onStep = { param($k, $line) $list.Items[$k] = $line; $list.SetItemChecked($k, $true) }
    $run.Add_Click({
      $run.Enabled = $false; $copy.Enabled = $false; $open.Enabled = $false
      $sel = @(); for ($k = 0; $k -lt $steps.Count; $k++) { $sel += $list.GetItemChecked($k) }
      try {
        $script:lastSummary = Invoke-Round '' $sel $say $tick $onStep; $copy.Enabled = $true; $open.Enabled = $true
        $copy.PerformClick(); if (-not $script:draftMade) { $open.PerformClick(); $form.Activate(); $copy.Focus() | Out-Null }
      }
      catch { & $say ('STOPPED: ' + (ConvertTo-Masked ([string]$_))) }
      $run.Enabled = $true
    })
    $copy.Add_Click({
      try { [System.Windows.Forms.Clipboard]::SetText(($script:lastSummary -join "`r`n")); & $say 'Summary copied. Paste it into the e-mail body; its first line is the subject.' }
      catch { & $say ('Clipboard busy; press Copy summary again. (' + $_.Exception.Message + ')') }
    })
    $open.Add_Click({ if ($script:resultsDir) { Start-Process -FilePath 'explorer.exe' -ArgumentList ('"' + $script:resultsDir + '"') } })
    $form.Add_FormClosing({ if ($script:child -and -not $script:child.HasExited) { try { $script:child.Kill() } catch { $null = $_ } } })
    [void]$form.ShowDialog()
    return
  } catch { $gui = $false; Write-Host ('No window (' + $_.Exception.Message + '); text mode.') }
}
try {
  $script:textMode = $true
  $say = { param($t) Add-RunLog $t; Write-Host $t }
  $typed = ''   # no DODID question: the profile folder is used (PFM 13 Nov)
  foreach ($l in (Get-RoundPlan $typed).Lines) { Write-Host $l }
  # The plan above shows first; Enter starts the run (PFM 13 Nov), N stops before anything is written.
  $go = ([string](Read-Host 'Press Enter to run (N then Enter stops, nothing written)')).Trim()
  if ($go -match '^[Nn]') { Write-Host 'Stopped before anything was written.'; return }
  $sel = @(); foreach ($s in $steps) { $sel += $true }
  $sum = Invoke-Round $typed $sel $say { } { }
  if ($script:resultsDir -and $env:OS -eq 'Windows_NT' -and -not $script:draftMade) { Start-Process -FilePath 'explorer.exe' -ArgumentList ('"' + $script:resultsDir + '"') }
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
            '  A window opens: press Enter (or Run); it uses your Windows profile folder. It writes the files below into the task folders under\n'
            '  C:\\Users\\<DODID>\\OneDrive - United States Air Force\\90-161.Z (replacing older copies), runs the steps,\n'
            '  and saves its results in Rounds\\%s, then opens an Outlook draft with them (never sent). No download, no admin rights.\n'
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
