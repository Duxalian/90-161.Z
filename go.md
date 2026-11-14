# 90-161.Z: tasks for my work computer

Updated: 14 Nov 26 (Round R12: the site steps, logo and seals now run by script; Task 11 r3; Tasks 2, 7, 10 and 14 closed or moved into the round).
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

## Round R12 r2: site setup, seals and logo by script (open, 14 Nov 26)

**For:** does by script what I did by hand: Task 2 steps 7-8, Task 14, Task 7 Part B (library, folder, upload, sync, path) and the Task 11 result download. Checks stay the same; the script reads each change back.
**Time:** about 10 minutes (estimate) for the default steps; Part B form adds about 25.
**Changes:** on my computer: writes into T01, T07, T11, T14, T15, T16, Config and Rounds\R12; saves the seal attachments from the "90161Z T07 seals" e-mails into T07\Seals (reads Outlook, changes nothing there); moves Rounds\R11 and old scripts to the Recycle Bin. On the new site: sets "edit own rows" on PFM Publications and PFM Endorsements, sets the time zone to Central, uploads the logo and its thumbnail to Site Assets and sets them in the header, creates the library 90-161.Z with the folder Seals and uploads the seals and prepared seals, and downloads the Task 11 result file if it exists. Nothing else. Saves one Outlook draft (never sent).
Steps:
1. Keep the 6 e-mails "90161Z T07 seals r1" in the Inbox (the round reads them).
2. Press Copy script next to this link (if it says blocked: open the link, Ctrl+A, Ctrl+C).
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/paste/90161Z-R12-round-r2.ps1
3. Start menu: type ISE, open Windows PowerShell ISE. File > New, click in the white pane, press Ctrl+V, then F5.
4. Three steps are checked. The render test (T01) is off: it turns on by itself only when the renderer code changed since it last passed (R11). Check "T11 Part B" too if I have the time. If I already ran R12 r1, I do not run r2.
5. Press Enter (or Run). The site setup step asks for the NEW site address (filled in from last time) and opens a CAC sign-in.
6. When it ends, open the new site and look at the header: the logo should show (white squares on the blue header). This is the only check by eye.
7. The Outlook draft opens with the summary and the files. Send it.
**Report:** the draft itself, plus one line in the e-mail body: "logo OK" or what looks wrong. Claude watches the inbox for the subject.
**If it fails:** read the WHAT TO DO line in the window. A FAIL line in the site setup names the by-hand fallback (for example Change the look > Header); do only that item by hand.

## Task 11: rights and capability test, r3 (open, 14 Nov 26)

**For:** finds what I can and cannot do on the new site, with the office mailbox, in Power Apps, Power Automate and Forms. Every later design step depends on these answers. r3 also reads its own test e-mails, so the round needs no Outlook check and no mailbox box.
**Time:** about 35 minutes (estimate): Part A 10, Part B (in a round) 25.
Folder: %USERPROFILE%\OneDrive - United States Air Force\90-161.Z\T11
**Changes:** imports one flow into my Power Automate. On the new site the flow creates test lists and a test group named "PFM Rights Probe ..." and deletes them at the end (they stay in the site recycle bin), and adds one result file to the Documents library. It sends 3 test e-mails to me only: 1 from my mailbox, 2 from the office mailbox (subjects start "90161Z TEST"), then reads how they arrived. Nothing else.
Part A, the probe flow (best before Round R12, so the round fetches the result):
1. Save this file into the T11 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T11-rights-probe-r3.zip
2. Power Automate: My flows > Import > Import Package (Legacy). Pick the file. For each connection (SharePoint, Office 365 Users, Office 365 Outlook) pick my existing one, or Create new if I have none. Import.
3. Run "90161Z T11 Rights Probe r3". Site address: the new site. Coworker e-mail: one regular member of that site (not an owner). Wing group e-mail: the group that gives wing members access, if it has one. Office mailbox e-mail: the office shared mailbox (the organizational mailbox the office sends from, not mine). The run takes a few minutes longer than r2 (it waits 2 minutes for the test e-mails).
Part B: check "T11 Part B" in the round. The form keeps my answers, so I can answer some rows each round.
Report: the round's e-mail. No names, site address or group names in the notes: write "my AD group", "the office mailbox".
**If it fails:** if the import asks for a connection I cannot make, send its name. If the run stops early, delete anything named "PFM Rights Probe ..." by hand and send the name of the step that failed and its error text (no names). A red step in the run is a result, not a failure: the run goes on.

## Done

- Task 2, the 12 lists on the new site (14 Nov 26): R11 counted 12 PFM lists there. Round R12 sets "edit own rows" and the time zone by script and counts lists and rows, so I do not read the flow result.
- Task 14 and Task 7 Part B (14 Nov 26): moved into Round R12 (logo, Seals folder, upload, prep). Claude corrected the 17 seals and sent them in 6 e-mails "90161Z T07 seals r1".
- Task 10, decision briefs (14 Nov 26): R11 checked all 3 (overflow 0, past-edge 0) and I opened them in PowerPoint: they open normally. Closed.
- Round R11 (13 Nov 26): window, inventory (142 items), renderer, brief check (3 of 3), PnP on the new site (manage lists, site and permissions; 12 PFM lists) passed; the Outlook check stopped (E_ABORT, the Outlook access prompt): R12 moves it into the probe flow. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/reviews/2026-11-14-r11-results.md
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
