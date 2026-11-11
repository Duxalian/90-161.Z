# 90-161.Z: tasks for my work computer

Updated: 2026-11-11 15:43 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by email to my Gmail. Never send real publication content.

## Task 1: renderer test, r3 (open, 2026-11-11 15:43 CT)

Folder: ...\90-161.Z\T01

r2 result: runner and validator ok; Word could not save. r3 fixes the save. Replace New-Publication.ps1 and the runner; the other 3 files are unchanged.

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Save these 5 files into the T01 folder (delete the r2 runner):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T01-renderer-test-r3.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Publication.Common.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/publication.sample.json

In File Explorer, right-click 90161Z-T01-renderer-test-r3.ps1 > Run with PowerShell. Type my DODID, or press Enter. It saves 90161Z-T01-result-r3.txt in the T01 folder.

Report: the RENDER, VALIDATE and exit lines (or the STOPPED line), and each check (1-8) in the test plan that fails, with what I see.

## Task 2: create the lists, r2 (open, 2026-11-11 15:43 CT)

Folder: ...\90-161.Z\T02

Hold (2026-11-11): run r2 only on a test site, not the real site, until the row-privacy decision in the gap review is made (it changes section 4).

First: delete the 4 lists the r1 run made on the wrong site (Stages, Publications, Endorsements, PublicationIndex): Site contents > the list's ... menu > Delete.

What r2 does: on the site I name, it creates 7 lists: PFM Offices, PFM Process Steps, PFM Settings, PFM Publications, PFM Activity Log, PFM Endorsements, PFM Product Index. It first reads the site's title and stops, creating nothing, if the title I type does not match. Details:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/power-automate-provisioning.md

Download into the T02 folder (raw link only):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T02-provision-lists-r2.zip

The file must be 74,828 bytes.

In Power Automate: My flows > Import > Import Package (Legacy) > Upload > 90161Z-T02-provision-lists-r2.zip.
Import setup: flow = Create as new. SharePoint connection = Select during import > pick my existing SharePoint connection > Save. Then Import.
Open the flow "90161Z T02 Provision Lists r2", Test > Manually > Run flow. Type the full site address and the site's title exactly as it shows at the top of the site. Run it once only.
Pass: "Result" shows "Lists: 7, fields and views: 112, updates: 11 - provisioning finished". Then do the checks in section 3 and the permissions in section 4 of the details page.
Then delete the r1 flow "90161Z T02 Provision lists r1".

Report: import ok or the exact error text; the Result text, or for the first failed step only its name, HTTP status and error code.

## Done

- Task 2, create the lists r1 (2026-11-11): import and run ok, 4 lists created, but on the wrong site and before names were agreed (r2 replaces it).
- Task 1, renderer test r2 (2026-11-11): runner and validator ok; Word save failed (fixed in r3).
- Task 4, SharePoint connection test r2 (2026-11-11): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (2026-11-11 08:40): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
