# Architecture: 90-161.Z

Status: draft (Agent, 2026-11-10). Items marked **Rec:** are not decisions until PFM approves them in docs/DECISIONS.md.

## 1. Goals

| # | Goal | Users |
|---|---|---|
| G1 | Track the status of each publication through the DAFMAN 90-161 process | PFM (wing publications manager), customers (OPRs, authors) |
| G2 | Turn a draft of any quality into a correctly written and formatted final publication | PFM |
| G3 | Customers enter their endorsers; the system tracks each endorsement, sends alerts and runs flows | Customers, endorsers |
| G4 | Work passes between PFM, Claude and GenAI.mil models through GitHub | PFM, agents |
| G5 | Frontend runs in DoD365 (SharePoint + Power Platform) | All |

## 2. Data boundary (PFM, 2026-11-10)

- Government data stays in DoD365 and GenAI.mil only: drafts, publication content, names, emails, office symbols, comments, CRMs.
- GitHub holds only: list schemas, flow designs, Power Apps source (YAML), JSON view formatting, prompts, templates, docs, and fake sample data.
- Claude (personal device) never receives real drafts or real endorser data. Bug reports to the repo are sanitized: no names, no emails, no content.

## 3. Components

| Layer | Component | Where | Purpose |
|---|---|---|---|
| Data | `PFM Publications` list | SharePoint site | One row per action on a publication or form (Action Type: New, Rewrite, Interim Change, Administrative Change, Guidance Memorandum, Certify Current, Rescind, Transfer; supplement and OI are publication types, DECISIONS 2026-11-11) |
| Data | `PFM Endorsements` list | SharePoint site | One row per endorser per publication: order, role, status, due date, response |
| Data | `PFM Process Steps` list (PFMProcessSteps) | SharePoint site | Process steps derived from DAFMAN 90-161, with paragraph references. All list names: docs/power-automate-provisioning.md section 1 |
| Data | Library `90-161.Z` | SharePoint site | Folders Seals, Working Files (drafts, DAF Form 673, CRM; one subfolder per action, Q3A) and Record Sets (publications and forms apart, 15A); versioning on |
| Logic | Power Automate flows | DoD365 | Endorsement requests, reminders, escalation, stage advance, status notices to customers |
| UI | Power Apps canvas app | DoD365 | Customer intake (new request, endorser entry), status view, the PFM's work queue |
| UI | List views + JSON formatting | SharePoint | Fallback UI and the PFM's admin views |
| AI | GenAI.mil assistant | GenAI.mil | Draft cleanup and formatting against DAFMAN 90-161 rules and the DAF template (G2) |
| Source | Repo `rhope-ops/90-161.Z` | GitHub (public) | Code, schemas, prompts, decisions, handoff |

## 4. Endorsement flow (G3), first version

1. The AO submits the request in the app. Mandatory coordinators come from PFM Offices (JAG last, CIO, PFM, FOIA, Records; PFM 2026-11-12, Q6 and Q13); the AO adds offices with functional interest (5.1.3) and names the OPR's certifying and approving officials (5.6.3, 5.7).
2. Flow creates one `Endorsements` row per endorser, status `Not Started`.
3. Flow sends the request to every endorser in the open Coordination Stage at the same time (Privacy Review, then Formal Coordination, then Legal; DAFMAN 3.4, 5.1.8.1, Table A3.1 note 2; PFM 2026-11-11), with the draft link and due date. Legal opens when every other row is final or Not Applicable and every comment is adjudicated (5.1.8.1, 2.8.13); an open nonconcur may go on to Legal and Certification, and approval needs it resolved or an impasse memo (5.5.1, 5.5.2; PFM 1A, 2026-11-12).
4. Endorser responds with one of the DAFMAN 5.4 responses in PFM Endorsements: Concur, Concur With Comment, Concur—No Response, Nonconcur, No Comment. Comments go to the CRM.
5. Reminder at due date minus 2 workdays; escalation to customer and PFM when overdue.
6. A Nonconcur notifies the customer and the PFM and raises Open Nonconcurs; the OPR resolves it or elevates it (5.5).
7. When all required endorsements are complete, flow moves the publication to the next stage and notifies the customer.

The exact stages, mandatory coordinators and time limits come from DAFMAN 90-161 (no wing supplement exists). No value is invented here.

## 5. Document engine (G2)

Goal (PFM, 2026-11-10): rules force the output to look like DAFMAN 90-161 itself. Format comes from code, never from the model.

| Layer | Runs on | Does |
|---|---|---|
| L1 Model | GenAI.mil | Rewrites the draft for plain language; returns content only, as JSON in `schemas/publication.schema.json` (header fields, paragraphs with level, tables, attachments). No style fields exist in the schema. |
| L2 Renderer | Gov device (option open, see Decide) | Builds the .docx from the JSON. Font, margins, numbering, bolding, header block, draft marking are fixed in code. Two modes: `draft` (coordination, rule F-010) and `final`. |
| L3 Validator | Same as L2 | Checks every rule in docs/format-rules.md; outputs a pass/fail report per rule ID. |

- "Perfect" = 0 fails on `hard` rules, and PFM approves.
- Model choice: run the same 3 fake test drafts through ChatGPT Mil and Gemini; pick by schema-valid rate, lint warnings and edit count.

## 6. Hand-off model (G4)

| Actor | Can reach | Does |
|---|---|---|
| Claude (personal device) | GitHub, public DAF publications | Designs schemas, flows, app YAML, prompts, checklists; keeps docs and decisions |
| GenAI.mil model | Gov data, uploaded files | Document cleanup (G2); fixes that need real data |
| PFM (gov device) | DoD365, GenAI.mil | Builds/imports items into DoD365, runs tests with real data, reports sanitized results |

Transfer path (PFM, 2026-11-10): GitHub is reachable from NIPR; PFM opens the repo on the gov device.

## 7. Risks

| Risk | Effect | Mitigation |
|---|---|---|
| Gov data enters GitHub or Claude by mistake | Policy violation, PII spill | Rule in AGENTS.md; fake sample data only; sanitized bug reports |
| Site collection admin only: tenant admin, app registration and app catalog not available | PnP.PowerShell may need an Entra app registration | Check available modules first; fallback = build by hand from repo specs |
| AFIMPT steps in DAFMAN (6.6) | Do not apply to ANG wing products, which post on the wing site (1.1.3.2, 6.4.1, 8.4.1; PFM 2026-11-10) | 90-161.Z tracks through posting |
| Power Automate premium connectors not licensed | Some flow steps unavailable | Use standard connectors only (SharePoint, Outlook, Teams, Approvals) |
| Customers edit each other's items | Data changes between units | Closed (PFM, 2026-11-12, 10A): edit own rows only on PFM Publications and PFM Endorsements; others change rows through flows |
| Customers see each other's items | Data exposure between units | Accepted (PFM, 2026-11-11): all site members read all rows; the app filters by Requester and AO. Coordination data is internal to the wing |
| GenAI.mil output looks right but breaks a rule | Bad final publication | Deterministic checklist; PFM review; no auto-publish |
| Wing files (template, AO guide, checklist) differ from DAFMAN | Wrong stages or format | No wing supplement exists (PFM 2026-11-10); DAFMAN wins on any conflict (PFM 2026-11-11) |
