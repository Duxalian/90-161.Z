# Roles, permissions and intake: design r1 (12 Nov 26)

Status: design from phase 2+3 round 1 (PFM 4A 5A 6A 7A 8A+ 9A, 12 Nov; docs/phases.md). Items marked **REC:** are agent recommendations, open until the PFM approves. Items marked **Test** are not proven on the tenant (docs/rights-test-plan.md). Library layout and folder permissions: docs/reviews/2026-11-12-list-design-full-scope.md section 5 (decided in batch 2).

## 1. Roles are data (PFM 4A, 6A)

| PFM Settings key | Value | Who changes it |
|---|---|---|
| PFM | Person (sign-in address) | PFM or Alternate PFM, through the app |
| Alternate PFM | Person | PFM, through the app |
| Acting PFM | Person, empty when nobody acts | PFM or Alternate PFM (**REC:** Q11) |
| Acting Until | Date | Same as Acting PFM |

- The app shows the PFM screens to members of the SharePoint group **PFM Office** (decided 3.7B). Flows address a role ("send to Acting PFM, else PFM"), never a fixed person.
- The Acting PFM gets full PFM rights (6A). Every change is a PFM Activity Log row.
- Flow "90-161.Z - Assign Acting PFM" (app button): adds the person to PFM Office, writes the two Settings rows, logs, e-mails the PFM, the Alternate PFM and the new Acting PFM.
- The daily health-check flow (P5A) warns 5 weekdays before Acting Until. **REC:** Q10 for what happens on the end date.

## 2. Connections (PFM 5A)

Service accounts are not available in practice (PFM, 12 Nov). Flows run on the PFM's connections, inside a solution with connection references.

- The Alternate PFM is co-owner of the solution, every flow and the app (continuity decision 2026-11-11).
- If the PFM's account stops: the Alternate PFM opens the solution, sets each connection reference to the Alternate's own connection, turns the flows back on. Runbook step list in the handover runbook (P5A). **Test:** a co-owner can re-bind a connection reference without the original owner (add to Task 11).
- The health-check flow reports a broken connection the same day (a flow that cannot run cannot report itself: **REC:** a second, tiny flow on the Alternate's connection checks that the health-check ran).

## 3. Permission groups (PFM 7A)

| Group | Made by | Members | Rights |
|---|---|---|---|
| PFM Office (SharePoint group) | Setup | PFM, Alternate PFM, Acting PFM, people who work the org box | Edit on every PFM list and the 90-161.Z library; only group with edit on config lists (P2A) |
| Wing access group (existing; type per P6) | Exists | All wing members | Read on all lists; create and edit own rows on PFM Publications and PFM Endorsements (10A); read on Published |
| Site Owners (existing) | Exists | Site owners | Unchanged; not used by the app |

- **REC:** Q13: the owner of PFM Office is PFM Office itself, so any member can add an Acting PFM when no site owner is reachable.
- A flow sets these through SharePoint REST when the installer has Manage Permissions (R5); else setup prints a checklist for the site owner.

## 4. Intake of existing data (PFM 8A plus manual upload, 9A)

| Source | How | Result |
|---|---|---|
| Existing site groups | Setup reads the site's groups and offers them as the wing access group | Choice, nothing copied |
| Library of posted publications on the same site (9A) | Setup asks which library; a flow reads file names and file properties (Title, Modified) and matches the designator pattern | One PFM Product Index row per file, view "PFM - Imported, Not Confirmed"; the PFM confirms each row |
| Manual upload (PFM, 12 Nov) | App screen: upload one existing publication or form; same reading as the scan | One row, same view |
| Products CSV (3A) | Import screen | Rows, same view |
| e-Publishing index (Task 9) | Cross-check by number | Report of mismatches |

- Limit (high confidence): standard connectors cannot read the text of a PDF or .docx; AI Builder is premium. So OPR, certifier and dates come from typing, or from Q12.
- **REC:** Q14: imported files stay where they are; the row links to them.

## 5. Open questions (round 2)

| Q | Question | Options | REC |
|---|---|---|---|
| Q10 | Acting PFM on the end date | A: removed from PFM Office the next weekday, logged, warning 5 weekdays before. B: reminder only; a person removes | A |
| Q11 | Who may name an Acting PFM | A: PFM or Alternate PFM. B: any PFM Office member | A |
| Q12 | Cover data of existing publications | A: a runner step on the gov device reads the covers of a folder of existing publications with Word COM (number, title, date, OPR, certifier) into the 3A CSV; real data stays on the device and in SharePoint. B: file name and properties only, the rest typed | A |
| Q13 | Owner of the PFM Office group | A: the group itself. B: site Owners | A |
| Q14 | Existing publication files | A: stay in place, the row links to them. B: copied into 90-161.Z Published | A (no broken links, no duplicates) |
