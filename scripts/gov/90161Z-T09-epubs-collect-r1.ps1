<#
.SYNOPSIS
  90-161.Z Task 9 e-Publishing collector, r1. Windows PowerShell 5.1, Windows Forms only (no modules).
.DESCRIPTION
  Opens the T09 folder and a small window that lists the 3 e-Publishing pages Task 9 asks for (go.md Task 9:
  save each page in the browser with Ctrl+S as "Webpage, Single File (*.mhtml)" into T09). The window ticks each
  file as soon as it is in the folder; press Done when all 3 are there (or when you stop). The 90-161.Z Deployer
  then attaches the files it finds. Nothing is downloaded or changed by this script.
  The DODID and profile folder are replaced by <DODID>.
  Parameters (used by the 90-161.Z Deployer): -Id, -NoPause.
#>
param([string]$Id, [switch]$NoPause)
$task = 'T09'
$Pages = @(
  @{ Name = '90161Z-T09-epubs-departmental-r1.mhtml'; What = 'Departmental publications, one series with many publications' },
  @{ Name = '90161Z-T09-epubs-ang-r1.mhtml'; What = 'Air National Guard publications, one series' },
  @{ Name = '90161Z-T09-epubs-majcom-r1.mhtml'; What = 'My gaining MAJCOM publications, one series' })

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

$secret = @()
try {
  $ErrorActionPreference = 'Stop'
  $who = Get-TaskId $Id
  $id = $who.Id
  $secret = $who.Secret
  $dir = Get-TaskDir $id $task 'Task 9' -Create
  Start-Process -FilePath 'explorer.exe' -ArgumentList ('"' + $dir + '"')

  Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing
  [System.Windows.Forms.Application]::EnableVisualStyles()
  $form = New-Object System.Windows.Forms.Form
  $form.Text = '90-161.Z Task 9 - save 3 e-Publishing pages'
  $form.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96); $form.AutoScaleMode = 'Dpi'
  $form.Font = New-Object System.Drawing.Font('Segoe UI', 10)
  $form.ClientSize = New-Object System.Drawing.Size(760, 360); $form.StartPosition = 'CenterScreen'
  $grid = New-Object System.Windows.Forms.TableLayoutPanel
  $grid.Dock = 'Fill'; $grid.Padding = New-Object System.Windows.Forms.Padding(10); $grid.ColumnCount = 1; $grid.RowCount = 3
  foreach ($h in 'AutoSize', 'Percent', 'AutoSize') { [void]$grid.RowStyles.Add((New-Object System.Windows.Forms.RowStyle($h, 100))) }
  $help = New-Object System.Windows.Forms.Label
  $help.AutoSize = $true; $help.MaximumSize = New-Object System.Drawing.Size(720, 0)
  $help.Text = 'In the browser, open e-Publishing and each list below (largest page size). Press Ctrl+S, Save as type: ' +
    'Webpage, Single File (*.mhtml), into the T09 folder that just opened, with the name shown. Each line ticks when its file is there. ' +
    'Do not type the MAJCOM name anywhere else.'
  $list = New-Object System.Windows.Forms.CheckedListBox
  $list.Dock = 'Fill'; $list.Enabled = $true; $list.SelectionMode = 'None'
  foreach ($p in $Pages) { [void]$list.Items.Add($p.Name + '   (' + $p.What + ')', $false) }
  $bar = New-Object System.Windows.Forms.FlowLayoutPanel; $bar.AutoSize = $true; $bar.Dock = 'Fill'
  $state = New-Object System.Windows.Forms.Label; $state.AutoSize = $true; $state.Margin = New-Object System.Windows.Forms.Padding(3, 8, 12, 3)
  $done = New-Object System.Windows.Forms.Button; $done.Text = 'Done'; $done.AutoSize = $true; $done.MinimumSize = New-Object System.Drawing.Size(110, 32)
  $bar.Controls.AddRange(@($state, $done))
  $grid.Controls.Add($help, 0, 0); $grid.Controls.Add($list, 0, 1); $grid.Controls.Add($bar, 0, 2)
  $form.Controls.Add($grid)
  $check = {
    $n = 0
    for ($i = 0; $i -lt $Pages.Count; $i++) {
      $have = Test-Path -LiteralPath (Join-Path $dir $Pages[$i].Name) -PathType Leaf
      if ($have) { $n++ }
      $list.SetItemChecked($i, $have)
    }
    $state.Text = $n.ToString() + ' of ' + $Pages.Count + ' saved'
    $script:found = $n
  }
  $timer = New-Object System.Windows.Forms.Timer; $timer.Interval = 2000; $timer.Add_Tick({ & $check })
  $done.Add_Click({ $form.Close() })
  $form.Add_Shown({ $form.TopMost = $true; $form.Activate(); $form.TopMost = $false; $timer.Start() })
  $script:found = 0
  & $check
  [void]$form.ShowDialog()
  $timer.Stop(); $timer.Dispose()
  & $check
  foreach ($p in $Pages) {
    $f = Join-Path $dir $p.Name
    if (Test-Path -LiteralPath $f -PathType Leaf) { Write-Host ($p.Name + ' PASS bytes=' + (Get-Item -LiteralPath $f).Length) }
    else { Write-Host ($p.Name + ' not saved yet') }
  }
  Write-Host ('EPUBS found=' + $script:found + ' of ' + $Pages.Count)
} catch {
  $msg = [string]$_
  if ($secret) { $msg = ConvertTo-Masked $msg $secret }
  Write-Host ''
  Write-Host ('STOPPED: ' + $msg)
} finally {
  if (-not $NoPause) { [void](Read-Host 'Press Enter to close') }
}
