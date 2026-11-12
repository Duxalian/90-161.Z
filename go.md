# 90-161.Z: tasks for my work computer

Updated: 12 Nov 26 (paste and run added). Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
How to paste and run (ISSM agreed to try this, 12 Nov 26): open the paste link, Ctrl+A, Ctrl+C. Start menu, type ISE, open Windows PowerShell ISE. File > New. Click in the white script pane, Ctrl+V, press F5. Type my DODID or press Enter. It makes the task folders if they are missing, saves the files into them and runs the test. Nothing to download or save by hand. If ISE is not there: open Windows PowerShell, right-click to paste, press Enter (not tested yet; tell Claude if it fails). Screenshots of the ISE window can show my DODID in the path: crop them.
If a script will not run, stop that task and tell Claude with the STOPPED line. Do not work around it (risk R02).
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by e-mail to my Gmail. Never send real publication content.

## Fix first: renderer, round 2 (open, 11 Nov 26, 2045 CT)

Your 11 Nov runs worked: every render made a PDF, the cover spacing matches DAFMAN, and the seals are the right size. Two things are left: the table of contents indents (the "Specified cast" line) and the seal sits 0.09 in too high. The new New-Publication.ps1 fixes both and prints which fix worked.

First time with paste and run (see the top of this page). Two pastes, no downloads:
1. Paste and run Task 1 r6 (it writes the new New-Publication.ps1 into T01):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-T01-paste-r6.ps1
2. Paste and run Task 7 seal test r2:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-T07-paste-r2.ps1
3. E-mail 90161Z-T01-result-r6.txt, 90161Z-T07-test-result-r2.txt and the 3 PDFs (SAMPLEWINGI99-101.pdf, -TALL.pdf, -ROUND.pdf), also if they show FORMAT-FAIL lines. If a paste stops, send the STOPPED line and say ISE or PowerShell window.

## Task 12: color sources, r1 (open, 12 Nov 26, 1530 CT)

Folder: ...\90-161.Z\T12

Claude cannot open Air Force websites from the cloud. These 3 public documents set the official Air Force and ANG colors for our briefs and the app. About 5 minutes.

1. Save this PDF into the T12 folder:
https://www.ang.af.mil/Portals/77/documents/ANG%20Graphics%20Standard.pdf
2. Save this PDF into the T12 folder:
https://www.dafhistory.af.mil/Portals/16/documents/Organizational-Records/GuideAirForceHeraldryJune2022.pdf
3. Open this page, press Ctrl+S, Save as type Webpage, Single File (*.mhtml), into the T12 folder:
https://www.trademark.af.mil/Branding/Air-Force-Symbol/
If a link is dead, search for the title ("ANG Graphics Standard", "Guide to Air Force Heraldry", "Air Force Symbol").

Report: e-mail the 3 files to my Gmail, subject "90161Z T12 r1". They are public documents.

## Task 11: rights test, r1 (open, 12 Nov 26, 1400 CT)

Folder: ...\90-161.Z\T11

Tests what I can and cannot do as a regular user, as site owner and as site collection admin, plus the office mailbox and Power Platform. Every later design step depends on these answers. About 45 minutes.

Part A, the probe flow (about 10 minutes):
1. Save this file into the T11 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T11-rights-probe-r1.zip
2. Power Automate, My flows, Import, Import Package (Legacy), pick the zip. For the SharePoint connection pick my existing one. Import.
3. Run "90161Z T11 Rights Probe r1". Site address: the site where the PFM lists are. Coworker e-mail: one regular member of that site (not an owner). Wing group e-mail: the group that gives wing members access, if it has an e-mail address.
4. The flow creates test lists and a test group named "PFM Rights Probe ..." and deletes them at the end. If the run stops early, delete anything named that way by hand. The deleted test lists also sit in the site recycle bin; I may empty them there.
5. Open the site's Documents library and download 90161Z-T11-rights-result-r1.json.

Part B, manual checks (about 35 minutes): follow section 6 of this page and write down what each row asks for:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/rights-test-plan.md

Report: e-mail the result file and my Part B notes to my Gmail, subject "90161Z T11 r1". No names, no site address, no group names in the notes: write "my AD group", "the office mailbox".

## Task 10: decision briefs, r4 (open, 12 Nov 26, 1600 CT)

Folder: ...\90-161.Z\T10

Three drafts (older revisions are gone):
- Command brief r4 (10 slides): 7 questions for my commanders, each answered Yes, No or Pending evaluation, with an answer sheet.
- Installer brief r4 (22 slides): for a PFM installing it at their own wing.
- Adoption brief r1 (12 slides): the path to ANG-wide use. Use only after other wing PFMs show interest.

1. Save the three files into the T10 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-command-brief-r4.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-installer-brief-r4.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-adoption-brief-r1.pptx
2. Open each in PowerPoint. Check that it opens without a repair message and that no text runs off a slide.
3. Reply in the Claude chat: changes I want, and whether each may go to its audience.

## Task 1: renderer test, r6 (open, 12 Nov 26)

Folder: ...\90-161.Z\T01

r6 = r5 run by paste and run, with the renderer fixes from Fix first. Do it as Fix first step 1; this section is the reference. Old r3, r4 and r5 runners in T01 can be deleted.

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Paste and run:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-T01-paste-r6.ps1

It saves 90161Z-T01-result-r6.txt in the T01 folder.

Report: e-mail the result file, SAMPLEWINGI99-101.docx and SAMPLEWINGI99-101.pdf to my Gmail. Claude measures the cover and the table of contents from the PDF.

