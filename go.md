# 90-161.Z: tasks for my work computer

Updated: 11 Nov 26, 1801 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by e-mail to my Gmail. Never send real publication content.

## Task 1: renderer test, r3 (open, 11 Nov 26, 1543 CT)

Folder: ...\90-161.Z\T01

r2 result: runner and validator ok; Word could not save. r3 fixes the save. Replace New-Publication.ps1 and the runner; the other three files are unchanged.

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Save these five files into the T01 folder (delete the r2 runner):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T01-renderer-test-r3.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Publication.Common.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/publication.sample.json

In File Explorer, right-click 90161Z-T01-renderer-test-r3.ps1 > Run with PowerShell. Type my DODID, or press Enter. It saves 90161Z-T01-result-r3.txt in the T01 folder.

Report: the RENDER, VALIDATE and exit lines (or the STOPPED line), and each check (1-8) in the test plan that fails, with what I see.

## Task 2: create the lists, r9 (open, 11 Nov 26, 1801 CT)

Folder: ...\90-161.Z\T02

r9 replaces r6, r7 and r8 (do not run them). r9 = r8 without the site-title check: the flow asks only for the site address. r8 standardized every name, choice and description standardized IAW DAFMAN 90-161 and The Tongue and Quill, and column descriptions that spell out abbreviations. r7 added the DAFMAN 90-161 check I approved: the eight DAFMAN action types, coordination stages (Privacy Review, Formal Coordination, Legal), nonconcur resolution, certifier and approver fields, a new PFM Reviews list for the 4-year reviews, Expired status, Superseded By and Parent Publication links, and two settings rows (15 business days, 30 calendar days).

Run it on a TEST site first (a site or subsite only I use). After it passes there, run it again on the real site.

First: delete the four lists the r1 run made on the wrong site (Stages, Publications, Endorsements, PublicationIndex): Site contents > the list's ... menu > Delete.

What r9 does: on the site I paste, it creates nine lists: PFM Offices, PFM Process Steps, PFM Series, PFM Settings, PFM Product Index, PFM Publications, PFM Activity Log, PFM Endorsements, PFM Reviews. Details and checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/power-automate-provisioning.md

What the lists look like (opens in the Claude app, not on my work computer):
https://claude.ai/artifact/2CtD3ASmmmzkz1EPErgCvh

Download into the T02 folder (raw link only):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T02-provision-lists-r9.zip

The file must be 143,327 bytes.

In Power Automate: My flows > Import > Import Package (Legacy) > Upload > 90161Z-T02-provision-lists-r9.zip.
Import setup: flow = Create as new. SharePoint connection = Select during import > pick my existing SharePoint connection > Save. Then Import.
Open the flow "90161Z T02 Provision Lists r9", Test > Manually > Run flow. Paste the full site address. Run it once per site.
Pass: "Result" shows "Lists: 9, fields and views: 213, rows: 41, updates: 15. Provisioning finished." Then do the checks in section 3 and the settings in section 4 of the details page.
Then delete the r1 flow "90161Z T02 Provision lists r1" and any r2 to r8 flow I imported.

Report: test site or real site; import ok or the exact error text; the Result text, or for the first failed step only its name, HTTP status and error code.

## Task 5: solution export sample (open, 11 Nov 26, 1606 CT)

Folder: ...\90-161.Z\T05

Goal: a real export so Claude can build flows as Dataverse solutions (easier to move and hand over than legacy packages). Like Task 3, Claude needs a real file before building one.

In Power Automate:
1. Solutions > New solution. Display name: 90161Z T05 Solution Sample. Publisher: New publisher > Display name: PFM, Name: pfm, Prefix: pfm > Save > Create.
2. Open the solution > New > Automation > Cloud flow > Instant. Name: 90161Z T05 Sample. Trigger: Manually trigger a flow. Create.
3. Add the SharePoint action Get items. Site Address and List Name: any site and list on my test site. Save.
4. Back in the solution: Export solution > Next > Unmanaged > Export. Save the zip into the T05 folder.
5. Open the zip. Send me by e-mail (to my Gmail) the list of file and folder names in it, and the full text of: solution.xml, customizations.xml, [Content_Types].xml and the .json file in the Workflows folder.

Report: also tell me if step 1 or step 4 was blocked, with the exact message. Never send list contents.

## Done

- Task 2, create the lists r1 (11 Nov 26): import and run ok, four lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (11 Nov 26): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (11 Nov 26): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (11 Nov 26, 0840): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
