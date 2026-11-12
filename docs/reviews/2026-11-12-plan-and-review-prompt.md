# Plan for the full DAFMAN scope, and a prompt for a fresh review (12 Nov 26)

## Plan (Agent recommendation; step 3 waits on PFM approval, decision 16)

1. Done: full DAFMAN 90-161 gap check, two passes (docs/reviews/2026-11-12-dafman-full-gap-check.md).
2. Done: rules in docs/process-model.md ("Rules from the full DAFMAN check"); decisions 12A, 13, 14A, 15A in docs/DECISIONS.md.
3. Proposed: list design, add-only (docs/reviews/2026-11-12-list-design-full-scope.md): 3 new lists (PFM Guidance, PFM Recommendations for the DAF Form 847, PFM Waivers), 44 new columns, 11 new choice values, library folders.
4. After approval: update schemas/lists/*.json, rebuild flow/provisioning-payload.json, update the list mockup (scripts/build_list_mockup.py), docs/sharepoint-lists.md.
5. Build an add-only provisioning flow (T02 r10 or a new task number) that creates only the 3 new lists and adds columns and choice values to the 9 existing lists; a test proves the payload has no create call for an existing list and no delete or rename; fresh reviewer before merge; go.md task.
6. Then: PFM Guidance seed rows (the AO and endorser steps), flows (gates in section 5 of the design), and the Power Apps app.

## Prompt for a fresh review (paste into a new chat with repo access)

```
You review another agent's work on the public repo rhope-ops/90-161.Z (a SharePoint, Power Automate and Power Apps system for an ANG wing Publications and Forms Manager). Read AGENTS.md first and follow it; you are a reviewer, so do not change decisions, only report.

Goal: an independent check that the plan matches DAFMAN 90-161 and the PFM's decisions, before any list is built.

Read:
1. ref/dafman90-161.txt (the source; cite paragraph and line).
2. docs/DECISIONS.md (newest first; the PFM's decisions win over everything except DAFMAN).
3. docs/process-model.md, docs/ARCHITECTURE.md.
4. docs/reviews/2026-11-12-dafman-full-gap-check.md (what the agent says it found and checked).
5. docs/reviews/2026-11-12-list-design-full-scope.md (the proposed list changes).
6. schemas/lists/*.json (the lists that exist on the live site today).
7. The walkthrough doc https://claude.ai/artifact/VLxDqQfhEfWSw4Ckrc52Ki if you can open it.

Check and report, each finding with evidence (file and line, DAFMAN paragraph and line):
A. DAFMAN rules that apply to an ANG wing and are still missing from the process model or the list design. Sample at least 3 chapters yourself (for example 5, 7 and 8) instead of trusting the gap check.
B. Gap-check rows that are wrong: the cited text does not say it, or it applies only above wing level.
C. Design problems: a column that serves no checked rule, a missing column a flow gate needs, a choice value that conflicts with DAFMAN wording, a lookup or person column count over 12 in one view, or anything that would rename or delete live data.
D. Conflicts between docs (DECISIONS vs process-model vs ARCHITECTURE vs the design vs the walkthrough).
E. Anything that puts government data, real names, office symbols or the wing's name in this public repo.

Output: a numbered list, most severe first, each item: type (A-E), severity (high, medium, low), evidence, and a proposed fix. Then a one-line verdict: ready to build, or not, and why. Label it "independent review" with your model name. Do not commit; give the report to the PFM.
```
