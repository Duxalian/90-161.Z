# Decisions: 90-161.Z

Newest first. "By" = PFM for a decision. "By" = Agent for a recommendation that PFM has not approved yet.

| Date | Decision | By | Replaces |
|---|---|---|---|
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
