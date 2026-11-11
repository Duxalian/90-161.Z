<#
.SYNOPSIS
  90-161.Z Task 1 runner: renderer test (docs/gov-test-plan.md). Windows PowerShell 5.1.
.DESCRIPTION
  Asks for the DODID (Enter = this computer's profile folder), goes to the Task 1 folder
  C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T01, checks the 4 task files are there,
  runs the validator, the draft render and the final render, and saves the output to
  90161Z-T01-result-r1.txt in that folder. The DODID is replaced by <DODID> in all output.
  Start it with right-click > Run with PowerShell, so no -File path has to be typed.
#>
$ErrorActionPreference = 'Stop'
$task = 'T01'
$tail = 'OneDrive - United States Air Force\90-161.Z\' + $task
$need = @('Publication.Common.ps1', 'Test-Publication.ps1', 'New-Publication.ps1', 'publication.sample.json')

function Exit-Runner([string]$Message) {
  Write-Host $Message
  [void](Read-Host 'Press Enter to close')
  exit 1
}

$id = (Read-Host 'DODID (press Enter to use this computer''s profile folder)').Trim()
if (-not $id) { $id = Split-Path -Leaf $env:USERPROFILE }
if ($id -notmatch '^[A-Za-z0-9._-]+$') { Exit-Runner 'FOLDER not found: the DODID has characters a folder name cannot have.' }
$dir = Join-Path (Join-Path 'C:\Users' $id) $tail
if (-not (Test-Path -LiteralPath $dir -PathType Container)) {
  Exit-Runner ('FOLDER not found: C:\Users\<DODID>\' + $tail + '. Create it, save the Task 1 files into it, then run again.')
}
Set-Location -LiteralPath $dir

$missing = @($need | Where-Object { -not (Test-Path -LiteralPath (Join-Path $dir $_) -PathType Leaf) })
if ($missing.Count -gt 0) { Exit-Runner ('MISSING in ' + $task + ' folder: ' + ($missing -join ', ')) }
# Files pasted into Notepad and saved locally need no unblock; a failed unblock is not an error here.
try { Get-ChildItem -LiteralPath $dir -Filter *.ps1 | Unblock-File -ErrorAction Stop } catch { Write-Host 'NOTE unblock skipped' }

$log = Join-Path $dir ('90161Z-' + $task + '-result-r1.txt')
$sample = Join-Path $dir 'publication.sample.json'
$steps = @(
  @{ Name = '1 validate'; File = 'Test-Publication.ps1'; Args = @('-Path', $sample) },
  @{ Name = '2 draft'; File = 'New-Publication.ps1'; Args = @('-Path', $sample, '-Mode', 'draft') },
  @{ Name = '3 final'; File = 'New-Publication.ps1'; Args = @('-Path', $sample, '-Mode', 'final', '-Pdf') }
)
# PS 5.1: with Stop, a stderr line from a step (2>&1) would end the runner. Record it instead.
$ErrorActionPreference = 'Continue'
$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('TASK ' + $task + ' renderer test r1, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
foreach ($s in $steps) {
  $lines.Add('STEP ' + $s.Name)
  $out = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $dir $s.File) @($s.Args) 2>&1
  $code = $LASTEXITCODE
  foreach ($o in @($out)) {
    $masked = ([string]$o) -replace [regex]::Escape($id), '<DODID>'
    $lines.Add($masked)
  }
  $lines.Add('STEP ' + $s.Name + ' exit=' + $code)
}
$lines | ForEach-Object { Write-Host $_ }
$lines | Set-Content -LiteralPath $log -Encoding UTF8
Write-Host ''
Write-Host ('Saved: ' + (Split-Path -Leaf $log) + ' in the ' + $task + ' folder. Report the RENDER, VALIDATE and exit lines.')
[void](Read-Host 'Press Enter to close')
