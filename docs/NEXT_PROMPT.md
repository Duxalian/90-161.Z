# Next prompt: 90-161.Z

Updated: 2026-11-14 by Claude. Keep this file at 40 lines or fewer and state only: decisions live in docs/DECISIONS.md, design in the docs it links. The current request overrides this file.

## Open now

- Bloat audit 2 done (docs/reviews/2026-11-13-bloat-audit-2.md); P1-P4 approved and made: tests 21 s -> 12.7 s, baseline bc233b9, task-common block (scripts/build_task_scripts.py), 3 short DECISIONS lines. Next audit by 27 Nov 26.
- History clean done 13 Nov 26: names gone from all of main and gh-pages (fresh-clone scan 0 in 1,053 file versions); old branches deleted; GitHub Support purge requested by the PFM. Delivery is now by pull request (AGENTS.md); Auto-merge and auto-delete on; no main ruleset (not available; PFM 13 Nov).
- Kit baseline: final sync 7f2965c (archimedes_lever); projects no longer sync, so sync_baseline.py, drift.py and .baseline are gone (owner decision 2026-11-13, other session). Pre-push check gate on.
- 14 Nov: new site exists and is CUI-approved; T02 r11 builds the 12 lists there and sets edit-own-rows (old Task 8); Tasks 11 and 14 use the new site. Hold any step that needs a PnP check (PFM). New site = separate site collection. Second-look F1-F5 wait for the PFM's go; S8-S11 open (sweep page).

## State (main)

- Cloud sessions: environment "90-161.Z" (pwsh + PSScriptAnalyzer; PII_GUARD_DENYLIST set).
- Lists: 9 PFM lists, names and columns in docs/DECISIONS.md and schemas/lists; full-scope design docs/reviews/2026-11-12-list-design-full-scope.md. Schemas for 12 lists merged (PR 10). Table A3.2 seed: docs/coordination-table-a3-2.md.
- Provisioning: flow/defs/90161Z-T02-provision-lists-r11.json -> flow/packages/90161Z-T02-provision-lists-r11.zip (12 lists, 88 rows, item-level permissions with a NOT SET fallback; ReadSecurity/WriteSecurity by REST is unverified until the run); go.md Task 2; docs/power-automate-provisioning.md.
- Design check r7 flow and app rules ("Rules for the flows and the app", https://claude.ai/artifact/X8LbHd79Zh614i1qYzhyTW) are not built yet.
- Coverage: docs/dafman-coverage/README.md (1,408 rows: Covered 384, N/A 347, Gap 39). Process: docs/process-model.md. Customer guidance r3: docs/guidance/customer-steps.md (review doc https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV).
- Phases: docs/phases.md; roles docs/roles-and-permissions.md; backups docs/backup-and-restore.md; screen map docs/app/screen-map.md; setup docs/setup-and-updates.md; rights tests docs/rights-test-plan.md (results to the private log only).
- Briefs: docs/brief/*.json -> scripts/build_decision_brief.js (go.md Task 10). Plan audit: https://claude.ai/artifact/Wdvg7PB2321twKVubQbp2i. Order of work: https://claude.ai/artifact/UAKZ89DXU6xJsedi1dpt7J.

## Waiting on the PFM (go.md)

0. Renderer round 2: evidence docs/reviews/2026-11-12-gov-results-t01r5-t06-t07.md, R01-R04 results in docs/reviews/ (all passed).
1. R13 r1 on go.md (14 Nov): probe flow r3 guided by the Deployer (zip written to T11, Power Automate opened, path on the clipboard; DoD address make.powerautomate.appsplatform.us from Microsoft Learn, editable, PFM confirms in R13), seal prep r5 (subject match ignores the DoD "[Non-DoD Source] " prefix; every Outlook mail folder), site setup r2 (seals path from the library root folder; waits up to 15 min for the probe result). New log text (PASSED / NEEDS REVIEW). R12 results: docs/reviews/2026-11-14-r12-results.md. Logo wrong (PFM 14 Nov: header shows only a thin white rectangle border): redesign as a preview before R14. Claude watches Gmail for "90161Z R13". T01, T15, T16 PnP test output text not cleaned yet (steps off). Next after R13: T09 reader, T12 colors. Open: S2, S3, S5 3-15, S6, S7, S8-S11, F1-F4 (sweep page).
2. Task 6 prompt r2 follow-up: list AFI (validator F-032/F-039 fixed 13 Nov).
3. Seals: Claude corrected 17 unit seals (1,200 px, glow removed, 2 px feather; tool in the session scratchpad, not in the repo) and mailed them in 6 parts; they arrived with "[Non-DoD Source] " before the subject, which R12 did not match; R13 matches it.
4. Logo option D (PFM 14 Nov): mark r1 no fill on the blue header, navy thumbnail (assets/logo, scripts/build_logo.py); R12 set the logo (read back); the PFM's look check is open. After T11 results: design the site home page as a preview, then a page/header flow (DECISIONS 2026-11-13).
5. Result e-mails: delete only after the PFM confirms (AGENTS.md Project rules).

## Next design (after Task 5)

1. Flows as solution-aware flows with connection references (match the real export), not legacy packages.
2. Draft flows F01-F05 in flow/solution (F05 = routing, S5A; open points in its README). Not built: the endorser-answer app flow (10A).
3. Then the Power Apps canvas app (docs/app/screen-map.md); Accessibility Checker 0 errors.

## Do not

- Put government data, the wing's name, site path, DODIDs or office symbols in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
