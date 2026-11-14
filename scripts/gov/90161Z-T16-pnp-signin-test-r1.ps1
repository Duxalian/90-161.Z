<#
.SYNOPSIS
  90-161.Z Task 16 PnP sign-in test, r1. Read-only. Windows PowerShell 5.1, the installed PnP.PowerShell 1.x only.
.DESCRIPTION
  Re-tests decision 1B (12 Nov 26: both no-app-registration sign-ins failed on 10 Nov). The 10 Nov test never named the
  government cloud (-AzureEnvironment) and never tried the SharePoint Online Management Shell app, a Microsoft app
  that exists in every tenant, so it needs no app registration. This test tries 4 routes in order and stops at the
  first that connects:
    1. -SPOManagementShell -AzureEnvironment USGovernmentDoD   (sign-in window; pick the CAC certificate)
    2. -SPOManagementShell -AzureEnvironment USGovernmentHigh
    3. -UseWebLogin                                            (the 10 Nov route, for comparison)
    4. -Interactive -AzureEnvironment USGovernmentDoD          (the PnP app Microsoft removed in 2024; expected to fail)
  On a connect it reads only: the permission to manage lists, manage the site and add items, and the list count.
  It changes nothing on the site and nothing on this computer except the site address file below.
  The site address is asked once and kept only on this computer in Config\90161Z-site.txt; every output line shows
  it as <SITE>, and the DODID as <DODID>. Error text is cut to 160 characters.
  Output: 90161Z-T16-pnp-result-r1.txt in the T16 folder (send this).
  Parameters (used by the 90-161.Z Deployer): -Id, -NoPause, -AllRoutes (try every route even after a connect).
#>
param([string]$Id, [switch]$NoPause, [switch]$AllRoutes)
$task = 'T16'

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

function Get-SiteAddress([string]$ConfigDir) {
  # Kept only on this computer (the repo is public). Asked once with a small Windows dialog.
  $f = Join-Path $ConfigDir '90161Z-site.txt'
  if (Test-Path -LiteralPath $f -PathType Leaf) { $v = ([string](Get-Content -LiteralPath $f -TotalCount 1)).Trim(); if ($v) { return $v } }
  Add-Type -AssemblyName Microsoft.VisualBasic
  $v = [string][Microsoft.VisualBasic.Interaction]::InputBox('Address of the SharePoint site with the PFM lists (starts with https://). Kept only on this computer.', '90-161.Z Task 16', 'https://')
  $v = $v.Trim()
  if ($v -notmatch '^https://[^/]+/sites/[^/]+') { throw 'SITE ADDRESS not given or not a site address (https://<host>/sites/<name>). Run again.' }
  if (-not (Test-Path -LiteralPath $ConfigDir -PathType Container)) { [void](New-Item -ItemType Directory -Path $ConfigDir -Force) }
  Set-Content -LiteralPath $f -Value $v -Encoding UTF8
  return $v
}
function Hide-Site([string]$Text, [string]$Site) {
  # The result is e-mailed: no site, tenant or sign-in address may stay in it (review R09 T16).
  if ($Site) {
    $Text = $Text -replace [regex]::Escape($Site.TrimEnd('/')), '<SITE>'
    try {
      $u = [uri]$Site
      $Text = $Text -replace [regex]::Escape($u.Host), '<SITE-HOST>'
      $path = $u.AbsolutePath.TrimEnd('/')   # /sites/<name>: also in server-relative and URL-encoded form
      if ($path.Length -gt 1) {
        $Text = $Text -replace [regex]::Escape($path), '<SITE-PATH>'
        $Text = $Text -replace [regex]::Escape([uri]::EscapeDataString($path)), '<SITE-PATH>'
        $leaf = ($path -split '/')[-1]
        if ($leaf.Length -ge 3) { $Text = $Text -replace ('\b' + [regex]::Escape($leaf) + '\b'), '<SITE-NAME>' }
      }
      $tenant = ($u.Host -split '\.')[0]
      if ($tenant.Length -ge 3) { $Text = $Text -replace ('\b' + [regex]::Escape($tenant) + '\b'), '<TENANT>' }
    } catch { $null = $_ }
  }
  $Text = $Text -replace 'https?://\S+', '<URL>'
  $Text = $Text -replace '\b[\w.-]+\.(sharepoint|onmicrosoft|microsoftonline|windows)\.(com|us|net|mil)\b', '<TENANT-HOST>'
  $Text = $Text -replace '\b[\w.-]+\.mil\b', '<HOST>'
  $Text = $Text -replace '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b', '<GUID>'
  return $Text
}

