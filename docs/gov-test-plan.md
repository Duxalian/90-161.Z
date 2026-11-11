# Gov-device test plan: renderer (New-Publication.ps1)

The renderer was linted and its validator tested in the agent workspace. Word COM was not run there. Run these steps on the gov device and report the lines that start with RENDER, VALIDATE or an error.

## Get the files

From https://github.com/rhope-ops/90-161.Z (no login), save into one folder, for example `C:\90161Z`:

- `scripts/gov/Publication.Common.ps1` (shared; must sit in the same folder)
- `scripts/gov/Test-Publication.ps1`
- `scripts/gov/New-Publication.ps1`
- `samples/publication.sample.json`

## Run

If PowerShell blocks the downloaded files, run once in that folder: `Get-ChildItem *.ps1 | Unblock-File`

```
cd C:\90161Z
powershell -ExecutionPolicy Bypass -File .\Test-Publication.ps1 -Path .\publication.sample.json
powershell -ExecutionPolicy Bypass -File .\New-Publication.ps1 -Path .\publication.sample.json -Mode draft
powershell -ExecutionPolicy Bypass -File .\New-Publication.ps1 -Path .\publication.sample.json -Mode final -Pdf
```

## Pass criteria

| # | Check | Pass |
|---|---|---|
| 1 | Validator last line | `VALIDATE fails=0 warns=5`; ATT1 lines list acronyms, forms and references with listed=yes |
| 2 | Draft render | `RENDER docx=...SAMPLEWINGI99-101_DRAFT.docx pages=N mode=draft` |
| 3 | Draft header | "DRAFT—NOT FOR IMPLEMENTATION OR COMPLIANCE" on every page including page 1 (F-010) |
| 4 | Final render | `.docx` and `.pdf` created; TOC present after the opening paragraph in both modes (F-027, always) |
| 5 | Cover | Matches docs/reviews/2026-11-11-cover-consistency.md: seal 1.20 in at left; right column right-aligned at 7.50 in; 3 rules 0.75 pt; OPR value 0.50 in after label; "Certified by:" right with "(Col Sample A. Certifier)" under it; Supersedes value 1.00 in after label; Pages right on the Supersedes line |
| 5a | Sentences | Two spaces before each new sentence; one space before (T-n) (L-004) |
| 5b | Opening paragraph | Built from parts: implements, purpose, applicability, records, DAF Form 847, supplement, waiver (4.5.5 order) |
| 6 | Pages line | "Pages: N" equals Word's page count |
| 7 | Running header | Page 2+ only; odd/even sides swap (L-001) |
| 8 | Indents | 1.1.1. at 0.25 in, 1.1.1.1. at 0.5 in from the margin (L-002) |

Report any check that fails with what you see. No real content is needed: the sample is fake.
