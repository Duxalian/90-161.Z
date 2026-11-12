<#
.SYNOPSIS
  90-161.Z renderer (layer L2). Builds a camera-ready Word file that looks like DAFMAN 90-161
  from a publication content file (JSON, schemas/publication.schema.json).

.DESCRIPTION
  Format comes only from this code. Values are from DAFMAN 90-161 (rule IDs in docs/format-rules.md)
  or measured from ref/dafman90-161.pdf (layout IDs L-xxx in docs/format-rules.md).
  The validator (Test-Publication.ps1) runs first; the renderer stops if it reports any FAIL.
  Needs: Windows PowerShell 5.1 and Microsoft Word 16 (COM). Nothing else.

.EXAMPLE
  .\New-Publication.ps1 -Path .\mypub.json -Mode draft
  .\New-Publication.ps1 -Path .\mypub.json -Mode final -Pdf
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)][string]$Path,
  [ValidateSet('draft', 'final')][string]$Mode = 'draft',
  [string]$OutDir,
  [switch]$Pdf
)

Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'
$common = Join-Path $PSScriptRoot 'Publication.Common.ps1'
if (-not (Test-Path -LiteralPath $common)) { throw 'Publication.Common.ps1 is missing. Download it into the same folder as this script.' }
. $common

# ---------------- constants (rule / layout IDs in docs/format-rules.md) ----------------
$PT = 72                       # points per inch
$FontName = 'Times New Roman'  # F-001 (4.5.3.1)
$FontSize = 12                 # F-001
$Margin = 1.0 * $PT            # F-001: one-inch margins
$HeaderDist = 0.5 * $PT        # L-001: running header top at 0.507 in
$IndentStep = 0.25 * $PT       # L-002: each paragraph level indents 0.25 in
$SpaceAfter = 6                # L-003: 6 pt between paragraphs
$Gap = '  '                    # L-004: two spaces after paragraph numbers, headings, and in the running header
$LabelTab = 1.5 * $PT          # L-005: ACCESSIBILITY/RELEASABILITY text starts 1.5 in from the margin
$SigIndent = 3.0 * $PT         # L-006: signature block starts 4.0 in from the page edge
$ShieldWidth = 1.2 * $PT       # L-007: seal/shield box 1.20 in square
$SealPx = 360                  # L-007a: prepared seals are 360 x 360 px PNG (Task 7 seal prep), emblem centered (PFM 2A)
$RuleWidth = 6                 # L-008: cover rules 0.75-0.80 pt measured on 7 covers (wdLineWidth075pt)
# L-008a: cover spacing measured on DAFMAN 90-161 page 1 (baseline/rule gaps, inches): title->compliance 0.417,
# compliance->rule 0.182, rule->ACCESSIBILITY 0.285, RELEASABILITY->rule 0.264, rule->OPR 0.394,
# Supersedes->rule 0.415, rule->opening 0.369. Values below reproduce them within 0.02 in.
$ComplianceBefore = 16         # L-010e / L-008a: space before the compliance line (pt)
$ComplianceRuleDist = 11       # L-008a: text-to-rule distance under the compliance line (pt)
$ComplianceAfter = 9           # L-008a: rule to ACCESSIBILITY
$ReleaseRuleDist = 16          # L-008a: text-to-rule distance under RELEASABILITY (pt)
$ReleaseAfter = 16             # L-008a: rule to OPR line
$BlockRuleBefore = 12.5        # L-008a: Supersedes/Pages line to the third rule
$GroupBlankLine = 12           # L-010c: blank line between right-column groups, exactly 12 pt (group pitch 0.358 in on DAFMAN 90-161)
$TocFontSize = 11              # L-012: TOC on DAFMAN 90-161 page 2: 11 pt; chapter and attachment lines bold (4.5.9.7.4.2), paragraph lines not bold
$TocLine = 14.5                # L-012: 0.202 in between lines of one entry (exactly 14.5 pt)
$TocAfter = 5                  # L-012: 0.272 in between entries
$TocHang = 1.0 * $PT           # L-012: entry text and wrapped lines at 2.00 in (1.00 in from the margin)
$TocNumber = 0.5 * $PT         # L-012: paragraph number at 1.50 in
$OprTab = 0.5 * $PT            # L-010f: office symbol 0.50 in after "OPR:"
$SupTab = 1.0 * $PT            # L-010g: Supersedes value 1.00 in after the label, wraps under itself
$OprLeftCol = 4.0 * $PT        # L-010g/h: Supersedes value wraps before 5.0 in; Certified by / Pages right-aligned at 7.50 in
$TextWidth = 6.5 * $PT
$DraftMark = "DRAFT$([char]0x2014)NOT FOR IMPLEMENTATION OR COMPLIANCE"   # F-010 (4.5.1)
$EmDash = [char]0x2014

