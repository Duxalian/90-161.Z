# Decisions: 90-161.Z

Newest first. "By" = the owner for a decision. "By" = Agent for a recommendation that the owner has not approved yet.

| Date | Decision | By | Replaces |
|---|---|---|---|
| 2026-11-10 | Repo is public, so the gov device reads it without a GitHub login. Rule: nothing that names the wing, people or office symbols goes in the repo. | the owner | Rec "make the repo public" |
| 2026-11-10 | GitHub login is blocked on the gov device (GitHub itself is reachable). | the owner | Transfer path "the owner opens the repo on the gov device" |
| 2026-11-10 | Renderer: try both A (PowerShell + Word COM) and C (Power Automate "Populate a Microsoft Word template"). | the owner | — |
| 2026-11-10 | the owner is not a tenant admin. | the owner | — |
| 2026-11-10 | The wing has no supplement to DAFMAN 90-161. | the owner | — |
| 2026-11-10 | the owner is the PFM of an ANG wing. ANG wing publications are posted on the wing's own site, not through AFIMPT/AFDPO (DAFMAN 90-161 paras 1.1.3.2, 6.4.1, 6.6.3). Output must be camera-ready final, not an AFDPO-tagged draft. | the owner | "Final submission goes through AFIMPT" (Agent) |
| 2026-11-10 | **Rec:** Enforce format in 3 layers: schema (model returns content only), deterministic renderer, rule validator. See docs/format-rules.md. | Agent | — |
| 2026-11-10 | the owner is a site collection administrator and can reach SharePoint through PowerShell. | the owner | "no admin rights" assumption (partly) |
| 2026-11-10 | Formatting goal: rules force output to look like DAFMAN 90-161 itself. AFIMPT is not used for formatting or tracking. | the owner | — |
| 2026-11-10 | 90-161.Z is the system of record for endorsements (no TMT). | the owner | — |
| 2026-11-10 | Transfer path: GitHub is reachable from NIPR; the owner opens the repo on the gov device. | the owner | — |
| 2026-11-10 | Rule source: DAFMAN 90-161, 18 Oct 2023, incorporating Change 1 (14 Jul 2025) and Corrective Action (1 May 2026), plus the wing supplement if one exists (none exists). | the owner | — |
| 2026-11-10 | **Rec:** Pilot the document engine on ChatGPT Mil and Gemini (GenAI.mil) with the same 3 test drafts; pick by checklist pass rate. | Agent | — |
| 2026-11-10 | Repo: private rhope-ops/90-161.Z, bootstrapped from standard_project. | the owner | — |
| 2026-11-10 | Scope: wing/installation publications. | the owner | — |
| 2026-11-10 | Platform: SharePoint Lists + Power Automate + Power Apps in DoD365. | the owner | — |
| 2026-11-10 | Data boundary: government data stays in DoD365/GenAI.mil only; GitHub holds code, schemas, prompts and fake data. | the owner | — |
| 2026-11-10 | Use the rhope-ops/standard_project baseline instructions. | the owner | — |
