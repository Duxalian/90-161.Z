# Review brief: changes of 12 Nov 26 (second session), for a fresh reviewer

Scope: commits 1adf2ec to 071d68a on main (`git log --oneline 11801cb..071d68a`, 8 commits). Docs only; no schema, flow or script changed. The PFM wants an independent check with fresh context before more adjustments.

## What changed (facts only; judge them yourself)

| Commit | Change | Files |
|---|---|---|
| 1adf2ec | Independent review of the list design (18 findings); PFM decisions 1A 2A 3B 4A 5A; design, gap check, process model and architecture edited; Table A3.2 seed extracted; real names in an older review replaced by patterns | docs/reviews/2026-11-12-independent-review.md, docs/DECISIONS.md, docs/reviews/2026-11-12-list-design-full-scope.md, docs/reviews/2026-11-12-dafman-full-gap-check.md, docs/process-model.md, docs/ARCHITECTURE.md, docs/coordination-table-a3-2.md, docs/reviews/2026-11-11-cover-consistency.md |
| 621e5a4 | PFM approved the design for T02 r10; multi-person AO; outbound DAF Form 847 route; PFM Guidance column names | docs/DECISIONS.md, list design, docs/NEXT_PROMPT.md |
| 5dd9acd | PFM answers on procedure gaps (Process Steps "Applies To", flow rule catalog, CSV initial load, build order on hold) | docs/DECISIONS.md |
| 6570315 | Table A3.2 seed corrections | docs/coordination-table-a3-2.md |
| eb8f0e1 | DAFMAN coverage map (1,408 rows by 6 agents); new process-model sections "New publication request" (N1-N11) and "Special review out of cycle" (S1-S7); list design section 3a | docs/dafman-coverage/*, docs/process-model.md, list design |
| deff5b7 | PFM answers on the coverage map (ANGMAN 1.7.9 waiver memorandum, waiver scope, 3a approved, 8.8.6 not applicable); PFM Waivers redesigned; customer guidance draft r1 | docs/DECISIONS.md, list design, docs/guidance/customer-steps.md |
| 9dd58fd | Customer guidance r2 (52 screens, rewritten for first-time action officers); go.md Task 9 (save e-Publishing pages); decisions on the e-Publishing route and the administrative change approver | docs/guidance/customer-steps.md, go.md, docs/DECISIONS.md, docs/NEXT_PROMPT.md |
| 071d68a | Guidance links the PFM's review doc | docs/guidance/customer-steps.md |

The PFM's review copy of the guidance: https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV (Claude Docs; the PFM may have edited it since 071d68a, so compare it with the repo file).

## Prompt for the fresh review (paste into a new chat with repo access)

```
You review another agent's work on the public repo rhope-ops/90-161.Z (SharePoint, Power Automate and Power Apps for an ANG wing Publications and Forms Manager, "the PFM"). Read AGENTS.md first and follow it. You are a reviewer: do not change decisions, do not commit; report to the PFM.

Scope: the 8 commits in docs/reviews/2026-11-12-review-brief-session2.md (git log 11801cb..071d68a; git diff 11801cb 071d68a). Docs only.

Read:
1. ref/dafman90-161.txt (the rule source; cite paragraph and line) and ref/angman90-161.pdf (waivers).
2. docs/DECISIONS.md, newest rows first (the PFM's decisions win over everything except DAFMAN).
3. The diff, then the changed files in full: docs/process-model.md, docs/reviews/2026-11-12-list-design-full-scope.md, docs/guidance/customer-steps.md, docs/coordination-table-a3-2.md, docs/dafman-coverage/README.md (+ parts as needed), docs/ARCHITECTURE.md, go.md.
4. schemas/lists/*.json (the 9 lists live on the site today).
5. The PFM's review doc of the guidance: https://claude.ai/artifact/8qUeXnJNPhyEJNUYU6ShzV (Claude Docs tools), and the walkthrough https://claude.ai/artifact/VLxDqQfhEfWSw4Ckrc52Ki.

Check and report, each finding with evidence (file and line; DAFMAN paragraph and line):
A. DAFMAN accuracy: every rule stated in process-model "New publication request" (N1-N11), "Special review out of cycle" (S1-S7) and in the 52 guidance screens. Flag any statement the cited paragraph does not support, any invented value (time, level, count), and any rule that applies above wing level only.
B. Audience: the guidance is for military members who may have never done this and face a long, tedious process. Flag screens that are unclear, too long, use unexplained terms, skip a step the member needs, or leave a path without screens.
C. Consistency: DECISIONS vs list design vs process-model vs ARCHITECTURE vs guidance vs walkthrough vs coverage map. Flag stale text and any approved decision that a doc contradicts.
D. List design: add-only rule for the live site; column counts in section 6; lookup and person columns per list (SharePoint list view threshold 12, Created By and Modified By included); a column with no rule, or a rule that needs a column.
E. Coverage map: sample at least 40 rows across all 6 parts against the DAFMAN text; report wrong "N/A" or "Covered" calls and any gap that no theme in the README carries.
F. Public repo: government data, real names, office symbols, .mil addresses, the wing's name or its gaining MAJCOM.
G. go.md Task 9 against the go.md rules in AGENTS.md "Project rules".

Output: a numbered list, most severe first; each item: type (A-G), severity (high, medium, low), evidence, proposed fix. Then a one-line verdict (ready for the PFM's next adjustments and the T02 r10 build, or not, and why). Label it "independent review" with your model name.
```