# Word enums
$wdAlignLeft = 0; $wdAlignCenter = 1; $wdAlignRight = 2; $wdAlignJustify = 3
$wdBorderBottom = -3; $wdBorderLeft = -2
$wdHeaderPrimary = 1; $wdHeaderFirst = 2; $wdHeaderEven = 3
$wdFieldPage = 33; $wdStatisticPages = 2
$wdFormatDocx = 16; $wdFormatPdf = 17
$wdAlignTabRight = 2; $wdStory = 6; $wdPageBreak = 7
$wdLineSpaceExactly = 4; $wdStyleTOC1 = -20; $wdStyleTOC2 = -21

function ConvertTo-WordBool([bool]$Value) { if ($Value) { return -1 } return 0 }   # Word True = -1
function Get-Prop($Obj, [string]$Name) {
  if ($null -eq $Obj) { return $null }
  $p = $Obj.PSObject.Properties[$Name]
  if ($null -eq $p) { return $null }
  return $p.Value
}

# ---------------- validate first (L3) ----------------
$validator = Join-Path $PSScriptRoot 'Test-Publication.ps1'
$report = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $validator -Path $Path
$validExit = $LASTEXITCODE
$report | ForEach-Object { Write-Output $_ }
if ($validExit -ne 0) { throw 'Validator reported FAIL findings. Fix the content file, then run again. No document was built.' }