## Task 8: edit own rows only, r1 (open, 11 Nov 26, 2100 CT)

No files. Decided 10A: everyone reads all rows; people edit only rows they created, on two lists.

1. On the real site, open PFM Publications. Settings (gear) > List settings > Advanced settings.
2. Item-level Permissions. Read access: Read all items. Create and Edit access: Create items and edit items that were created by the user. Select OK.
3. Do the same for PFM Endorsements. Leave the other seven lists as they are.
4. Check: as a site member who is not an owner (or ask one), open PFM Publications. A row that person did not create shows no Edit.

Report: reply "Task 8 done" and the step 4 result (Edit shown or not shown).

## Task 7: seals, r1 (open, 11 Nov 26, 1905 CT)

Folder: ...\90-161.Z\T07. Decided: each unit's own shield (1C), in a SharePoint library (2A); every seal is prepared to the same 1.20 in box, centered (1A 2A).

Part A, test with fake seals (do this first):
Status 12 Nov 26: seal prep passed; seal size passed; seal 0.09 in too high. Now Part A is one paste (Fix first step 2), which does steps 1 to 4 below:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-T07-paste-r2.ps1
Reference only, the old download steps:
1. Save this file into the T01 folder (it replaces the file of the same name there). New-Publication.ps1 comes from Fix first:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
2. Save these two files into the T07 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T07-seal-prep-r1.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T07-seal-test-r2.ps1
3. Make a folder TestSeals inside the T07 folder. Save these four fake seals into it:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-round-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-tall-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-soft-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/90161Z-T07-testseal-tiny-r1.png
4. In File Explorer, right-click 90161Z-T07-seal-test-r2.ps1 > Run with PowerShell. Type my DODID, or press Enter.
5. E-mail to my Gmail: 90161Z-T07-test-result-r2.txt and the two PDFs it made (SAMPLEWINGI99-101-TALL.pdf, SAMPLEWINGI99-101-ROUND.pdf).

Part B, real seals:
Seals go in a Seals folder in the project library 90-161.Z (decided 12 Nov 26). Shields almost never change, so they stay there.
1. On the real site, if the library does not exist yet: New > Document library. Name: 90-161.Z. Create. Keep the site's permissions (no special permissions on the library or the folder).
2. In the library: New > Folder. Name: Seals.
3. Upload each unit's shield into Seals. Any size or format (PNG, JPG, GIF, BMP, TIF); the larger and cleaner the better. Name each file with the unit's short name, no spaces (for example SAMPLEUNIT.png).
4. In the library, select Sync, so the files are also on my computer.
5. In File Explorer, open the synced 90-161.Z library, then the Seals folder. Click the address bar, Ctrl+C.
6. Right-click 90161Z-T07-seal-prep-r1.ps1 > Run with PowerShell. Type my DODID, or press Enter. When it asks for the seal folder, paste the address (Ctrl+V) and press Enter. Do not just press Enter: r1 only finds a library named PFM Seals. It writes the prepared seals into Seals\Prepared.
7. Send only 90161Z-T07-result-r1.txt (seals by number, no names). Keep 90161Z-T07-key-r1.txt on my computer: it says which number is which unit. Never send seal files or unit names.

FAIL = under 100 dpi, no prepared file: ask the unit or the MAJCOM for a larger file. WARN = under 150 dpi: usable, may print soft.

## Task 9: e-Publishing pages for the numbering index, r1 (open, 11 Nov 26, 2202 CT)

Folder: ...\90-161.Z\T09

No files to download. Claude cannot open e-Publishing from the cloud; my computer can. Claude needs 3 saved pages to write the script that reads publication titles and numbers. Decided 1A 2A: departmental, Air National Guard and my gaining MAJCOM publications.

1. On my work computer, open e-Publishing (the Air Force publications website). Go to the product index for departmental publications and open one series with many publications (for example 33). Wait until the list of publications shows. If the list has a "Show entries" or page-size box, set it to the largest number (or All) first, so the saved page holds the whole series.
2. Press Ctrl+S. Save as type: Webpage, Single File (*.mhtml). Save it in the T09 folder as 90161Z-T09-epubs-departmental-r1.mhtml.
3. Do the same for Air National Guard publications, one series. Save as 90161Z-T09-epubs-ang-r1.mhtml.
4. Do the same for my gaining MAJCOM's publications, one series. Save as 90161Z-T09-epubs-majcom-r1.mhtml. Do not type the MAJCOM's name in the e-mail text.
5. Write down what I clicked to get to each list (menu names only).

Report: e-mail the 3 files and the click path from step 5 to my Gmail, subject "90161Z T09 r1". These pages are public; they hold no wing data. The MAJCOM page shows my gaining MAJCOM, so Claude keeps all 3 pages, and any CSV or test file made from them, out of the repository.

## Done

- Task 6, GenAI.mil extraction r1 (11 Nov 26): GPT and Gemini both 12 of 12 content checks; GPT had fewer errors. Grok dropped (too slow, 11 Nov 26).
- Task 2, create the lists r9 (11 Nov 26): pass on the real site. Lists: 9, fields and views: 213, rows: 41, updates: 15.
- Task 5, solution export sample (11 Nov 26): export received; Claude uses it for solution-aware flows. The flow used a SharePoint connection reference from another solution; future packages carry their own.
- Task 1, renderer test r3 (11 Nov 26): pass (checks 1-6). Fixes in r5: (T-3) line break, cover spacing, table of contents style.
- Task 2, create the lists r1 (11 Nov 26): import and run ok, four lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (11 Nov 26): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (11 Nov 26): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (11 Nov 26, 0840): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