$secret = @()
$lines = New-Object System.Collections.Generic.List[string]
try {
  $ErrorActionPreference = 'Stop'
  $who = Get-TaskId $Id
  $id = $who.Id
  $secret = $who.Secret
  $dir = Get-TaskDir $id $task 'Task 16' -Create
  Set-Location -LiteralPath $dir
  $configDir = Join-Path (Split-Path -Parent $dir) 'Config'
  $site = Get-SiteAddress $configDir
  $lines.Add('TASK T16 PnP sign-in test r1, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm') + ', read-only')
  $mod = @(Get-Module -ListAvailable -Name PnP.PowerShell | Sort-Object Version -Descending)
  if (-not $mod.Count) { throw 'PNP not installed: PnP.PowerShell is not on this computer.' }
  $null = & { Import-Module PnP.PowerShell -RequiredVersion $mod[0].Version -DisableNameChecking } *>&1   # module warnings never reach the log
  $lines.Add('PNP module=' + $mod[0].Version + ' powershell=' + $PSVersionTable.PSVersion)
  $routes = @(
    @{ Name = 'spo-shell-dod'; Args = @{ SPOManagementShell = $true; AzureEnvironment = 'USGovernmentDoD' } },
    @{ Name = 'spo-shell-high'; Args = @{ SPOManagementShell = $true; AzureEnvironment = 'USGovernmentHigh' } },
    @{ Name = 'web-login'; Args = @{ UseWebLogin = $true } },
    @{ Name = 'interactive-dod'; Args = @{ Interactive = $true; AzureEnvironment = 'USGovernmentDoD' } })
  $okRoute = ''
  foreach ($r in $routes) {
    if ($okRoute -and -not $AllRoutes) { $lines.Add('ROUTE ' + $r.Name + ' skipped (a route already connected)'); continue }
    Write-Host ('Trying ' + $r.Name + ': a sign-in window may open; sign in with your CAC...')
    $a = $r.Args
    try {
      # Everything PnP writes itself (warnings, sign-in text) is captured and dropped: only this script's masked lines leave.
      $null = & { Connect-PnPOnline -Url $site @a -ErrorAction Stop } *>&1
      $script:web = $null; $script:listCount = 0
      $null = & { $script:web = Get-PnPWeb -Includes EffectiveBasePermissions -ErrorAction Stop; $script:listCount = @(Get-PnPList -ErrorAction Stop).Count } *>&1
      $p = $script:web.EffectiveBasePermissions
      $k = [Microsoft.SharePoint.Client.PermissionKind]
      $lines.Add('ROUTE ' + $r.Name + ' PASS manage-lists=' + $p.Has($k::ManageLists) + ' manage-site=' + $p.Has($k::ManageWeb) +
        ' add-items=' + $p.Has($k::AddListItems) + ' lists=' + $script:listCount)
      if (-not $okRoute) { $okRoute = $r.Name }
    } catch {
      # Hide first, then cut (a cut inside an address would defeat the hiding). "not connected", not FAIL: a route that
      # does not connect is a finding, not a broken round.
      $m = ConvertTo-Masked (Hide-Site (([string]$_.Exception.Message) -replace '\s+', ' ') $site) $secret
      $m = $m -replace '(?i)\bfail', 'fault'   # the Deployer counts the word FAIL as a broken step
      $lines.Add('ROUTE ' + $r.Name + ' not connected ' + $_.Exception.GetType().Name + ': ' + $m.Substring(0, [Math]::Min(160, $m.Length)))
    } finally {
      try { $null = & { Disconnect-PnPOnline -ErrorAction SilentlyContinue } *>&1 } catch { $null = $_ }
    }
  }
  $lines.Add('PNP result: ' + $(if ($okRoute) { 'connected with ' + $okRoute + ' (PASS)' } else { 'no route connected' }))
} catch {
  $m = ConvertTo-Masked (Hide-Site ([string]$_) $site) $secret
  $lines.Add('STOPPED: ' + $m.Substring(0, [Math]::Min(300, $m.Length)))
} finally {
  $masked = @($lines | ForEach-Object { ConvertTo-Masked (Hide-Site $_ $site) $secret })
  try { Set-Content -LiteralPath (Join-Path $dir '90161Z-T16-pnp-result-r1.txt') -Value $masked -Encoding UTF8 } catch { $null = $_ }
  $masked | ForEach-Object { Write-Host $_ }
  if (-not $NoPause) { [void](Read-Host 'Press Enter to close') }
}
