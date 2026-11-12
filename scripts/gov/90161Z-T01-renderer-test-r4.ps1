<#
.SYNOPSIS
  90-161.Z Task 1 runner, r4: renderer test (docs/gov-test-plan.md). Windows PowerShell 5.1.
.DESCRIPTION
  Asks for the DODID (Enter = this computer's profile folder), goes to the Task 1 folder
  C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T01, checks the 4 task files are there,
  runs the validator, the draft render and the final render, and saves the output to
  90161Z-T01-result-r4.txt in that folder after each step. The DODID, profile folder name and user name
  are replaced by <DODID> in all output. Start it with right-click > Run with PowerShell (no -File path typed).
  The window always waits for Enter before it closes, also after an unexpected error.
#>
$task = 'T01'
$tail = 'OneDrive - United States Air Force\90-161.Z\' + $task
$need = @('Publication.Common.ps1', 'Test-Publication.ps1', 'New-Publication.ps1', 'publication.sample.json')

function ConvertTo-Masked([string]$Text, [string[]]$Secret) {
  foreach ($x in $Secret) { $Text = $Text -replace [regex]::Escape($x), '<DODID>' }
  return $Text
}

try {
  $ErrorActionPreference = 'Stop'
  $profileLeaf = ''
  if ($env:USERPROFILE) { $profileLeaf = Split-Path -Leaf $env:USERPROFILE }
  $id = ([string](Read-Host 'DODID (press Enter to use this computer''s profile folder)')).Trim()
  if (-not $id) { $id = $profileLeaf }
  if ($id -notmatch '^[A-Za-z0-9._-]{4,}$') { throw 'DODID not valid: use the folder name under C:\Users (4 or more letters, digits, dot, dash or underscore).' }
  # Longest first, so a longer name is masked before a shorter one inside it.
  $secret = @($id, $profileLeaf, $env:USERNAME) |
    Where-Object { $_ -and $_.Length -ge 4 } | Sort-Object -Unique | Sort-Object Length -Descending

  $dir = Join-Path (Join-Path 'C:\Users' $id) $tail
  if (-not (Test-Path -LiteralPath $dir -PathType Container)) {
    throw ('FOLDER not found: C:\Users\<DODID>\' + $tail + '. Create it, save the Task 1 files into it, then run again.')
  }
  Set-Location -LiteralPath $dir
  $missing = @($need | Where-Object { -not (Test-Path -LiteralPath (Join-Path $dir $_) -PathType Leaf) })
  if ($missing.Count -gt 0) { throw ('MISSING in ' + $task + ' folder: ' + ($missing -join ', ')) }
  # Files pasted into Notepad and saved locally need no unblock; a failed unblock is not an error here.
  Get-ChildItem -LiteralPath $dir -Filter *.ps1 | ForEach-Object { Unblock-File -LiteralPath $_.FullName -ErrorAction SilentlyContinue }

  $log = Join-Path $dir ('90161Z-' + $task + '-result-r4.txt')
  $sample = Join-Path $dir 'publication.sample.json'
  $steps = @(
    @{ Name = '1 validate'; File = 'Test-Publication.ps1'; Args = @('-Path', $sample) },
    @{ Name = '2 draft'; File = 'New-Publication.ps1'; Args = @('-Path', $sample, '-Mode', 'draft') },
    @{ Name = '3 final'; File = 'New-Publication.ps1'; Args = @('-Path', $sample, '-Mode', 'final', '-Pdf') }
  )
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add('TASK ' + $task + ' renderer test r4, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
  foreach ($s in $steps) {
    Write-Host ('STEP ' + $s.Name + ' running (Word steps can take a few minutes; do not close this window)...')
    $lines.Add('STEP ' + $s.Name)
    $stepArgs = $s.Args
    $global:LASTEXITCODE = $null
    # PS 5.1: with Stop, a stderr line from the step (2>&1) would end the runner. Record it instead.
    $ErrorActionPreference = 'Continue'
    $out = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $dir $s.File) @stepArgs 2>&1
    $code = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    foreach ($o in @($out | Where-Object { $null -ne $_ })) {
      $masked = ConvertTo-Masked ([string]$o) $secret
      $lines.Add($masked)
      Write-Host $masked
    }
    $lines.Add('STEP ' + $s.Name + ' exit=' + $code)
    Write-Host ('STEP ' + $s.Name + ' exit=' + $code)
    Set-Content -LiteralPath $log -Value $lines -Encoding UTF8
  }
  Write-Host ''
  Write-Host ('Saved: ' + (Split-Path -Leaf $log) + ' in the ' + $task + ' folder. Report the RENDER, VALIDATE and exit lines.')
} catch {
  $msg = [string]$_
  if ($secret) { $msg = ConvertTo-Masked $msg $secret }
  Write-Host ''
  Write-Host ('STOPPED: ' + $msg)
  Write-Host 'Result file is NOT complete. Report this STOPPED line.'
} finally {
  [void](Read-Host 'Press Enter to close')
}
