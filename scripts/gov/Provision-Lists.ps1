<#
.SYNOPSIS
  Provision the 90-161.Z SharePoint lists from schemas/lists/*.json (idempotent).
.DESCRIPTION
  Target: Windows PowerShell 5.1 with PnP.PowerShell 1.12.0 (cookie sign-in, no app registration).
  Modes:
    -PlanOnly  No PnP, no network. Loads and validates the schemas and prints the ordered plan.
    -DryRun    Connects and compares with the site. Changes nothing.
    (neither)  Creates missing lists, fields and views. Existing ones are skipped.
  Output never contains the site URL, user names, passwords or list content.
  Nothing is stored. There is no password parameter: the credential prompt (Get-Credential) keeps it in memory only.
.PARAMETER SiteUrl
  Site URL. If omitted (and not -PlanOnly) the script asks for it.
.PARAMETER SchemaPath
  Folder with the list schema files. Default: schemas/lists in this repo.
.PARAMETER SignIn
  Web (browser sign-in window) or Credential (Get-Credential prompt). If omitted the script asks.
.PARAMETER SeedStages
  Also add the Stage rows from Stages.json when the row's stage number is not in the list yet.
  The stage model is still marked draft in docs/process-model.md: verify it first.
#>
[CmdletBinding()]
param(
  [string]$SiteUrl,
  [string]$SchemaPath,
  [ValidateSet('Web', 'Credential')]
  [string]$SignIn,
  [switch]$PlanOnly,
  [switch]$DryRun,
  [switch]$SeedStages
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

if (-not $SchemaPath) {
  $SchemaPath = Join-Path (Join-Path (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) 'schemas') 'lists'
}

$script:AllowedTypes = @('Text', 'Note', 'Choice', 'Number', 'DateTime', 'Boolean', 'URL', 'Lookup')
$script:Counts = [ordered]@{
  ListsCreated = 0; ListsSkipped = 0; FieldsCreated = 0; FieldsSkipped = 0
  ViewsCreated = 0; ViewsSkipped = 0; SeedsCreated = 0; SeedsSkipped = 0; Failed = 0
}

function Get-SafeMessage {
  # Strips URLs from an error message so the site URL never reaches the screen.
  param([string]$Text)
  if (-not $Text) { return '' }
  $t = [regex]::Replace($Text, 'https?://\S+', '<url>')
  if ($SiteUrl) { $t = $t.Replace($SiteUrl, '<url>') }
  $t = [regex]::Replace($t, '\b[\w.-]+\.(us|mil|com|gov|net)\b', '<host>')
  $t = [regex]::Replace($t, '/(sites|teams)/\S+', '/$1/<site>')
  return $t
}

function Test-HasProp {
  param($Object, [string]$Name)
  return ($null -ne $Object) -and ($Object.PSObject.Properties.Name -contains $Name)
}

function Read-ListSchema {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path -PathType Container)) { throw 'Schema folder not found.' }
  $files = @(Get-ChildItem -LiteralPath $Path -Filter *.json | Sort-Object Name)
  if ($files.Count -eq 0) { throw 'No schema files found.' }
  $schemas = @()
  foreach ($f in $files) {
    $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    try { $s = $raw | ConvertFrom-Json } catch { throw ('Invalid JSON in ' + $f.Name) }
    $s | Add-Member -NotePropertyName SourceFile -NotePropertyValue $f.Name -Force
    $schemas += $s
  }
  return $schemas
}

function Test-ListSchema {
  # Returns an array of problem strings (empty = valid).
  param($Schemas)
  $problems = New-Object System.Collections.Generic.List[string]
  $names = @($Schemas | ForEach-Object { if (Test-HasProp $_ 'list') { $_.list } })
  foreach ($s in $Schemas) {
    $where = $s.SourceFile
    foreach ($k in @('list', 'description', 'fields', 'views', 'ref')) {
      if (-not (Test-HasProp $s $k)) { $problems.Add("$where : missing '$k'") }
    }
    if (-not (Test-HasProp $s 'fields')) { continue }
    $seen = @{}
    foreach ($f in @($s.fields)) {
      foreach ($k in @('internalName', 'displayName', 'type', 'required', 'ref')) {
        if (-not (Test-HasProp $f $k)) { $problems.Add("$where : a field is missing '$k'") }
      }
      if (-not (Test-HasProp $f 'internalName')) { continue }
      $n = $f.internalName
      if ($n -notmatch '^[A-Za-z][A-Za-z0-9_]*$') { $problems.Add("$where : bad internal name '$n'") }
      if ($seen.ContainsKey($n)) { $problems.Add("$where : duplicate field '$n'") }
      $seen[$n] = $true
      if ((Test-HasProp $f 'ref') -and -not $f.ref) { $problems.Add("$where : field '$n' has empty ref") }
      if ((Test-HasProp $f 'type') -and ($script:AllowedTypes -notcontains $f.type)) { $problems.Add("$where : field '$n' has unknown type '$($f.type)'") }
      if ((Test-HasProp $f 'type') -and $f.type -eq 'Choice') {
        if (-not (Test-HasProp $f 'choices') -or @($f.choices).Count -eq 0) { $problems.Add("$where : choice field '$n' has no choices") }
        elseif ((Test-HasProp $f 'default') -and $f.default -and (@($f.choices) -notcontains $f.default)) { $problems.Add("$where : default of '$n' is not a choice") }
      }
      if ((Test-HasProp $f 'type') -and $f.type -eq 'Lookup') {
        if (-not (Test-HasProp $f 'lookup') -or -not (Test-HasProp $f.lookup 'list')) { $problems.Add("$where : lookup field '$n' has no target") }
        elseif ($names -notcontains $f.lookup.list) { $problems.Add("$where : lookup target of '$n' is not a schema list") }
      }
    }
    if (Test-HasProp $s 'views') {
      foreach ($v in @($s.views)) {
        if (-not (Test-HasProp $v 'name') -or -not (Test-HasProp $v 'fields')) { $problems.Add("$where : a view needs name and fields"); continue }
        foreach ($vf in @($v.fields)) {
          if (-not $seen.ContainsKey($vf)) { $problems.Add("$where : view '$($v.name)' uses unknown field '$vf'") }
        }
        if (Test-HasProp $v 'orderBy') {
          foreach ($o in @($v.orderBy)) { if (-not $seen.ContainsKey($o.field)) { $problems.Add("$where : view '$($v.name)' orders by unknown field '$($o.field)'") } }
        }
        if (Test-HasProp $v 'where') {
          if (-not $seen.ContainsKey($v.where.field)) { $problems.Add("$where : view '$($v.name)' filters on unknown field") }
          if (@('Eq', 'Neq') -notcontains $v.where.op) { $problems.Add("$where : view '$($v.name)' filter op must be Eq or Neq") }
        }
      }
    }
  }
  return ,$problems.ToArray()
}

function Get-ProvisionOrder {
  # Lookup targets first. Fails on a cycle.
  param($Schemas)
  $remaining = @($Schemas)
  $done = @{}
  $ordered = @()
  while ($remaining.Count -gt 0) {
    $progress = $false
    $next = @()
    foreach ($item in $remaining) {
      $deps = @($item.fields | Where-Object { $_.type -eq 'Lookup' } | ForEach-Object { $_.lookup.list } | Where-Object { $_ -ne $item.list })
      $ready = $true
      foreach ($d in $deps) { if (-not $done.ContainsKey($d)) { $ready = $false } }
      if ($ready) {
        $ordered += $item
        $done[$item.list] = $true
        $progress = $true
      } else {
        $next += $item
      }
    }
    if (-not $progress) { throw 'Lookup dependency cycle between schema lists.' }
    $remaining = $next
  }
  return $ordered
}

function Write-Plan {
  param($Ordered)
  $lists = 0; $fields = 0; $views = 0
  $i = 0
  foreach ($s in $Ordered) {
    $i++
    $lists++
    $fs = @($s.fields | Where-Object { -not (Test-HasProp $_ 'builtIn') -or -not $_.builtIn })
    $fields += $fs.Count
    $vs = @($s.views)
    $views += $vs.Count
    $seedCount = 0
    if (Test-HasProp $s 'seed') { $seedCount = @($s.seed).Count }
    Write-Host ('{0}. {1}: {2} fields, {3} views, {4} seed rows (from {5})' -f $i, $s.list, $fs.Count, $vs.Count, $seedCount, $s.SourceFile)
    foreach ($f in $fs) {
      $extra = ''
      if ($f.type -eq 'Lookup') { $extra = ' -> ' + $f.lookup.list }
      Write-Host ('     field {0} [{1}{2}] ref: {3}' -f $f.internalName, $f.type, $extra, $f.ref)
    }
    foreach ($v in $vs) { Write-Host ('     view  {0}' -f $v.name) }
  }
  return [pscustomobject]@{ Lists = $lists; Fields = $fields; Views = $views }
}

function ConvertTo-XmlText {
  param([string]$Text)
  return [System.Security.SecurityElement]::Escape($Text)
}

function Get-FieldXml {
  param($Field, [string]$LookupListId)
  $attrs = @(
    'ID="{' + [guid]::NewGuid().ToString() + '}"'
    'Name="' + (ConvertTo-XmlText $Field.internalName) + '"'
    'StaticName="' + (ConvertTo-XmlText $Field.internalName) + '"'
    'DisplayName="' + (ConvertTo-XmlText $Field.displayName) + '"'
    'Required="' + ([string]([bool]$Field.required)).ToUpper() + '"'
  )
  $inner = ''
  switch ($Field.type) {
    'Text'     { $attrs += 'Type="Text"' }
    'Note'     { $attrs += 'Type="Note"'; $attrs += 'NumLines="6"' }
    'Number'   { $attrs += 'Type="Number"' }
    'Boolean'  { $attrs += 'Type="Boolean"' }
    'DateTime' { $attrs += 'Type="DateTime"'; $attrs += 'Format="DateOnly"' }
    'URL'      { $attrs += 'Type="URL"'; $attrs += 'Format="Hyperlink"' }
    'Choice'   {
      $attrs += 'Type="Choice"'
      $inner = '<CHOICES>' + ((@($Field.choices) | ForEach-Object { '<CHOICE>' + (ConvertTo-XmlText $_) + '</CHOICE>' }) -join '') + '</CHOICES>'
    }
    'Lookup'   {
      $attrs += 'Type="Lookup"'
      $attrs += 'List="{' + $LookupListId + '}"'
      $show = 'Title'
      if (Test-HasProp $Field.lookup 'showField') { $show = $Field.lookup.showField }
      $attrs += 'ShowField="' + (ConvertTo-XmlText $show) + '"'
    }
  }
  if ((Test-HasProp $Field 'default') -and $null -ne $Field.default -and "$($Field.default)" -ne '') {
    $inner += '<Default>' + (ConvertTo-XmlText "$($Field.default)") + '</Default>'
  }
  return '<Field ' + ($attrs -join ' ') + '>' + $inner + '</Field>'
}

function Get-ViewQuery {
  param($View)
  $q = ''
  if (Test-HasProp $View 'where') {
    $w = $View.where
    $tag = $w.op
    $q += '<Where><' + $tag + '><FieldRef Name="' + (ConvertTo-XmlText $w.field) + '"/><Value Type="' + (ConvertTo-XmlText $w.type) + '">' + (ConvertTo-XmlText "$($w.value)") + '</Value></' + $tag + '></Where>'
  }
  if (Test-HasProp $View 'orderBy') {
    $q += '<OrderBy>'
    foreach ($o in @($View.orderBy)) {
      $asc = 'TRUE'
      if (-not $o.ascending) { $asc = 'FALSE' }
      $q += '<FieldRef Name="' + (ConvertTo-XmlText $o.field) + '" Ascending="' + $asc + '"/>'
    }
    $q += '</OrderBy>'
  }
  return $q
}

function Test-ListPresent {
  param([string]$Name)
  $l = Get-PnPList -Identity $Name -ErrorAction SilentlyContinue
  return ($null -ne $l)
}

function Get-ExistingFieldName {
  param([string]$ListName)
  return @(Get-PnPField -List $ListName -ErrorAction Stop | ForEach-Object { $_.InternalName })
}

function Invoke-OneSchema {
  param($Schema, [bool]$ReadOnly, [hashtable]$Planned)
  $name = $Schema.list
  $listExists = Test-ListPresent -Name $name
  if ($listExists) {
    $script:Counts.ListsSkipped++
    Write-Output ('list  {0}: exists, skipped' -f $name)
  } elseif ($ReadOnly) {
    $script:Counts.ListsCreated++
    Write-Output ('list  {0}: would create' -f $name)
  } else {
    try {
      [void](New-PnPList -Title $name -Template GenericList -OnQuickLaunch -ErrorAction Stop)
      $script:Counts.ListsCreated++
      $listExists = $true
      Write-Output ('list  {0}: created' -f $name)
    } catch {
      $script:Counts.Failed++
      Write-Output ('list  {0}: FAILED ({1}) {2}' -f $name, $_.Exception.GetType().Name, (Get-SafeMessage $_.Exception.Message))
      return
    }
  }
  $Planned[$name] = $true

  $existing = @()
  if ($listExists) { $existing = Get-ExistingFieldName -ListName $name }
  foreach ($f in @($Schema.fields)) {
    if ((Test-HasProp $f 'builtIn') -and $f.builtIn) { continue }
    if ($existing -contains $f.internalName) {
      $script:Counts.FieldsSkipped++
      Write-Output ('  field {0}.{1}: exists, skipped' -f $name, $f.internalName)
      continue
    }
    if ($ReadOnly) {
      $script:Counts.FieldsCreated++
      Write-Output ('  field {0}.{1}: would create' -f $name, $f.internalName)
      continue
    }
    try {
      $lookupId = ''
      if ($f.type -eq 'Lookup') {
        $target = Get-PnPList -Identity $f.lookup.list -ErrorAction Stop
        $lookupId = $target.Id.ToString()
      }
      $xml = Get-FieldXml -Field $f -LookupListId $lookupId
      [void](Add-PnPFieldFromXml -List $name -FieldXml $xml -ErrorAction Stop)
      $script:Counts.FieldsCreated++
      Write-Output ('  field {0}.{1}: created' -f $name, $f.internalName)
    } catch {
      $script:Counts.Failed++
      Write-Output ('  field {0}.{1}: FAILED ({2}) {3}' -f $name, $f.internalName, $_.Exception.GetType().Name, (Get-SafeMessage $_.Exception.Message))
    }
  }

  foreach ($v in @($Schema.views)) {
    $viewExists = $false
    if ($listExists) {
      $found = Get-PnPView -List $name -Identity $v.name -ErrorAction SilentlyContinue
      $viewExists = ($null -ne $found)
    }
    if ($viewExists) {
      $script:Counts.ViewsSkipped++
      Write-Output ('  view  {0}.{1}: exists, skipped' -f $name, $v.name)
      continue
    }
    if ($ReadOnly) {
      $script:Counts.ViewsCreated++
      Write-Output ('  view  {0}.{1}: would create' -f $name, $v.name)
      continue
    }
    try {
      $query = Get-ViewQuery -View $v
      $isDefault = $false
      if ((Test-HasProp $v 'default') -and $v.default) { $isDefault = $true }
      $viewFields = @($v.fields)
      if ($query) {
        [void](Add-PnPView -List $name -Title $v.name -Fields $viewFields -Query $query -SetAsDefault:$isDefault -ErrorAction Stop)
      } else {
        [void](Add-PnPView -List $name -Title $v.name -Fields $viewFields -SetAsDefault:$isDefault -ErrorAction Stop)
      }
      $script:Counts.ViewsCreated++
      Write-Output ('  view  {0}.{1}: created' -f $name, $v.name)
    } catch {
      $script:Counts.Failed++
      Write-Output ('  view  {0}.{1}: FAILED ({2}) {3}' -f $name, $v.name, $_.Exception.GetType().Name, (Get-SafeMessage $_.Exception.Message))
    }
  }

  if ($script:DoSeed -and (Test-HasProp $Schema 'seed')) {
    $have = @{}
    if ($listExists) {
      foreach ($item in @(Get-PnPListItem -List $name -PageSize 100 -ErrorAction Stop)) {
        $have[[string]$item.FieldValues['StageNumber']] = $true
      }
    }
    foreach ($row in @($Schema.seed)) {
      $key = [string]$row.StageNumber
      if ($have.ContainsKey($key)) {
        $script:Counts.SeedsSkipped++
        continue
      }
      if ($ReadOnly) {
        $script:Counts.SeedsCreated++
        continue
      }
      try {
        $values = @{ Title = $row.Title; StageNumber = $row.StageNumber; DafmanRef = $row.DafmanRef; IsOptional = [bool]$row.IsOptional }
        if ($row.ExitCondition) { $values['ExitCondition'] = $row.ExitCondition }
        [void](Add-PnPListItem -List $name -Values $values -ErrorAction Stop)
        $script:Counts.SeedsCreated++
      } catch {
        $script:Counts.Failed++
        Write-Output ('  seed  {0} stage {1}: FAILED ({2})' -f $name, $key, $_.Exception.GetType().Name)
      }
    }
    Write-Output ('  seed  {0}: created/would create {1}, skipped {2} (running totals)' -f $name, $script:Counts.SeedsCreated, $script:Counts.SeedsSkipped)
  }
}

# ---- main ----
$script:DoSeed = [bool]$SeedStages
$schemas = Read-ListSchema -Path $SchemaPath
$problems = Test-ListSchema -Schemas $schemas
if ($problems.Count -gt 0) {
  foreach ($p in $problems) { Write-Output ('SCHEMA PROBLEM: ' + $p) }
  Write-Output ('SCHEMA problems=' + $problems.Count)
  exit 2
}
$ordered = Get-ProvisionOrder -Schemas $schemas

if ($PlanOnly) {
  $tot = Write-Plan -Ordered $ordered
  Write-Output ('PLAN lists={0} fields={1} views={2}' -f $tot.Lists, $tot.Fields, $tot.Views)
  exit 0
}

if (-not $SiteUrl) { $SiteUrl = Read-Host 'Site URL (https://...sharepoint-mil.us/sites/...)' }
if (-not $SignIn) {
  $mode = Read-Host 'Sign-in: W = web sign-in window (CAC), P = username/password prompt'
  if ($mode -eq 'P') { $SignIn = 'Credential' } else { $SignIn = 'Web' }
}

try {
  Import-Module PnP.PowerShell -ErrorAction Stop
  if ($SignIn -eq 'Credential') {
    # Get-Credential shows a Windows prompt. The password stays in memory only; it is never saved or printed.
    $cred = Get-Credential -Message '90-161.Z: SharePoint account'
    try { Connect-PnPOnline -Url $SiteUrl -Credentials $cred -ErrorAction Stop }
    finally { Remove-Variable cred -ErrorAction SilentlyContinue }
  } else {
    Connect-PnPOnline -Url $SiteUrl -UseWebLogin -ErrorAction Stop
  }
} catch {
  Write-Output ('Connect: FAILED ({0}) {1}' -f $_.Exception.GetType().Name, (Get-SafeMessage $_.Exception.Message))
  exit 1
}

$readOnly = [bool]$DryRun
if ($readOnly) { Write-Output 'Mode: dry run (nothing is changed)' } else { Write-Output 'Mode: provision' }
$planned = @{}
try {
  foreach ($s in $ordered) { Invoke-OneSchema -Schema $s -ReadOnly $readOnly -Planned $planned }
} finally {
  Disconnect-PnPOnline -ErrorAction SilentlyContinue
}

Write-Output '====='
$script:Counts.GetEnumerator() | ForEach-Object { '{0}: {1}' -f $_.Key, $_.Value }
Write-Output '====='
if ($script:Counts.Failed -gt 0) { exit 1 }
exit 0
