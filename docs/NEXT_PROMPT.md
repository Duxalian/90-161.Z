# Next prompt: 90-161.Z

Updated: 2026-11-13 by Claude. Keep this file at 40 lines or fewer and state only: decisions live in docs/DECISIONS.md, design in the docs it links. The current request overrides this file.

## Open now

- Bloat audit 2 done (docs/reviews/2026-11-13-bloat-audit-2.md); P1-P4 approved and made: tests 21 s -> 12.7 s, baseline bc233b9, task-common block (scripts/build_task_scripts.py), 3 short DECISIONS lines. Next audit by 27 Nov 26.
- History clean done 13 Nov 26: names gone from all of main and gh-pages (fresh-clone scan 0 in 1,053 file versions); old branches deleted; GitHub Support purge requested by the PFM. Delivery is now by pull request (AGENTS.md); Auto-merge and auto-delete on; no main ruleset (not available; PFM 13 Nov).
- Kit baseline: final sync 7f2965c (archimedes_lever); projects no longer sync, so sync_baseline.py, drift.py and .baseline are gone (owner decision 2026-11-13, other session). Pre-push check gate on.
- Closed 13 Nov: 3.5A (JAG in app), test site = live site (isolated URL), site approved for CUI. Waiting on the PFM: 5.1 after renderer round 2.

## State (main)

- Cloud sessions: environment "90-161.Z" (pwsh + PSScriptAnalyzer; PII_GUARD_DENYLIST set).
- Lists: 9 PFM lists, names and columns in docs/DECISIONS.md and schemas/lists; full-scope design docs/reviews/2026-11-12-list-design-full-scope.md. T02 r10 schemas in the sweep draft PR (all batches answered, 12-13 Nov). Table A3.2 seed: docs/coordination-table-a3-2.md.
- Provisioning: flow/defs/90161Z-T02-provision-lists-r10.json -> flow/packages/90161Z-T02-provision-lists-r10.zip (12 lists, new installs). The live site has the r9 lists: r10 needs an upgrade path (PFM decision open, PR 10); docs/power-automate-provisioning.md.
- Design check r7 flow and app rules ("Rules for the flows and the app", https://claude.ai/artifact/X8LbHd79Zh614i1qYzhyTW) are not built yet.
- Coverage: docs/dafman-coverage/README.md (1,408 rows: Covered 383, N/A 314, Gap 73). Process: docs/process-model.md. Customer guidance r3: docs/guidance/customer-steps.md (review doc https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV).
- Phases: docs/phases.md; roles docs/roles-and-permissions.md; backups docs/backup-and-restore.md; screen map docs/app/screen-map.md; setup docs/setup-and-updates.md; rights tests docs/rights-test-plan.md (results to the private log only).
- Briefs: docs/brief/*.json -> scripts/build_decision_brief.js (go.md Task 10). Plan audit: https://claude.ai/artifact/Wdvg7PB2321twKVubQbp2i. Order of work: https://claude.ai/artifact/UAKZ89DXU6xJsedi1dpt7J.

## Waiting on the PFM (go.md)

0. Renderer round 2: evidence docs/reviews/2026-11-12-gov-results-t01r5-t06-t07.md, R01-R04 results in docs/reviews/ (all passed).
1. Draft PR 10 (sweep) waits for the PFM: decisions in docs/reviews/2026-11-13-sweep-decisions.md (S1 r10 upgrade path first). R08 live; R09 (build 83c168c9) goes live only after approval. Claude watches Gmail for "90161Z R08"/"R09".
2. Task 6 prompt r2 follow-up: list AFI; validator F-032/F-039 false positives.
3. Task 7 Part B: real seals in library 90-161.Z, folder Seals; r1 needs the pasted path.
4. Task 14 site logo (assets/logo, scripts/build_logo.py). After T11 results: design the site home page as a preview, then a page/header flow (DECISIONS 2026-11-13).
5. Result e-mails: delete only after the PFM confirms (AGENTS.md Project rules).

## Next design (after Task 5)

1. Flows as solution-aware flows with connection references (match the real export), not legacy packages.
2. First flows per the design-check rules: Activity Log events; endorsement routing from PFM Offices (Legal last); weekday suspense reminders and escalation; Next Review Due (4 years) with review task 6 months before; on-demand status report e-mail.
3. Then the Power Apps canvas app (docs/app/screen-map.md); Accessibility Checker 0 errors.

## Do not

- Put government data, the wing's name, site path, DODIDs or office symbols in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
