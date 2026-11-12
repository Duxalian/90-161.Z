# Next prompt: 90-161.Z

Updated: 2026-11-12 by Claude (T06/T07 results). Keep this file at 40 lines or fewer. The current request overrides it.

## State (main)

- Cloud sessions: start on the environment "90-161.Z" (pwsh + PSScriptAnalyzer setup script; PII_GUARD_DENYLIST set).
- Names and columns decided 2026-11-11 (docs/DECISIONS.md): 9 PFM lists (Offices, Series, Process Steps, Settings, Publications, Activity Log, Endorsements, Product Index, Reviews); Title Case; tests/check_names.py.
- r7 (PFM 1A 2A 3A 4A, design check https://claude.ai/artifact/X8LbHd79Zh614i1qYzhyTW): 8 DAFMAN action types; Coordination Stage (Privacy Review, Formal Coordination, Legal); actions point to their Product Index row; PFM Reviews; certifier/approver fields. Flow and app rules from that doc's "Rules for the flows and the app" are not built yet.
- Provisioning: flow/defs/90161Z-T02-provision-lists-r9.json -> flow/packages/90161Z-T02-provision-lists-r9.zip (143,327 bytes); site address only, no site-title check (PFM 2026-11-12); 39 series rows (Table A2.1) + 2 settings rows (5.2, 5.2.2). Docs: docs/power-automate-provisioning.md.
- Mockup of all lists: https://claude.ai/artifact/2CtD3ASmmmzkz1EPErgCvh (python3 scripts/build_list_mockup.py <out.html>, then republish).
- Style (PFM 2026-11-11): docs/style-standard.md, DAFMAN 90-161 + The Tongue and Quill; tests/check_names.py enforces it. Rules approved by the PFM 2026-11-11 (1A); No Response kept in PFM Reviews (2A). Apply it to flow e-mails and the app too.
- Access (PFM 10A, 2026-11-12): all site members read all rows; on PFM Publications and PFM Endorsements they edit only rows they created (go.md Task 8, manual); endorser results go through an app flow; the app filters by Requester and AO.
- Records: AFRIMS T 33-38 R 07 (destroy record set - DAF Forms 673/399 and paperwork - when superseded or rescinded). Publications stay browsable. Working files: rule open.
- 15 business days (DAFMAN 5.2): a measure, not a hard deadline; reminders, warnings and escalation emails in a measured, professional tone; weekdays only.
- Continuity: co-owners on every flow and the app; maintainer how-to written last, step by step for a non-expert.
- Gap review: https://claude.ai/artifact/Ta3utvkZGP5aKXWWeRh7vU (open: test site, Accessibility Checker gate, CUI check for working files).

## Waiting on the PFM (go.md)

0. Renderer fix (go.md top): all 5 T06/T07 renders failed "Specified cast is not valid" (docs/reviews/2026-11-11-gov-results-t06-t07.md). New-Publication.ps1 now prints FORMAT-FAIL/RENDER-ERROR with the line; read those lines first, then fix the named step.
1. Task 1 r5: cover spacing, TOC style, tier hyphen (docs/reviews/2026-11-11-page1-vs-dafman.md). Measure his PDF against DAFMAN page 1.
2. Task 6 r1: validated (schema pass) with Gemini, GPT, Grok; waiting on the 3 JSON files to grade against EXPECTED in scripts/build_messy_draft.py.
3. Task 7 r1: Part A prep PASS (4/4 lines); renders wait on the fix (then check PDFs per docs/gov-test-plan.md Task 7). Part B: real seals in library 90-161.Z, folder Seals (PFM 7B); r1 needs the pasted path (next seal-prep revision: Enter finds "* - 90-161.Z\Seals"). T02 r9 passed on the real site.
4. Result e-mails: delete only after the PFM confirms (AGENTS.md Project rules).

## Next design (after Task 5)

1. Build flows as solution-aware flows with connection references (match the real export), not legacy packages.
2. First flows (apply the design-check rules: stage gating, Legal never Concur—No Response, GM expiry, rescind cascades to forms, periodic review timers): write every event to PFM Activity Log; endorsement routing from PFM Offices (Legal last); suspense reminders and escalation (weekdays); Next Review Due = 4 years after the later of Effective Date and Last Certified Current Date, review task 6 months before, prescribed forms with their publication; on-demand status report email.
3. Then the Power Apps canvas app (customer intake, status, PFM queue; OPR opens the office record), Accessibility Checker 0 errors.

## Do not

- Put government data, the wing's name, site path, DODIDs or office symbols in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
