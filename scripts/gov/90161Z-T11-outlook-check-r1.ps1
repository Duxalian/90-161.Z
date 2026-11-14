<#
.SYNOPSIS
  90-161.Z Task 11 Outlook check, r1. Read-only. Windows PowerShell 5.1 and classic Outlook (COM), no modules.
.DESCRIPTION
  Does two Task 11 rows without a person (PFM 14 Nov 26, automate Part B):
    O1 (E2, was M13): opens the inbox of the office mailbox the way "Add shared folder or mailbox" would.
    O2 (E1, E3, E4, was M12, M14, M15): finds the 3 test mails the T11 probe flow r2 sent to me
        ("90161Z TEST E01/E03/E04") and records how each arrived: from me, sent as the office mailbox, or on behalf of it.
  Run it after the probe flow. It sends nothing, deletes nothing and changes nothing in Outlook.
  The office mailbox address is asked once and kept only on this computer in Config\90161Z-office-mailbox.txt.
  Output lines hold no names and no addresses: only PASS, BLOCKED, counts and the words above. Error text is cut to 160
  characters with both addresses replaced.
  Output: 90161Z-T11-outlook-r1.txt in the T11 folder (send this).
  Parameters (used by the 90-161.Z Deployer): -Id, -NoPause.
#>
param([string]$Id, [switch]$NoPause)
$task = 'T11'

# >>> task-common: generated from scripts/gov/src/task-common.ps1 by scripts/build_task_scripts.py (do not edit)
function ConvertTo-Masked([string]$Text, [string[]]$Secret) {
  foreach ($x in $Secret) { $Text = $Text -replace [regex]::Escape($x), '<DODID>' }
  return $Text
}

function Get-TaskId([string]$Id) {
  # Returns @{ Id; Leaf (profile folder name); Secret (longest first, so a longer name is masked before a shorter one inside it) }.
  $leaf = ''
  if ($env:USERPROFILE) { $leaf = Split-Path -Leaf $env:USERPROFILE }
  $value = ([string]$Id).Trim()
  # No DODID question (PFM 13 Nov 26): the Windows profile folder name is used when -Id is not given.
  if (-not $value) { $value = $leaf }
  if ($value -notmatch '^[A-Za-z0-9._-]{4,}$') { throw 'DODID not valid: use the folder name under C:\Users (4 or more letters, digits, dot, dash or underscore).' }
  $secret = @(@($value, $leaf, $env:USERNAME) |
    Where-Object { $_ -and $_.Length -ge 4 } | Sort-Object -Unique | Sort-Object Length -Descending)
  return @{ Id = $value; Leaf = $leaf; Secret = $secret }
}

