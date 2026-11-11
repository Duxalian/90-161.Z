# Gov-device test plan: renderer (New-Publication.ps1)

The renderer was linted and its validator tested in the agent workspace. Word COM was not run there. Run these steps on the gov device and report the lines that start with RENDER, VALIDATE or an error.

## Get the files

Task folder (PFM, 2026-11-11): `C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T01`. Create it once. From https://github.com/rhope-ops/90-161.Z (no login), save these 5 files into it (raw links in go.md, Task 1):

- `scripts/gov/90161Z-T01-renderer-test-r2.ps1` (runner)
- `scripts/gov/Publication.Common.ps1` (shared; must sit in the same folder)
- `scripts/gov/Test-Publication.ps1`
- `scripts/gov/New-Publication.ps1`
- `samples/publication.sample.json`

## Run

In File Explorer, right-click `90161Z-T01-renderer-test-r2.ps1` > **Run with PowerShell**. No path is typed, so the "-File ... does not exist" error cannot occur.

1. It asks for the DODID. Type it, or press Enter to use this computer's profile folder (`C:\Users\<that folder>`).
2. It goes to the T01 folder, checks the 4 other files are there, unblocks the scripts, and runs: validator, draft render, final render with PDF.
3. It shows the output, saves it as `90161Z-T01-result-r2.txt` in the T01 folder (DODID replaced by `<DODID>`), and waits for Enter.

Messages: `FOLDER not found` = the T01 folder is missing or the DODID is wrong; `MISSING in T01 folder: <names>` = save those files.

Manual fallback (PowerShell window), only if Run with PowerShell is blocked: go to the T01 folder first, then run each step:

```
powershell -ExecutionPolicy Bypass -File .\Test-Publication.ps1 -Path .\publication.sample.json
powershell -ExecutionPolicy Bypass -File .\New-Publication.ps1 -Path .\publication.sample.json -Mode draft
powershell -ExecutionPolicy Bypass -File .\New-Publication.ps1 -Path .\publication.sample.json -Mode final -Pdf
```

The "-File ... does not exist" error means the PowerShell window is not in the folder that holds the file.

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
