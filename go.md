# 90-161.Z: tasks for my work computer

Updated: 2026-11-11 15:35 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
New files are named 90161Z-T<task>-<name>-r<revision> so they sort by task in my folders. Use the highest r number.
If a downloaded script is blocked: open its raw link, Ctrl+A, Ctrl+C, paste into Notepad, File > Save as, Save as type = All files, the exact file name shown at the end of the link, into the task folder. All script files are plain ASCII, so the paste is exact.
Each task has its own folder: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<task> (for example ...\90-161.Z\T01). Save that task's files there. Scripts ask for my DODID and go to that folder themselves.
Reply with results in the Claude chat or by email to my Gmail. Never send real publication content.

## Task 1: renderer test, r2 (on hold, 2026-11-11 15:35 CT)

r2 result: runner, folder and validator ok; Word could not save the file. The fix waits until the naming decisions are made (file names are part of them). Do not rerun yet.

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

## Done

- Task 2, create the lists r1 (2026-11-11): import and run ok, 4 lists created, but on the wrong site and before names were agreed. I delete those 4 lists (Site contents > list ... > Delete). A new task follows after the naming decisions.
- Task 4, SharePoint connection test r2 (2026-11-11): import ok, existing SharePoint connection ok, run passed (Item count showed items read).
- Task 3, flow import test (2026-11-11 08:40): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
