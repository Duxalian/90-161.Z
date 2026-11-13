# 90-161.Z: tasks for my work computer

Updated: 13 Nov 26 (Round R06: 90-161.Z Deployer with automatic cleanup; Copy script button; R05 done. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Every task below has the same parts: **For** (why), **Time** (an estimate), **Changes** (what it writes or changes, before I start), **Steps**, **Report** (what to send back) and **If it fails**.
Reload this page to see new tasks (GitHub can serve a copy up to 5 minutes old).
Never send real publication content, names, site addresses or group names. Reply in the Claude chat or by e-mail.

## How a paste task (round) works

**For:** a round is one block of text I paste into PowerShell ISE. It opens the 90-161.Z Deployer window, saves its own files, runs the tests and makes the results e-mail. The ISSM allows this for scripts that use no elevated credentials (13 Nov 26).
**Changes:** it writes only into my own OneDrive folder 90-161.Z (the window shows the full path in bold): the task folders it needs (for example T01), Config and its results folder Rounds\<round>. It makes missing folders and replaces files of the same name. From R06 on it also moves finished files to the Recycle Bin (only files 90-161.Z made). Before Run, the window lists every file, marked (new), (replaces the file there) or RECYCLE.
Steps:
1. Press Copy script next to the round's link in its task below. If it says blocked: open the link, press Ctrl+A, then Ctrl+C.
2. Start menu: type ISE and open Windows PowerShell ISE as myself (not "Run as administrator").
3. File > New. Click in the white script pane. Press Ctrl+V, then F5.
4. The 90-161.Z Deployer window opens. Check the bold "Writes to" line: it shows my OneDrive 90-161.Z folder, or says NOT found. The first time, type the e-mail address the results go to in "Send results to" (it is remembered).
5. Press Enter (or Run). Word steps take a few minutes each. Keep the window open until the log says DONE.
6. At DONE an Outlook draft opens with the address, the subject (OK or CHECK), the summary and all result files. Send it. If no draft opens, the results folder opens and the e-mail text is on the clipboard: new e-mail, Ctrl+V in the body, cut the first line into the subject, drag in all files from the folder. No zip: zips do not cross the boundary.
**If it fails:** the window shows a line that starts with WHAT TO DO under the problem: do that. Otherwise send the line that starts with STOPPED. The report file in Rounds\<round> also holds it. Do not work around it. If no window opens, the same steps run as text in ISE and the results folder opens by itself.
The script never sends the e-mail; the draft waits in Outlook. Finished task folders are cleaned up by the rounds; a later round makes any folder it needs again. Keep T07 if it holds 90161Z-T07-key-r1.txt (rounds never touch it).
Sensitivity label: every render gets the label from Config\90161Z-label.json. Never delete the Config folder: without it, renders print "LABEL not set" and have no label. The file I labeled by hand is no longer needed. If Config is lost, run a round, then capture again from its new render (it is already labeled); label a file by hand again only if renders say LABEL FAIL.

## How a download task works

**For:** some tasks need files saved from a link, or steps on the SharePoint site.
Steps:
1. Copy each link into the address bar (the Copy link button copies it).
2. Save the file with Ctrl+S into the task's folder. The folder box in each task has a Copy button: paste its path into the Save dialog's address bar (%USERPROFILE% becomes my profile folder).
3. Use the file name as it comes: 90161Z-T<task>-<name>-r<revision>. The highest r number is the newest.
**If it fails:** if a link is dead or a file is blocked, stop and tell Claude which link.

## Fix first: Round R06 r1, the 90-161.Z Deployer and automatic cleanup (open, 13 Nov 26)

**For:** tests the renamed 90-161.Z Deployer window (full folder path, e-mail box, checkbox, progress bar) and cleans up the project folder by itself.
**Time:** about 6 minutes (estimate).
**Changes:** writes into T01 (renderer files and a new sample render), Config (the e-mail address and a small history file) and Rounds\R06. Moves finished files to the Recycle Bin: folders T02, T03, T04, T05, T06, T13, Rounds\R01 to R05, and the old T07 scripts. Only files 90-161.Z made: any other file stays, with its folder. The window lists each one (RECYCLE) before Run; uncheck "Clean up finished files" to skip it. Saves one Outlook draft (never sent). Nothing on the SharePoint site.
Steps:
1. Press Copy script next to this link (if it says blocked: open the link, Ctrl+A, Ctrl+C). The window title will show build BUILDID.
https://raw.githubusercontent.com/rhope-ops/90-161.Z/COMMIT/scripts/gov/paste/90161Z-R06-round-r1.ps1
2. Start menu: type ISE, open Windows PowerShell ISE. File > New, click in the white pane, press Ctrl+V, then F5.
3. In the window, check the bold "Writes to" line. In "Send results to", type the address you send results to (only this once).
4. If anything in the window overlaps or is cut off, uncheck "This window looked right".
5. Press Enter (or Run). The progress bar and timer show the step; wait for DONE.
6. The Outlook draft opens with the address, subject 90161Z R06 OK (or CHECK), the summary and 2 files. Send it.
**Report:** the draft itself. Add one line if Copy script said blocked, or if Outlook asked anything.
**If it fails:** read the WHAT TO DO line in the window and do that. If no draft opens, the folder opens and the text is on the clipboard: send as before. If a file did not go to the Recycle Bin, the summary says failed=; send anyway.

## Task 14: site logo, r1 (open, 13 Nov 26)

**For:** puts the 90-161.Z logo (woven squares with a ρ) on the SharePoint site header. White and light blue, made for a blue background.
**Time:** about 5 minutes (estimate).
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T14
**Changes:** saves 2 picture files into T14. On the site it changes only the logo and the logo thumbnail. Nothing runs on the computer. Needs site owner rights; without them, send the 2 files to a site owner.
Steps:
1. Save these 2 files into the T14 folder (steps in "How a download task works"):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/assets/logo/90161Z-T14-site-logo-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/assets/logo/90161Z-T14-site-logo-tile-r1.png
2. Open the site. Click the gear (Settings), then Change the look, then Header.
3. Under Site logo thumbnail, click Change and pick 90161Z-T14-site-logo-tile-r1.png (the logo on a blue square).
4. Under Site logo, click Change and pick 90161Z-T14-site-logo-r1.png (clear background). Click Save.
5. Look at the header. If the logo is hard to see (the header is white or light), set Site logo to 90161Z-T14-site-logo-tile-r1.png as well, then Save.
**Report:** reply "T14 done", or the step number and what the screen said. No screenshots: they show the site name.
**If it fails:** if Change the look or Header is missing, I am not a site owner: stop and say so. If the upload is refused, send the message text.

## Task 11: rights test, r1 (open, 12 Nov 26)

**For:** finds what I can and cannot do as a regular user, as site owner and as site collection admin, plus the office mailbox and Power Platform. Every later design step depends on these answers.
**Time:** about 45 minutes (estimate): Part A 10, Part B 35.
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T11
**Changes:** imports one flow into my Power Automate. The flow creates test lists and a test group named "PFM Rights Probe ..." on the site and deletes them at the end; the deleted lists stay in the site recycle bin, where I may empty them. It adds one result file to the site's Documents library.
Part A, the probe flow:
1. Save this file into the T11 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T11-rights-probe-r1.zip
2. Power Automate: My flows > Import > Import Package (Legacy). Pick the file. For the SharePoint connection, pick my existing one. Import.
3. Run "90161Z T11 Rights Probe r1". Site address: the site with the PFM lists. Coworker e-mail: one regular member of that site (not an owner). Wing group e-mail: the group that gives wing members access, if it has an e-mail address.
4. When the run ends, open the site's Documents library and download 90161Z-T11-rights-result-r1.json.
Part B, manual checks:
5. Open this page, go to section 6 and write down what each row asks for:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/rights-test-plan.md
Report: one e-mail, subject "90161Z T11 r1": the result file and my Part B notes. No names, site address or group names in the notes: write "my AD group", "the office mailbox".
**If it fails:** if the run stops early, delete anything named "PFM Rights Probe ..." by hand and send the name of the step that failed and its error text (no names).

## Task 8: edit own rows only, r1 (open, 11 Nov 26)

**For:** sets the decided rule (10A): everyone reads all rows; on two lists, people edit only the rows they created.
**Time:** about 10 minutes (estimate).
**Changes:** changes one setting on two lists on the real site: PFM Publications and PFM Endorsements. To undo, set it back to "Create and edit all items".
Steps:
1. On the real site, open PFM Publications. Settings (gear) > List settings > Advanced settings.
2. Item-level Permissions. Read access: Read all items. Create and Edit access: Create items and edit items that were created by the user. Select OK.
3. Do the same for PFM Endorsements. Leave the other seven lists as they are.
4. Check: as a site member who is not an owner (or ask one), open PFM Publications. A row that person did not create shows no Edit.
Report: reply "Task 8 done" and the step 4 result (Edit shown or not shown).
**If it fails:** if Advanced settings has no Item-level Permissions, reply with what the page shows instead.

## Task 10: decision briefs, r5 (open, 12 Nov 26)

**For:** a last check of the three briefs before they go to their audiences.
**Time:** about 15 minutes (estimate).
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T10
**Changes:** saves 3 files into T10. Nothing else.
- Command brief r5 (10 slides): 7 questions for my commanders, each answered Yes, No or Pending evaluation, with an answer sheet. Script delivery is gone (the ISSM approved it); question 7 is now the top two risks.
- Installer brief r6 (22 slides): for a PFM installing it at their own wing. R02 says each wing's ISSM must approve paste and run; ours did.
  r6 (13 Nov 26) only replaces the old owner name in 5 links and updates the decision count; if I already checked r5, I save r6 and only check that it opens.
- Adoption brief r2 (12 slides): the path to ANG-wide use. Use only after other wing PFMs show interest.
Steps:
1. Save the three files into the T10 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-command-brief-r5.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-installer-brief-r6.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-adoption-brief-r2.pptx
2. Open each in PowerPoint. Check that it opens without a repair message and that no text runs off a slide.
Report: reply in the Claude chat: the changes I want, and whether each brief may go to its audience.
**If it fails:** if a file shows a repair message, name the brief.

## Task 12: color sources, r1 (open, 12 Nov 26)

**For:** these 3 public documents set the official Air Force and ANG colors for the briefs and the app. Claude cannot open Air Force websites from the cloud.
**Time:** about 5 minutes (estimate).
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T12
**Changes:** saves 3 files into T12. Nothing else.
Steps:
1. Save this PDF into the T12 folder:
https://www.ang.af.mil/Portals/77/documents/ANG%20Graphics%20Standard.pdf
2. Save this PDF into the T12 folder:
https://www.dafhistory.af.mil/Portals/16/documents/Organizational-Records/GuideAirForceHeraldryJune2022.pdf
3. Open this page, press Ctrl+S, Save as type: Webpage, Single File (*.mhtml), into the T12 folder:
https://www.trademark.af.mil/Branding/Air-Force-Symbol/
Report: one e-mail, subject "90161Z T12 r1": the 3 files. They are public documents.
**If it fails:** if a link is dead, search for its title ("ANG Graphics Standard", "Guide to Air Force Heraldry", "Air Force Symbol") and save what that finds.

## Task 9: e-Publishing pages for the numbering index, r1 (open, 11 Nov 26)

**For:** Claude needs 3 saved e-Publishing pages to write the script that reads publication titles and numbers. Claude cannot open e-Publishing from the cloud. Decided 1A 2A: departmental, Air National Guard and my gaining MAJCOM publications.
**Time:** about 20 minutes (estimate).
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T09
**Changes:** saves 3 files into T09. Nothing else.
Steps:
1. Open e-Publishing (the Air Force publications website). Go to the product index for departmental publications and open one series with many publications (for example 33). Wait until the list shows. If the list has a "Show entries" or page-size box, set it to the largest number (or All) first.
2. Press Ctrl+S. Save as type: Webpage, Single File (*.mhtml). Save it in the T09 folder as 90161Z-T09-epubs-departmental-r1.mhtml.
3. Do the same for Air National Guard publications, one series. Save as 90161Z-T09-epubs-ang-r1.mhtml.
4. Do the same for my gaining MAJCOM's publications, one series. Save as 90161Z-T09-epubs-majcom-r1.mhtml.
5. Write down what I clicked to get to each list (menu names only).
Report: one e-mail, subject "90161Z T09 r1": the 3 files and the click path from step 5. Do not type the MAJCOM's name in the e-mail text. Claude keeps these pages, and anything made from them, out of the repository.
**If it fails:** if a page saves without the list, save what shows and say which page.

## Task 7: real seals, Part B, r1 (open, 11 Nov 26)

**For:** prepares every unit's real shield for the publication covers. Decided: each unit's own shield (1C) in the project library (2A, 12 Nov 26), every seal prepared to the same 1.20 in box, centered. Part A (fake seals) passed in Round R01.
**Time:** about 20 minutes (estimate), plus waiting for files from units.
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T07
**Changes:** on the real site, creates the library 90-161.Z and its Seals folder if they do not exist (site permissions, nothing special) and adds the shield files. On my computer, syncs that library and writes the prepared seals into Seals\Prepared, plus two text files in T07.
Round R04 already saved the seal prep script (r2) into T07 (13 Nov 26).
Steps:
1. On the real site, if the library does not exist yet: New > Document library. Name: 90-161.Z. Create.
2. In the library: New > Folder. Name: Seals.
3. Upload each unit's shield into Seals. Any size or format (PNG, JPG, GIF, BMP, TIF); the larger and cleaner the better. Name each file with the unit's short name, no spaces (for example SAMPLEUNIT.png).
4. In the library, select Sync, so the files are also on my computer.
5. In File Explorer, open the synced 90-161.Z library, then the Seals folder. Click the address bar, Ctrl+C.
6. In the T07 folder, right-click 90161Z-T07-seal-prep-r2.ps1 > Run with PowerShell. Press Enter at the DODID question. When it asks for the seal folder, press Ctrl+V and Enter (do not leave it empty).
Report: send only 90161Z-T07-result-r1.txt (seals by number, no names). Keep 90161Z-T07-key-r1.txt on my computer: it says which number is which unit. Never send seal files or unit names.
**If it fails:** FAIL means under 100 dpi, no prepared file: ask the unit or the MAJCOM for a larger file. WARN means under 150 dpi: usable, may print soft. If the script stops, send its STOPPED line.

## Done

- Round R05, Outlook draft (13 Nov 26): 4 of 4 pass; the draft opened with subject, summary and both files; the Window line came back empty (R06 uses a checkbox). Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r05-results.md
- Round R04, quicker finish and DAFMAN link style (13 Nov 26): 4 of 4 pass; summary subject and clipboard worked; ACCESSIBILITY link now bold, blue, underlined like the DAFMAN cover link; seal prep r2 saved in T07. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r04-results.md
- Round R03, renderer fixes (12 Nov 26): 4 of 4 pass; TOC 1.50 / 2.00 in the PDF; label set; ACCESSIBILITY link works. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r03-results.md
- Round R02, automatic sensitivity label (12 Nov 26): label set by itself (PDF Uncontrolled/General); TOC positions right in the PDF (1.50 / 2.00 in), the Word read-back was wrong and is replaced by a PDF check. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r02-results.md
- Round R01, renderer round 2 and fake-seal test (12 Nov 26): window, steps and results folder worked; seal top 1.472 in (want 1.47); TOC number 1.50 in and text 2.00 in in the PDF; cover gaps within 0.01 in of DAFMAN. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r01-results.md
- Task 6, GenAI.mil extraction r1 (11 Nov 26): GPT and Gemini both 12 of 12 content checks; GPT had fewer errors. Grok dropped (too slow, 11 Nov 26).
- Task 2, create the lists r9 (11 Nov 26): pass on the real site. Lists: 9, fields and views: 213, rows: 41, updates: 15.
- Task 5, solution export sample (11 Nov 26): export received; Claude uses it for solution-aware flows. The flow used a SharePoint connection reference from another solution; future packages carry their own.
- Task 1, renderer test r3 (11 Nov 26): pass (checks 1-6). Fixes in r5: (T-3) line break, cover spacing, table of contents style.
- Task 2, create the lists r1 (11 Nov 26): import and run ok, four lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (11 Nov 26): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (11 Nov 26): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (11 Nov 26, 0840): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
