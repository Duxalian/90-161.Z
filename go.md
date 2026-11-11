# 90-161.Z: tasks for my work computer

Updated: 2026-11-11 07:55 CT. Bookmark on my work computer (clickable links):
rhope-ops.github.io/90-161.Z
Fallback (plain text):
raw.githubusercontent.com/rhope-ops/90-161.Z/main/go.md

Reload to see new tasks (GitHub can serve a copy up to 5 minutes old).
Copy each URL below into the address bar. Save files with Ctrl+S.
Reply with results in the Claude chat or by email to my Gmail. Never send real publication content.

## Task 1: renderer test (open)

Steps and pass checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/gov-test-plan.md

Save these 4 files into one folder on my computer (for example C:\90161Z):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Publication.Common.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/Test-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/scripts/gov/New-Publication.ps1
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/samples/publication.sample.json

Then run the 3 commands in the test plan, section "Run".

Report: the RENDER and VALIDATE lines, and each check (1-8) that fails, with what I see.

## Task 2: Power Automate list provisioning (open)

Build steps and checks:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/docs/power-automate-provisioning.md

Payload (paste the whole file into the "Payload" Compose action):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/provisioning-payload.json

Report: pass or fail for each check in section 3. For a failure, only the HTTP status and error code.

## Task 3: flow import test (open)

Download this file (Ctrl+S if it opens as text; keep the .zip name):
https://rhope-ops.github.io/90-161.Z/flow/packages/hello-test.zip
Fallback:
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/hello-test.zip

In Power Automate: My flows > Import > Import Package (Legacy) > Upload > hello-test.zip.
Import setup: Create as new > Save > Import.
Open the flow, Test > Manually > Run flow.
Pass: the run succeeds and "Echo compose" shows "Hello from 90-161.Z - import worked".

Report: download ok/fail; Import Package (Legacy) menu present yes/no; import ok or the exact error text; run result.

## Done

(none yet)
