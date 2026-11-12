# Next prompt: 90-161.Z

Updated: 2026-11-12 by Claude (second independent review; PFM 1A-5A; fixes made; assumed-decision batches open). Keep this file at 40 lines or fewer. The current request overrides it.

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
- Full-scope list design (14A, approved 12 Nov): docs/reviews/2026-11-12-list-design-full-scope.md, revised after the second independent review (https://claude.ai/artifact/VNBoH8i4SNy7do6py58YNM; PFM 1A-5A: one stage table 0-12, one AO plus one alternate, AO 1/2 Email columns, scope ladder with squadron and flight, flow opens the rescind on no answer). Next: T02 r10 (provisioning flow + seed rows + go.md task), after batch answers that add columns (register 1.3-1.5, 4.5). Table A3.2 seed: docs/coordination-table-a3-2.md.
- DAFMAN coverage map (12 Nov): docs/dafman-coverage/README.md (1,408 rows: Covered 383, N/A 314, Gap 73; themes T1-T13). process-model: stages 0-12, new publication (N1-N11, N6 scope and N11 officials), special review (S1-S7). Customer guidance draft r3 (75 screens): docs/guidance/customer-steps.md; the PFM's review doc https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV carries r3. e-Publishing index: go.md Task 9.
- Open now: the PFM answers the assumed decisions in 5 batches (34 points): https://claude.ai/artifact/UAKZ89DXU6xJsedi1dpt7J. After each batch: record in DECISIONS, fix the docs, push.

## Waiting on the PFM (go.md)

0. Renderer round 2 (go.md Fix first): 6/6 renders made PDFs; cover gaps within 0.011 in of DAFMAN; only L-012 TOC indent failed (cast error) and seal top 1.383 vs 1.47. New-Publication.ps1 now tries 3 routes for L-012 and prints `route=` with a read-back; seal +6.3 pt. Evidence: docs/reviews/2026-11-12-gov-results-t01r5-t06-t07.md.
1. Task 1 r5 and Task 7 Part A step 4: re-run with the new renderer; measure TOC (number 1.50, text 2.00, pitch 0.272) and seal top 1.47.
2. Task 6 r1 done: GPT and Gemini 12/12; GPT is the extractor, Gemini fallback (PFM 1A). Grok dropped. Prompt r2 follow-up: list AFI; validator F-032/F-039 false positives.
3. Task 7 Part B: real seals in library 90-161.Z, folder Seals; r1 needs the pasted path.
4. F-040 decided (PFM 1A 2B 3A): no tier on wing statements except T-0/T-1/T-2 above the wing; prompt r2 (M8) ready for the next Task 6 run.
5. Result e-mails: delete only after the PFM confirms (AGENTS.md Project rules).

## Next design (after Task 5)

1. Build flows as solution-aware flows with connection references (match the real export), not legacy packages.
2. First flows (apply the design-check rules: stage gating, Legal never Concur—No Response, GM expiry, rescind cascades to forms, periodic review timers): write every event to PFM Activity Log; endorsement routing from PFM Offices (Legal last); suspense reminders and escalation (weekdays); Next Review Due = 4 years after the later of Effective Date and Last Certified Current Date, review task 6 months before, prescribed forms with their publication; on-demand status report email.
3. Then the Power Apps canvas app (customer intake, status, PFM queue; OPR opens the office record), Accessibility Checker 0 errors.

## Do not

- Put government data, the wing's name, site path, DODIDs or office symbols in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
