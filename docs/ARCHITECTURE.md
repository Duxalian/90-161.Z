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
| Data | `Publications` list | SharePoint site | One row per publication action (new, rewrite, change, supplement, OI, certify-as-current, rescind) |
| Data | `Endorsements` list | SharePoint site | One row per endorser per publication: order, role, status, due date, response |
| Data | `PFM Process Steps` list (PFMProcessSteps) | SharePoint site | Process steps derived from DAFMAN 90-161, with paragraph references. All list names: docs/power-automate-provisioning.md section 1 |
| Data | `Drafts` library | SharePoint site | Draft versions, AF Form 673, CRM files; versioning on |
| Logic | Power Automate flows | DoD365 | Endorsement requests, reminders, escalation, stage advance, status notices to customers |
| UI | Power Apps canvas app | DoD365 | Customer intake (new request, endorser entry), status view, the PFM's work queue |
| UI | List views + JSON formatting | SharePoint | Fallback UI and the PFM's admin views |
| AI | GenAI.mil assistant | GenAI.mil | Draft cleanup and formatting against DAFMAN 90-161 rules and the DAF template (G2) |
| Source | Repo `rhope-ops/90-161.Z` | GitHub (private) | Code, schemas, prompts, decisions, handoff |

## 4. Endorsement flow (G3), first version

1. Customer submits the publication request and an ordered endorser list in the app.
2. Flow creates one `Endorsements` row per endorser, status `Not started`.
3. Flow sends the request to every endorser in the open Coordination Stage at the same time (Privacy Review, then Formal Coordination, then Legal; DAFMAN 3.4, 5.1.8.1, Table A3.1 note 2; PFM 2026-11-11), with the draft link and due date. A stage opens when the previous one is complete and has no open nonconcur (5.5).
4. Endorser responds: `Concur`, `Concur with comment`, `Non-concur`. Comments go to the CRM.
5. Reminder at due date minus 2 workdays; escalation to customer and PFM when overdue.
6. `Non-concur` stops the chain and notifies customer and PFM.
7. When all required endorsements are complete, flow moves the publication to the next stage and notifies the customer.

The exact stages, mandatory coordinators and time limits come from DAFMAN 90-161 and the wing supplement (step 3 of the plan). No value is invented here.

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
| Final submission goes through AFIMPT (6.6, T-1) | 90-161.Z cannot replace that step | Track up to submission; PFM submits in AFIMPT |
| Power Automate premium connectors not licensed | Some flow steps unavailable | Use standard connectors only (SharePoint, Outlook, Teams, Approvals) |
| Customers see each other's items | Data exposure between units | Accepted (PFM, 2026-11-11): all site members read all rows; the app filters by Requester and AO. Coordination data is internal to the wing |
| GenAI.mil output looks right but breaks a rule | Bad final publication | Deterministic checklist; PFM review; no auto-publish |
| Local wing supplement differs from DAFMAN | Wrong stages | Read the wing supplement before the stage model is fixed |
