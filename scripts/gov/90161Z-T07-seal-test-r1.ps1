<#
.SYNOPSIS
  90-161.Z Task 7 seal test runner, r1 (L-007, L-007a). Windows PowerShell 5.1.
.DESCRIPTION
  Asks for the DODID (Enter = this computer's profile folder), goes to the Task 7 folder
  C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T07, checks the 4 fake test seals in its
  TestSeals subfolder and the renderer scripts in the T01 folder, runs 90161Z-T07-seal-prep-r1.ps1 on the test
  seals, then renders the T01 sample twice (tall seal, round seal) as final .docx and PDF in the T07 folder.
  Saves the output to 90161Z-T07-test-result-r1.txt. The DODID, profile folder name and user name are replaced
  by <DODID> in all output.
#>
$task = 'T07'
$tail = 'OneDrive - United States Air Force\90-161.Z\' + $task
$need = @('90161Z-T07-seal-prep-r1.ps1', 'TestSeals\90161Z-T07-testseal-round-r1.png', 'TestSeals\90161Z-T07-testseal-tall-r1.png', 'TestSeals\90161Z-T07-testseal-soft-r1.png', 'TestSeals\90161Z-T07-testseal-tiny-r1.png')
$needT01 = @('Publication.Common.ps1', 'Test-Publication.ps1', 'New-Publication.ps1', 'publication.sample.json')   # Task 1 r5 files

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
    throw ('FOLDER not found: C:\Users\<DODID>\' + $tail + '. Create it, save the Task 7 files into it, then run again.')
  }
  $t01 = Join-Path (Split-Path -Parent $dir) 'T01'
  $missing01 = @($needT01 | Where-Object { -not (Test-Path -LiteralPath (Join-Path $t01 $_) -PathType Leaf) })
  if ($missing01.Count -gt 0) { throw ('MISSING in T01 folder (save the Task 1 files there first): ' + ($missing01 -join ', ')) }
  Set-Location -LiteralPath $dir
  $missing = @($need | Where-Object { -not (Test-Path -LiteralPath (Join-Path $dir $_) -PathType Leaf) })
  if ($missing.Count -gt 0) { throw ('MISSING in ' + $task + ' folder: ' + ($missing -join ', ')) }
  # Files pasted into Notepad and saved locally need no unblock; a failed unblock is not an error here.
  Get-ChildItem -LiteralPath $dir -Filter *.ps1 | ForEach-Object { Unblock-File -LiteralPath $_.FullName -ErrorAction SilentlyContinue }

  $log = Join-Path $dir '90161Z-T07-test-result-r1.txt'
  $testDir = Join-Path $dir 'TestSeals'
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add('TASK ' + $task + ' seal test r1, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm'))

  # Step 1: seal prep on the fake test seals (no questions; it writes its own result file).
  Write-Host 'STEP 1 seal prep running...'
  $lines.Add('STEP 1 seal prep')
  $prepResult = '90161Z-T07-testprep-result-r1.txt'
  $ErrorActionPreference = 'Continue'
  & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $dir '90161Z-T07-seal-prep-r1.ps1') -Id $id -SealDir $testDir -ResultName $prepResult -NoPause *> $null
  $ErrorActionPreference = 'Stop'
  $prepPath = Join-Path $dir $prepResult
  if (Test-Path -LiteralPath $prepPath) { foreach ($l in Get-Content -LiteralPath $prepPath) { $lines.Add($l) } } else { $lines.Add('STEP 1 seal prep wrote no result file') }

  # Steps 2-3: render the T01 sample with a prepared seal (tall, then round).
  $sampleJson = Get-Content -LiteralPath (Join-Path $t01 'publication.sample.json') -Raw -Encoding UTF8 | ConvertFrom-Json
  $steps = @()
  foreach ($kind in @('tall', 'round')) {
    $sealPng = Join-Path (Join-Path $testDir 'Prepared') ('90161Z-T07-testseal-' + $kind + '-r1.png')
    $sampleJson.meta.shieldImage = $sealPng
    $sampleJson.meta.designator = 'SAMPLEWINGI99-101-' + $kind.ToUpperInvariant()
    $jsonPath = Join-Path $dir ('90161Z-T07-sample-' + $kind + '-r1.json')
    $sampleJson | ConvertTo-Json -Depth 50 | Set-Content -LiteralPath $jsonPath -Encoding UTF8
    $steps += @{ Name = ($(if ($kind -eq 'tall') { '2' } else { '3' }) + ' render ' + $kind + ' seal'); File = 'New-Publication.ps1'; Args = @('-Path', $jsonPath, '-Mode', 'final', '-Pdf', '-OutDir', $dir) }
  }
  foreach ($s in $steps) {
    Write-Host ('STEP ' + $s.Name + ' running (Word steps can take a few minutes; do not close this window)...')
    $lines.Add('STEP ' + $s.Name)
    $stepArgs = $s.Args
    $global:LASTEXITCODE = $null
    # PS 5.1: with Stop, a stderr line from the step (2>&1) would end the runner. Record it instead.
    $ErrorActionPreference = 'Continue'
    $out = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $t01 $s.File) @stepArgs 2>&1
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
  Write-Host ('Saved: ' + (Split-Path -Leaf $log) + ' in the ' + $task + ' folder. Send it with the two PDFs.')
} catch {
  $msg = [string]$_
  if ($secret) { $msg = ConvertTo-Masked $msg $secret }
  Write-Host ''
  Write-Host ('STOPPED: ' + $msg)
  Write-Host 'Result file is NOT complete. Report this STOPPED line.'
} finally {
  [void](Read-Host 'Press Enter to close')
}
