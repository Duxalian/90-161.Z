<#
.SYNOPSIS
  90-161.Z Task 13, r1: capture the sensitivity label (Microsoft Purview) from one file the PFM labeled by hand,
  so the renderer can apply the same label to every file it makes. Windows PowerShell 5.1, Word 16 COM.
.DESCRIPTION
  Opens the given .docx read-only in Word (invisible), reads Document.SensitivityLabel.GetLabel() and writes
  ..\Config\90161Z-label.json next to the task folders (label id, tenant id, label name). That file stays on this
  computer: the ids are never printed or sent. Output: LABEL captured name=<label name> PASS, or LABEL FAIL <reason>.
  Parameters: -Id and -NoPause (used by the round runner), -Path (default: the T01 sample .docx).
#>
param([string]$Id, [switch]$NoPause, [string]$Path)
$null = $Id   # accepted for the round runner; this step needs no DODID (paths come from its own folder)
$word = $null; $doc = $null
try {
  $ErrorActionPreference = 'Stop'
  if (-not $Path) { $Path = Join-Path (Join-Path (Split-Path -Parent $PSScriptRoot) 'T01') 'SAMPLEWINGI99-101.docx' }
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw ('no file to read: T01\' + (Split-Path -Leaf $Path) + '. Render it first (Round R01), label it by hand, save it, then run again.') }
  $cfgDir = Join-Path (Split-Path -Parent $PSScriptRoot) 'Config'
  $word = New-Object -ComObject Word.Application
  $word.Visible = $false
  $word.DisplayAlerts = 0
  $doc = $word.Documents.Open([string](Resolve-Path -LiteralPath $Path).Path, $false, $true)   # ConfirmConversions, ReadOnly
  $li = $doc.SensitivityLabel.GetLabel()
  if (-not $li -or -not [string]$li.LabelId) { throw ('the file has no sensitivity label. Open it in Word, choose the label (for example Uncontrolled/General), save, close, then run again.') }
  if (-not (Test-Path -LiteralPath $cfgDir -PathType Container)) { [void](New-Item -ItemType Directory -Path $cfgDir -Force) }
  $cfg = [ordered]@{ labelId = [string]$li.LabelId; siteId = [string]$li.SiteId; labelName = [string]$li.LabelName
                     capturedFrom = (Split-Path -Leaf $Path); captured = (Get-Date -Format 'yyyy-MM-dd HH:mm') }
  $cfg | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $cfgDir '90161Z-label.json') -Encoding UTF8
  Write-Output ('LABEL captured name=' + $cfg.labelName + ' from ' + $cfg.capturedFrom + ' -> Config\90161Z-label.json PASS')
} catch {
  Write-Output ('LABEL FAIL ' + $_.Exception.Message)
} finally {
  if ($doc) { try { $doc.Close([ref]0) } catch { $null = $_ } }
  if ($word) { try { $word.Quit() } catch { $null = $_ }; [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word) }
  if (-not $NoPause) { [void](Read-Host 'Press Enter to close') }
}
