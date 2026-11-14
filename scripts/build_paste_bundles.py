#!/usr/bin/env python3
"""Build the round bundles in scripts/gov/paste from scripts/paste_bundles.json.

A bundle is one PowerShell text (the "90-161.Z Deployer", PFM 13 Nov; formerly "runner") (Windows PowerShell 5.1) that the PFM copies from its raw page, pastes into
Windows PowerShell ISE and runs with F5 (ISSM approved paste and run in writing, PFM 2026-11-12). It is a
bootstrapper for fast test rounds (PFM 1A, 6A: function over form):
  1. uses the Windows profile folder as the DODID (no question: PFM 13 Nov, the empty-box default worked) and shows
     the real path on screen (reports and e-mails still mask it);
  1b. recycles finished files (cleanup list in the JSON; only files 90-161.Z made; to the Recycle Bin) and reports
     what it recycled and what is left (folder counts, no file names) in the summary (R06, PFM 13 Nov);
  2. makes each task folder under C:\\Users\\<DODID>\\OneDrive - United States Air Force\\90-161.Z if missing and
     writes every file (text: same content as UTF-8 with BOM and CRLF; binary: byte-exact from base64);
  3. runs the steps one by one (each a runner file, as a child powershell.exe with -Id and -NoPause), with a live
     log, DODID masked, and PASS/FAIL counts per step. A step of kind "guide" (R13, PFM 14 Nov 26: the Deployer
     delivers every file, no separate downloads) is work the PFM does in another program, such as a flow import: the
     Deployer writes its file, opens the address, puts the file path on the clipboard and waits for Done or Skip.
     Log text (R13, PFM 14 Nov 26): one heading per step ("Step k of n: name"), the step's output indented under it,
     one result line (PASSED, NEEDS REVIEW or SKIPPED); the e-mail subject ends in PASSED or NEEDS REVIEW;
  4. writes a results folder Rounds\\<round> with one report file (summary + full masked log) and copies of the
     collect files (PDFs), ready to attach to one e-mail (no zip: zips do not cross the boundary, PFM 13 Nov);
  5. makes an Outlook draft (classic Outlook, COM): subject = summary line 1, body = the rest, every results file
     attached, never sent (R05); To from the window box, saved in Config\\90161Z-mail-to.txt (R06). If no draft can be made, it opens the results folder and puts
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



def step_default(s):
    """A step's default tick. "default" may be true/false, or {"passed": <hash>, "paths": [...]}: then the step is on
    only when those files changed since the round that last passed it (PFM 14 Nov 26: no repeat render test)."""
    d = s.get('default', True)
    if isinstance(d, dict):
        return files_hash(d['paths']) != d['passed']
    return bool(d)


def files_hash(paths):
    h = hashlib.sha256()
    for rel in sorted(paths):
        h.update(rel.encode() + b'\0' + (ROOT / rel).read_bytes() + b'\0')
    return h.hexdigest()[:16]

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
# ---------------- 90-161.Z Deployer (generated; same engine in every round bundle) ----------------
function Get-Secret([string]$Id, [string]$Leaf) {
  @($Id, $Leaf, $env:USERNAME) | Where-Object { $_ -and $_.Length -ge 4 } | Sort-Object -Unique | Sort-Object Length -Descending
}
function ConvertTo-Masked([string]$Text) {
  foreach ($x in $script:secret) { $Text = $Text -replace [regex]::Escape($x), '<DODID>' }
  return $Text
}
function Get-ProfileLeaf { if ($env:USERPROFILE) { return (Split-Path -Leaf $env:USERPROFILE) }; return '' }
function Get-BasePath {
  # The real path (shown on screen, PFM 13 Nov: no placeholder). Reports and e-mails show <DODID> instead.
  $leaf = Get-ProfileLeaf
  if (-not $leaf) { $leaf = 'no-profile-folder' }
  return (Join-Path (Join-Path (Join-Path $usersRoot $leaf) 'OneDrive - United States Air Force') '90-161.Z')
}
function Resolve-Base {
  # No DODID question (PFM 13 Nov): the Windows profile folder name is the DODID.
  $leaf = Get-ProfileLeaf
  $script:secret = Get-Secret $leaf $leaf
  if ($leaf -notmatch '^[A-Za-z0-9._-]{4,}$') { throw 'PROFILE folder name not usable (Windows profile not found). Sign in to Windows with your own account, then run again.' }
  $base = Get-BasePath
  $oneDrive = Split-Path -Parent $base
  if (-not (Test-Path -LiteralPath $oneDrive -PathType Container)) { throw ('FOLDER not found: ' + $oneDrive + '. OneDrive is not set up in this Windows profile.') }
  $script:dodid = $leaf
  return $base
}
function Format-Duration([double]$Seconds) {
  $s = [int][math]::Round($Seconds)
  return ('{0}m {1:00}s' -f [math]::Floor($s / 60), ($s % 60))
}
function Test-WordOpen { return (@(Get-Process -Name WINWORD -ErrorAction SilentlyContinue).Count -gt 0) }
function Test-MailTo([string]$To) {
  $one = '[^@\s;,]+@[^@\s;,]+\.[^@\s;,]+'
  return ($To -match ('^\s*' + $one + '(\s*;\s*' + $one + ')*\s*;?\s*$'))
}
function Get-ConfigFile([string]$Base, [string]$Name) { return (Join-Path (Join-Path $Base 'Config') $Name) }
function Get-MailTo([string]$Base) {
  # Config\90161Z-mail-to.txt: the address the results e-mail goes to (PFM 13 Nov). The window box saves it.
  $p = Get-ConfigFile $Base '90161Z-mail-to.txt'
  if (Test-Path -LiteralPath $p -PathType Leaf) { try { return ([string](Get-Content -LiteralPath $p -TotalCount 1)).Trim() } catch { return '' } }
  return ''
}
function Save-MailTo([string]$Base, [string]$To) {
  $p = Get-ConfigFile $Base '90161Z-mail-to.txt'
  $dir = Split-Path -Parent $p
  if (-not (Test-Path -LiteralPath $dir -PathType Container)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
  [System.IO.File]::WriteAllText($p, ($To.Trim() + "`r`n"), (New-Object System.Text.UTF8Encoding $true))
}
function Read-RoundHistory([string]$Base) {
  # Config\90161Z-history.csv: round, step, finish time, status, seconds (no DODID). Feeds the banner and the estimates.
  $p = Get-ConfigFile $Base '90161Z-history.csv'
  if (Test-Path -LiteralPath $p -PathType Leaf) { try { return @(Import-Csv -LiteralPath $p) } catch { return @() } }
  return @()
}
function Add-RoundHistory([string]$Base, [string]$Step, [string]$Status, [int]$Seconds) {
  try {
    $p = Get-ConfigFile $Base '90161Z-history.csv'
    $dir = Split-Path -Parent $p
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
    [pscustomobject]@{ Round = $round; Step = $Step; Finished = (Get-Date -Format 'yyyy-MM-dd HH:mm'); Status = $Status; Seconds = $Seconds } |
      Export-Csv -LiteralPath $p -Append -NoTypeInformation
  } catch { $null = $_ }   # history is a convenience: never stop a round for it
}
function Get-NewerRound {
  # Reads go.md (the bookmark page's source; data, not code) and returns the highest round number listed in an open task
  # heading when it is newer than this one, else ''. Short timeout; any failure is silent, so it never blocks a run.
  try {
    $rq = [System.Net.WebRequest]::Create($goUrl)
    $rq.Timeout = 4000
    try { $rq.UseDefaultCredentials = $true } catch { $null = $_ }   # https: Windows sign-in for the proxy (a file URL in tests has none)
    if ($rq.Proxy) { $rq.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials }
    $rs = $rq.GetResponse()
    try { $text = (New-Object System.IO.StreamReader($rs.GetResponseStream())).ReadToEnd() } finally { $rs.Close() }
    $mine = [int]($round -replace '\D', '')
    $max = 0
    foreach ($m in [regex]::Matches($text, '(?m)^## [^\r\n]*Round R(\d{2})[^\r\n]*\(open')) { $n = [int]$m.Groups[1].Value; if ($n -gt $max) { $max = $n } }
    if ($max -gt $mine) { return ('R{0:00}' -f $max) }
  } catch { $null = $_ }
  return ''
}
function Get-LastRoundText($Hist) {
  $r = @($Hist | Where-Object { $_.Step -eq 'ROUND' })
  if (-not $r.Count) { return 'Last round on this computer: none recorded yet.' }
  $l = $r[-1]
  $word = @{ OK = 'passed'; CHECK = 'needed review'; STOPPED = 'stopped' }[[string]$l.Status]; if (-not $word) { $word = [string]$l.Status }
  return ('Last round on this computer: ' + $l.Round + ' ' + $word + ' on ' + $l.Finished + ' (took ' + (Format-Duration ([double]$l.Seconds)) + ').')
}
function Get-StepEstimate($Hist, [string]$Name) {
  $r = @($Hist | Where-Object { $_.Step -eq $Name -and $_.Status -eq 'OK' -and $_.Seconds })   # last good run only
  if ($r.Count) { return [int]$r[-1].Seconds }
  return 0
}
$helpRules = @(
  @{ Re = 'FOLDER not found|PROFILE folder'; Text = 'OneDrive is not set up in this Windows profile. Open OneDrive from the Start menu, sign in, wait until it says it is up to date, then run again.' },
  @{ Re = 'being used by another process|cannot access the file'; Text = 'A file is open in another program. Close Word and any file from the 90-161.Z folder, then press Run again.' },
  @{ Re = 'RPC_E_CALL_REJECTED|0x80010001|0x8001010A|server busy'; Text = 'Word was busy. Close every Word window, wait 10 seconds, then press Run again.' },
  @{ Re = 'ran longer than'; Text = 'A step ran too long. Close Word (check the taskbar), then press Run again. If it happens twice, send the results as they are.' },
  @{ Re = 'LABEL (FAIL|not set)'; Text = 'The sensitivity label was not set. Keep the Config folder; see "Sensitivity label" on the bookmark page.' },
  @{ Re = 'denied|UnauthorizedAccess'; Text = 'Windows blocked a file. Check that the 90-161.Z folder is in your own OneDrive and not read-only, then run again.' },
  @{ Re = 'Outlook draft could not be created'; Text = 'Open Outlook (classic), then press Make e-mail draft. Or send by hand: the results folder is open and the summary is on the clipboard.' },
  @{ Re = 'FORMAT-FAIL'; Text = 'The renderer found a format problem. Send the results as they are; Claude fixes it.' },
  @{ Re = 'NO IMAGES'; Text = 'The seal images are not on this computer yet. Send the results; Claude checks how the seal e-mails were delivered.' },
  @{ Re = 'Clean-up could not'; Text = 'A file could not go to the Recycle Bin (it may be open). Close it; the next round tries again.' },
  @{ Re = 'e-mail address does not look right'; Text = 'Type one address like name@example.com (several: separate with ;), or leave the box empty.' }
)
function Get-WhatToDo([string]$Line) {
  foreach ($h in $helpRules) {
    if ($Line -match $h.Re -and -not $script:helped.ContainsKey($h.Re)) { $script:helped[$h.Re] = $true; return ('What to do: ' + $h.Text) }
  }
  return ''
}
function Test-OurFile([string]$Name) {
  # Files 90-161.Z made: 90161Z-* names, sample renders, and the support scripts that keep their names.
  if ($Name -like '90161Z-*' -or $Name -like 'SAMPLEWING*') { return $true }
  return ($known -contains $Name)
}
function Get-CleanupPlan([string]$Base) {
  # Finished items only (PFM 13 Nov). A file not made by 90-161.Z is never touched; its folder stays.
  $res = @{ Files = @(); Dirs = @(); Kept = 0; Lines = @() }
  foreach ($c in $cleanup) {
    if ($c.Kind -eq 'dir') {
      $p = Join-Path $Base $c.Path
      if (-not (Test-Path -LiteralPath $p -PathType Container)) { continue }
      $all = @(Get-ChildItem -LiteralPath $p -Recurse -File -Force -ErrorAction SilentlyContinue)
      $ours = @($all | Where-Object { Test-OurFile $_.Name })
      $other = $all.Count - $ours.Count
      $res.Files += @($ours | ForEach-Object { $_.FullName }); $res.Dirs += $p; $res.Kept += $other
      $res.Lines += ('  Recycle   ' + $c.Path + '\  (' + $ours.Count + ' files' + $(if ($other) { '; keeps ' + $other + ' file(s) not made by 90-161.Z, and the folder' } else { '' }) + ')')
    } else {
      $dir = Join-Path $Base (Split-Path -Parent $c.Path)
      if (-not (Test-Path -LiteralPath $dir -PathType Container)) { continue }
      foreach ($f in @(Get-ChildItem -LiteralPath $dir -Filter (Split-Path -Leaf $c.Path) -File -Force -ErrorAction SilentlyContinue)) {
        if (Test-OurFile $f.Name) { $res.Files += $f.FullName; $res.Lines += ('  Recycle   ' + (Split-Path -Parent $c.Path) + '\' + $f.Name) }
      }
    }
  }
  return $res
}
function Move-ToRecycleBin([string]$Path, [switch]$Folder) {
  # Windows: to the Recycle Bin (restore from there). Elsewhere (tests only): plain delete.
  if ($env:OS -eq 'Windows_NT') {
    Add-Type -AssemblyName Microsoft.VisualBasic
    if ($Folder) { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($Path, 'OnlyErrorDialogs', 'SendToRecycleBin') }
    else { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($Path, 'OnlyErrorDialogs', 'SendToRecycleBin') }
  } else { Remove-Item -LiteralPath $Path -Force -Recurse:$Folder }
}
function Invoke-Cleanup([string]$Base, [scriptblock]$Say) {
  $plan = Get-CleanupPlan $Base
  $done = 0; $gone = 0; $failed = 0
  foreach ($f in $plan.Files) {
    try { Move-ToRecycleBin $f; $done++ } catch { $failed++; & $Say ('Clean-up could not recycle ' + (ConvertTo-Masked $f) + ': ' + (ConvertTo-Masked $_.Exception.Message)) }
  }
  foreach ($d in @($plan.Dirs | Sort-Object Length -Descending)) {
    # The folder goes only when nothing is left in it.
    if ((Test-Path -LiteralPath $d -PathType Container) -and @(Get-ChildItem -LiteralPath $d -Recurse -File -Force -ErrorAction SilentlyContinue).Count -eq 0) {
      try { Move-ToRecycleBin $d -Folder; $gone++ } catch { $failed++; & $Say ('Clean-up could not recycle ' + (ConvertTo-Masked $d) + ': ' + (ConvertTo-Masked $_.Exception.Message)) }
    }
  }
  $line = 'Clean-up: moved to the Recycle Bin: ' + $done + ' files, ' + $gone + ' folders; kept (not made by 90-161.Z): ' + $plan.Kept + ' files; failed: ' + $failed + '.'
  if ($failed) { $script:roundBad = $true }
  & $Say $line
  return $line
}
function Get-FolderInventory([string]$Base) {
  # What is left, for Claude to update the next round's steps: task folders by name, counts only (no file names).
  $parts = @(); $odd = 0
  foreach ($d in @(Get-ChildItem -LiteralPath $Base -Directory -Force -ErrorAction SilentlyContinue | Sort-Object Name)) {
    if ($d.Name -notmatch '^(T\d\d|Rounds|Config)$') { $odd++; continue }
    $all = @(Get-ChildItem -LiteralPath $d.FullName -Recurse -File -Force -ErrorAction SilentlyContinue)
    $other = @($all | Where-Object { -not (Test-OurFile $_.Name) }).Count
    $parts += ($d.Name + ' ' + $all.Count + $(if ($other) { ' (' + $other + ' other)' } else { '' }))
  }
  return ('Files left by folder: ' + ($parts -join ', ') + $(if ($odd) { '; other folders: ' + $odd } else { '' }) + '.')
}
function Write-BundleFile([string]$Base, [scriptblock]$Say) {
  $utf8Bom = New-Object System.Text.UTF8Encoding $true
  & $Say 'Preparing files'
  foreach ($f in $files) {
    $dir = Join-Path $Base $f.Dir
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
    $path = Join-Path $dir $f.Name
    if ($f.Kind -eq 'text') { [System.IO.File]::WriteAllText($path, (($f.Data -replace "`r?`n", "`r`n") + "`r`n"), $utf8Bom) }
    else { [System.IO.File]::WriteAllBytes($path, [System.Convert]::FromBase64String(($f.Data -replace '\s', ''))) }
    & $Say ('  Saved   ' + $f.Dir + '\' + $f.Name + '  (SHA-256 ' + $f.Sha + ')')
  }
  & $Say ('  ' + $files.Count + ' files saved.')
}
function Save-RoundDownload([string]$Base, [scriptblock]$Say) {
  # Data files only (briefs, public color documents), never code (PFM 3A). WebClient uses the Windows proxy and sign-in.
  # A repo file must match its SHA-256; a failed download leaves the link on the bookmark page as the fallback.
  $ok = 0; $bad = 0
  if (-not $fetch.Count) { return '' }
  try { [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072 } catch { $null = $_ }   # TLS 1.2 on PS 5.1
  foreach ($f in $fetch) {
    $dir = Join-Path $Base $f.Dir
    if (-not (Test-Path -LiteralPath $dir -PathType Container)) { [void](New-Item -ItemType Directory -Path $dir -Force) }
    $path = Join-Path $dir $f.Name
    $wc = New-Object System.Net.WebClient
    try {
      $wc.UseDefaultCredentials = $true
      if ($wc.Proxy) { $wc.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials }
      $wc.DownloadFile($f.Url, $path)
      if ($f.Sha) {
        $got = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
        if ($got -ne $f.Sha) { Remove-Item -LiteralPath $path -Force; throw 'the file changed since this round was built' }
      }
      $ok++; & $Say ('  Downloaded   ' + $f.Dir + '\' + $f.Name + '  (' + ('{0:N0}' -f (Get-Item -LiteralPath $path).Length) + ' bytes)')
    } catch {
      $bad++
      if (Test-Path -LiteralPath $path -PathType Leaf) { try { Remove-Item -LiteralPath $path -Force } catch { $null = $_ } }   # no partial file left behind
      & $Say ('  Download failed   ' + $f.Dir + '\' + $f.Name + ': ' + (ConvertTo-Masked $_.Exception.Message) + ' (save it from the bookmark page instead)')
    } finally { $wc.Dispose() }
  }
  $line = 'Downloads: ' + $ok + ' saved, ' + $bad + ' failed.'
  if ($bad) { $script:roundBad = $true }
  & $Say $line
  return $line
}
function Invoke-RoundStep([string]$Base, $Step, [scriptblock]$Say, [scriptblock]$Tick, [string]$Answer) {
  $exe = 'powershell.exe'
  if (-not (Get-Command $exe -ErrorAction SilentlyContinue)) { $exe = 'pwsh' }
  $dir = Join-Path $Base $Step.Dir
  $psi = New-Object System.Diagnostics.ProcessStartInfo
  $psi.FileName = $exe
  $psi.Arguments = '-NoProfile -ExecutionPolicy Bypass -File "' + (Join-Path $dir $Step.File) + '" -Id "' + $script:dodid + '" -NoPause'
  if ($Step.Args) { $psi.Arguments += ' ' + $Step.Args }   # fixed arguments from the round (for example -Set T12)
  if ($Step.AskParam -and $Answer) {
    # A trailing \ before the closing quote would escape it (command-line rules): trim it, but a drive root keeps its \,
    # doubled so "D:\\" reads back as D:\ (review R08).
    $a = $Answer; if ($a.Length -gt 3) { $a = $a.TrimEnd('\') }
    if ($a.EndsWith('\')) { $a += '\' }
    $psi.Arguments += ' -' + $Step.AskParam + ' "' + $a + '"'
  }
  $psi.WorkingDirectory = $dir
  $psi.UseShellExecute = $false; $psi.CreateNoWindow = $true
  $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError = $true
  $r = @{ Pass = 0; Fail = 0; Exit = $null }
  $p = [System.Diagnostics.Process]::Start($psi)
  $script:child = $p
  $limit = $stepMinutes; if ($Step.Minutes) { $limit = [int]$Step.Minutes }   # a step that waits for a person sets its own limit
  $deadline = (Get-Date).AddMinutes($limit)
  $errTask = $p.StandardError.ReadToEndAsync()
  $lineTask = $p.StandardOutput.ReadLineAsync()
  while ($true) {
    while (-not $lineTask.Wait(150)) {
      & $Tick
      if ((Get-Date) -gt $deadline) { try { $p.Kill() } catch { $null = $_ }; $r.Fail++; & $Say ('    STOPPED: the step ran longer than ' + $limit + ' minutes and was ended.'); break }
    }
    if (-not $lineTask.IsCompleted) { break }
    $line = $lineTask.Result
    if ($null -eq $line) { break }
    $line = ConvertTo-Masked $line
    # Lines that may name a unit or a file (for example seal details) never reach the report (data boundary).
    if ($Step.ScreenOnly -and $line -match $Step.ScreenOnly) { $line = ($line -replace '^(\S+).*$', '$1') + ' (detail hidden: it may hold a name; run the step script by hand to see it)' }
    if ($line -match '(^|\s)PASS(\s|$)') { $r.Pass++ }
    if ($line -match '(^|\s)(FAIL|FORMAT-FAIL|RENDER-ERROR|MEASURE-ERROR|STOPPED:)(\s|$)') { $r.Fail++ }
    if ($line.Trim()) { & $Say ('    ' + $line) }   # step output, indented under its step heading
    $lineTask = $p.StandardOutput.ReadLineAsync()
  }
  $p.WaitForExit()
  $script:child = $null
  foreach ($e in @(([string]$errTask.Result) -split "`r?`n" | Where-Object { $_ })) { $r.Fail++; & $Say ('    Error output: ' + (ConvertTo-Masked $e)) }
  $r.Exit = $p.ExitCode
  return $r
}
function Get-StepState($R) {
  if ($R.Skipped) { return 'SKIPPED' }
  if ($R.Fail -gt 0 -or $R.Exit -ne 0) { return 'NEEDS REVIEW' }
  return 'PASSED'
}
function Get-StepLine($Step, $R, [double]$Seconds) {
  # One line per step in the summary and the e-mail: name, result, check counts, time.
  $state = Get-StepState $R
  if ($R.Skipped) { return ($Step.Name + ': SKIPPED by you') }
  if ($Step.Kind -eq 'guide') { return ($Step.Name + ': ' + $state + ' (confirmed by you) in ' + (Format-Duration $Seconds)) }
  return ($Step.Name + ': ' + $state + ' (' + $R.Pass + ' passed, ' + $R.Fail + ' failed, exit code ' + $R.Exit + ') in ' + (Format-Duration $Seconds))
}
function Copy-TextToClipboard([string]$Text) {
  try { [System.Windows.Forms.Clipboard]::SetText($Text); return $true } catch { $null = $_ }
  try { if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) { Set-Clipboard -Value $Text; return $true } } catch { $null = $_ }
  return $false
}
function Show-GuideDialog($Step, [string]$File, [string]$Url, [string]$UrlFile) {
  # A step done by the PFM in another program (for example a flow import): numbered instructions, the address to open
  # (editable, remembered in Config), the file path on the clipboard. Done = the PFM confirms; Skip = the step is skipped.
  $d = New-Object System.Windows.Forms.Form
  $d.Text = '90-161.Z Deployer - ' + $Step.Name
  $d.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96); $d.AutoScaleMode = 'Dpi'
  $d.Font = New-Object System.Drawing.Font('Segoe UI', 10)
  $d.StartPosition = 'CenterScreen'; $d.ClientSize = New-Object System.Drawing.Size(820, 520); $d.MinimumSize = New-Object System.Drawing.Size(600, 420); $d.MinimizeBox = $false; $d.TopMost = $true
  $g = New-Object System.Windows.Forms.TableLayoutPanel
  $g.AutoScroll = $true; $g.Padding = New-Object System.Windows.Forms.Padding(12); $g.ColumnCount = 1; $g.RowCount = 5; $g.Dock = 'Fill'
  $wrap = New-Object System.Drawing.Size(760, 0)
  $head = New-Object System.Windows.Forms.Label
  $head.AutoSize = $true; $head.MaximumSize = $wrap; $head.Text = $Step.Name
  try { $head.Font = New-Object System.Drawing.Font($d.Font.FontFamily, [single]11, [Enum]::Parse(('System.Drawing.FontStyle' -as [type]), 'Bold')) } catch { $null = $_ }
  $body = New-Object System.Windows.Forms.Label
  $body.AutoSize = $true; $body.MaximumSize = $wrap; $body.Margin = New-Object System.Windows.Forms.Padding(3, 8, 3, 8)
  $body.Text = (@($Step.Guide) -join "`r`n")
  $urlPanel = New-Object System.Windows.Forms.FlowLayoutPanel
  $urlPanel.AutoSize = $true; $urlPanel.WrapContents = $true
  $urlLabel = New-Object System.Windows.Forms.Label
  $urlLabel.Text = 'Address to open:'; $urlLabel.AutoSize = $true; $urlLabel.Margin = New-Object System.Windows.Forms.Padding(3, 7, 3, 3)
  $urlBox = New-Object System.Windows.Forms.TextBox
  $urlBox.Width = 460; $urlBox.Text = $Url
  $urlPanel.Controls.AddRange(@($urlLabel, $urlBox))
  $btns = New-Object System.Windows.Forms.FlowLayoutPanel
  $btns.AutoSize = $true; $btns.WrapContents = $true
  $mk = { param($text) $b = New-Object System.Windows.Forms.Button; $b.Text = $text; $b.AutoSize = $true; $b.MinimumSize = New-Object System.Drawing.Size(110, 32); $b }
  $openB = & $mk 'Open in browser'
  $copyB = & $mk 'Copy file path'
  $showB = & $mk 'Show file in folder'
  $doneB = & $mk 'Done: the run has started'
  $skipB = & $mk 'Skip this step'
  $doneB.DialogResult = 'OK'; $skipB.DialogResult = 'Cancel'
  $btns.Controls.AddRange(@($openB, $copyB, $showB, $doneB, $skipB))
  $note = New-Object System.Windows.Forms.Label
  $note.AutoSize = $true; $note.MaximumSize = $wrap
  $note.Text = $(if (Copy-TextToClipboard $File) { 'The full path of ' + $Step.File + ' is on the clipboard.' } else { 'Select Copy file path to put the path of ' + $Step.File + ' on the clipboard.' })
  $row = 0; foreach ($c in @($head, $body, $urlPanel, $note, $btns)) { $g.Controls.Add($c, 0, $row); $row++ }
  $d.Controls.Add($g)
  $openB.Add_Click({
    $u = $urlBox.Text.Trim()
    if ($u -notmatch '^https://') { $note.Text = 'The address must start with https://'; return }
    try { if ($UrlFile) { Set-Content -LiteralPath $UrlFile -Value $u -Encoding UTF8 } } catch { $null = $_ }
    try { Start-Process -FilePath $u; $note.Text = 'Opened in your browser. Follow the steps above, then select Done.' } catch { $note.Text = 'The browser could not be opened: ' + $_.Exception.Message }
  })
  $copyB.Add_Click({ $note.Text = $(if (Copy-TextToClipboard $File) { 'File path copied. Paste it into the File name box of the upload window (Ctrl+V).' } else { 'The clipboard is busy. Select Copy file path again.' }) })
  $showB.Add_Click({ Start-Process -FilePath 'explorer.exe' -ArgumentList ('/select,"' + $File + '"') })
  $d.CancelButton = $skipB
  $d.Add_Shown({ $openB.Focus() | Out-Null })   # Enter on the focused button opens the browser; Done needs a deliberate click
  $res = $d.ShowDialog()
  $d.Dispose()
  return ($res -eq 'OK')
}
function Invoke-GuideStep([string]$Base, $Step, [scriptblock]$Say) {
  $r = @{ Pass = 0; Fail = 0; Exit = 0; Skipped = $false }
  $dir = Join-Path $Base $Step.Dir
  $file = Join-Path $dir $Step.File
  $url = $Step.Url
  $urlFile = ''
  if ($Step.UrlConfig) {
    $urlFile = Get-ConfigFile $Base $Step.UrlConfig
    if (Test-Path -LiteralPath $urlFile -PathType Leaf) { try { $v = ([string](Get-Content -LiteralPath $urlFile -TotalCount 1)).Trim(); if ($v -match '^https://') { $url = $v } } catch { $null = $_ } }
  }
  & $Say ('    File ready: ' + $Step.Dir + '\' + $Step.File)
  if ($script:textMode) {
    foreach ($l in @($Step.Guide)) { & $Say ('    ' + $l) }
    & $Say ('    Address: ' + $url)
    if (Copy-TextToClipboard $file) { & $Say '    The full file path is on the clipboard.' }
    if ($env:OS -eq 'Windows_NT') { try { Start-Process -FilePath $url } catch { $null = $_ } }
    $a = ([string](Read-Host 'Press Enter when the flow run has started, or type S and press Enter to skip this step')).Trim()
    $ok = ($a -notmatch '^[Ss]')
  } else { $ok = Show-GuideDialog $Step $file $url $urlFile }
  if ($ok) {
    if ($Step.Marker) { try { Set-Content -LiteralPath (Join-Path $dir $Step.Marker) -Value (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') -Encoding UTF8 } catch { $null = $_ } }
    $r.Pass = 1
    & $Say '    Confirmed by you: the flow is imported and its run has started.'
  } else { $r.Skipped = $true; & $Say '    Skipped by you.' }
  return $r
}
function Add-RunLog([string]$T) { if ($null -ne $script:runLog) { $script:runLog.Add($T) } }
function Export-RoundResult([string]$Base, [string[]]$Summary) {
  # One folder of plain files to attach to one e-mail (zips do not cross the boundary, PFM 13 Nov).
  $out = Join-Path (Join-Path $Base 'Rounds') $round
  if (-not (Test-Path -LiteralPath $out -PathType Container)) { [void](New-Item -ItemType Directory -Path $out -Force) }
  $count = 1; $missing = @()
  foreach ($c in $collect) {
    if ($c.Step -and -not ($script:ranSteps -contains $c.Step)) { continue }   # a skipped step has nothing to send
    $src = Join-Path $Base $c.Dir
    if ($c.Name -match '[*?]') {
      # A pattern (R10: any saved page counts, whatever its name); top level only, so a browser's "_files" folders stay out.
      # Several patterns may be joined with ';' ("*.mhtml;*.pdf"): missing only when none of them finds a file.
      # Windows -Filter '*.htm' also matches '.html': keep each file once. Copies carry the task prefix (T09-..., T12-...) so
      # two tasks never overwrite each other, and older copies of that task are removed first (review R10).
      $hits = @(); if (Test-Path -LiteralPath $src -PathType Container) { foreach ($pat in ($c.Name -split ';')) { $hits += @(Get-ChildItem -LiteralPath $src -File -Filter $pat -ErrorAction SilentlyContinue) } }
      $hits = @($hits | Sort-Object FullName -Unique)
      Get-ChildItem -LiteralPath $out -File -Filter ($c.Dir + '-*') -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
      foreach ($h in $hits) { Copy-Item -LiteralPath $h.FullName -Destination (Join-Path $out ($c.Dir + '-' + $h.Name)) -Force; $count++ }
      if (-not $hits.Count) { $missing += ($c.Dir + '\' + $c.Name) }
      continue
    }
    $old = Join-Path $out $c.Name
    if (Test-Path -LiteralPath $old -PathType Leaf) { Remove-Item -LiteralPath $old -Force }   # an older copy of the same name must not be sent again
    $p = Join-Path $src $c.Name
    if (Test-Path -LiteralPath $p -PathType Leaf) { Copy-Item -LiteralPath $p -Destination (Join-Path $out $c.Name) -Force; $count++ } else { $missing += ($c.Dir + '\' + $c.Name) }
  }
  if ($missing.Count) { $script:roundBad = $true }
  $report = Join-Path $out ('90161Z-' + $round + '-report-r1.txt')
  $body = @($Summary) + @('', '---------------- full log ----------------') + @($script:runLog)
  [System.IO.File]::WriteAllText($report, (($body -join "`r`n") + "`r`n"), (New-Object System.Text.UTF8Encoding $true))
  return @{ Dir = $out; Count = $count; Missing = $missing }
}
function Get-RoundPlan {
  # What this round writes and recycles, before it runs (PFM 13 Nov: show the impact; show the real path).
  $base = Get-BasePath
  $found = Test-Path -LiteralPath (Split-Path -Parent $base) -PathType Container
  $lines = @(('Working folder: ' + $base + $(if ($found) { '' } else { '   (NOT found: OneDrive is not set up in this Windows profile)' })), '', 'Files this round saves:')
  foreach ($f in $files) {
    $p = Join-Path (Join-Path $base $f.Dir) $f.Name
    $lines += ($(if (Test-Path -LiteralPath $p -PathType Leaf) { '  Replace   ' } else { '  New       ' }) + $f.Dir + '\' + $f.Name)
  }
  foreach ($f in $fetch) {
    $p = Join-Path (Join-Path $base $f.Dir) $f.Name
    $lines += ($(if (Test-Path -LiteralPath $p -PathType Leaf) { '  Replace   ' } else { '  New       ' }) + $f.Dir + '\' + $f.Name + '  (downloaded from ' + ([uri]$f.Url).Host + $(if ($f.Sha) { ', checked' } else { '' }) + ')')
  }
  $lines += ('  Results   Rounds\' + $round + '\  (one report file and copies of the result files)')
  if ($cleanup.Count) {
    $cp = @{ Lines = @(); Kept = 0 }
    if (Test-Path -LiteralPath $base -PathType Container) { $cp = Get-CleanupPlan $base }
    if ($cp.Lines.Count) { $lines += ''; $lines += 'Clean-up (runs first; moves files to the Recycle Bin; clear its check box to skip):'; $lines += $cp.Lines }
    else { $lines += ''; $lines += 'Clean-up: nothing to recycle.' }
  }
  $lines += ''
  $lines += 'Missing folders are created and files of the same name are replaced. Nothing else is changed, moved or deleted.'
  return @{ Shown = $base; Found = $found; Lines = $lines }
}
function Save-RoundDraft([string]$Dir, [string[]]$Summary, [string]$To, [string]$WindowLine) {
  # One Outlook draft with subject, body and every results file (R05, PFM 13 Nov); To from the window box (R06).
  # Never sent: this code has no Send call (tests/run.sh checks). Classic Outlook only (new Outlook has no COM): else fall back.
  if ($env:OS -ne 'Windows_NT') { return 'not Windows' }
  try {
    $ol = New-Object -ComObject Outlook.Application
    $m = $ol.CreateItem(0)
    $m.Subject = $Summary[0]
    if ($To) { $m.To = $To }
    $m.Body = ((@($Summary | Select-Object -Skip 1) + @('', $WindowLine)) -join "`r`n")
    foreach ($f in @(Get-ChildItem -LiteralPath $Dir -File)) { [void]$m.Attachments.Add($f.FullName) }
    $m.Display()   # first: if it fails, nothing is left in Drafts
    $m.Save()
    return ''
  } catch { return (ConvertTo-Masked $_.Exception.Message) }
}
function Invoke-Round([bool]$Clean, [bool[]]$Selected, [string]$To, [scriptblock]$Say, [scriptblock]$Tick, [scriptblock]$OnStep, [scriptblock]$OnStatus, [scriptblock]$WindowLine, [string[]]$Answers) {
  $script:ranSteps = @()
  $script:roundBad = $false
  $script:runLog = New-Object System.Collections.Generic.List[string]
  $script:helped = @{}
  $sayRaw = $Say
  $speak = { param($t) & $sayRaw $t; $w = Get-WhatToDo $t; if ($w) { & $sayRaw $w } }
  $base = Resolve-Base
  $hist = Read-RoundHistory $base
  $started = Get-Date
  # Line 1 is the e-mail subject (PFM 13 Nov); PASSED or NEEDS REVIEW is added at the end (R06; words R13).
  $summary = @(('90161Z ' + $round), ('Round ' + $round + ', build ' + $buildId + ', started ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')))
  $units = 0
  if ($Clean -and $cleanup.Count) { $units++ }
  $total = 0
  foreach ($x in $Selected) { if ($x) { $units++; $total++ } }
  $n = 0; $k1 = 0
  try {
  & $speak ('90-161.Z Deployer, round ' + $round + ' (build ' + $buildId + '), started ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
  & $speak ('Working folder: ' + (ConvertTo-Masked $base))
  if ($script:noWindowWhy) { & $speak ('Note: no window could open, so the round runs in text mode. Reason: ' + (ConvertTo-Masked $script:noWindowWhy)) }
  if (Test-WordOpen) { & $speak 'Note: Word is open. Renders use Word: save your documents and close Word if a step stops.' }
  & $speak ''
  Write-BundleFile $base $speak
  $fl = Save-RoundDownload $base $speak
  if ($fl) { $summary += $fl }
  # An empty box clears the saved address (review R06 #5).
  try { if ($To -or (Test-Path -LiteralPath (Get-ConfigFile $base '90161Z-mail-to.txt') -PathType Leaf)) { Save-MailTo $base $To } } catch { & $speak ('NOTE: could not save the e-mail address: ' + (ConvertTo-Masked $_.Exception.Message)) }
  if ($cleanup.Count) {
    if ($Clean) { $n++; & $OnStatus $n $units 'Clean-up' 0; & $speak ''; $summary += (Invoke-Cleanup $base $speak) }
    else { $summary += 'Clean-up: SKIPPED by you' }
  }
  for ($k = 0; $k -lt $steps.Count; $k++) {
    if (-not $Selected[$k]) { $summary += ($steps[$k].Name + ': not selected'); continue }
    $est = Get-StepEstimate $hist $steps[$k].Name
    $n++; $k1++; & $OnStatus $n $units $steps[$k].Name $est
    & $speak ''
    & $speak ('Step ' + $k1 + ' of ' + $total + ': ' + $steps[$k].Name)
    if ($steps[$k].Note) { & $speak ('  ' + $steps[$k].Note) }
    & $speak ('  Started ' + (Get-Date -Format 'HH:mm') + $(if ($est) { '. Last successful run took ' + (Format-Duration $est) + '.' } else { '.' }))
    $t0 = Get-Date
    $ans = ''; if ($Answers -and $Answers.Count -gt $k) { $ans = [string]$Answers[$k] }
    if ($steps[$k].Kind -eq 'guide') { $r = Invoke-GuideStep $base $steps[$k] $speak }
    else { $r = Invoke-RoundStep $base $steps[$k] $speak $Tick $ans }
    $script:ranSteps += $steps[$k].Name
    $secs = ((Get-Date) - $t0).TotalSeconds
    $state = Get-StepState $r
    if ($state -eq 'NEEDS REVIEW') { $script:roundBad = $true }
    $line = Get-StepLine $steps[$k] $r $secs
    $summary += $line
    & $speak ('  Result: ' + ($line.Substring($steps[$k].Name.Length + 2)))
    & $OnStep $k $line
    Add-RoundHistory $base $steps[$k].Name $(if ($state -eq 'PASSED') { 'OK' } else { 'CHECK' }) ([int]$secs)
  }
  & $speak ''
  $summary += (Get-FolderInventory $base)
  } catch {
    # A run that stops midway still leaves a report to send (summary so far + the log up to the stop).
    $summary[0] = '90161Z ' + $round + ' STOPPED'
    $summary += ('STOPPED: ' + (ConvertTo-Masked ([string]$_)))
    [void](Export-RoundResult $base $summary)
    Add-RoundHistory $base 'ROUND' 'STOPPED' ([int]((Get-Date) - $started).TotalSeconds)
    throw
  }
  $z = Export-RoundResult $base $summary
  $summary += ('Results folder: Rounds\' + $round + ', files: ' + $z.Count + $(if (@($z.Missing).Count) { '; ' + @($z.Missing).Count + ' expected files missing: ' + ($z.Missing -join ', ') } else { '; no expected file missing' }) + '.')
  & $speak $summary[-1]
  $bad = $script:roundBad   # a step that needs review, a failed clean-up or download, or a missing result file
  $state = $(if ($bad) { 'NEEDS REVIEW' } else { 'PASSED' })
  $summary[0] = '90161Z ' + $round + ' ' + $state
  [void](Export-RoundResult $base $summary)   # rewrite so the report holds the RESULTS line and the subject
  Add-RoundHistory $base 'ROUND' $(if ($bad) { 'CHECK' } else { 'OK' }) ([int]((Get-Date) - $started).TotalSeconds)
  $script:resultsDir = $z.Dir
  & $speak ''
  if ($bad) { & $speak 'Note: one or more items need review (see above). Send the results anyway; they show what went wrong.' }
  # R05: an Outlook draft with everything in it; if Outlook cannot make one, the folder opens and the summary is on the clipboard.
  $why = Save-RoundDraft $z.Dir $summary $To (& $WindowLine)
  $script:draftMade = (-not $why)
  if ($script:draftMade) {
    & $speak ('DONE in ' + (Format-Duration ((Get-Date) - $started).TotalSeconds) + '. An Outlook draft is open with the subject "' + $summary[0] + '", the summary and all result files (' + $z.Count + ').')
    & $speak $(if ($To) { 'Review the draft, then select Send.' } else { 'Enter the To address in the draft (or in the box here for next time), then select Send.' })
  } else {
    & $speak ('The Outlook draft could not be created (' + $why + ').')
    & $speak ('DONE. The results folder Rounds\' + $round + ' is open and the summary is on the clipboard.')
    & $speak ('Create a new e-mail: paste the summary into the body, move the first line ("' + $summary[0] + '") into the subject, and attach all files from the folder (' + $z.Count + ').')
  }
  return ,$summary
}

$script:secret = @(); $script:dodid = ''; $script:child = $null; $script:runLog = $null; $script:resultsDir = ''; $script:draftMade = $false; $script:textMode = $false; $script:helped = @{}; $stepMinutes = 30
$script:statusBase = ''; $script:stepStart = $null; $script:stepEst = 0; $script:noWindowWhy = ''; $script:ranSteps = @()
$gui = $true
try { Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing } catch { $gui = $false; $script:noWindowWhy = 'Windows Forms not available: ' + $_.Exception.Message }
if ($gui) {
  try {
    # Layout follows the font and screen scaling (R02: in ISE, which is DPI-aware, fixed pixel positions overlapped):
    # one column of rows, each control on its own row; the log takes the spare height.
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $basePath = Get-BasePath
    $hist0 = Read-RoundHistory $basePath
    $form = New-Object System.Windows.Forms.Form
    $form.Text = '90-161.Z Deployer - ' + $round + ' - build ' + $buildId
    $form.SuspendLayout()
    $form.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96); $form.AutoScaleMode = 'Dpi'   # sizes below are at 100 % scaling
    $form.Font = New-Object System.Drawing.Font('Segoe UI', 10)
    $form.ClientSize = New-Object System.Drawing.Size(940, 720); $form.MinimumSize = New-Object System.Drawing.Size(680, 520)
    $form.StartPosition = 'CenterScreen'
    $grid = New-Object System.Windows.Forms.TableLayoutPanel
    $grid.Dock = 'Fill'; $grid.Padding = New-Object System.Windows.Forms.Padding(10); $grid.ColumnCount = 1; $grid.RowCount = 10
    [void]$grid.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle('Percent', 100)))
    foreach ($h in 'AutoSize', 'AutoSize', 'AutoSize', 'AutoSize', 'AutoSize', 'AutoSize', 'Percent', 'AutoSize', 'AutoSize', 'AutoSize') { [void]$grid.RowStyles.Add((New-Object System.Windows.Forms.RowStyle($h, 100))) }
    $wrap = New-Object System.Drawing.Size(880, 0)
    $banner = New-Object System.Windows.Forms.Label
    $banner.AutoSize = $true; $banner.MaximumSize = $wrap; $banner.Text = Get-LastRoundText $hist0
    $newer = Get-NewerRound
    if ($newer) { $banner.Text = 'A newer round, ' + $newer + ', is on the bookmark page. Close this window and run ' + $newer + ' instead.   ' + $banner.Text; try { $banner.ForeColor = ('System.Drawing.Color' -as [type])::FromName('DarkRed') } catch { $null = $_ } }
    $where = New-Object System.Windows.Forms.Label
    $where.AutoSize = $true; $where.MaximumSize = $wrap; $where.Margin = New-Object System.Windows.Forms.Padding(3, 6, 3, 3)
    # Cosmetics never stop the window. R06 fell back to text mode: Font('Segoe UI', 10, 'Bold') fails at binding with
    # "Multiple ambiguous overloads" (string 'Bold' fits FontStyle and GraphicsUnit). Typed enum here; each in its own try.
    try { $where.Font = New-Object System.Drawing.Font($form.Font.FontFamily, [single]10, [Enum]::Parse(('System.Drawing.FontStyle' -as [type]), 'Bold')) } catch { $null = $_ }
    $warn = New-Object System.Windows.Forms.Label
    $warn.AutoSize = $true; $warn.MaximumSize = $wrap
    try { $warn.ForeColor = ('System.Drawing.Color' -as [type])::FromName('DarkRed') } catch { $null = $_ }
    $list = New-Object System.Windows.Forms.CheckedListBox
    $list.Anchor = 'Left, Right'; $list.CheckOnClick = $true; $list.IntegralHeight = $false
    $off = 0
    if ($cleanup.Count) { [void]$list.Items.Add('Clean-up: move finished files to the Recycle Bin', $true); $off = 1 }
    foreach ($s in $steps) { [void]$list.Items.Add($s.Name + $(if ($s.AskParam) { '  (asks for a folder)' } elseif ($s.Kind -eq 'guide') { '  (needs you)' } else { '' }), [bool]$s.Default) }
    $list.Height = ($list.ItemHeight * [math]::Max(3, $list.Items.Count + 1)) + 6
    $bar = New-Object System.Windows.Forms.ProgressBar
    $bar.Dock = 'Fill'; $bar.Height = 18; $bar.Minimum = 0; $bar.Maximum = 1; $bar.Value = 0
    $status = New-Object System.Windows.Forms.Label
    $status.AutoSize = $true; $status.MaximumSize = $wrap
    $log = New-Object System.Windows.Forms.TextBox
    $log.Dock = 'Fill'; $log.Multiline = $true; $log.ScrollBars = 'Both'; $log.WordWrap = $false; $log.ReadOnly = $true
    $log.Font = New-Object System.Drawing.Font('Consolas', 9)
    $toPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $toPanel.AutoSize = $true; $toPanel.WrapContents = $true; $toPanel.Dock = 'Fill'
    $toLabel = New-Object System.Windows.Forms.Label
    $toLabel.Text = 'Send results to (e-mail):'; $toLabel.AutoSize = $true; $toLabel.Margin = New-Object System.Windows.Forms.Padding(3, 7, 3, 3)
    $toBox = New-Object System.Windows.Forms.TextBox
    $toBox.Width = 360; $toBox.Text = Get-MailTo $basePath
    $toPanel.Controls.AddRange(@($toLabel, $toBox))
    $okBox = New-Object System.Windows.Forms.CheckBox
    $okBox.AutoSize = $true; $okBox.Checked = $true; $okBox.MaximumSize = $wrap
    $okBox.Text = 'This window looked right (nothing overlapped or cut off). Uncheck if not; the e-mail says so.'
    $buttons = New-Object System.Windows.Forms.FlowLayoutPanel
    $buttons.AutoSize = $true; $buttons.WrapContents = $true; $buttons.Dock = 'Fill'
    $run = New-Object System.Windows.Forms.Button
    $run.Text = 'Run'; $run.AutoSize = $true; $run.MinimumSize = New-Object System.Drawing.Size(110, 32)
    $draft = New-Object System.Windows.Forms.Button
    $draft.Text = 'Make e-mail draft'; $draft.AutoSize = $true; $draft.MinimumSize = New-Object System.Drawing.Size(110, 32); $draft.Enabled = $false
    $copy = New-Object System.Windows.Forms.Button
    $copy.Text = 'Copy summary'; $copy.AutoSize = $true; $copy.MinimumSize = New-Object System.Drawing.Size(110, 32); $copy.Enabled = $false
    $open = New-Object System.Windows.Forms.Button
    $open.Text = 'Open results folder'; $open.AutoSize = $true; $open.MinimumSize = New-Object System.Drawing.Size(110, 32); $open.Enabled = $false
    $buttons.Controls.AddRange(@($run, $draft, $copy, $open))
    $row = 0; foreach ($c in @($banner, $where, $warn, $list, $bar, $status, $log, $toPanel, $okBox, $buttons)) { $grid.Controls.Add($c, 0, $row); $row++ }
    $form.Controls.Add($grid)
    $form.ResumeLayout($false); $form.PerformLayout()
    # Enter starts the run (PFM 13 Nov). Focus: the address box when it is empty, else Run.
    $form.AcceptButton = $run
    # Enter in the address box moves to Run instead of starting the round (review R06 #3: a stray Enter must not start a cleanup).
    $toBox.Add_Enter({ $form.AcceptButton = $null })
    $toBox.Add_Leave({ $form.AcceptButton = $run })
    $toBox.Add_KeyDown({ if ($_.KeyCode -eq 'Return') { $_.SuppressKeyPress = $true; $run.Focus() | Out-Null } })
    $form.Add_Shown({
      # Fit the screen (R09: 1280 x 800 at 150 % scaling is smaller than the window).
      $wa = [System.Windows.Forms.Screen]::FromControl($form).WorkingArea
      $form.Width = [Math]::Min($form.Width, [int]($wa.Width * 0.95)); $form.Height = [Math]::Min($form.Height, [int]($wa.Height * 0.95))
      $form.Left = $wa.Left + [int](($wa.Width - $form.Width) / 2); $form.Top = $wa.Top + [int](($wa.Height - $form.Height) / 2)
      if ($toBox.Text) { $run.Focus() | Out-Null } else { $toBox.Focus() | Out-Null } })
    $first = Get-RoundPlan
    $where.Text = 'Writes to: ' + $first.Shown + $(if ($first.Found) { '' } else { '   (NOT found)' })
    $warnings = @()
    if (-not $first.Found) { $warnings += 'OneDrive folder NOT found in this Windows profile: open OneDrive from the Start menu and sign in, then paste and run again.' }
    if (Test-WordOpen) { $warnings += 'Word is open. Save your documents and close Word before Run (renders use Word).' }
    $warn.Text = ($warnings -join "`r`n"); $warn.Visible = [bool]$warnings.Count
    $est = 0; foreach ($s in $steps) { $est += Get-StepEstimate $hist0 $s.Name }
    $status.Text = 'Ready. Press Enter or select Run.' + $(if ($est) { ' Estimated time: ' + (Format-Duration $est) + ' (from your last successful runs).' } else { '' })
    $howTo = @('How to use this window',
      '  1. Confirm that "Writes to" above shows your own OneDrive folder. Enter the address for the results e-mail (it is remembered).',
      '  2. Press Enter or select Run. Clear a check box to skip that step. Keep this window open until the log shows DONE.',
      '     A step marked "(needs you)" opens a short instruction window; follow it, then select Done.',
      '  3. At DONE, an Outlook draft opens with the subject, the summary and all result files. Review it, then select Send.',
      '     If no draft opens, the results folder opens and the summary is on the clipboard. Make e-mail draft tries Outlook again.',
      '  Closing this window stops a running step.', '')
    $log.Text = (($howTo + $first.Lines) -join "`r`n") + "`r`n"

    $script:lastSummary = @()
    $say = { param($t) Add-RunLog $t; try { $log.AppendText($t + "`r`n"); [System.Windows.Forms.Application]::DoEvents() } catch { Write-Host $t } }
    $tick = {
      if ($script:stepStart) {
        $status.Text = $script:statusBase + '   ' + (Format-Duration ((Get-Date) - $script:stepStart).TotalSeconds) + $(if ($script:stepEst) { '   (last successful run: ' + (Format-Duration $script:stepEst) + ')' } else { '' })
      }
      [System.Windows.Forms.Application]::DoEvents()
    }
    $onStep = { param($k, $line) $list.Items[$k + $off] = $line; $list.SetItemChecked($k + $off, $true); $bar.Value = [math]::Min($bar.Value + 1, $bar.Maximum) }
    $onStatus = { param($i, $count, $name, $estimate)
      $bar.Maximum = [math]::Max(1, $count); $bar.Value = [math]::Min([math]::Max(0, $i - 1), $bar.Maximum)
      $script:statusBase = 'Step ' + $i + ' of ' + $count + ': ' + $name; $script:stepStart = Get-Date; $script:stepEst = $estimate
      $status.Text = $script:statusBase; [System.Windows.Forms.Application]::DoEvents() }
    $windowLine = { if ($okBox.Checked) { 'Window: OK' } else { 'Window: NOT OK - write here what overlapped or was cut off' } }
    $toFront = { $form.TopMost = $true; $form.Activate(); $form.TopMost = $false }
    $run.Add_Click({
      $run.Enabled = $false; $draft.Enabled = $false; $copy.Enabled = $false; $open.Enabled = $false
      $to = $toBox.Text.Trim()
      if ($to -and -not (Test-MailTo $to)) {
        $script:helped = @{}; & $say 'The e-mail address does not look right.'; & $say (Get-WhatToDo 'e-mail address does not look right')
        $run.Enabled = $true; $toBox.Focus() | Out-Null; return
      }
      $clean = ($off -eq 1 -and $list.GetItemChecked(0))
      $sel = @(); for ($k = 0; $k -lt $steps.Count; $k++) { $sel += $list.GetItemChecked($k + $off) }
      # A checked step that needs a folder asks for it now; Cancel skips that step.
      $answers = @(); for ($k = 0; $k -lt $steps.Count; $k++) {
        $a = ''
        if ($sel[$k] -and $steps[$k].AskParam) {
          $pick = New-Object System.Windows.Forms.FolderBrowserDialog
          $pick.Description = $steps[$k].AskPrompt; $pick.ShowNewFolderButton = $false
          if ($pick.ShowDialog($form) -eq 'OK') { $a = $pick.SelectedPath } else { $sel[$k] = $false; & $say ($steps[$k].Name + ': skipped (no folder picked)') }
          $pick.Dispose()
        }
        $answers += $a
      }
      try {
        $script:lastSummary = Invoke-Round $clean $sel $to $say $tick $onStep $onStatus $windowLine $answers
        $script:stepStart = $null; $bar.Value = $bar.Maximum
        $status.Text = 'DONE: ' + $script:lastSummary[0] + $(if ($script:draftMade) { '. The Outlook draft is open.' } else { '. The results folder is open and the summary is copied.' })
        $copy.Enabled = $true; $open.Enabled = $true; $draft.Enabled = $true
        $copy.PerformClick()
        if (-not $script:draftMade) { $open.PerformClick(); & $toFront; $copy.Focus() | Out-Null }
      }
      catch {
        $script:stepStart = $null
        $msg = 'STOPPED: ' + (ConvertTo-Masked ([string]$_)); & $say $msg
        $w = Get-WhatToDo $msg; if ($w) { & $say $w }
        $status.Text = 'STOPPED. See the last lines of the log.'; & $toFront
      }
      $run.Enabled = $true
    })
    $draft.Add_Click({
      $why = Save-RoundDraft $script:resultsDir $script:lastSummary $toBox.Text.Trim() (& $windowLine)
      if ($why) { $script:helped = @{}; $m = 'The Outlook draft could not be created (' + $why + ').'; & $say $m; & $say (Get-WhatToDo $m) } else { & $say 'The Outlook draft is open.' }
    })
    $copy.Add_Click({
      try { [System.Windows.Forms.Clipboard]::SetText(($script:lastSummary -join "`r`n")); & $say 'Summary copied. Paste it into the e-mail body; its first line is the subject.' }
      catch { & $say ('The clipboard is busy. Select Copy summary again. (' + $_.Exception.Message + ')') }
    })
    $open.Add_Click({ if ($script:resultsDir) { Start-Process -FilePath 'explorer.exe' -ArgumentList ('"' + $script:resultsDir + '"') } })
    $form.Add_FormClosing({ if ($script:child -and -not $script:child.HasExited) { try { $script:child.Kill() } catch { $null = $_ } } })
    [void]$form.ShowDialog()
    return
  } catch {
    $gui = $false; $script:noWindowWhy = [string]$_.Exception.Message
    if ($_.InvocationInfo) { $script:noWindowWhy += ' (line ' + $_.InvocationInfo.ScriptLineNumber + ')' }
    $shown = $script:noWindowWhy
    if ($env:USERPROFILE) { $shown = $shown -replace [regex]::Escape([string]$env:USERPROFILE), 'C:\Users\<DODID>' }
    Write-Host ('No window could open (' + (ConvertTo-Masked $shown) + '). The round runs in text mode.')
  }
}
try {
  $script:textMode = $true
  $say = { param($t) Add-RunLog $t; Write-Host $t }
  Write-Host ('90-161.Z Deployer - ' + $round + ' - build ' + $buildId)
  Write-Host (Get-LastRoundText (Read-RoundHistory (Get-BasePath)))
  $newer = Get-NewerRound
  if ($newer) { Write-Host ('A newer round, ' + $newer + ', is on the bookmark page. Type N and press Enter to stop, then run ' + $newer + '.') }
  foreach ($l in (Get-RoundPlan).Lines) { Write-Host $l }
  if (Test-WordOpen) { Write-Host 'Word is open. Save your documents and close Word before you run (renders use Word).' }
  $to = Get-MailTo (Get-BasePath)
  # The plan above shows first; Enter starts the run (PFM 13 Nov), N stops before anything is written.
  $go = ([string](Read-Host 'Press Enter to start the round, or type N and press Enter to stop with no changes')).Trim()
  if ($go -match '^[Nn]') { Write-Host 'Stopped. Nothing was written.'; return }
  $sel = @(); foreach ($s in $steps) { $sel += ([bool]$s.Default -and -not $s.AskParam) }   # text mode: steps that need a folder are skipped
  $onStatusText = { }   # the log already shows each step heading
  $sum = Invoke-Round $true $sel $to $say { } { } $onStatusText { 'Window: text mode (no window opened)' } @()
  if ($script:resultsDir -and $env:OS -eq 'Windows_NT' -and -not $script:draftMade) { Start-Process -FilePath 'explorer.exe' -ArgumentList ('"' + $script:resultsDir + '"') }
  if (Get-Command Set-Clipboard -ErrorAction SilentlyContinue) { try { Set-Clipboard -Value ($sum -join "`r`n"); Write-Host 'Summary copied to the clipboard.' } catch { Write-Host 'The clipboard is not available.' } }
} catch {
  Write-Host ''
  $m = 'STOPPED: ' + (ConvertTo-Masked ([string]$_))
  Write-Host $m
  $w = Get-WhatToDo $m; if ($w) { Write-Host $w }
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
    # kind "guide": a step the PFM does in another program (guide lines, an address to open, a marker file on Done).
    steps = ['$steps += @{ Name = %s; Dir = %s; File = %s; Default = $%s; AskParam = %s; AskPrompt = %s; ScreenOnly = %s; Minutes = %d; Args = %s; Note = %s; Kind = %s; Guide = @(%s); Url = %s; UrlConfig = %s; Marker = %s }'
             % (q(s['name']), q(s['dir']), q(s['file']), 'true' if step_default(s) else 'false',
                q(s.get('ask', {}).get('param', '')), q(s.get('ask', {}).get('prompt', '')), q(s.get('screenOnly', '')),
                int(s.get('minutes', 30)), q(s.get('args', '')), q(s.get('note', '')), q(s.get('kind', 'script')),
                ', '.join(q(g) for g in s.get('guide', [])), q(s.get('url', '')), q(s.get('urlConfig', '')), q(s.get('marker', '')))
             for s in b['steps']]
    # Data files the round downloads (not code, PFM 3A): repo files from raw main, checked by SHA-256; public pages as they are.
    fetch = []
    for f in b.get('fetch', []):
        if 'src' in f:
            data = (ROOT / f['src']).read_bytes()
            url = 'https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/' + f['src']
            fetch.append((f['dir'], Path(f['src']).name, url, hashlib.sha256(data).hexdigest()))
        else:
            fetch.append((f['dir'], f['name'], f['url'], ''))
    fetchs = ['$fetch += @{ Dir = %s; Name = %s; Url = %s; Sha = %s }' % tuple(q(x) for x in t) for t in fetch]
    for s in b['steps']:
        assert any(f['dir'] == s['dir'] and Path(f['src']).name == s['file'] for f in b['files']), s
    collect = ['$collect += @{ Dir = %s; Name = %s; Step = %s }' % (q(c['dir']), q(c['name']), q(c.get('step', ''))) for c in b['collect']]
    cleanup = ['$cleanup += @{ Path = %s; Kind = %s }' % (q(c['path']), q(c['kind'])) for c in b.get('cleanup', [])]
    # Support scripts that keep their names (they load each other) and samples: made by 90-161.Z, so cleanup may recycle them.
    known = sorted({f.name for f in (ROOT / 'scripts/gov').glob('*.ps1')} | {f.name for f in (ROOT / 'samples').glob('*')})
    body = ('$goUrl = \'https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md\'\n$round = %s\n$usersRoot = \'C:\\Users\'\n$files = @()\n%s\n$fetch = @()\n%s\n$steps = @()\n%s\n$collect = @()\n%s\n$cleanup = @()\n%s\n$known = @(%s)\n%s'
            % (q(b['round']), '\n'.join(parts), '\n'.join(fetchs), '\n'.join(steps), '\n'.join(collect), '\n'.join(cleanup), ', '.join(q(k) for k in known), ENGINE))
    build_id = hashlib.sha256(body.encode('ascii')).hexdigest()[:8]
    head = ('<#\n  90-161.Z Deployer, round bundle: %s.\n'
            '  GENERATED by scripts/build_paste_bundles.py from scripts/paste_bundles.json; do not edit.\n'
            '  How to run: open Windows PowerShell ISE, File > New, paste all of this text into the script pane, press F5.\n'
            '  The 90-161.Z Deployer window opens: press Enter (or Run); it uses your Windows profile folder. It writes the files below into the task folders under\n'
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
