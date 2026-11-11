# SharePoint lists and provisioning script

> Status (PFM, 2026-11-10): the PowerShell path did not work on the gov device (PnP sign-in window never opened). Create the lists with Power Automate instead: docs/power-automate-provisioning.md. Provision-Lists.ps1 is kept for reference and is not verified; open review findings: unsanitized terminating errors, no -AzureEnvironment option, exit code on bad JSON.

Status: draft (Agent, 2026-11-10; names updated per PFM 2026-11-11). Implements docs/ARCHITECTURE.md sections 3 and 4, docs/process-model.md, and the Product Index (DAFMAN 90-161 6.4.2). Nothing here is a PFM decision. No site, person or office data is in the repo.

## What the script needs

- Windows PowerShell 5.1 and PnP.PowerShell 1.12.0 (no other modules).
- Site collection admin rights on the 90-161.Z site. No tenant admin and no app registration.
- The script file and the four schema files, all in one folder tree on the gov device.

## How to run

1. On the gov device open the public repo in a browser. Open each file below, use "Raw", select all, copy.
   - `scripts/gov/Provision-Lists.ps1`
   - every file in `schemas/lists/` (7 files, named by list URL name)
2. Create this folder layout and save each file in it as UTF-8 (Notepad: Save as, Encoding UTF-8):

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\90-161.Z\scripts\gov", "$HOME\90-161.Z\schemas\lists" | Out-Null
```

   Files go to `$HOME\90-161.Z\scripts\gov\Provision-Lists.ps1` and `$HOME\90-161.Z\schemas\lists\*.json`.
3. Open PowerShell (not as admin). If scripts are blocked for this session only:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

4. Check the schemas (no network, no sign-in):

```powershell
& "$HOME\90-161.Z\scripts\gov\Provision-Lists.ps1" -PlanOnly
```

   Last line must read `PLAN lists=4 fields=25 views=5`.
5. Dry run. It asks for the site URL and the sign-in type (W = web window with CAC, P = username/password prompt). It changes nothing:

```powershell
& "$HOME\90-161.Z\scripts\gov\Provision-Lists.ps1" -DryRun
```

6. Provision (creates the 7 PFM lists in lookup order; skips anything that exists):

```powershell
& "$HOME\90-161.Z\scripts\gov\Provision-Lists.ps1"
```

7. Optional, after you verify docs/process-model.md against DAFMAN 90-161: add the nine Stage rows. Rows whose stage number already exists are skipped.

```powershell
& "$HOME\90-161.Z\scripts\gov\Provision-Lists.ps1" -SeedStages
```

Copy the lines between the `=====` markers (created and skipped counts) into the chat. The script prints no site URL, user name or list content, and error text has URLs replaced by `<url>`. There is no password parameter; with P the Windows prompt keeps the password in memory only. Parameters `-SiteUrl` and `-SignIn Web|Credential` skip the prompts. Exit code 0 = no failures, 1 = a failure, 2 = a schema problem.

## What each list holds

Field lists below are the schema files; each field has a `ref` there.

| List (URL name) | Rows | Fields (internal name) | Lookups | Views |
|---|---|---|---|---|
| PFM Activity Log (PFMActivityLog) | One row per event: status change, endorsement requested, reminder sent, status report emailed | Title, Publication, EventType, EventBy, EventDetails | Publication -> PFMPublications | PFM - Recent |
| PFM Endorsements (PFMEndorsements) | One row per endorser per publication action: order, role, status, suspense, response (DAFMAN 90-161 5 | Title, Publication, EndorserOrder, CoordinationRole, Endorser, Execution, IsRequired, EndorsementStatus, DueDate, ExtensionDate, ResponseDate, CRMLink | Publication -> PFMPublications | PFM - By Publication, PFM - Not Started |
| PFM Offices (PFMOffices) | One row per coordinating office: endorser and coordination role | Title, Endorser, CoordinationRole, CoordinateLast, IsActive | none | PFM - Active Offices |
| PFM Process Steps (PFMProcessSteps) | Process steps for one publication action, derived from DAFMAN 90-161 | Title, StepNumber, DAFMANRef, ExitCondition, IsOptional | none | PFM - By Step Number |
| PFM Product Index (PFMProductIndex) | Product Index (PI) of all applicable organizational publications and forms that the PFM maintains (DAFMAN 90-161 6 | Title, ProductType, PublicationType, Series, OPR, PublicationNumber, PrescribingPublication, Publication, PostedLink, ProductStatus, InactiveDate, EffectiveDate, CertifiedCurrentDate, NextReviewDue | Series -> PFMSeries, OPR -> PFMOffices, PrescribingPublication -> PFMProductIndex, Publication -> PFMPublications | Library - Active, Library - All Including Old, PFM - By Number, PFM - Review Due, PFM - Not Active, PFM - Prescribed Forms by Publication |
| PFM Publications (PFMPublications) | One row per publication or form action the PFM tracks (ARCHITECTURE s3) | Title, ActionType, ProductType, PublicationType, Series, PublicationNumber, ProcessStep, ActionStatus, StatusNotes, OPR, Requester, AO, DraftLink, CoordinationSuspense | Series -> PFMSeries, ProcessStep -> PFMProcessSteps, OPR -> PFMOffices | PFM - Queue, PFM - Stalled or On Hold |
| PFM Series (PFMSeries) | Publication series numbers and titles from DAFMAN 90-161 Attachment 2, Table A2 | Title, SeriesNumber | none | PFM - By Number |
| PFM Settings (PFMSettings) | One row per setting the app and flows read (wing name for the subtitle, PFM mailbox, defaults) | Title, SettingValue, SettingNotes | none | PFM - All Settings |

- PFM Endorsements, EndorsementStatus choices are exactly the DAFMAN 90-161 5.4 responses plus `Not started` (default): Not started, Concur, Concur With Comment, Concur—No Response (em dash, as in 5.4.3), Nonconcur, No Comment.
- PFM Process Steps rows come from the docs/process-model.md Stages table (verbatim stage text, paragraph refs). That table is marked draft, not verified.
- The CRM columns (5.3, T-1) are stored as reference data in `PFMEndorsements.json` under `crmColumns` and are not provisioned. CRMLink points to the CRM file.
- Samples with fake data: `samples/lists/<URL name>.csv`, headers = internal names (lookup columns hold the target row's Title). Import by hand or from a flow; the script does not import them.

## Open choices

No value below is decided. Each needs a PFM decision or a source.

1. Customer visibility. Decided (PFM, 2026-11-11): B, all site members read all rows; item-level permissions off. Options considered:
   - A: item-level permissions set by a flow. Strong separation; flow must run as an account that can manage permissions, and each item breaks inheritance (list limits and slower views).
   - B: one list, views and app filtering only. Simple; not a security boundary (a user with list access can open any item through the list).
   - C: separate lists per unit. Strongest separation; many lists to provision and report across.
2. Endorser as Person field or text. The schema uses a text field `Endorser`.
   - Person: resolves to a real account, enables flow notices and Approvals; stores directory PII in the list and needs the account to exist.
   - Text: no PII model and no account needed; flows need a typed address or a separate lookup, and typos are possible.
3. Comments (CRM). Schema stores only a link.
   - Word CRM file in the Drafts library (5.3 encourages Word): matches the sample CRM; comments are not queryable.
   - A fifth `Comments` list with the nine 5.3 columns: queryable and countable; Source holds name, phone and email (PII) per row, and Critical = automatic nonconcur (5.3.3) needs a flow rule.
4. Short stage names. Stage titles are the full process-model text (long in dropdowns). A short-name column would be a new value that the docs do not give.
5. Finer action types. process-model.md names Interim change (7.7) and Administrative change (7.8); ARCHITECTURE s3 lists only "change". The schema uses the s3 list.
6. Mandatory coordinators and Role choices. Tables A3.1 / A3.2 are not extracted, so Role is free text and no coordinator list exists.
7. Time limits as data. 15 business days (5.2, T-3) and 30 calendar days (5.2.2) are not stored; DueDate and CoordinationSuspense are plain dates set by a flow or the OPR. A computed default needs a decision on the business-day calendar.
8. PI content. 6.4.2 gives no column list. The schema has number, title, link to the tracked action and posted location only. Candidates: posting date, status (current/rescinded, 7.11), review date (7.4).
9. Publication fields not in the docs: certifying/approving official (5.6, 5.7), DAF Form 673 and 399 tracking, posting date. Left out until chosen.
10. Stage as lookup versus choice. Lookup follows ARCHITECTURE s3 and keeps paragraph refs; a choice would be simpler to filter but would duplicate the stage names.
11. Seeding. `-SeedStages` is opt-in because process-model.md is unverified.
12. Delivery of files to the gov device is manual copy (GitHub login is blocked). Option: `Invoke-WebRequest` from the raw GitHub address, if the gov network allows it; untested.
