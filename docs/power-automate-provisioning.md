# Create the 90-161.Z lists with Power Automate

Decided (PFM, 2026-11-10): lists are created by a Power Automate flow, not PowerShell. The flow runs under your own sign-in and uses only the SharePoint connector ("Send an HTTP request to SharePoint"): no premium license, no admin.

Names (PFM, 2026-11-11, docs/DECISIONS.md): every list has the prefix PFM. Each list is created under its URL name without spaces, then gets its display title.

## 1. What the flow creates

| Display title | URL name | Holds | Who sees rows |
|---|---|---|---|
| PFM Offices | PFMOffices | One row per coordinating office | All site members |
| PFM Series | PFMSeries | Series numbers and titles (DAFMAN Table A2.1), 39 rows added by the flow | All site members |
| PFM Process Steps | PFMProcessSteps | The process steps with Table A5.2 target business days (draft; not seeded) | All site members |
| PFM Settings | PFMSettings | One row per setting (wing name, PFM mailbox, defaults); 2 rows added by the flow (DAFMAN 5.2, 5.2.2 suspense days) | All site members |
| PFM Publications | PFMPublications | One row per action (8 DAFMAN 1.1.4 types); points to its Product Index row | All site members |
| PFM Activity Log | PFMActivityLog | One row per event; Created and Publication indexed | All site members |
| PFM Endorsements | PFMEndorsements | One row per coordinator per action; Coordination Stage (Privacy Review, Formal Coordination, Legal) | All site members |
| PFM Product Index | PFMProductIndex | The Product Index (DAFMAN 6.4.2) | All site members |
| PFM Reviews | PFMReviews | One row per periodic or special review (DAFMAN 7.4.2-7.4.4) | All site members |

Columns, views and their DAFMAN references: `schemas/lists/*.json` (one file per list, named by URL name). The payload `flow/provisioning-payload.json` is generated from them.

## 2. Import and run

Package: `flow/packages/90161Z-T02-provision-lists-r7.zip` (built by `python3 scripts/build_flow_package.py` from `flow/defs/90161Z-T02-provision-lists-r7.json`; the payload is embedded at build). Steps for the gov device are in go.md, Task 2.

The flow asks for 2 inputs:
- **Site URL**: the full address of the site that will hold the lists.
- **Site Title**: the site's title exactly as it shows at the top of the site.

Order of work:
1. **Check Site Title** reads the site's title. If it does not match what you typed (ignoring capital letters and outer spaces), the run stops with "SiteTitleMismatch" and creates nothing.
2. **Create Lists**: 9 lists under their URL names, versioning on.
3. **Get ... ID** (Offices, Process Steps, Product Index, Publications, Series): the IDs that lookup columns need.
4. **Create Fields And Views**: columns, views and view columns, one request at a time.
5. **Add Rows**: the 39 series rows into PFM Series and the 2 rows into PFM Settings.
6. **Apply Updates**: index Created on the Activity Log, rename the Title column where a list uses another label (Setting, Event, Office), then set each list's display title. This runs last because steps 2-4 find lists by URL name.
7. **Result** shows the counts.

## 3. Checks after the run

| Check | Pass |
|---|---|
| Run | Succeeded; Result shows "Lists: 9, fields and views: 213, rows: 41, updates: 15 - provisioning finished" |
| Site contents | The 9 display titles in section 1 exist; PFM Series has 39 rows; PFM Settings has 2 rows |
| List address | Open PFM Publications: the address ends in /Lists/PFMPublications |
| PFM Endorsements, Endorser column | Type Person or Group, people only |
| PFM Endorsements, Endorsement Status column | Choices: Not started, Concur, Concur With Comment, Concur—No Response, Nonconcur, No Comment; default Not started |
| PFM Endorsements, Coordination Stage column | Choices: Privacy Review, Formal Coordination, Legal; default Formal Coordination |
| PFM Publications, Product column | Lookup to PFM Product Index, shows Publication Number |
| PFM Publications, Status Notes column | List settings > Status Notes shows "Append Changes to Existing Text: Yes" |

Run it once. A second run fails on lists and fields that already exist and ends red; that is expected.

If a run fails part way (any step red, Result not shown), do not run it again on top. Recover:
1. Note the failed step's name, HTTP status and error code.
2. Site contents: delete every list whose name starts with PFM (they are empty after provisioning). Some may still show their URL name (for example PFMPublications) because titles are set last.
3. Empty the site recycle bin of those lists (Recycle bin > select > Delete), so the URL names are free again.
4. Run the flow again.

If a step fails, open it and send only the HTTP status code and the error code (for example `400 / -2130575342`). Do not send URLs or names.

## 4. Permissions and site settings (manual)

Decided (PFM, 2026-11-11, replaces the 2026-11-10 creator-only rule): all site members read all rows; people add and change rows through the app. Do not turn on item-level permissions: it would hide rows from the AO and endorsers, and from anyone when a flow creates the row.

1. Leave each PFM list on the site's permissions (no unique permissions, no Advanced settings change).
2. Site settings > Regional settings > Time zone: (UTC-06:00) Central Time. Date-only columns (suspense, due and review dates) then show the same day for everyone.

## Change a list or column

1. Edit `schemas/lists/<URL name>.json`. Names follow the rules in docs/DECISIONS.md (2026-11-11); `tests/check_names.py` fails on a name that breaks them.
2. Run `python3 scripts/build_flow_payload.py`, then `python3 scripts/build_flow_package.py`. Never hand-edit the payload or the zip.
3. Run `tests/run.sh` (pass = `TESTS pass=N fail=0`).
4. A list that already exists on the site is not changed by a re-run. Add a new column by hand in List settings, with the same internal name, or plan a change flow.
