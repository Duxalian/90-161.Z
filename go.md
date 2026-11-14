# 90-161.Z: tasks for my work computer

Updated: 14 Nov 26 (Round R11 and Task 11 r2: most Task 11 checks are now automatic, plus a wider inventory for future projects).
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

## Round R11 r1: Task 11 checks and wider inventory (open, 14 Nov 26)

**For:** reads the Task 11 test e-mails, runs the Task 11 form (17 checks), and records more about this computer and the new site for future projects.
**Time:** about 5 minutes (estimate) for the default steps; Task 11 Part B adds about 25, the PnP step about 2.
**Changes:** writes into T01, T07, T10, T11, T14, T15, T16, Config and Rounds\R11. Moves Rounds\R10, the T09 and T12 page-saver scripts and the old T15 and T16 scripts to the Recycle Bin (my saved pages stay). Opens PowerPoint without a window and closes it. Reads Outlook and the new site; changes nothing in either. Saves one Outlook draft (never sent).
Steps:
1. Do Task 11 Part A first if I want the Task 11 steps (it sends the test e-mails).
2. Press Copy script next to this link (if it says blocked: open the link, Ctrl+A, Ctrl+C).
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-R11-round-r1.ps1
3. Start menu: type ISE, open Windows PowerShell ISE. File > New, click in the white pane, press Ctrl+V, then F5.
4. The first three steps are checked. Also check "T11 Outlook check", "T11 Part B" and "T16 PnP test" when I have the time.
5. Press Enter (or Run). The Outlook check asks once for the office mailbox address; the PnP step asks for the NEW site address (change it if it shows the old one) and opens a CAC sign-in. The form: pick a result per row, short notes without names, Save and close.
6. The Outlook draft opens with the summary and the files. Send it.
**Report:** the draft itself; Claude watches the inbox for the subject.
**If it fails:** read the WHAT TO DO line in the window. If Outlook asks to allow access to e-mail addresses, choose Allow for 1 minute. If a window is cut off, uncheck "This window looked right" and send anyway.

## Task 2: create the 12 lists on the new site, r11 (open, 14 Nov 26)

**For:** builds all 12 PFM lists, their columns, views and starting rows on the new site (decided 14 Nov 26), and sets "edit own rows" on PFM Publications and PFM Endorsements (this replaces the old Task 8).
**Time:** about 20 minutes (estimate): 5 to import, about 15 for the run.
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T02
**Changes:** imports one flow into my Power Automate. On the new site only: creates 12 lists named PFM ..., adds 88 rows (series, settings, offices, process steps) changes the item-level permissions of 2 of those lists, and (step 8, by hand) sets the site time zone to Central. Nothing on the old site. Nothing runs on the computer.
Steps:
1. Save this file into the T02 folder (steps in "How a download task works"):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T02-provision-lists-r11.zip
2. Power Automate: My flows > Import > Import Package (Legacy). Pick the file. For the SharePoint connection, pick my existing one. Import.
3. Open the new site. Copy its address from the address bar (up to and including the site name, nothing after it).
4. Run "90161Z T02 Provision Lists r11". Site URL: paste the address. Run once only.
5. Wait until the run shows Succeeded (about 15 minutes). Open the step Result.
6. Result must say "Lists: 12, fields and views: 329, rows: 88, updates: 21. Provisioning finished. Item-level permissions: set on 2 lists."
7. Only if Result says "Item-level permissions: NOT SET": open PFM Publications > Settings (gear) > List settings > Advanced settings > Item-level Permissions. Read access: Read all items. Create and Edit access: Create items and edit items that were created by the user. OK. Do the same for PFM Endorsements.
8. Site settings (gear) > Site information > View all site settings > Regional settings: Time zone (UTC-06:00) Central Time. OK.
**Report:** reply "T02 done" and the Result text from step 6 (it holds counts only, no names).
**If it fails:** do not run it again on top. Send only the failed step's name, its HTTP status and error code (for example 400 / -2130575342), no addresses. Claude then sends the clean-up steps (delete the PFM lists and empty the recycle bin) before a second run.

## Task 14: site logo, r1 (open, 13 Nov 26)

**For:** puts the 90-161.Z logo (woven squares with a ρ) on the SharePoint site header. White and light blue, made for a blue background.
**Time:** about 5 minutes (estimate).
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T14
**Changes:** saves 2 picture files into T14. On the new site (the one Task 2 fills) it changes only the logo and the logo thumbnail. Nothing runs on the computer. Needs site owner rights; without them, send the 2 files to a site owner.
Steps:
1. The current round (R08 or later) saves these 2 files into the T14 folder. Without a round, save them (steps in "How a download task works"):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/assets/logo/90161Z-T14-site-logo-r1.png
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/assets/logo/90161Z-T14-site-logo-tile-r1.png
2. Open the new site. Click the gear (Settings), then Change the look, then Header.
3. Under Site logo thumbnail, click Change and pick 90161Z-T14-site-logo-tile-r1.png (the logo on a blue square).
4. Under Site logo, click Change and pick 90161Z-T14-site-logo-r1.png (clear background). Click Save.
5. Look at the header. If the logo is hard to see (the header is white or light), set Site logo to 90161Z-T14-site-logo-tile-r1.png as well, then Save.
**Report:** reply "T14 done", or the step number and what the screen said. No screenshots: they show the site name.
**If it fails:** if Change the look or Header is missing, I am not a site owner: stop and say so. If the upload is refused, send the message text.

