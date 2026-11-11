# Architecture: 90-161.Z

Status: draft (Agent, 2026-11-10). Items marked **Rec:** are not decisions until the owner approves them in docs/DECISIONS.md.

## 1. Goals

| # | Goal | Users |
|---|---|---|
| G1 | Track the status of each publication through the DAFMAN 90-161 process | the owner (wing publications manager), customers (OPRs, authors) |
| G2 | Turn a draft of any quality into a correctly written and formatted final publication | the owner |
| G3 | Customers enter their endorsers; the system tracks each endorsement, sends alerts and runs flows | Customers, endorsers |
| G4 | Work passes between the owner, Claude and GenAI.mil models through GitHub | the owner, agents |
| G5 | Frontend runs in DoD365 (SharePoint + Power Platform) | All |

## 2. Data boundary (the owner, 2026-11-10)

- Government data stays in DoD365 and GenAI.mil only: drafts, publication content, names, emails, office symbols, comments, CRMs.
- GitHub holds only: list schemas, flow designs, Power Apps source (YAML), JSON view formatting, prompts, templates, docs, and fake sample data.
- Claude (personal device) never receives real drafts or real endorser data. Bug reports to the repo are sanitized: no names, no emails, no content.

## 3. Components

| Layer | Component | Where | Purpose |
|---|---|---|---|
| Data | `Publications` list | SharePoint site | One row per publication action (new, rewrite, change, supplement, OI, certify-as-current, rescind) |
| Data | `Endorsements` list | SharePoint site | One row per endorser per publication: order, role, status, due date, response |
| Data | `Stages` list | SharePoint site | Stage model derived from DAFMAN 90-161, with paragraph references |
| Data | `Drafts` library | SharePoint site | Draft versions, AF Form 673, CRM files; versioning on |
| Logic | Power Automate flows | DoD365 | Endorsement requests, reminders, escalation, stage advance, status notices to customers |
| UI | Power Apps canvas app | DoD365 | Customer intake (new request, endorser entry), status view, the owner's work queue |
| UI | List views + JSON formatting | SharePoint | Fallback UI and the owner's admin views |
| AI | GenAI.mil assistant | GenAI.mil | Draft cleanup and formatting against DAFMAN 90-161 rules and the DAF template (G2) |
| Source | Repo `rhope-ops/90-161.Z` | GitHub (private) | Code, schemas, prompts, decisions, handoff |

## 4. Endorsement flow (G3), first version

1. Customer submits the publication request and an ordered endorser list in the app.
2. Flow creates one `Endorsements` row per endorser, status `Not started`.
3. Flow sends the request to the next endorser(s) (sequential or parallel per row), with the draft link and due date.
4. Endorser responds: `Concur`, `Concur with comment`, `Non-concur`. Comments go to the CRM.
5. Reminder at due date minus 2 workdays; escalation to customer and the owner when overdue.
6. `Non-concur` stops the chain and notifies customer and the owner.
7. When all required endorsements are complete, flow moves the publication to the next stage and notifies the customer.

The exact stages, mandatory coordinators and time limits come from DAFMAN 90-161 and the wing supplement (step 3 of the plan). No value is invented here.

## 5. Document engine (G2)

- Input: a draft of any quality (.docx).
- **Rec:** a GenAI.mil assistant (custom GPT in ChatGPT Mil, or a Gemini agent) with fixed instructions from this repo plus the DAF publication template and DAFMAN 90-161 formatting rules as knowledge files.
- Output: a cleaned .docx in the DAF template, plus a change list and a rule checklist with pass/fail per rule.
- the owner reviews every output. The checklist is the acceptance test; "perfectly formatted" means every checklist rule passes.
- Model choice: run the same 3 test drafts through both models; pick by checklist pass rate and edit count.

## 6. Hand-off model (G4)

| Actor | Can reach | Does |
|---|---|---|
| Claude (personal device) | GitHub, public DAF publications | Designs schemas, flows, app YAML, prompts, checklists; keeps docs and decisions |
| GenAI.mil model | Gov data, uploaded files | Document cleanup (G2); fixes that need real data |
| the owner (gov device) | DoD365, GenAI.mil | Builds/imports items into DoD365, runs tests with real data, reports sanitized results |

Transfer path from GitHub to the gov device is open: see Decide in docs/NEXT_PROMPT.md.

## 7. Risks

| Risk | Effect | Mitigation |
|---|---|---|
| Gov data enters GitHub or Claude by mistake | Policy violation, PII spill | Rule in AGENTS.md; fake sample data only; sanitized bug reports |
| No admin rights: no PnP/pac CLI, no app catalog | Cannot script deployment | Build by hand from repo specs; Power Apps YAML paste; flow from step lists |
| Power Automate premium connectors not licensed | Some flow steps unavailable | Use standard connectors only (SharePoint, Outlook, Teams, Approvals) |
| Customers see each other's items | Data exposure between units | Item-level permissions set by flow, or separate views plus app filtering (decide in build) |
| GenAI.mil output looks right but breaks a rule | Bad final publication | Deterministic checklist; the owner review; no auto-publish |
| Local wing supplement differs from DAFMAN | Wrong stages | Read the wing supplement before the stage model is fixed |
