# Runs Get-EmblemBoxFromByte from the Task 7 seal prep script on raw pixels made by
# scripts/build_test_seals.py --raw, and compares with the Python reference box. Exit 0 = all match.
param([Parameter(Mandatory = $true)][string]$RawDir)
$ErrorActionPreference = 'Stop'
$script = Join-Path $PSScriptRoot '..\..\scripts\gov\90161Z-T07-seal-prep-r1.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile((Resolve-Path $script).Path, [ref]$null, [ref]$null)
$fn = $ast.FindAll({ param($n) $n -is [System.Management.Automation.Language.FunctionDefinitionAst] -and $n.Name -eq 'Get-EmblemBoxFromByte' }, $true) | Select-Object -First 1
if (-not $fn) { Write-Output 'FAIL function Get-EmblemBoxFromByte not found'; exit 1 }
. ([scriptblock]::Create($fn.Extent.Text))
$bad = 0
foreach ($t in Get-ChildItem -LiteralPath $RawDir -Filter *.txt) {
  $v = (Get-Content -LiteralPath $t.FullName -Raw).Trim() -split ' ' | ForEach-Object { [int]$_ }
  $bytes = [System.IO.File]::ReadAllBytes((Join-Path $RawDir ($t.BaseName + '.bgra')))
  $box = Get-EmblemBoxFromByte $bytes ($v[0] * 4) $v[0] $v[1] 245 16
  $want = ($v[2..5] -join ',')
  $got = ($box -join ',')
  if ($got -eq $want) { Write-Output "PASS $($t.BaseName) box=$got" } else { $bad++; Write-Output "FAIL $($t.BaseName) got=$got want=$want" }
}
exit $bad
