# 90-161.Z PSGallery diagnostic (read-only). Installs nothing.
# Run in a normal PowerShell window. Copy the lines between the ===== markers into the chat.
$r = [ordered]@{}
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$r['TLS'] = [Net.ServicePointManager]::SecurityProtocol.ToString()
[Net.WebRequest]::DefaultWebProxy.Credentials = [Net.CredentialCache]::DefaultNetworkCredentials
$r['NuGet provider'] = try { (Get-PackageProvider -ListAvailable -Name NuGet -ErrorAction Stop | Select-Object -First 1).Version.ToString() } catch { 'missing' }
$r['PSGallery repo'] = try { $g = Get-PSRepository -Name PSGallery -ErrorAction Stop; "$($g.SourceLocation) ($($g.InstallationPolicy))" } catch { 'not registered' }
$r['HTTP to gallery'] = try { (Invoke-WebRequest -Uri 'https://www.powershellgallery.com/api/v2/' -UseBasicParsing -UseDefaultCredentials -TimeoutSec 20 -ErrorAction Stop).StatusCode } catch { 'FAIL: ' + $_.Exception.Message }
$r['Find-Module'] = try { (Find-Module -Name PnP.PowerShell -Repository PSGallery -ErrorAction Stop).Version.ToString() } catch { 'FAIL: ' + $_.Exception.Message }
Write-Output '====='
$r.GetEnumerator() | ForEach-Object { '{0}: {1}' -f $_.Key, $_.Value }
Write-Output '====='
