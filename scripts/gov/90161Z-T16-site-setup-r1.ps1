<#
.SYNOPSIS
  90-161.Z Task 16 site setup, r1. Windows PowerShell 5.1, the installed PnP.PowerShell 1.12.0 (no other module).
.DESCRIPTION
  What it is for: sets up the new SharePoint site in one run, so the PFM does not click it by hand (DECISIONS 14 Nov 26:
  optional Deployer PnP write steps, allowed because the read-only PnP test passed). About 10 minutes (an estimate).
  Power Automate and the manual site pages stay the documented fallback for every item.

  WHAT IT CHANGES ON THE SITE (nothing else on the site, nothing on this computer except the files named below):
    a. Lists "PFM Publications" and "PFM Endorsements": item-level permissions. Sets read = all items (1) and edit =
       only the person's own items (2) when they are not already so.
    b. Site time zone: sets (UTC-06:00) Central Time (US and Canada), id 11, when it is another.
    c. Site logo (only with -Logo, which the round passes): uploads T14\90161Z-T14-site-logo-r1.png (no fill, for the blue
       header) and T14\90161Z-T14-site-logo-thumb-r1.png (navy, for white cards) to the Site Assets library and sets them as
       the site logo and the logo thumbnail (PFM 14 Nov 26, option D). Fallback if it reports FAIL: site Settings > Change the look > Header.
    d. Seals: creates the document library "90-161.Z" and its folders "Seals" and "Seals/Prepared" when missing (no unique
       permissions); uploads the images from T07\Seals and T07\Seals\Prepared. An image already there is replaced.
    e. Probe result: if "90161Z-T11-rights-result-r3.json" (else r2) is in the site's default Documents library, copies it to
       the T11 folder (reads the site, writes only the T11 folder).
    f. Task 2 check: counts the PFM lists and their rows (read-only).
  Each item is checked on its own and prints PASS (already right), SET (changed and read back), SKIP (nothing to do) or
  FAIL; one item never stops the others. Counts only: no list, seal or file names are written (seal names are unit names).
  The site address is kept only on this computer in Config\90161Z-site.txt; every output line shows it as <SITE> and the DODID
  as <DODID>. Error text is cut to 160 characters.
  Output: 90161Z-T16-setup-r1.txt in the T16 folder (send this).
  Parameters (used by the 90-161.Z Deployer): -Id, -Logo, -NoPause.
