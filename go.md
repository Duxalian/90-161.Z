# 90-161.Z: tasks for my work computer

Updated: 11 Nov 26, 1837 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by e-mail to my Gmail. Never send real publication content.

## Task 1: renderer test, r5 (open, 11 Nov 26, 1837 CT)

Folder: ...\90-161.Z\T01

r5 replaces r4 (do not run r4). r3 passed. r5 fixes what I saw and what Claude measured against DAFMAN 90-161 page 1 and its table of contents: (T-3) stays on one line; the space above and below the cover lines (rules) and the right-column groups now match DAFMAN within 0.03 in; the table of contents is 11 pt, with only the Chapter lines bold. Replace New-Publication.ps1 and the runner; the other three files are unchanged.

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Save these two files into the T01 folder (delete the r3 and r4 runners):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T01-renderer-test-r5.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1

In File Explorer, right-click 90161Z-T01-renderer-test-r5.ps1 > Run with PowerShell. Type my DODID, or press Enter. It saves 90161Z-T01-result-r5.txt in the T01 folder.

Report: e-mail the result file, SAMPLEWINGI99-101.docx and SAMPLEWINGI99-101.pdf to my Gmail. Claude measures the cover and the table of contents from the PDF.

## Task 6: GenAI.mil extraction test, r1 (open, 11 Nov 26, 1837 CT)

Folder: ...\90-161.Z\T06. Do Task 1 r5 first: this task uses the renderer files in the T01 folder.

Goal: GenAI.mil turns a messy draft into content, and the renderer builds the publication from that content. The draft is fake.

Save these three files into the T06 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/prompts/90161Z-T06-extract-prompt-r1.txt
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T06-messy-draft-r1.docx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T06-extract-test-r1.ps1

1. Open GenAI.mil. Open 90161Z-T06-extract-prompt-r1.txt in Notepad, Ctrl+A, Ctrl+C, and paste it into a new chat. Attach 90161Z-T06-messy-draft-r1.docx. Send.
2. In the answer, copy only the text inside the json box. Paste it into Notepad. File > Save as, Save as type = All files, name 90161Z-T06-extracted-r1.json, Encoding = UTF-8, into the T06 folder.
3. Copy the "CHANGES AND QUESTIONS" list into a second Notepad file, 90161Z-T06-changes-r1.txt, in the T06 folder.
4. In File Explorer, right-click 90161Z-T06-extract-test-r1.ps1 > Run with PowerShell. Type my DODID, or press Enter. It saves 90161Z-T06-result-r1.txt.

Report: e-mail these to my Gmail: 90161Z-T06-extracted-r1.json, 90161Z-T06-changes-r1.txt, 90161Z-T06-result-r1.txt, and the PDF it made. Also say which GenAI.mil model I used. If GenAI.mil refused the file or cut off the answer, send its exact message.

## Task 7: seal library on the real site (open, 11 Nov 26, 1837 CT)

No download. Decided: each unit's own shield (1C); seals live in a SharePoint library (2A).

1. On the real site: New > Document library. Name: PFM Seals. Create.
2. Upload each unit's shield as a PNG file. Name each file with the unit's short name, no spaces (for example SAMPLEUNIT.png). Square images work best; the renderer sets the width to 1.20 in.
3. In the library, select Sync, so the files are also on my computer for the renderer.

Report: done, and the number of seals uploaded. Do not send the seal files or unit names to Claude.

## Done

- Task 2, create the lists r9 (11 Nov 26): pass on the real site. Lists: 9, fields and views: 213, rows: 41, updates: 15.
- Task 5, solution export sample (11 Nov 26): export received; Claude uses it for solution-aware flows. The flow used a SharePoint connection reference from another solution; future packages carry their own.
- Task 1, renderer test r3 (11 Nov 26): pass (checks 1-6). Fixes in r5: (T-3) line break, cover spacing, table of contents style.
- Task 2, create the lists r1 (11 Nov 26): import and run ok, four lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (11 Nov 26): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (11 Nov 26): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (11 Nov 26, 0840): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
