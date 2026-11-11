# Create the 90-161.Z lists with Power Automate

Decided (PFM, 2026-11-10): lists are created by a Power Automate flow, not PowerShell. The flow runs under your own sign-in and uses only the SharePoint connector ("Send an HTTP request to SharePoint"): no premium license, no admin.

Names (PFM, 2026-11-11, docs/DECISIONS.md): every list has the prefix PFM. Each list is created under its URL name without spaces, then gets its display title.

## 1. What the flow creates

| Display title | URL name | Holds | Who sees rows |
|---|---|---|---|
| PFM Offices | PFMOffices | One row per coordinating office | All site members |
| PFM Process Steps | PFMProcessSteps | The process steps (draft; not seeded) | All site members |
| PFM Settings | PFMSettings | One row per setting (wing name, PFM mailbox, defaults) | All site members |
| PFM Publications | PFMPublications | One row per publication or form action | Creator only (section 4) |
| PFM Activity Log | PFMActivityLog | One row per event; Created and Publication indexed | All site members |
| PFM Endorsements | PFMEndorsements | One row per endorser per action | Creator only (section 4) |
| PFM Product Index | PFMProductIndex | The Product Index (DAFMAN 6.4.2) | All site members |

Columns, views and their DAFMAN references: `schemas/lists/*.json` (one file per list, named by URL name). The payload `flow/provisioning-payload.json` is generated from them.

## 2. Import and run

Package: `flow/packages/90161Z-T02-provision-lists-r2.zip` (built by `python3 scripts/build_flow_package.py` from `flow/defs/90161Z-T02-provision-lists-r2.json`; the payload is embedded at build). Steps for the gov device are in go.md, Task 2.

The flow asks for 2 inputs:
- **Site URL**: the full address of the site that will hold the lists.
- **Site Title**: the site's title exactly as it shows at the top of the site.

Order of work:
1. **Check Site Title** reads the site's title. If it does not match what you typed (ignoring capital letters and outer spaces), the run stops with "SiteTitleMismatch" and creates nothing.
2. **Create Lists**: 7 lists under their URL names, versioning on.
3. **Get Process Steps ID**, **Get Publications ID**: the IDs that lookup columns need.
4. **Create Fields And Views**: columns, views and view columns, one request at a time.
5. **Apply Updates**: index Created on the Activity Log, rename the Title column where a list uses another label (Setting, Event, Office), then set each list's display title. This runs last because steps 2-4 find lists by URL name.
6. **Result** shows the counts.

## 3. Checks after the run

| Check | Pass |
|---|---|
| Run | Succeeded; Result shows "Lists: 7, fields and views: 112, updates: 11 - provisioning finished" |
| Site contents | The 7 display titles in section 1 exist |
| List address | Open PFM Publications: the address ends in /Lists/PFMPublications |
| PFM Endorsements, Endorser column | Type Person or Group, people only |
| PFM Endorsements, Endorsement Status column | Choices: Not started, Concur, Concur With Comment, Concur—No Response, Nonconcur, No Comment; default Not started |
| PFM Publications, Status Notes column | List settings > Status Notes shows "Append Changes to Existing Text: Yes" |

Run it once. A second run fails on lists and fields that already exist and ends red; that is expected.

If a step fails, open it and send only the HTTP status code and the error code (for example `400 / -2130575342`). Do not send URLs or names.

## 4. Set item-level permissions (manual, 2 lists)

Decided (PFM, 2026-11-10): customers see only the rows they created. You (site owner) still see all rows. For **PFM Publications** and **PFM Endorsements**:

List > Settings (gear) > List settings > Advanced settings > Item-level Permissions:
- Read access: **Read items that were created by the user**
- Create and Edit access: **Create items and edit items that were created by the user**
> OK.

Known gap: an AO who did not create a row cannot see it. A later flow will give the AO access to that row.

## Change a list or column

1. Edit `schemas/lists/<URL name>.json`. Names follow the rules in docs/DECISIONS.md (2026-11-11); `tests/check_names.py` fails on a name that breaks them.
2. Run `python3 scripts/build_flow_payload.py`, then `python3 scripts/build_flow_package.py`. Never hand-edit the payload or the zip.
3. Run `tests/run.sh` (pass = `TESTS pass=N fail=0`).
4. A list that already exists on the site is not changed by a re-run. Add a new column by hand in List settings, with the same internal name, or plan a change flow.
