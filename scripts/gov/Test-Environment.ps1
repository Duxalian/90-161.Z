# 90-161.Z environment check (read-only).
# Purpose: find out which renderer options work on this government device.
# It changes nothing, installs nothing, and prints no user name, host name or file content.
#
# How to run (execution policy blocks unsigned .ps1 files on many devices):
#   Open PowerShell (not as admin). Copy everything from "#region CHECK" to "#endregion CHECK"
#   and paste it into the console. Pasted commands are not subject to the script execution policy.
#   Then copy the block between the ===== lines and paste it into the chat.

#region CHECK
$r = [ordered]@{}
$r['PowerShell']     = $PSVersionTable.PSVersion.ToString()
$r['Edition']        = $PSVersionTable.PSEdition
$r['LanguageMode']   = $ExecutionContext.SessionState.LanguageMode.ToString()
$r['ExecPolicy']     = (Get-ExecutionPolicy -List | ForEach-Object { "$($_.Scope)=$($_.ExecutionPolicy)" }) -join '; '
$r['Is64BitProcess'] = [Environment]::Is64BitProcess

foreach ($m in 'PnP.PowerShell','Microsoft.Online.SharePoint.PowerShell','SharePointPnPPowerShellOnline') {
  $found = Get-Module -ListAvailable -Name $m | Sort-Object Version -Descending | Select-Object -First 1
  $r["Module $m"] = if ($found) { $found.Version.ToString() } else { 'not installed' }
}
$r['PSGallery reachable'] = try { if (Find-Module -Name PnP.PowerShell -Repository PSGallery -ErrorAction Stop) { 'yes' } } catch { 'no: ' + $_.Exception.GetType().Name }

$w = $null
try {
  $w = New-Object -ComObject Word.Application -ErrorAction Stop
  $w.Visible = $false
  $r['Word COM'] = 'OK, version ' + $w.Version
  try {
    $d = $w.Documents.Add()
    $d.Content.Text = 'test'
    $d.Content.Font.Name = 'Times New Roman'
    $r['Word COM edit'] = 'OK, font=' + $d.Content.Font.Name
    $d.Close([ref]0)
  } catch { $r['Word COM edit'] = 'FAIL: ' + $_.Exception.Message }
} catch {
  $r['Word COM'] = 'FAIL: ' + $_.Exception.Message
} finally {
  if ($w) { $w.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($w) }
}

$tnr = Test-Path "$env:WINDIR\Fonts\times.ttf"
$r['Times New Roman font'] = if ($tnr) { 'present' } else { 'missing' }

Write-Output '====='
$r.GetEnumerator() | ForEach-Object { '{0}: {1}' -f $_.Key, $_.Value }
Write-Output '====='
#endregion CHECK