function Get-TaskDir([string]$Id, [string]$Task, [string]$Label, [switch]$Create) {
  # The task folder C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\<Task>. -Create makes it when missing.
  $tail = 'OneDrive - United States Air Force\90-161.Z\' + $Task
  $dir = Join-Path (Join-Path 'C:\Users' $Id) $tail
  if (-not (Test-Path -LiteralPath $dir -PathType Container)) {
    if ($Create) { New-Item -ItemType Directory -Path $dir | Out-Null }
    else { throw ('FOLDER not found: C:\Users\<DODID>\' + $tail + '. Create it, save the ' + $Label + ' files into it, then run again.') }
  }
  return $dir
}

function Assert-TaskFile([string]$Dir, [string[]]$Name, [string]$Message) {
  # Throws $Message + the missing names when a file in $Name is not in $Dir.
  $missing = @($Name | Where-Object { -not (Test-Path -LiteralPath (Join-Path $Dir $_) -PathType Leaf) })
  if ($missing.Count -gt 0) { throw ($Message + ($missing -join ', ')) }
}

function Unblock-TaskScript([string]$Dir) {
  # Files pasted into Notepad and saved locally need no unblock; a failed unblock is not an error here.
  Get-ChildItem -LiteralPath $Dir -Filter *.ps1 | ForEach-Object { Unblock-File -LiteralPath $_.FullName -ErrorAction SilentlyContinue }
}

function Invoke-TaskStep([hashtable]$Step, [string]$ScriptDir, [string[]]$Secret, $Lines, [string]$Log) {
  # Runs $Step.File from $ScriptDir in a child powershell.exe with $Step.Args, masks and records its output and exit
  # code in $Lines, and saves $Lines to $Log after the step.
  Write-Host ('STEP ' + $Step.Name + ' running (Word steps can take a few minutes; do not close this window)...')
  $Lines.Add('STEP ' + $Step.Name)
  $stepArgs = $Step.Args
  $global:LASTEXITCODE = $null
  # PS 5.1: with Stop, a stderr line from the step (2>&1) would end the runner. Record it instead.
  $ErrorActionPreference = 'Continue'
  $out = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $ScriptDir $Step.File) @stepArgs 2>&1
  $code = $LASTEXITCODE
  $ErrorActionPreference = 'Stop'
  foreach ($o in @($out | Where-Object { $null -ne $_ })) {
    $masked = ConvertTo-Masked ([string]$o) $Secret
    $Lines.Add($masked)
    Write-Host $masked
  }
  $Lines.Add('STEP ' + $Step.Name + ' exit=' + $code)
  Write-Host ('STEP ' + $Step.Name + ' exit=' + $code)
  Set-Content -LiteralPath $Log -Value $Lines -Encoding UTF8
}
# <<< task-common

function Get-OfficeMailbox([string]$ConfigDir) {
  $f = Join-Path $ConfigDir '90161Z-office-mailbox.txt'
  if (Test-Path -LiteralPath $f -PathType Leaf) { $v = ([string](Get-Content -LiteralPath $f -TotalCount 1)).Trim(); if ($v) { return $v } }
  Add-Type -AssemblyName Microsoft.VisualBasic
  $v = [string][Microsoft.VisualBasic.Interaction]::InputBox('E-mail address of the office shared mailbox (the one you typed in the probe flow). Kept only on this computer.', '90-161.Z Task 11', '')
  $v = $v.Trim()
  if ($v -notmatch '^[^@\s]+@[^@\s]+\.[^@\s]+$') { throw 'MAILBOX not given or not an e-mail address. Run again.' }
  if (-not (Test-Path -LiteralPath $ConfigDir -PathType Container)) { [void](New-Item -ItemType Directory -Path $ConfigDir -Force) }
  Set-Content -LiteralPath $f -Value $v -Encoding UTF8
  return $v
}
function Hide-Text([string]$Text, [string[]]$Hide) {
  foreach ($h in $Hide) { if ($h) { $Text = $Text -replace [regex]::Escape($h), '<ADDRESS>' } }
  $Text = $Text -replace '[^@\s<>"]+@[^@\s<>"]+', '<ADDRESS>'
  if ($Text.Length -gt 160) { $Text = $Text.Substring(0, 160) }
  return $Text
}
function Get-Smtp($Entry) {
  # Exchange senders carry an X500 address; the SMTP address comes from the Exchange user or list.
  try { $u = $Entry.GetExchangeUser(); if ($u) { return [string]$u.PrimarySmtpAddress } } catch { $null = $_ }
  try { $l = $Entry.GetExchangeDistributionList(); if ($l) { return [string]$l.PrimarySmtpAddress } } catch { $null = $_ }
  try { return [string]$Entry.Address } catch { return '' }
}

$secret = @()
$hide = @()
try {
  $ErrorActionPreference = 'Stop'
  $who = Get-TaskId $Id
  $id = $who.Id
  $secret = $who.Secret
  $dir = Get-TaskDir $id $task 'Task 11' -Create
  Set-Location -LiteralPath $dir
  $configDir = Join-Path (Split-Path -Parent $dir) 'Config'
  $office = Get-OfficeMailbox $configDir
  $hide = @($office)
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add('TASK T11 Outlook check r1, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm') + ', read-only')
  $ol = New-Object -ComObject Outlook.Application
  $ns = $ol.GetNamespace('MAPI')
  $me = ''
  try { $me = Get-Smtp $ns.CurrentUser.AddressEntry; $hide += $me } catch { $null = $_ }

  # O1: the office mailbox inbox opens (Full Access).
  $rcp = $ns.CreateRecipient($office)
  $officeSmtp = $office
  if (-not $rcp.Resolve()) {
    $lines.Add('O1 office-inbox=BLOCKED the address does not resolve in the address book')
  } else {
    $s = Get-Smtp $rcp.AddressEntry; if ($s) { $officeSmtp = $s; $hide += $s }
    try {
      $f = $ns.GetSharedDefaultFolder($rcp, 6)   # 6 = olFolderInbox
      $n = [int]$f.Items.Count
      $lines.Add('O1 office-inbox=PASS items-readable=True count=' + $n)
    } catch {
      $lines.Add('O1 office-inbox=BLOCKED ' + (Hide-Text $_.Exception.Message $hide))
    }
  }

  # O2: how the probe's test mails arrived (last 7 days, newest first, at most 500 items read).
  $inbox = $ns.GetDefaultFolder(6)
  $items = $inbox.Items
  $items.Sort('[ReceivedTime]', $true)
  $since = (Get-Date).AddDays(-7)
  $found = @{}
  $read = 0
  foreach ($m in $items) {
    $read++
    if ($read -gt 500) { break }
    try { if ($m.ReceivedTime -lt $since) { break } } catch { continue }
    $subj = ''; try { $subj = [string]$m.Subject } catch { continue }
    if ($subj -notmatch '^90161Z TEST (E0[134])\b') { continue }
    $key = $Matches[1]
    if ($found.ContainsKey($key)) { continue }   # newest only
    $sndr = ''; try { $sndr = Get-Smtp $m.Sender } catch { $null = $_ }
    $onBehalf = ''; try { $onBehalf = [string]$m.SentOnBehalfOfName } catch { $null = $_ }
    $fromOffice = ($sndr -and ($sndr -ieq $officeSmtp))
    $repOffice = $false
    if ($onBehalf -and $rcp.Resolved) { try { $repOffice = ($onBehalf -ieq [string]$rcp.AddressEntry.Name) } catch { $null = $_ } }
    $how = if ($fromOffice) { 'sent-as-office' } elseif ($repOffice) { 'on-behalf-of-office' } elseif ($sndr -and $me -and ($sndr -ieq $me)) { 'from-me' } else { 'other' }
    $found[$key] = $how
  }
  foreach ($k in 'E01', 'E03', 'E04') {
    if ($found.ContainsKey($k)) { $lines.Add('O2 ' + $k + ' arrived=True how=' + $found[$k]) }
    else { $lines.Add('O2 ' + $k + ' arrived=False (run the probe flow first, or that flow step did not work)') }
  }
  $lines.Add('OUTLOOK done checks=4 items-read=' + [Math]::Min($read, 500))
  $masked = @($lines | ForEach-Object { ConvertTo-Masked (Hide-Text $_ $hide) $secret })
  Set-Content -LiteralPath (Join-Path $dir '90161Z-T11-outlook-r1.txt') -Value $masked -Encoding UTF8
  $masked | ForEach-Object { Write-Host $_ }
  Write-Host ''
  Write-Host 'Saved: 90161Z-T11-outlook-r1.txt in the T11 folder. Nothing was sent or changed.'
} catch {
  $msg = Hide-Text ([string]$_) $hide
  if ($secret) { $msg = ConvertTo-Masked $msg $secret }
  Write-Host ''
  Write-Host ('STOPPED: ' + $msg)
} finally {
  if (-not $NoPause) { [void](Read-Host 'Press Enter to close') }
}
