# Next prompt: 90-161.Z

Updated: 2026-11-11 by Claude. Keep this file at 40 lines or fewer. The current request overrides it.

## State

- Rules: DAFMAN 90-161 wins every contradiction; wing files shape process only (AGENTS.md).
- Phase A done: covers measured (docs/reviews/2026-11-11-cover-consistency.md).
- Phase C done (agent workspace): renderer cover per measurements, certifier name line, 0.75 pt rules, opening paragraph built from openingParts (4.5.5 order, verbatim fixed text), two-space sentences, TOC always, Attachment 1 (ATT1) report. tests/run.sh 19/19. Independent review: 12 findings, 0 high; fixed.
- Gov-device tasks live in go.md (repo root) (never email the military address).
- Flow import route verified on the gov device 2026-11-11: scripts/build_flow_package.py zip, raw link, Import Package (Legacy), run passed.
- SharePoint connection in an imported package verified on the gov device 2026-11-11 (Task 4 r2).
- Names decided 2026-11-11 (DECISIONS.md; doc https://claude.ai/artifact/WU7A3UXrmr9tFf2sy18Ptk): 7 PFM lists, Title Case, tests/check_names.py. Provisioning package T02 r2 has a site-title guard. go.md Task 2 r2.
- Design goal (PFM): successor can troubleshoot and fix; maintainer how-to required.
- Not yet run on the gov device: Task 1 r3 (SaveAs fix), Task 2 r2.

## Open (in order)

1. PFM runs the gov test plan and the flow; fix failures.
2. Phase D: customer process in the app (periodic review per 7.4.2, drafting, PFM review, informal coordination, formal coordination with Legal last, certify, approve, post), endorsement flows, on-demand status report email.
3. Phase B: one short Word getting-started document (after the app has a link).

## Needs PFM

- Gov-device results (renderer test plan, flow section 3 checks).

## Do not

- Put government data, the wing's name or site path in this repo or in Claude chats.
- Take rules from the wing files. Format comes from code and DAFMAN 90-161.