## Task 11: rights and capability test, r2 (open, 14 Nov 26)

**For:** finds what I can and cannot do on the new site, with the office mailbox, in Power Apps, Power Automate and Forms. Every later design step depends on these answers, and the inventory helps future projects. r2 does most checks by itself (decided 14 Nov 26).
**Time:** about 35 minutes (estimate): Part A 10, Part B (in the round) 25.
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T11
**Changes:** imports one flow into my Power Automate. On the new site the flow creates test lists and a test group named "PFM Rights Probe ..." and deletes them at the end (they stay in the site recycle bin), and adds one result file to the Documents library. It sends 3 test e-mails to me only: 1 from my mailbox, 2 from the office mailbox (subjects start "90161Z TEST"). Nothing else.
Part A, the probe flow (after Task 2):
1. Save this file into the T11 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T11-rights-probe-r2.zip
2. Power Automate: My flows > Import > Import Package (Legacy). Pick the file. For each connection (SharePoint, Office 365 Users, Office 365 Outlook) pick my existing one, or Create new if I have none. Import.
3. Run "90161Z T11 Rights Probe r2". Site address: the new site. Coworker e-mail: one regular member of that site (not an owner). Wing group e-mail: the group that gives wing members access, if it has one. Office mailbox e-mail: the office shared mailbox.
4. When the run ends, open the site's Documents library, download 90161Z-T11-rights-result-r2.json and save it into the T11 folder. Keep the 3 "90161Z TEST" e-mails until the round has run.
Part B: run the current round with "T11 Outlook check" and "T11 Part B" checked (see its task). The round reads the test e-mails, opens the form for the 17 checks only a person can do, and attaches the result file.
Report: the round's e-mail. No names, site address or group names in the notes: write "my AD group", "the office mailbox".
**If it fails:** if the import asks for a connection I cannot make, send its name. If the run stops early, delete anything named "PFM Rights Probe ..." by hand and send the name of the step that failed and its error text (no names). A red step in the run is a result, not a failure: the run goes on.
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
1. The current round (R08 or later) saves the three files into the T10 folder and checks each in PowerPoint (90161Z-T10-check-r1.txt). Without a round, save them:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-command-brief-r5.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-installer-brief-r6.pptx
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/brief/90161Z-T10-adoption-brief-r2.pptx
2. Open each in PowerPoint. Check that it opens without a repair message and that no text runs off a slide.
Report: reply in the Claude chat: the changes I want, and whether each brief may go to its audience.
**If it fails:** if a file shows a repair message, name the brief.

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
6. Run the current round with "T07 seal prep" checked and pick the Seals folder when it asks (the round attaches only the result file). Without a round: in the T07 folder, right-click 90161Z-T07-seal-prep-r3.ps1 > Run with PowerShell, then paste the folder path when it asks (Ctrl+V, Enter).
Report: send only 90161Z-T07-result-r1.txt (seals by number, no names). Keep 90161Z-T07-key-r1.txt on my computer: it says which number is which unit. Never send seal files or unit names.
**If it fails:** FAIL means under 100 dpi, no prepared file: ask the unit or the MAJCOM for a larger file. WARN means under 150 dpi: usable, may print soft. If the script stops, send its STOPPED line.

## Done

- Round R10 (13 Nov 26): window, inventory, renderer, brief check (3 of 3), PnP web login passed; Task 9 pages (3 of 3) and Task 12 documents (3 of 3) received; Task 11 form worked (2 of 18 rows answered). Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-14-r10-results.md
- Task 9, e-Publishing pages (13 Nov 26, in R10): 3 of 3 saved with the list; Claude writes the reader next.
- Task 12, color sources (13 Nov 26, in R10): 3 of 3 documents received; Claude reads the colors next.
- Round R09 (13 Nov 26): window, inventory, renderer and PnP retest passed (PnP web login connected with full list rights); downloads were blocked, Task 9 names did not match, the Task 11 form stopped: fixed in R10. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-14-r09-results.md
- Round R06, Deployer and cleanup (13 Nov 26): 4 of 4 pass; Copy script worked; cleanup recycled 4 files and 1 folder; the draft opened; the window did not (text mode), fix in R08. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-13-r06-results.md
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
