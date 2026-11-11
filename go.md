# 90-161.Z: tasks for my work computer

Updated: 2026-11-11 08:20 CT. Bookmark on my work computer (clickable links):
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

## Task 4: SharePoint connection test (open, 2026-11-11 10:20 CT)

Download (raw link only):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/packages/sp-get-items.zip

The file must be 6,337 bytes.

In Power Automate: My flows > Import > Import Package (Legacy) > Upload > sp-get-items.zip.
Import setup: flow = Create as new. SharePoint connection = Select during import > pick my existing SharePoint connection > Save. Then Import.
Open the flow, Test > Manually > Run flow. Type the full site address and the display name of any list on that site.
Pass: the run succeeds and "Item count" shows "Items read: N - SharePoint connection worked".

Report: file size; import ok or the exact error text; run result (only the Item count text or the error code, no list contents).

## Done

- Task 3, flow import test (2026-11-11 08:40): raw zip link, Import Package (Legacy), run passed ("Echo compose" showed the expected text).
