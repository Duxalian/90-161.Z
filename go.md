# 90-161.Z: tasks for my work computer

Updated: 11 Nov 26, 1955 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by e-mail to my Gmail. Never send real publication content.

## Fix first: renderer cast error (open, 11 Nov 26, 1955 CT)

My T06 and T07 renders stopped with "Specified cast is not valid", so no PDFs. The seal prep passed. The new New-Publication.ps1 names the line that fails and still makes the PDF.

1. Save this file into the T01 folder (replace the old one):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
2. Run Task 1 r5 (below). Then Task 7 Part A step 4 again. Then Task 6 step 4 again.
3. If a result shows FORMAT-FAIL or RENDER-ERROR lines, e-mail it anyway, with the PDFs that exist.

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
Status 11 Nov 26: steps 1-3 done with Gemini, GPT and Grok; validation passed, render failed (fix above). Also e-mail each model's JSON and changes list: rename them with the model at the end, for example 90161Z-T06-extracted-r1-grok.json. Run step 4 once, with any one of them saved as 90161Z-T06-extracted-r1.json.

## Task 7: seals, r1 (open, 11 Nov 26, 1905 CT)

Folder: ...\90-161.Z\T07. Decided: each unit's own shield (1C), in a SharePoint library (2A); every seal is prepared to the same 1.20 in box, centered (1A 2A).

Part A, test with fake seals (do this first):
1. Save these two files into the T01 folder (they replace the files of the same name there). The renderer now accepts only prepared seals and fits every seal in the 1.20 in box:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
2. Save these two files into the T07 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T07-seal-prep-r1.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T07-seal-test-r1.ps1
3. Make a folder TestSeals inside the T07 folder. Save these four fake seals into it:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-round-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-tall-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-soft-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-tiny-r1.png
4. In File Explorer, right-click 90161Z-T07-seal-test-r1.ps1 > Run with PowerShell. Type my DODID, or press Enter.
5. E-mail to my Gmail: 90161Z-T07-test-result-r1.txt and the two PDFs it made (SAMPLEWINGI99-101-TALL.pdf, SAMPLEWINGI99-101-ROUND.pdf).

Part B, real seals:
1. On the real site: New > Document library. Name: PFM Seals. Create.
2. Upload each unit's shield. Any size or format (PNG, JPG, GIF, BMP, TIF); the larger and cleaner the better. Name each file with the unit's short name, no spaces (for example SAMPLEUNIT.png).
3. In the library, select Sync, so the files are also on my computer.
4. In File Explorer, right-click 90161Z-T07-seal-prep-r1.ps1 > Run with PowerShell. Type my DODID, or press Enter. Press Enter again to find the synced PFM Seals folder (or paste its path). It writes the prepared seals into a Prepared folder inside the library.
5. Send only 90161Z-T07-result-r1.txt (seals by number, no names). Keep 90161Z-T07-key-r1.txt on my computer: it says which number is which unit. Never send seal files or unit names.

FAIL = under 100 dpi, no prepared file: ask the unit or the MAJCOM for a larger file. WARN = under 150 dpi: usable, may print soft.

## Done

- Task 2, create the lists r9 (11 Nov 26): pass on the real site. Lists: 9, fields and views: 213, rows: 41, updates: 15.
- Task 5, solution export sample (11 Nov 26): export received; Claude uses it for solution-aware flows. The flow used a SharePoint connection reference from another solution; future packages carry their own.
- Task 1, renderer test r3 (11 Nov 26): pass (checks 1-6). Fixes in r5: (T-3) line break, cover spacing, table of contents style.
- Task 2, create the lists r1 (11 Nov 26): import and run ok, four lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (11 Nov 26): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (11 Nov 26): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (11 Nov 26, 0840): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
