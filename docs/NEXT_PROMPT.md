# Next prompt: 90-161.Z

Updated: 2026-11-10 23:05 by Claude. Keep this file at 40 lines or fewer. The current request overrides it.

## State

- main: renderer lane and lists lane merged. tests/run.sh passes in the agent workspace.
- Renderer: scripts/gov/Test-Publication.ps1 (validator), scripts/gov/New-Publication.ps1 (Word COM). Not yet run on the gov device.
- Lists: schemas/lists/*.json; flow/provisioning-payload.json (generated); docs/power-automate-provisioning.md. Flow not yet built.
- format-rules.md: 45 rules checked against ref text (self-review); layout L-001..L-011 measured from the PDF.
- PowerShell to SharePoint: blocked (PnP sign-in window never opened). Provision-Lists.ps1 kept, not verified.

## Open (in order)

1. PFM builds and runs the provisioning flow; report pass/fail per section 3 of the guide.
2. PFM runs docs/gov-test-plan.md (renderer on the sample); fix what fails.
3. Pilot L1 on GenAI.mil with docs/genai-prompt.md and 3 fake drafts (ChatGPT Mil vs Gemini).
4. Endorsement flows (request, reminder, escalation) in Power Automate, per ARCHITECTURE s4.
5. Power Apps intake and status screens.
6. Extract Tables A3.1/A3.2 (mandatory coordinators) for wing-level use.

## Needs PFM

- Open choices in docs/sharepoint-lists.md (customer visibility, Endorser person vs text, CRM storage).
- "Certified by:" (DAFMAN cover) vs "Certified By:" (4.5.4.11): renderer uses 4.5.4.11.

## Do not

- Put government data, the wing's name or site path in this repo or in Claude chats.
- Let the model set format. Format comes from code.
