# Decisions: 90-161.Z

Newest first. "By" = PFM for a decision. "By" = Agent for a recommendation that PFM has not approved yet.

| Date | Decision | By | Replaces |
|---|---|---|---|
| 2026-11-11 | Design goal: easy for the PFM's successor to troubleshoot, change and fix. The finished product includes a step-by-step how-to written for a non-expert. | PFM | - |
| 2026-11-11 | Columns: AO on PFM Publications is a Person column (GAL entry, clickable card). Stalled actions are flagged with Action Status (On Track, On Hold, Stalled) and Status Notes (append-only, dated). The Endorsements column Status is renamed Endorsement Status so each label has one meaning. | PFM (AO, status with notes); Agent (column names, values) | - |
| 2026-11-11 | Title Case for every name of a thing (lists, views, flows, column display names); tests/check_names.py enforces it. Additions now: PFM Settings, PFM Activity Log, PFM Offices lists; Product Type column (Publication, Form); Last Review Date and Next Review Due on PFM Product Index. PFM Working Files library later (folder permissions need their own test). | PFM (8A, 9B) | sentence case; library now |
| 2026-11-11 | Baseline sync to archimedes_lever 2452a16: "Personal data" rule, first-use check (SessionStart hook), docs/FIRST_USE.md, pii_guard.py. Owner stays "the PFM". The guard (.pii-guard) waits for the allow list: 79 findings today, 62 of them in the public DAFMAN text ref/dafman90-161.txt. | PFM (1A) | — |
| 2026-11-11 | Naming (doc https://claude.ai/artifact/WU7A3UXrmr9tFf2sy18Ptk): app name 90-161.Z; subtitle "<wing> ARW Publications and Forms" (wing filled in on the gov device, never in this repo). Lists live on an existing site with one prefix. Lists: Publications, Endorsements, Product Index (DAFMAN 6.4.2), Process Steps. Rules 1-8 approved (DAFMAN terms; URL name without spaces + display title; prefix; PascalCase internal names with capital acronyms; views "<audience> - <what>"; flows "<app> - <verb> <object>" with proper grammar and capitalization; <designator>.docx / <designator>_DRAFT.docx; names only in schemas and flow defs, test-checked). Provisioning flow checks the site title before it creates anything. | PFM (1A, 2B, 3A, rules, 5A, 6B) | Stages, PublicationIndex, no prefix, no site check |
| 2026-11-11 | List prefix "PFM" (PFM chose "PFM or whatever is more appropriate"; Agent kept PFM: DAFMAN role term, 146 hits; DAFMAN 6.4.2 makes the PI a PFM duty). URL names PFMPublications, PFMEndorsements, PFMProductIndex, PFMProcessSteps; titles "PFM Publications" etc. | Agent within PFM delegation | - |
| 2026-11-11 | Cloud sessions for this repo use the personal environment "90-161.Z" (setup script installs pwsh 7.4.6 + PSScriptAnalyzer 1.23.0; network as Default). The PII guard variable PII_GUARD_DENYLIST goes on every environment that baseline repos use (Default, ICF, NMB, 90-161.Z); the PFM adds it in Settings, never in the repo or chat. | PFM (1A 2A) | Default environment, manual pwsh install |
| 2026-11-11 | Task scripts' DODID prompt: Enter uses this computer's profile folder name; a typed DODID overrides it. | PFM (2A, proposed by Agent) | Prompt only, no default |
| 2026-11-11 | Gov-device task folders: C:\Users\<DODID>\OneDrive - United States Air Force\90-161.Z\T<NN>, one per task. Task scripts ask for the DODID and change to the task folder themselves. | PFM | Any folder, e.g. C:\90161Z |
| 2026-11-11 | The baseline is now rhope-ops/archimedes_lever (fresh history, no personal name; "the owner" is its role word). scripts/sync_baseline.py and scripts/drift.py point there; the Owner line "the PFM" still replaces the role word. | PFM | rhope-ops/standard_project (archived) |
| 2026-11-11 | Files for the gov device are named to sort in the PFM's folders: 90161Z-T<NN>-<slug>-r<N> (project, 2-digit task, name, revision). Flow display names use the same prefix ("90161Z T04 ... r2"). | PFM (pattern proposed by Agent, approved by PFM 14:14) | sp-get-items.zip, hello-test.zip |
| 2026-11-11 | Baseline sync: model-agnostic agent rules, git pre-push hook for every tool, log_check, drift and timeline tools, GEMINI.md. Owner stays "the PFM". | PFM | Claude-only hooks and model names |
| 2026-11-11 | AGENTS.md "- Owner: the PFM" keeps the name out of this public repo on every baseline sync (standard_project f11c658). | PFM | Manual name fix after each sync |
| 2026-11-11 | Collaboration log becomes the "Project log" from the standard_project baseline (Type, Arc, CT timestamps, Arcs table) to feed a timeline; it stays in the private Claude doc because this repo is public. Baseline synced; "PFM" kept in place of the name. | PFM | Collaboration log rule (turning points only) |
| 2026-11-11 | Flows get the SharePoint site URL as a run-time input; the site URL and list IDs never go in the repo (the URL is not CUI, but the repo is public and the rule on the wing's site path stands). Lists are chosen by name. | PFM | Rec: site URL in the package |
| 2026-11-11 | Repo stays public (the gov device reads raw links and Pages without login). Gov-network test details move out of the repo into the private collaboration log; the repo keeps only working rules. | PFM | Rec B: private repo + public drop repo |
| 2026-11-11 | The future SharePoint page on the collaboration gives general lessons only: no specific addresses, file sizes or filter behavior. | PFM | full detail |
| 2026-11-11 | Collaboration log moves to a private Claude doc (https://claude.ai/artifact/9zLxe6e9vJPKtRQv5xSSzk) so chats outside the Project can read it; the Project doc only points there. | PFM | Project doc claude/collab-log.md |
| 2026-11-11 | Collaboration log lives in a private claude.ai Project doc (claude/collab-log.md), not the public repo; agents append each turning point. | PFM | — |
| 2026-11-11 | Pages site is the hand-off bookmark (works on the gov device, links clickable); raw go.md is the fallback. | PFM | Pages trial |
| 2026-11-11 | Trial: GitHub Pages front page (rhope-ops.github.io/90-161.Z, branch gh-pages) renders go.md from main with clickable links; go.md stays the source. | PFM | go.md plain text only |
| 2026-11-11 | Hand-off page moves to go.md at the repo root (short address the PFM types once and bookmarks); plain-text URLs, no GitHub Pages. | PFM | docs/HANDOFF.md |
| 2026-11-11 | Gov-device hand-off via a bookmarked docs/HANDOFF.md raw page; no more emails to the military address. | PFM | Plain-text hand-off emails |
| 2026-11-11 | Hand-off emails are plain text only (no HTML part). | PFM | explicit HTML links |
| 2026-11-11 | Hand-off emails: exact raw URLs as explicit links (no wrapper); written in the PFM's voice ("my computer"). | PFM | — |
| 2026-11-11 | Build order C (renderer) > D (app) > B (getting-started doc). | PFM | — |
| 2026-11-11 | TOC always for ANG wing publications (4.5.8.2, built per 4.5.8.3); no option to disable. | PFM | Rec "switch, default on" |
| 2026-11-11 | Certifier name line "(Rank First Last)" under Certified by is required (15 of 19 published covers; absent only where the office is the person, e.g. HAF). | PFM | Rec "off by default" |
| 2026-11-11 | The 90-161.Z app replaces the checklist, AO guide, template and Attachment 1 workbook. Old files are retired; one short Word doc gives a process summary and how to start in the app. | PFM | Fixed copies of each wing file |
| 2026-11-11 | The app can email a publication status report to anyone at any time (for example a supervisor). | PFM | — |
| 2026-11-11 | Phase A route: built-in browser (done); plan order A > B > C > D. | PFM | — |
| 2026-11-11 | DAFMAN 90-161 is the source of truth whenever any wing file (template, AO guide, checklist) or practice contradicts it. Wing files shape the customer process only; they never supply rules. | PFM | — |
| 2026-11-11 | Resolved by that rule: indent 0.25 in per level; signature block at 4.0 in; TOC per 4.5.8.2 (ANG wing level); waiver wording per 4.5.5.11 example. | PFM | wing template variants |
| 2026-11-11 | Two spaces before each new sentence (DAFMAN 90-161 measured: 6.55 pt between sentences vs 3.14 pt between words, n=53/1625, pages 40-46). | PFM | — |
| 2026-11-11 | Gov-device tasks: send raw GitHub links by email to the PFM's military address. | PFM | Copy blocks in chat |
| 2026-11-11 | Cover line reads "Certified by:" (as printed on published covers), not "Certified By:". | PFM | Rec |
| 2026-11-11 | New CRM template from DAFMAN 90-161 Figure A12.1 (Word, measured column widths): templates/CRM_A12-1.docx. Replaces the PFM's old CRM. | PFM | Old CRM |
| 2026-11-11 | CRM resolution codes A/R/M (Figure A12.1 key), not A/R/P (its column header). | PFM | — |
| 2026-11-11 | Endorser is a Person field (enables flow alerts to the endorser). | PFM | Endorser as text (Agent placeholder) |
| 2026-11-11 | Item-level permissions: customers read and edit only rows they created, on Publications and Endorsements. | PFM | — |
| 2026-11-10 | Create the SharePoint lists with a Power Automate flow (docs/power-automate-provisioning.md); PowerShell/PnP path dropped (sign-in window never opened). | PFM | PnP provisioning |
| 2026-11-10 | Site URL: repo holds only the domain pattern https://usaf.dps.mil/sites/<your-site>; the real site path stays on the gov device and in the flow. | PFM | — |
| 2026-11-10 | Build both lanes in parallel: (A) renderer + validator, (B) SharePoint lists + PnP provisioning. | PFM | — |
| 2026-11-10 | **Rec:** Renderer = PowerShell + Word COM (option A); environment check passed (docs/reviews/2026-11-10-gov-env-check.md). Option C stays open until the Premium check. | Agent | — |
| 2026-11-10 | Public repo uses "PFM", not the PFM's name. | PFM | — |
| 2026-11-10 | Repo is public, so the gov device reads it without a GitHub login. Rule: nothing that names the wing, people or office symbols goes in the repo. | PFM | Rec "make the repo public" |
| 2026-11-10 | GitHub login is blocked on the gov device (GitHub itself is reachable). | PFM | Transfer path "PFM opens the repo on the gov device" |
| 2026-11-10 | Renderer: try both A (PowerShell + Word COM) and C (Power Automate "Populate a Microsoft Word template"). | PFM | — |
| 2026-11-10 | PFM is not a tenant admin. | PFM | — |
| 2026-11-10 | The wing has no supplement to DAFMAN 90-161. | PFM | — |
| 2026-11-10 | PFM is the PFM of an ANG wing. ANG wing publications are posted on the wing's own site, not through AFIMPT/AFDPO (DAFMAN 90-161 paras 1.1.3.2, 6.4.1, 6.6.3). Output must be camera-ready final, not an AFDPO-tagged draft. | PFM | "Final submission goes through AFIMPT" (Agent) |
| 2026-11-10 | **Rec:** Enforce format in 3 layers: schema (model returns content only), deterministic renderer, rule validator. See docs/format-rules.md. | Agent | — |
| 2026-11-10 | PFM is a site collection administrator and can reach SharePoint through PowerShell. | PFM | "no admin rights" assumption (partly) |
| 2026-11-10 | Formatting goal: rules force output to look like DAFMAN 90-161 itself. AFIMPT is not used for formatting or tracking. | PFM | — |
| 2026-11-10 | 90-161.Z is the system of record for endorsements (no TMT). | PFM | — |
| 2026-11-10 | Transfer path: GitHub is reachable from NIPR; PFM opens the repo on the gov device. | PFM | — |
| 2026-11-10 | Rule source: DAFMAN 90-161, 18 Oct 2023, incorporating Change 1 (14 Jul 2025) and Corrective Action (1 May 2026), plus the wing supplement if one exists (none exists). | PFM | — |
| 2026-11-10 | **Rec:** Pilot the document engine on ChatGPT Mil and Gemini (GenAI.mil) with the same 3 test drafts; pick by checklist pass rate. | Agent | — |
| 2026-11-10 | Repo: private rhope-ops/90-161.Z, bootstrapped from standard_project. | PFM | — |
| 2026-11-10 | Scope: wing/installation publications. | PFM | — |
| 2026-11-10 | Platform: SharePoint Lists + Power Automate + Power Apps in DoD365. | PFM | — |
| 2026-11-10 | Data boundary: government data stays in DoD365/GenAI.mil only; GitHub holds code, schemas, prompts and fake data. | PFM | — |
| 2026-11-10 | Use the rhope-ops/standard_project baseline instructions. | PFM | — |