$pub = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
$meta = Get-Prop $pub 'meta'
$directive = [bool](Get-Prop $meta 'directive')
$designator = [string](Get-Prop $meta 'designator')
$dateText = [string](Get-Prop $meta 'date')
if (-not $OutDir) { $OutDir = Split-Path -Parent (Resolve-Path -LiteralPath $Path).Path }
if (-not (Test-Path -LiteralPath $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
$OutDir = (Resolve-Path -LiteralPath $OutDir).Path   # Word needs an absolute path
$suffix = ''
if ($Mode -eq 'draft') { $suffix = '_DRAFT' }
$outDocx = Join-Path $OutDir ($designator + $suffix + '.docx')   # S-001: file name without spaces (3.8.2)

# ---------------- seal check (L-007a), before Word starts ----------------
$shield = [string](Get-Prop $meta 'shieldImage')
if ($shield) {
  if (-not (Test-Path -LiteralPath $shield -PathType Leaf)) { throw ('SEAL not found (L-007a): ' + $shield) }
  Add-Type -AssemblyName System.Drawing
  $probe = [System.Drawing.Image]::FromFile((Resolve-Path -LiteralPath $shield).Path)
  try {
    $sealOk = ($probe.Width -eq $SealPx -and $probe.Height -eq $SealPx -and $probe.RawFormat.Guid -eq [System.Drawing.Imaging.ImageFormat]::Png.Guid)
  } finally { $probe.Dispose() }
  if (-not $sealOk) { throw ('SEAL not prepared (L-007a): use the PNG in the "Prepared" folder made by the Task 7 seal prep (' + $SealPx + ' x ' + $SealPx + ' px).') }
}

# ---------------- Word helpers ----------------
$word = $null; $doc = $null
# T06/T07 gov runs 2026-11-11: Word stopped with "Specified cast is not valid" and no line number.
# Each layout step added after r3 now runs in Use-Format: a failure prints FORMAT-FAIL with the rule and
# the script line, the build goes on (so the PDF still exists for measurement), and the exit code is 3.
$script:formatFails = 0
function Use-Format([string]$Rule, [scriptblock]$Do) {
  try { & $Do } catch {
    $script:formatFails++
    Write-Output ('FORMAT-FAIL ' + $Rule + ' line ' + $_.InvocationInfo.ScriptLineNumber + ': ' + $_.Exception.Message)
  }
}
function Format-Para([int]$Align = 3, [double]$Left = 0, [double]$First = 0, [double]$After = $SpaceAfter, [bool]$KeepNext = $false) {
  $pf = $script:sel.ParagraphFormat
  $pf.Alignment = $Align
  $pf.LeftIndent = $Left
  $pf.FirstLineIndent = $First
  $pf.SpaceBefore = 0
  $pf.SpaceAfter = $After
  $pf.LineSpacingRule = 0   # single
  $pf.KeepWithNext = ConvertTo-WordBool $KeepNext
  $pf.TabStops.ClearAll()
  $pf.Borders.Enable = 0
  $script:sel.Font.Bold = 0; $script:sel.Font.Italic = 0
  $script:sel.Font.Name = $FontName; $script:sel.Font.Size = $FontSize
}
function Write-Rich([string]$Text, [bool]$Bold = $false, [bool]$Italic = $false) {
  # Inline markup: {i}..{/i}, {b}..{/b}. Tier numbers "(T-0..3)" are bold (F-039, 4.5.9.7.4.12).
  # Two spaces before each new sentence (L-004).
  if ($null -eq $Text) { return }
  $Text = ConvertTo-TwoSpaceSentence $Text
  $tokens = [regex]::Split($Text, '(\{/?[ib]\}|\(T-[0-3]\))')
  $b = $Bold; $i = $Italic
  foreach ($t in $tokens) {
    switch -regex ($t) {
      '^\{i\}$' { $i = $true; continue }
      '^\{/i\}$' { $i = $Italic; continue }
      '^\{b\}$' { $b = $true; continue }
      '^\{/b\}$' { $b = $Bold; continue }
      '^\(T-[0-3]\)$' {
        # Word nonbreaking hyphen (character 30): "(T-3)" never splits across two lines (T01 r3 result, 2.2).
        $script:sel.Font.Bold = -1; $script:sel.Font.Italic = (ConvertTo-WordBool $i)
        $nb = $t.Replace('-', [string][char]30)
        try { $script:sel.TypeText([string]$nb) } catch {
          $script:formatFails++
          Write-Output ('FORMAT-FAIL F-039 nonbreaking hyphen line ' + $_.InvocationInfo.ScriptLineNumber + ': ' + $_.Exception.Message)
          $script:sel.TypeText([string]$t)
        }
        continue
      }
      default {
        if ($t -ne '') { $script:sel.Font.Bold = (ConvertTo-WordBool $b); $script:sel.Font.Italic = (ConvertTo-WordBool $i); $script:sel.TypeText($t) }
      }
    }
  }
  $script:sel.Font.Bold = (ConvertTo-WordBool $Bold); $script:sel.Font.Italic = (ConvertTo-WordBool $Italic)
}
function Complete-Para { $script:sel.TypeParagraph() }
function Add-TocEntry([string]$Entry, [int]$TocLevel) {
  # Hidden TC field; the TOC is built from these fields only, so entries hold headings, not body text.
  $clean = ($Entry -replace '"', "'")
  [int]$wasBold = $script:sel.Font.Bold
  if ($wasBold -ne 0 -and $wasBold -ne -1) { $wasBold = 0 }   # 9999999 = mixed
  $script:sel.Font.Bold = 0   # TOC style decides bold (L-012), not the heading run the field sits in
  $script:sel.Fields.Add($script:sel.Range, -1, ('TC "' + $clean + '" \l ' + $TocLevel), $false) | Out-Null
  $script:sel.Font.Bold = $wasBold
}
function Add-BottomRule([double]$Distance = 1) {
  # applies to the paragraph just ended; $Distance = points between the text and the rule (L-008a)
  $p = $script:doc.Paragraphs.Item($script:doc.Paragraphs.Count - 1)
  $bd = $p.Borders.Item($wdBorderBottom)
  $bd.LineStyle = 1; $bd.LineWidth = $RuleWidth
  Use-Format 'L-008a rule distance' { $p.Borders.DistanceFromBottom = [int][math]::Round($Distance) }   # Long in Word
}

try {
  $word = New-Object -ComObject Word.Application
  $word.Visible = $false
  $word.DisplayAlerts = 0
  $doc = $word.Documents.Add()
  $script:doc = $doc
  $script:sel = $word.Selection

  # ---------------- page setup (F-001, L-001) ----------------
  $ps = $doc.PageSetup
  $ps.TopMargin = $Margin; $ps.BottomMargin = $Margin; $ps.LeftMargin = $Margin; $ps.RightMargin = $Margin
  $ps.HeaderDistance = $HeaderDist; $ps.FooterDistance = $HeaderDist
  $ps.DifferentFirstPageHeaderFooter = -1
  $ps.OddAndEvenPagesHeaderFooter = -1
  $normal = $doc.Styles.Item(-1)   # wdStyleNormal
  $normal.Font.Name = $FontName; $normal.Font.Size = $FontSize
  $normal.ParagraphFormat.SpaceAfter = 0; $normal.ParagraphFormat.SpaceBefore = 0; $normal.ParagraphFormat.LineSpacingRule = 0

  # ---------------- front page header (F-012..F-023, L-005, L-007, L-008) ----------------
  Format-Para $wdAlignLeft 0 0 0
  $tbl = $doc.Tables.Add($sel.Range, 1, 2)
  $tbl.Borders.Enable = 0
  $tbl.Columns.Item(1).Width = $TextWidth / 2
  $tbl.Columns.Item(2).Width = $TextWidth / 2
  $tbl.LeftPadding = 0; $tbl.RightPadding = 0
  $c1 = $tbl.Cell(1, 1).Range
  $c1.Text = 'BY ORDER OF THE ' + [string](Get-Prop $meta 'byOrderOf')
  $byUnit = [string](Get-Prop $meta 'byOrderOfUnit')
  if ($byUnit) { $c1.InsertAfter("`r" + $byUnit) }
  $c1.Font.Bold = -1; $c1.Font.Italic = -1; $c1.ParagraphFormat.Alignment = $wdAlignLeft
  if ($shield) {   # checked above (L-007a)
    $tbl.Cell(1, 1).Range.InsertAfter("`r")
    $r = $tbl.Cell(1, 1).Range
    $r.MoveEnd(1, -1) | Out-Null   # exclude the end-of-cell mark
    $r.Collapse(0)
    $pic = $doc.InlineShapes.AddPicture((Resolve-Path -LiteralPath $shield).Path, $false, $true, $r)
    Use-Format 'L-007 seal aspect' { $pic.LockAspectRatio = 0 }   # msoFalse
    $pic.Width = [single]$ShieldWidth; $pic.Height = [single]$ShieldWidth   # square canvas: every seal fills the same 1.20 in box (L-007)
  }
  $right = New-Object System.Collections.Generic.List[object]
  $right.Add(@([string](Get-Prop $meta 'issuerLine'), 'bi'))
  $right.Add(@([string](Get-Prop $meta 'typeAndNumber'), 'bi'))
  $right.Add(@('', ''))
  $right.Add(@($dateText, 'bi'))
  foreach ($dl in @(Get-Prop $meta 'dateLines' | Where-Object { $null -ne $_ })) { $right.Add(@([string]$dl, 'i')) }
  $supLines = @(Get-Prop $meta 'supplementLines' | Where-Object { $null -ne $_ })
  if ($supLines.Count -gt 0) {                      # L-010c: organization / Supplement / supplement date group
    $right.Add(@('', ''))
    foreach ($sl in $supLines) { $right.Add(@([string]$sl, 'bi')) }
  }
  $right.Add(@('', ''))
  $right.Add(@([string](Get-Prop $meta 'seriesTitle'), 'bi'))
  $right.Add(@('', ''))
  $titleLines = @(Get-Prop $meta 'titleLines' | Where-Object { $null -ne $_ })
  if ($titleLines.Count -eq 0) { $titleLines = @([string](Get-Prop $meta 'title')) }
  foreach ($tl in $titleLines) { $right.Add(@(([string]$tl).ToUpper(), 'bi')) }   # F-018: all caps
  $c2 = $tbl.Cell(1, 2).Range
  $c2.Text = (($right | ForEach-Object { $_[0] }) -join "`r")
  $c2.ParagraphFormat.Alignment = $wdAlignRight
  for ($k = 0; $k -lt $right.Count; $k++) {
    $pr = $tbl.Cell(1, 2).Range.Paragraphs.Item($k + 1).Range
    $pr.Font.Bold = ConvertTo-WordBool ($right[$k][1] -like '*b*')
    $pr.Font.Italic = ConvertTo-WordBool ($right[$k][1] -like '*i*')
    if ($right[$k][0] -eq '') { Use-Format 'L-010c group line' { $pr.ParagraphFormat.LineSpacingRule = [int]$wdLineSpaceExactly; $pr.ParagraphFormat.LineSpacing = [single]$GroupBlankLine } }
  }
  $sel.EndKey($wdStory) | Out-Null

  Format-Para $wdAlignCenter 0 0 $ComplianceAfter
  Use-Format 'L-010e space before compliance' { $sel.ParagraphFormat.SpaceBefore = [single]$ComplianceBefore }   # about 0.42 in below the title or seal
  if ($directive) { Write-Rich 'COMPLIANCE WITH THIS PUBLICATION IS MANDATORY' $true }  # F-019 (4.5.4.7)
  Complete-Para; Add-BottomRule $ComplianceRuleDist

  Format-Para $wdAlignLeft $LabelTab (-$LabelTab) $SpaceAfter
  $sel.ParagraphFormat.TabStops.Add($LabelTab) | Out-Null
  Write-Rich 'ACCESSIBILITY:' $true; $sel.TypeText("`t"); Write-Rich ([string](Get-Prop $meta 'accessibility')); Complete-Para   # F-020
  Format-Para $wdAlignLeft $LabelTab (-$LabelTab) $ReleaseAfter
  $sel.ParagraphFormat.TabStops.Add($LabelTab) | Out-Null
  Write-Rich 'RELEASABILITY:' $true; $sel.TypeText("`t"); Write-Rich ([string](Get-Prop $meta 'releasability')); Complete-Para; Add-BottomRule $ReleaseRuleDist

  # OPR / Certified by / Supersedes / Pages block (L-010f-h), as a borderless 2-column table:
  # row 1: OPR | Certified by;  row 2: | (certifier name);  row 3: Supersedes | Pages
  Format-Para $wdAlignLeft 0 0 0
  $sup = @(Get-Prop $meta 'supersedes' | Where-Object { $null -ne $_ })
  $ot = $doc.Tables.Add($sel.Range, 3, 2)
  $ot.Borders.Enable = 0
  $ot.LeftPadding = 0; $ot.RightPadding = 0
  $ot.Columns.Item(1).Width = $OprLeftCol
  $ot.Columns.Item(2).Width = $TextWidth - $OprLeftCol
  $ot.Range.Font.Name = $FontName; $ot.Range.Font.Size = $FontSize; $ot.Range.Font.Bold = 0; $ot.Range.Font.Italic = 0
  $ot.Range.ParagraphFormat.SpaceAfter = 0; $ot.Range.ParagraphFormat.SpaceBefore = 0
  $c = $ot.Cell(1, 1).Range; $c.Text = 'OPR:' + "`t" + [string](Get-Prop $meta 'opr')                           # F-021 (4.5.4.10)
  $c.ParagraphFormat.TabStops.ClearAll(); $c.ParagraphFormat.TabStops.Add($OprTab) | Out-Null
  $c = $ot.Cell(1, 2).Range; $c.Text = 'Certified by: ' + [string](Get-Prop $meta 'certifiedBy'); $c.ParagraphFormat.Alignment = $wdAlignRight   # "by" lower case (PFM, 2026-11-11)
  $c = $ot.Cell(2, 2).Range; $c.Text = '(' + ([string](Get-Prop $meta 'certifiedByName')).Trim('(', ')', ' ') + ')'; $c.ParagraphFormat.Alignment = $wdAlignRight   # certifier name line (PFM, 2026-11-11)
  if ($sup.Count -gt 0) {   # F-022 (4.5.4.12): line omitted when nothing is superseded
    $c = $ot.Cell(3, 1).Range
    $c.Text = 'Supersedes:' + "`t" + (($sup | ForEach-Object { [string](Get-Prop $_ 'designator') + ', ' + [string](Get-Prop $_ 'date') }) -join '; ')
    $c.ParagraphFormat.TabStops.ClearAll(); $c.ParagraphFormat.TabStops.Add($SupTab) | Out-Null
    $c.ParagraphFormat.LeftIndent = $SupTab; $c.ParagraphFormat.FirstLineIndent = -$SupTab
  }
  $c = $ot.Cell(3, 2).Range; $c.Text = 'Pages: 0'; $c.ParagraphFormat.Alignment = $wdAlignRight   # F-023; "0" replaced after layout
  $pc = $ot.Cell(3, 2).Range
  $doc.Bookmarks.Add('PagesCount', $doc.Range($pc.End - 2, $pc.End - 1)) | Out-Null
  $sel.EndKey($wdStory) | Out-Null
  Format-Para $wdAlignLeft 0 0 0
  Use-Format 'L-008a space before third rule' { $sel.ParagraphFormat.SpaceBefore = [single]$BlockRuleBefore }
  Complete-Para; Add-BottomRule

  # ---------------- opening paragraph (F-024, F-025) ----------------
  Format-Para $wdAlignJustify 0 0 0   # L-008a: blank line, no space after, then the opening paragraph
  Complete-Para
  Format-Para $wdAlignJustify 0 0 $SpaceAfter
  Write-Rich (Get-OpeningParagraph $pub); Complete-Para   # 4.5.5: fixed statements from code, slots from content

  # ---------------- summary of changes (F-026, 4.5.6) ----------------
  $soc = [string](Get-Prop $pub 'summaryOfChanges')
  if ($soc) {
    Format-Para $wdAlignLeft 0 0 $SpaceAfter $true
    Write-Rich 'SUMMARY OF CHANGES' $true $true; Complete-Para
    Format-Para $wdAlignJustify 0 0 $SpaceAfter
    Write-Rich $soc; Complete-Para
  }

  # ---------------- table of contents (F-027, 4.5.8.2-4.5.8.3) ----------------
  $wantToc = $true   # F-027: ANG wing publications always carry a TOC (4.5.8.2), built per 4.5.8.3 (PFM, 2026-11-11)
  $tocRange = $null
  if ($wantToc) {
    Format-Para $wdAlignLeft 0 0 0
    $tocRange = $sel.Range
    Complete-Para
  }

  # ---------------- body ----------------
  $body = Get-Prop $pub 'body'
  $chapters = @(Get-Prop $body 'chapters' | Where-Object { $null -ne $_ })
  $flat = @(Get-Prop $body 'paragraphs' | Where-Object { $null -ne $_ })
  $script:hasChapters = $chapters.Count -gt 0
  $script:tableCounter = @{}

  function Write-Paragraph($P, [string]$Number, [int]$Level, [string]$Unit) {
    # Level 1 = main paragraph (bold number and heading, F-028/F-033); deeper levels indent 0.25 in each (L-002), not bold (F-004).
    $indent = ($Level - 1) * $IndentStep
    $revised = [bool](Get-Prop $P 'revised')
    Format-Para $wdAlignJustify $indent 0 $SpaceAfter
    $isTop = ($Level -eq 1)
    Write-Rich $Number $isTop
    $t = [string](Get-Prop $P 'title')
    $x = [string](Get-Prop $P 'text')
    if ($t) { $sel.TypeText($Gap); Write-Rich $t $isTop }
    if ($isTop) { Add-TocEntry ($Number + "`t" + ($t -replace '\{/?[ib]\}', '')) 2 }   # TOC: main paragraph headings only (4.5.8.3); number at 1.50, text at 2.00 (L-012)
    if ($x) { $sel.TypeText($Gap); Write-Rich $x }
    foreach ($n in @(Get-Prop $P 'notes' | Where-Object { $null -ne $_ })) { $sel.TypeText($Gap); Write-Rich 'Note:' $true; $sel.TypeText(' '); Write-Rich ([string]$n) }        # F-037 (4.6.2)
    foreach ($e in @(Get-Prop $P 'exceptions' | Where-Object { $null -ne $_ })) { $sel.TypeText($Gap); Write-Rich 'Exception:' $true; $sel.TypeText(' '); Write-Rich ([string]$e) }  # F-037 (4.6.3)
    Complete-Para
    if ($revised) {   # F-026: manual margin bar as a left border for camera-ready ICs (4.5.6.2)
      $pp = $script:doc.Paragraphs.Item($script:doc.Paragraphs.Count - 1)
      $lb = $pp.Borders.Item($wdBorderLeft); $lb.LineStyle = 1; $lb.LineWidth = 6
    }
    foreach ($b in @(Get-Prop $P 'bullets' | Where-Object { $null -ne $_ })) {   # non-directive only (F-029)
      Format-Para $wdAlignJustify ($indent + $IndentStep) 0 $SpaceAfter
      $sel.Range.ListFormat.ApplyBulletDefault() | Out-Null
      Write-Rich ([string]$b); Complete-Para
      $sel.Range.ListFormat.RemoveNumbers() | Out-Null
    }
    $tbl = Get-Prop $P 'table'
    if ($null -ne $tbl) { Write-Table $tbl $Unit }
    $kids = @(Get-Prop $P 'children' | Where-Object { $null -ne $_ })
    for ($i = 0; $i -lt $kids.Count; $i++) { Write-Paragraph $kids[$i] ("$Number$($i + 1).") ($Level + 1) $Unit }
  }

  function Write-Table($T, [string]$Unit) {
    # F-038 (4.6.4): number and title directly above, bold (4.5.9.7.4.7); numbering per Table 4.1
    if (-not $script:tableCounter.ContainsKey($Unit)) { $script:tableCounter[$Unit] = 0 }
    $script:tableCounter[$Unit]++
    $num = $script:tableCounter[$Unit]
    if ($Unit -ne '') { $num = "$Unit.$num" }
    Format-Para $wdAlignLeft 0 0 0 $true
    Write-Rich ("Table $num." + $Gap + [string](Get-Prop $T 'title')) $true; Complete-Para
    $cols = @(Get-Prop $T 'columns'); $rows = @(Get-Prop $T 'rows')
    Format-Para $wdAlignLeft 0 0 0
    $wt = $script:doc.Tables.Add($script:sel.Range, $rows.Count + 1, $cols.Count)
    $wt.Borders.Enable = 1
    for ($c = 0; $c -lt $cols.Count; $c++) { $wt.Cell(1, $c + 1).Range.Text = (([string]$cols[$c]) -replace '\{/?[ib]\}', '') }
    for ($r = 0; $r -lt $rows.Count; $r++) {
      $cells = @($rows[$r])
      for ($c = 0; $c -lt $cols.Count; $c++) { $wt.Cell($r + 2, $c + 1).Range.Text = (([string]$cells[$c]) -replace '\{/?[ib]\}', '') }
    }
    $wt.Range.Font.Name = $FontName; $wt.Range.Font.Size = $FontSize
    $wt.Range.ParagraphFormat.SpaceAfter = 0
    $script:sel.EndKey($wdStory) | Out-Null
    Format-Para $wdAlignLeft 0 0 $SpaceAfter; Complete-Para
  }

  if ($script:hasChapters) {
    for ($c = 0; $c -lt $chapters.Count; $c++) {
      $ch = $chapters[$c]; $cn = $c + 1
      $sel.InsertBreak($wdPageBreak)                       # L-009: each chapter starts a new page
      Format-Para $wdAlignCenter 0 0 $SpaceAfter $true
      Write-Rich ("Chapter $cn") $true
      Add-TocEntry ("Chapter $cn$EmDash" + ([string](Get-Prop $ch 'title')).ToUpper()) 1
      Complete-Para           # F-033 (4.5.9.7.4.4)
      Format-Para $wdAlignCenter 0 0 ($SpaceAfter * 2) $true
      Write-Rich ([string](Get-Prop $ch 'title')).ToUpper() $true; Complete-Para   # F-033 (4.5.9.7.4.5)
      $ps2 = @(Get-Prop $ch 'paragraphs' | Where-Object { $null -ne $_ })
      for ($i = 0; $i -lt $ps2.Count; $i++) { Write-Paragraph $ps2[$i] ("$cn.$($i + 1).") 1 "$cn" }
    }
  } else {
    for ($i = 0; $i -lt $flat.Count; $i++) { Write-Paragraph $flat[$i] ("$($i + 1).") 1 '' }
  }

  # ---------------- approving official (F-034, 4.5.10, L-006) ----------------
  $sig = @(Get-Prop $pub 'signature' | Where-Object { $null -ne $_ })
  if ($sig.Count -gt 0) {
    Format-Para $wdAlignLeft 0 0 0; Complete-Para; Complete-Para
    for ($s = 0; $s -lt $sig.Count; $s++) {
      Format-Para $wdAlignLeft $SigIndent 0 0
      $line = [string]$sig[$s]
      if ($s -eq 0) { $line = $line.ToUpper() }
      Write-Rich $line; Complete-Para
    }
  }

  # ---------------- attachments (F-035, F-036, 4.5.11) ----------------
  $atts = @(Get-Prop $pub 'attachments' | Where-Object { $null -ne $_ })
  for ($a = 0; $a -lt $atts.Count; $a++) {
    $at = $atts[$a]; $an = $a + 1
    $sel.InsertBreak($wdPageBreak)
    Format-Para $wdAlignCenter 0 0 $SpaceAfter $true
    Write-Rich "Attachment $an" $true
    Add-TocEntry ("Attachment $an$EmDash" + ([string](Get-Prop $at 'title')).ToUpper()) 1
    Complete-Para
    Format-Para $wdAlignCenter 0 0 ($SpaceAfter * 2) $true
    Write-Rich ([string](Get-Prop $at 'title')).ToUpper() $true; Complete-Para
    $g = Get-Prop $at 'glossary'
    if ($null -ne $g) {
      $sections = @(
        @('References', 'references', 'list'),
        @('Prescribed Forms', 'prescribedForms', 'list'),
        @('Adopted Forms', 'adoptedForms', 'list'),
        @('Abbreviations and Acronyms', 'abbreviations', 'pairs'),
        @('Office Symbols', 'officeSymbols', 'pairs'),
        @('Terms', 'terms', 'pairs'))
      foreach ($sec in $sections) {
        Format-Para $wdAlignLeft 0 0 $SpaceAfter $true
        Write-Rich $sec[0] $true; Complete-Para                    # 4.5.9.7.4.14.1: category titles bold
        $items = @(Get-Prop $g $sec[1] | Where-Object { $null -ne $_ })
        if ($items.Count -eq 0) {
          if ($sec[1] -in @('prescribedForms', 'adoptedForms')) { Format-Para $wdAlignLeft 0 0 $SpaceAfter; Write-Rich 'None'; Complete-Para }
          continue
        }
        foreach ($it in $items) {
          Format-Para $wdAlignLeft 0 0 $SpaceAfter
          if ($sec[2] -eq 'list') { Write-Rich ([string]$it) }
          else {
            Write-Rich ([string](Get-Prop $it 'term')) $true  # 4.5.9.7.4.14.2-3: terms bold, definitions not
            $sel.TypeText($EmDash); Write-Rich ([string](Get-Prop $it 'definition'))
          }
          Complete-Para
        }
      }
    } else {
      $aps = @(Get-Prop $at 'paragraphs' | Where-Object { $null -ne $_ })
      for ($i = 0; $i -lt $aps.Count; $i++) { Write-Paragraph $aps[$i] ("A$an.$($i + 1).") 1 "A$an" }
    }
  }

  # ---------------- running headers (L-001, F-010) ----------------
  $sec1 = $doc.Sections.Item(1)
  $runText = $designator + $Gap + $dateText.ToUpper()
  if ($dateText -eq '(Date)') { $runText = $designator + $Gap + $dateText }
  foreach ($kind in @($wdHeaderFirst, $wdHeaderPrimary, $wdHeaderEven)) {
    $h = $sec1.Headers.Item($kind).Range
    $h.Text = ''
    $h.Font.Name = $FontName; $h.Font.Size = $FontSize; $h.Font.Bold = -1
    $h.ParagraphFormat.TabStops.ClearAll()
    $h.ParagraphFormat.TabStops.Add($TextWidth, $wdAlignTabRight) | Out-Null
    if ($Mode -eq 'draft') {
      $h.InsertAfter($DraftMark); $h.ParagraphFormat.Alignment = $wdAlignCenter
      if ($kind -ne $wdHeaderFirst) { $h.InsertParagraphAfter() }
    }
    if ($kind -eq $wdHeaderFirst) { continue }   # cover page has no running header
    $line = $sec1.Headers.Item($kind).Range.Paragraphs.Last.Range
    $line.ParagraphFormat.Alignment = $wdAlignLeft
    if ($kind -eq $wdHeaderPrimary) {             # odd pages: designator left, page number right
      $line.InsertAfter($runText + "`t")
      $end = $sec1.Headers.Item($kind).Range
      $end.MoveEnd(1, -1) | Out-Null   # exclude the final paragraph mark
      $end.Collapse(0)
      $end.Fields.Add($end, $wdFieldPage) | Out-Null
    } else {                                      # even pages: page number left, designator right
      $start = $line.Duplicate; $start.Collapse(1)
      $start.Fields.Add($start, $wdFieldPage) | Out-Null
      $sec1.Headers.Item($kind).Range.InsertAfter("`t" + $runText)
    }
  }

  # ---------------- TOC and page count ----------------
  if ($null -ne $tocRange) {
    Format-Para $wdAlignLeft 0 0 0
    foreach ($lv in @(@($wdStyleTOC1, $true, 0), @($wdStyleTOC2, $false, $TocNumber))) {   # L-012
      [int]$styleId = $lv[0]; [bool]$styleBold = $lv[1]; [single]$styleFirst = $lv[2] - $TocHang
      Use-Format ('L-012 TOC style ' + $styleId) {
        $st = $doc.Styles.Item($styleId)
        $st.Font.Name = [string]$FontName; $st.Font.Size = [single]$TocFontSize
        $st.Font.Bold = [int](ConvertTo-WordBool $styleBold); $st.Font.Italic = 0
        $pf = $st.ParagraphFormat
        $pf.LeftIndent = [single]$TocHang; $pf.FirstLineIndent = $styleFirst
        $pf.SpaceBefore = 0; $pf.SpaceAfter = [single]$TocAfter
        $pf.LineSpacingRule = [int]$wdLineSpaceExactly; $pf.LineSpacing = [single]$TocLine
      }
    }
    $doc.TablesOfContents.Add($tocRange, $false, 1, 2, $true, '', $true, $true, '', $true, $true, $false) | Out-Null   # UseFields = TC entries only
    $doc.TablesOfContents.Item(1).Update()
  }
  $doc.Repaginate()
  $pages = $doc.ComputeStatistics($wdStatisticPages)
  $doc.Bookmarks.Item('PagesCount').Range.Text = [string]$pages
  $doc.Fields.Update() | Out-Null

  # Join-Path returns a PSObject-wrapped string; Word COM rejects it by ref (gov run 2026-11-11). Pass plain typed values.
  [string]$saveName = [string]$outDocx
  [int]$saveFormat = $wdFormatDocx
  $doc.SaveAs([ref]$saveName, [ref]$saveFormat)
  Write-Output ("RENDER docx=" + (Split-Path -Leaf $outDocx) + " pages=$pages mode=$Mode toc=$([bool]$tocRange)")
  if ($Pdf) {
    $outPdf = [IO.Path]::ChangeExtension($outDocx, '.pdf')
    $doc.ExportAsFixedFormat([string]$outPdf, [int]$wdFormatPdf)
    Write-Output ("RENDER pdf=" + (Split-Path -Leaf $outPdf))
  }
} catch {
  # Name the line, so a gov-device result shows where Word stopped.
  Write-Output ('RENDER-ERROR line ' + $_.InvocationInfo.ScriptLineNumber + ': ' + ([string]$_.InvocationInfo.Line).Trim() + ' :: ' + $_.Exception.Message)
  throw
} finally {
  # Each cleanup step on its own, so a cleanup error never hides the real one or leaves WINWORD.EXE running.
  [int]$noSave = 0
  if ($doc) { try { $doc.Close([ref]$noSave) } catch { Write-Output ('CLEANUP close: ' + $_.Exception.Message) } }
  if ($word) {
    try { $word.Quit() } catch { Write-Output ('CLEANUP quit: ' + $_.Exception.Message) }
    try { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word) } catch { Write-Output ('CLEANUP release: ' + $_.Exception.Message) }
  }
}
if ($script:formatFails -gt 0) { Write-Output ('FORMAT-FAILS count=' + $script:formatFails); exit 3 }
