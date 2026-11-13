# Decisions archive: 90-161.Z

Rows from docs/DECISIONS.md that a later row replaces in full, moved word for word (bloat audit 2026-11-13). "Replaced by" names the current row. Read on demand only.

| Date | Decision | By | Replaces | Replaced by |
|---|---|---|---|---|
| 2026-11-11 | **Rec:** ANGMAN 90-161 (15 Jun 2023, ref/angman90-161.pdf, from the PFM) covers ANG tier waivers on DAF Form 679 only, may not be supplemented at wing level, and implements DAFI 90-160 and DAFMAN 90-161. It does not change the wing publishing workflow; it becomes a source only if waiver tracking enters scope. Records under it follow AFI 33-322, ANGMAN 33-322 and the AFRIMS RDS. | Agent | - | 2026-11-12 Assumed decisions, batch 5 and 4.7 |
| 2026-11-11 | Collaboration log lives in a private claude.ai Project doc (claude/collab-log.md), not the public repo; agents append each turning point. | PFM | — | 2026-11-11 Collaboration log moves to a private Claude doc |
| 2026-11-11 | Trial: GitHub Pages front page (rhope-ops.github.io/90-161.Z, branch gh-pages) renders go.md from main with clickable links; go.md stays the source. | PFM | go.md plain text only | 2026-11-11 Pages site is the hand-off bookmark |
| 2026-11-11 | Gov-device hand-off via a bookmarked docs/HANDOFF.md raw page; no more emails to the military address. | PFM | Plain-text hand-off emails | 2026-11-11 Hand-off page moves to go.md |
| 2026-11-11 | Hand-off emails are plain text only (no HTML part). | PFM | explicit HTML links | 2026-11-11 Gov-device hand-off via a bookmarked page (archived); go.md since |
| 2026-11-11 | Hand-off emails: exact raw URLs as explicit links (no wrapper); written in the PFM's voice ("my computer"). | PFM | — | 2026-11-11 Hand-off emails are plain text only (archived); go.md since |
| 2026-11-11 | Gov-device tasks: send raw GitHub links by email to the PFM's military address. | PFM | Copy blocks in chat | 2026-11-11 Gov-device hand-off: no more e-mails to the military address (AGENTS.md Project rules, Gov device access) |
| 2026-11-10 | **Rec:** Renderer = PowerShell + Word COM (option A); environment check passed (docs/reviews/2026-11-10-gov-env-check.md). Option C stays open until the Premium check. | Agent | — | 2026-11-12 Document engine (5.1B) |
| 2026-11-10 | **Rec:** Enforce format in 3 layers: schema (model returns content only), deterministic renderer, rule validator. See docs/format-rules.md. | Agent | — | 2026-11-12 Document engine (5.1B) |
| 2026-11-10 | **Rec:** Pilot the document engine on ChatGPT Mil and Gemini (GenAI.mil) with the same 3 test drafts; pick by checklist pass rate. | Agent | — | 2026-11-12 Assumed decisions, batch 5 and 4.7; 2026-11-12 GPT is the GenAI.mil extractor |
| 2026-11-10 | Repo: private rhope-ops/90-161.Z, bootstrapped from standard_project. | PFM | — | 2026-11-10 Repo is public |