#>
param([string]$Id, [switch]$Logo, [switch]$NoPause)
$task = 'T16'
$LogoName = '90161Z-T14-site-logo-r1.png'
$ThumbName = '90161Z-T14-site-logo-thumb-r1.png'
$Images = @('.png', '.jpg', '.jpeg', '.gif', '.bmp', '.tif', '.tiff')

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
  # Kept only on this computer (the repo is public). Asked every run, filled in with the last address (r2: new site).
  $f = Join-Path $ConfigDir '90161Z-site.txt'
  $last = 'https://'
  if (Test-Path -LiteralPath $f -PathType Leaf) { $v = ([string](Get-Content -LiteralPath $f -TotalCount 1)).Trim(); if ($v) { $last = $v } }
  Add-Type -AssemblyName Microsoft.VisualBasic
  $v = [string][Microsoft.VisualBasic.Interaction]::InputBox('Address of the NEW SharePoint site (the one Task 2 filled), starts with https://. Change it if it shows the old site. Kept only on this computer.', '90-161.Z Task 16', $last)
  $v = $v.Trim()
  if ($v -notmatch '^https://[^/]+/sites/[^/]+') { throw 'SITE ADDRESS not given or not a site address (https://<host>/sites/<name>). Run again.' }
  if (-not (Test-Path -LiteralPath $ConfigDir -PathType Container)) { [void](New-Item -ItemType Directory -Path $ConfigDir -Force) }
  Set-Content -LiteralPath $f -Value $v -Encoding UTF8
  return $v
}
function Hide-Site([string]$Text, [string]$Site) {
  # The result is e-mailed: no site, tenant or sign-in address may stay in it (review R09 T16).
  $Text = $Text -replace '[\w.+-]+@[\w.-]+', '<EMAIL>'   # whole address first: the host rules below keep the name part (review R12 MAJOR)
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


function Add-Item([string]$Name, [scriptblock]$Body, [string[]]$Arg) {
  # One checked item: its lines are added by $Body through Add-Line; an error becomes one FAIL line and the next item runs.
  Write-Host ('ITEM ' + $Name + ' ...')
  try { $null = & { & $Body @Arg } *>&1 }
  catch {
    $m = ConvertTo-Masked (Hide-Site (([string]$_.Exception.Message) -replace '\s+', ' ') $script:site) $script:secret
    $script:lines.Add('ITEM ' + $Name + ' FAIL ' + $_.Exception.GetType().Name + ': ' + $m.Substring(0, [Math]::Min(160, $m.Length)))
  }
}
function Add-Line([string]$Name, [string]$Status, [string]$Text) {
  $script:lines.Add('ITEM ' + $Name + ' ' + $Status + $(if ($Text) { ' ' + $Text } else { '' }))
}
function Get-DocLibRoot {
  # Server-relative root folder of the default document library ("Documents" or "Shared Documents").
  $l = @(Get-PnPList -Includes RootFolder -ErrorAction Stop | Where-Object { $_.BaseTemplate -eq 101 -and @('Documents', 'Shared Documents') -contains $_.Title })[0]
  if (-not $l) { throw [System.InvalidOperationException]::new('default library not found') }
  return $l.RootFolder.ServerRelativeUrl
}
$ListSecurity = {
    $Short = $args[0]; $Title = $args[1]
    $ctx = Get-PnPContext
    $l = Get-PnPList -Identity $Title -Includes ReadSecurity, WriteSecurity -ErrorAction Stop
    $before = 'read=' + $l.ReadSecurity + ' write=' + $l.WriteSecurity
    if ($l.ReadSecurity -eq 1 -and $l.WriteSecurity -eq 2) { Add-Line $Short 'PASS' ($before + ' (already right)'); return }
    $l.ReadSecurity = 1; $l.WriteSecurity = 2; $l.Update(); $ctx.ExecuteQuery()
    $l2 = Get-PnPList -Identity $Title -Includes ReadSecurity, WriteSecurity -ErrorAction Stop
    if ($l2.ReadSecurity -eq 1 -and $l2.WriteSecurity -eq 2) { Add-Line $Short 'SET' ('was ' + $before + ', now read=1 write=2 (read back)') }
    else { Add-Line $Short 'FAIL' ('set did not stick: read=' + $l2.ReadSecurity + ' write=' + $l2.WriteSecurity + '. Fallback: List settings > Advanced settings > Item-level Permissions') }
}

$secret = @()
$site = ''
$lines = New-Object System.Collections.Generic.List[string]
try {
  $ErrorActionPreference = 'Stop'
  $who = Get-TaskId $Id
  $id = $who.Id
  $secret = $who.Secret
  $dir = Get-TaskDir $id $task 'Task 16' -Create
  Set-Location -LiteralPath $dir
  $root = Split-Path -Parent $dir
  $configDir = Join-Path $root 'Config'
  $site = Get-SiteAddress $configDir
  $lines.Add('TASK T16 site setup r1, ' + (Get-Date -Format 'yyyy-MM-dd HH:mm') + ', logo-switch=' + [bool]$Logo)
  $mod = @(Get-Module -ListAvailable -Name PnP.PowerShell | Sort-Object Version -Descending)
  if (-not $mod.Count) { throw 'PNP not installed: PnP.PowerShell is not on this computer.' }
  $null = & { Import-Module PnP.PowerShell -RequiredVersion $mod[0].Version -DisableNameChecking } *>&1
  $lines.Add('PNP module=' + $mod[0].Version + ' powershell=' + $PSVersionTable.PSVersion)
  Write-Host 'Connecting with web login: a sign-in window may open; sign in with your CAC...'
  $connected = $false
  try {
    $null = & { Connect-PnPOnline -Url $site -UseWebLogin -ErrorAction Stop } *>&1
    $script:web = $null
    $null = & { $script:web = Get-PnPWeb -Includes EffectiveBasePermissions -ErrorAction Stop } *>&1
    $p = $script:web.EffectiveBasePermissions
    $k = [Microsoft.SharePoint.Client.PermissionKind]
    $lines.Add('ROUTE web-login PASS manage-lists=' + $p.Has($k::ManageLists) + ' manage-site=' + $p.Has($k::ManageWeb) + ' manage-permissions=' + $p.Has($k::ManagePermissions))
    $connected = $true
  } catch {
    $m = ConvertTo-Masked (Hide-Site (([string]$_.Exception.Message) -replace '\s+', ' ') $site) $secret
    $m = $m -replace '(?i)\bfail', 'fault'
    $lines.Add('ROUTE web-login not connected ' + $_.Exception.GetType().Name + ': ' + $m.Substring(0, [Math]::Min(160, $m.Length)))
  }
  if ($connected) {
    # a. Item-level permissions on the two lists.
    Add-Item 'a1-permissions-publications' $ListSecurity @('a1-permissions-publications', 'PFM Publications')
    Add-Item 'a2-permissions-endorsements' $ListSecurity @('a2-permissions-endorsements', 'PFM Endorsements')
    # b. Site time zone (id 11 = UTC-06:00 Central Time).
    Add-Item 'b-time-zone' {
      $ctx = Get-PnPContext
      $w = Get-PnPWeb -Includes RegionalSettings, RegionalSettings.TimeZone -ErrorAction Stop
      $id0 = [int]$w.RegionalSettings.TimeZone.Id
      if ($id0 -eq 11) { Add-Line 'b-time-zone' 'PASS' 'id=11 (already Central)'; return }
      $tz = $w.RegionalSettings.TimeZones.GetById(11)
      $ctx.Load($tz); $ctx.ExecuteQuery()
      $w.RegionalSettings.TimeZone = $tz
      $w.RegionalSettings.Update(); $ctx.ExecuteQuery()
      $w2 = Get-PnPWeb -Includes RegionalSettings, RegionalSettings.TimeZone -ErrorAction Stop
      if ([int]$w2.RegionalSettings.TimeZone.Id -eq 11) { Add-Line 'b-time-zone' 'SET' ('was id=' + $id0 + ', now id=11 (read back)') }
      else { Add-Line 'b-time-zone' 'FAIL' ('now id=' + $w2.RegionalSettings.TimeZone.Id + '. Fallback: Site settings > Regional settings > Time zone') }
    }
    # c. Site logo.
    if (-not $Logo) { Add-Line 'c-logo' 'SKIP' 'switch -Logo not given' }
    else {
      Add-Item 'c-logo' {
        $logoFile = Join-Path $root ('T14\' + $LogoName)
        $thumbFile = Join-Path $root ('T14\' + $ThumbName)
        $missing = @(@($logoFile, $thumbFile) | Where-Object { -not (Test-Path -LiteralPath $_ -PathType Leaf) })
        if ($missing.Count -gt 0) { Add-Line 'c-logo' 'FAIL' ('logo files missing in the T14 folder: ' + (($missing | ForEach-Object { Split-Path -Leaf $_ }) -join ', ')); return }
        $assets = @(Get-PnPList -Includes RootFolder -ErrorAction Stop | Where-Object { $_.Title -eq 'Site Assets' })[0]
        if (-not $assets) { Add-Line 'c-logo' 'FAIL' 'Site Assets library not found. Fallback: Change the look > Header'; return }
        $url = (Add-PnPFile -Path $logoFile -Folder $assets.RootFolder.ServerRelativeUrl -ErrorAction Stop).ServerRelativeUrl
        $thumbUrl = (Add-PnPFile -Path $thumbFile -Folder $assets.RootFolder.ServerRelativeUrl -ErrorAction Stop).ServerRelativeUrl
        $how = ''
        $cmd = Get-Command Set-PnPWebHeader -ErrorAction SilentlyContinue
        if ($cmd -and $cmd.Parameters.ContainsKey('SiteLogoUrl')) {
          try {
            $a = @{ SiteLogoUrl = $url; ErrorAction = 'Stop' }
            if ($cmd.Parameters.ContainsKey('SiteThumbnailUrl')) { $a.SiteThumbnailUrl = $thumbUrl }
            Set-PnPWebHeader @a; $how = 'Set-PnPWebHeader' + $(if ($a.ContainsKey('SiteThumbnailUrl')) { ' (logo and thumbnail)' } else { ' (logo only)' })
          } catch { $how = '' }
        }
        if (-not $how) {
          try { Set-PnPSite -LogoFilePath $logoFile -ErrorAction Stop; $how = 'Set-PnPSite -LogoFilePath' } catch { $how = '' }
        }
        if (-not $how) {
          try { $ctx = Get-PnPContext; $w = $ctx.Web; $w.SiteLogoUrl = $url; $w.Update(); $ctx.ExecuteQuery(); $how = 'CSOM Web.SiteLogoUrl (logo only)' } catch { $how = '' }
        }
        $w3 = Get-PnPWeb -Includes SiteLogoUrl -ErrorAction Stop
        if ($how -and $w3.SiteLogoUrl) { Add-Line 'c-logo' 'SET' ('uploaded to Site Assets; set by ' + $how + '; site logo now set (read back)') }
        else { Add-Line 'c-logo' 'FAIL' 'uploaded to Site Assets but no cmdlet set it. Fallback: site Settings > Change the look > Header, pick the file in Site Assets' }
      }
    }
    # d. Seals library, folders and uploads.
    Add-Item 'd-seals' {
      $created = ''
      $lib = Get-PnPList -Identity '90-161.Z' -ErrorAction SilentlyContinue
      if (-not $lib) { $null = New-PnPList -Title '90-161.Z' -Template DocumentLibrary -Url '90-161.Z' -ErrorAction Stop; $created = 'library created; ' }
      foreach ($pair in @(@('90-161.Z', 'Seals'), @('90-161.Z/Seals', 'Prepared'))) {
        $full = $pair[0] + '/' + $pair[1]
        $fo = Get-PnPFolder -Url $full -ErrorAction SilentlyContinue
        if (-not $fo) { $null = Add-PnPFolder -Name $pair[1] -Folder $pair[0] -ErrorAction Stop; $created += 'folder ' + $pair[1] + ' created; ' }
      }
      $up = 0; $bad = 0; $found = 0
      foreach ($pair in @(@((Join-Path $root 'T07\Seals'), '90-161.Z/Seals'), @((Join-Path $root 'T07\Seals\Prepared'), '90-161.Z/Seals/Prepared'))) {
        if (-not (Test-Path -LiteralPath $pair[0] -PathType Container)) { continue }
        foreach ($f in @(Get-ChildItem -LiteralPath $pair[0] -File | Where-Object { $Images -contains $_.Extension.ToLowerInvariant() })) {
          $found++
          try { $null = Add-PnPFile -Path $f.FullName -Folder $pair[1] -ErrorAction Stop; $up++ } catch { $bad++ }
        }
      }
      if ($found -eq 0) { Add-Line 'd-seals' 'SKIP' ($created + 'no local images in T07\Seals yet (run the seal prep step first)') }
      elseif ($bad -gt 0) { Add-Line 'd-seals' 'FAIL' ($created + 'uploaded=' + $up + ' not-uploaded=' + $bad) }
      else { Add-Line 'd-seals' 'SET' ($created + 'uploaded=' + $up) }
    }
    # e. Probe result file.
    Add-Item 'e-probe-result' {
      $rel = Get-DocLibRoot
      $t11 = Join-Path $root 'T11'
      if (-not (Test-Path -LiteralPath $t11 -PathType Container)) { [void](New-Item -ItemType Directory -Path $t11) }
      foreach ($n in @('90161Z-T11-rights-result-r3.json', '90161Z-T11-rights-result-r2.json')) {
        $got = $false
        try { Get-PnPFile -Url ($rel + '/' + $n) -Path $t11 -FileName $n -AsFile -Force -ErrorAction Stop; $got = Test-Path -LiteralPath (Join-Path $t11 $n) -PathType Leaf } catch { $got = $false }
        if ($got) { Add-Line 'e-probe-result' 'SET' ('copied ' + $n.Substring(0, $n.Length - 5) + ' to the T11 folder'); return }
      }
      Add-Line 'e-probe-result' 'SKIP' 'no result file in the default library yet (run the probe flow first)'
    }
    # f. Task 2 check.
    Add-Item 'f-task2-lists' {
      $pl = @(Get-PnPList -ErrorAction Stop | Where-Object { $_.Title -like 'PFM *' })
      $rows = 0; foreach ($l in $pl) { $rows += [int]$l.ItemCount }
      if ($pl.Count -eq 12) { Add-Line 'f-task2-lists' 'PASS' ('lists=12 rows=' + $rows) }
      else { Add-Line 'f-task2-lists' 'FAIL' ('lists=' + $pl.Count + ' (expected 12) rows=' + $rows) }
    }
  }
  try { $null = & { Disconnect-PnPOnline -ErrorAction SilentlyContinue } *>&1 } catch { $null = $_ }
  $nf = @($lines | Where-Object { $_ -match '^ITEM .* FAIL' }).Count
  $lines.Add('SETUP items done, items with problems=' + $nf)
} catch {
  $m = ConvertTo-Masked (Hide-Site ([string]$_) $site) $secret
  $lines.Add('STOPPED: ' + $m.Substring(0, [Math]::Min(300, $m.Length)))
} finally {
  $masked = @($lines | ForEach-Object { ConvertTo-Masked (Hide-Site $_ $site) $secret })
  try { Set-Content -LiteralPath (Join-Path $dir '90161Z-T16-setup-r1.txt') -Value $masked -Encoding UTF8 } catch { $null = $_ }
  $masked | ForEach-Object { Write-Host $_ }
  if (-not $NoPause) { [void](Read-Host 'Press Enter to close') }
}
