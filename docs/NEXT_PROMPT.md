# Next prompt: 90-161.Z

Updated: 2026-11-13 by Claude. Keep this file at 40 lines or fewer and state only: decisions live in docs/DECISIONS.md, design in the docs it links. The current request overrides this file.

## Open now

- Bloat audit 1 done (docs/reviews/2026-11-13-bloat-audit.md); PFM answered B1-B5 (1A 2A 3A 4A). Next audit due 27 Nov 26 or 30 commits.
- B2 short index merged (PFM 1B, 13 Nov). B3 at next revision of each gov task script. B4/B5 done (baseline affff84, sync 2f5570d); Actions secret set, manual run 43349922182 passed (3 denylist entries).
- Baseline ecfd8a8 (checkout v5) synced here, workflow and pin only (71e5a42; run 43350378963 passed, no Node 20 warning); same bump in ICF c9077c6, no-more-beyond db264cf, transcription_assistant 417209a; setup-node v5 / setup-python v6 in ICF cac12ce, no-more-beyond 3890ff0, transcription_assistant 1259c10 (not yet run in CI). Pre-push check gate on (PFM, 2026-11-12: .pii-guard skips docs/dafman-coverage/* and docs/coordination-table-a3-2.md; pii_guard --all 0 findings).
- Waiting on the PFM: 3.5 legal answer; test site; CUI check for working files (gap review, docs/DECISIONS.md 2026-11-11); 5.1 after renderer round 2.

## State (main)

- Cloud sessions: environment "90-161.Z" (pwsh + PSScriptAnalyzer; PII_GUARD_DENYLIST set).
- Lists: 9 PFM lists, names and columns in docs/DECISIONS.md and schemas/lists; full-scope design docs/reviews/2026-11-12-list-design-full-scope.md. Next: T02 r10 (provisioning flow + seed rows + go.md task) after the batch answers that add columns (register 1.3-1.5, 4.5). Table A3.2 seed: docs/coordination-table-a3-2.md.
- Provisioning now: flow/defs/90161Z-T02-provision-lists-r9.json -> flow/packages/90161Z-T02-provision-lists-r9.zip; docs/power-automate-provisioning.md.
- Design check r7 flow and app rules ("Rules for the flows and the app", https://claude.ai/artifact/X8LbHd79Zh614i1qYzhyTW) are not built yet.
- Coverage: docs/dafman-coverage/README.md (1,408 rows: Covered 383, N/A 314, Gap 73). Process: docs/process-model.md. Customer guidance r3: docs/guidance/customer-steps.md (review doc https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV).
- Phases: docs/phases.md; roles docs/roles-and-permissions.md; backups docs/backup-and-restore.md; screen map docs/app/screen-map.md; setup docs/setup-and-updates.md; rights tests docs/rights-test-plan.md (results to the private log only).
- Briefs: docs/brief/*.json -> scripts/build_decision_brief.js (go.md Task 10). Plan audit: https://claude.ai/artifact/Wdvg7PB2321twKVubQbp2i. Order of work: https://claude.ai/artifact/UAKZ89DXU6xJsedi1dpt7J.

## Waiting on the PFM (go.md)

0. Renderer round 2: evidence docs/reviews/2026-11-12-gov-results-t01r5-t06-t07.md and docs/reviews/2026-11-13-r01-results.md (R01 passed).
1. Round R04 (summary line 1 = subject, auto copy/open, DAFMAN link style): commit 96ee38b, build 90c3b8d7. R03 passed (docs/reviews/2026-11-13-r03-results.md). Results: run `python3 scripts/measure_pdf.py <pdf>`. T02 r10 adds PFMSettings rows PublicationsSiteName, PublicationsListUrl.
2. Task 6 prompt r2 follow-up: list AFI; validator F-032/F-039 false positives.
3. Task 7 Part B: real seals in library 90-161.Z, folder Seals; r1 needs the pasted path.
4. Result e-mails: delete only after the PFM confirms (AGENTS.md Project rules).

## Next design (after Task 5)

1. Flows as solution-aware flows with connection references (match the real export), not legacy packages.
2. First flows per the design-check rules: Activity Log events; endorsement routing from PFM Offices (Legal last); weekday suspense reminders and escalation; Next Review Due (4 years) with review task 6 months before; on-demand status report e-mail.
3. Then the Power Apps canvas app (docs/app/screen-map.md); Accessibility Checker 0 errors.

## Do not

- Put government data, the wing's name, site path, DODIDs or office symbols in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
