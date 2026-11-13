# Test helper (agent workspace only): run scripts/gov/Test-Publication.ps1 on many inputs in ONE pwsh process.
# One pwsh start per input cost about 0.75 s each (bloat audit 2, PFM P1 2026-11-13). Each run writes <name>.out
# (the script's output lines) and <name>.rc (its exit code; 1 when it throws, with the error in <name>.err).
# -List: a text file with one "name<TAB>path" line per input.
param(
  [Parameter(Mandatory = $true)][string]$List,
  [Parameter(Mandatory = $true)][string]$OutDir
)
$validator = Join-Path $PSScriptRoot '../../scripts/gov/Test-Publication.ps1'
foreach ($line in (Get-Content -LiteralPath $List)) {
  if (-not $line) { continue }
  $name, $path = $line -split "`t", 2
  $global:LASTEXITCODE = 0
  $rc = 0
  try {
    $out = & $validator -Path $path
    $rc = $LASTEXITCODE
  } catch {
    $out = @()
    $rc = 1
    Set-Content -LiteralPath (Join-Path $OutDir "$name.err") -Value ([string]$_)
  }
  Set-Content -LiteralPath (Join-Path $OutDir "$name.out") -Value @($out | ForEach-Object { [string]$_ })
  Set-Content -LiteralPath (Join-Path $OutDir "$name.rc") -Value $rc
}
