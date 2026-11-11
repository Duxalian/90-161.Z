# 90-161.Z SharePoint connection check (read-only).
# Purpose: confirm that the installed PnP.PowerShell 1.x can connect to the 90-161.Z site
# without an app registration (cookie sign-in with -UseWebLogin), and that you can create lists there.
# It changes nothing. It prints no site name, URL, user name or list name.
#
# How to run: open PowerShell (not as admin), paste everything from "#region CHECK" to "#endregion CHECK".
# When asked, type the site URL. A sign-in window opens: sign in with your CAC as usual.
# Copy the lines between the ===== markers into the chat.

#region CHECK
$SiteUrl = Read-Host 'Site URL (https://...sharepoint-mil.us/sites/...)'
$r = [ordered]@{}
try {
  Import-Module PnP.PowerShell -ErrorAction Stop
  $r['PnP module'] = (Get-Module PnP.PowerShell).Version.ToString()
} catch { $r['PnP module'] = 'FAIL: ' + $_.Exception.Message }

try {
  $mode = Read-Host 'Sign-in: W = web sign-in window (CAC), P = username/password prompt'
  if ($mode -eq 'P') {
    # Get-Credential shows a Windows prompt. The password stays in memory only; it is never saved or printed.
    $cred = Get-Credential -Message '90-161.Z: SharePoint account'
    Connect-PnPOnline -Url $SiteUrl -Credentials $cred -ErrorAction Stop
    Remove-Variable cred
    $r['Connect'] = 'OK (credentials)'
  } else {
    Connect-PnPOnline -Url $SiteUrl -UseWebLogin -ErrorAction Stop
    $r['Connect'] = 'OK (web login)'
  }
  try {
    $web = Get-PnPWeb -Includes EffectiveBasePermissions -ErrorAction Stop
    $p = $web.EffectiveBasePermissions
    $r['Can manage lists']  = $p.Has([Microsoft.SharePoint.Client.PermissionKind]::ManageLists)
    $r['Can manage web']    = $p.Has([Microsoft.SharePoint.Client.PermissionKind]::ManageWeb)
    $r['Can add list items']= $p.Has([Microsoft.SharePoint.Client.PermissionKind]::AddListItems)
    $r['List count']        = @(Get-PnPList -ErrorAction Stop).Count
  } catch { $r['Read web'] = 'FAIL: ' + $_.Exception.Message }
  try {
    $flowOk = (Get-PnPFeature -Scope Web -ErrorAction Stop | Measure-Object).Count
    $r['Web features readable'] = "yes ($flowOk)"
  } catch { $r['Web features readable'] = 'no' }
  Disconnect-PnPOnline
} catch {
  $r['Connect'] = 'FAIL: ' + $_.Exception.Message
}

Write-Output '====='
$r.GetEnumerator() | ForEach-Object { '{0}: {1}' -f $_.Key, $_.Value }
Write-Output '====='
#endregion CHECK
