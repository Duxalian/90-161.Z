# Project phases (12 Nov 26)

Status: the PFM's phase order (12 Nov, in chat) plus agent recommendations marked **REC:**. A REC is not a decision until the PFM approves it; approved items go to docs/DECISIONS.md.

## PFM's phases (12 Nov)

| # | Phase | State now |
|---|---|---|
| 1 | Build and test the PowerShell ISE deployment engine UI | Built: Stage 1 runner (WinForms window in the paste, branch ccr-2cb71415-mt9o5x, commit 533f43b, build b60abd8b). Cloud checks on that branch: tests 50 pass / 0 fail, lint 0 findings. Not tested on the gov device: waits for Round R01 (go.md Fix first). |
| 2 | Outstanding items: function, use, scale, flexibility (for example the PFM away on deployment, roles easy to re-assign) | Partial: continuity (co-owners, how-to last), P4A sender switch, P5A handover runbook, 1.1C AO change. No role model for an acting PFM yet. |
| 3 | Lists, libraries, security settings; use existing groups; setup takes in as much existing data as possible | Partial: list design approved (14A), access group by type (P6, docs/setup-and-updates.md 4a), CSV import of products (3A), Series and Table A3.2 seeds. Rights not tested (go.md Task 11). |
| 4 | The app: UX/UI in full, all text | Inputs exist: docs/style-standard.md, customer guidance r3 (75 screens), PFM Guidance list (12A), palette (values wait for go.md Task 12). No screen map yet. |

## REC: changes to the plan

1. **REC:** Phase 1 = runner only (test loop for gov-device code). SharePoint setup stays in Power Automate flows. Reason: the PnP sign-in failed (10 Nov), and other wings may have no PowerShell access to SharePoint (Deployable package rule), so a PowerShell installer would be a second path to keep working.
2. **REC:** Run phases 2 and 3 as one discussion pass while R01 waits on the gov device. Role re-assignment is a permissions design question: it changes the same Settings rows and groups as phase 3.
3. **REC:** Add the phases that follow phase 4 (they are in NEXT_PROMPT "Next design" but not in this order):
   - 5. Flow rule catalog (docs/flow-rules.md, decided 2A) and T02 r10 provisioning.
   - 6. Flows build (solution-aware, connection references).
   - 7. App build (Power Apps canvas), Accessibility Checker 0 errors.
   - 8. Pilot on the test site (requested), rights tests (Task 11) before it.
   - 9. Handover: maintainer how-to, kit repo (5A), releases.

## Phase 2 and 3 starting points (agent first take)

- Risk (high): flows run on the PFM's connections (2.2A). If the PFM's account is disabled, every flow stops; a co-owner does not move the connections. Connection references let a co-owner re-bind them in one place.
- **REC:** roles as data, not names in code: PFM Settings rows PFM, Alternate PFM, Acting PFM (with Acting Until); the app shows PFM screens to members of the PFM office SharePoint group; flows address the role, not a person. Re-assign = one screen, one flow (group membership, Settings row, Activity Log row).
- Existing groups (high confidence): SharePoint permissions can be granted to existing Entra/AD security groups, M365 groups and SharePoint groups. A flow can set them through SharePoint REST if the installer has Manage Permissions (R5); otherwise a checklist for the site owner.
- Intake of existing data, candidates: existing site groups and members (offered as choices, not copied); posted publications in an existing library (designator, title, date from file names and properties, the PFM confirms each row); the products CSV (3A); the e-Publishing index (Task 9). Org box addresses for PFM Offices are entered or loaded by CSV (org boxes are not users; directory lookup is unlikely to find them).
