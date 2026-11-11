# 90-161.Z: tasks for my work computer

Updated: 2026-11-11 14:45 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by email to my Gmail. Never send real publication content.

## Task 1: renderer test, r2 (open, 2026-11-11 14:45 CT)

Folder: ...\90-161.Z\T01

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Save these 5 files into the T01 folder:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/90161Z-T01-renderer-test-r2.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Publication.Common.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/publication.sample.json

In File Explorer, right-click 90161Z-T01-renderer-test-r2.ps1 > Run with PowerShell. Type my DODID, or press Enter to use this computer's profile folder. It runs all 3 steps and saves 90161Z-T01-result-r2.txt in the T01 folder.

Report: the RENDER and VALIDATE lines, the 3 "exit=" lines, and each check (1-8) that fails, with what I see.

## Task 2: create the lists, r1 (open, 2026-11-11 14:45 CT)

Folder: ...\90-161.Z\T02

This replaces the hand-built flow: the flow now comes as a package, like Task 4. Run it on the site that will hold the 90-161.Z lists.

Download into the T02 folder (raw link only):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/90161Z-T02-provision-lists-r1.zip

The file must be 43,215 bytes.

In Power Automate: My flows > Import > Import Package (Legacy) > Upload > 90161Z-T02-provision-lists-r1.zip.
Import setup: flow = Create as new. SharePoint connection = Select during import > pick my existing SharePoint connection > Save. Then Import.
Open the flow "90161Z T02 Provision lists r1", Test > Manually > Run flow. Type the full site address. Run it once only.
Pass: the run succeeds and "Result" shows "Lists: 4, fields and views: 60 - provisioning finished". Then do the checks in section 3 and the permissions in section 4 of:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/power-automate-provisioning.md

Report: file size; import ok or the exact error text; the Result text, or for the first failed iteration only the HTTP status and error code.

## Done

- Task 4, SharePoint connection test r2 (2026-11-11): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (2026-11-11 08:40): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
