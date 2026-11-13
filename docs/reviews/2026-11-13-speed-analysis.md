# Why coding takes longer (2026-11-13)

Asked by the PFM, 13 Nov 26. Self-review by Claude; no independent review. CONFIDENCE: MEDIUM. There is no wall-clock record of earlier sessions (the 13 Nov history rewrite also merged early commits), so the comparison counts steps and sizes, not minutes.

## Answer

The checks are not the cause: all of them run in seconds. The cause is the **number of steps per change**, which comes from repo rules added on 12-13 Nov more than from the personal preferences. Claude's own rework adds to it. Each change now pays a fixed cost of about 25-35 tool calls before the code itself.

## Measured (13 Nov, this container)

| Item | Time / size |
|---|---|
| tests/run.sh | 12.8 s (baseline 12.2 s, within 25 %) |
| scripts/lint.sh | 4.9 s |
| pre-push hook (PII guard + checks) | 4.1 s |
| session check-in / Stop hook | 0.6 s / 0.1 s |
| Start-read instructions (bloat_check) | ~12,000 tokens, budget 12,000 (at limit) |
| AGENTS.md | 2,965 words, 91 rules; 16 commits changed it on 13 Nov (2 on 12 Nov) |
| docs/DECISIONS.md | 4,069 words |
| Personal preferences | ~2,000 words (estimate) |

## Steps one change cost in this session (R05: about 40 lines of code)

| Kind of step | Tool calls | Rule source |
|---|---|---|
| Code, build, tests, lint | ~8 | the work itself |
| Independent review + fixes | ~4, plus 1-2 min waiting | AGENTS.md Delegation, personal Reporting |
| PR: create, check status, wait for the scan, merge, verify main | ~6 | AGENTS.md Delivery (13 Nov) |
| Docs: go.md, DECISIONS short + archive, NEXT_PROMPT, review doc, test plan | ~6 | AGENTS.md Decisions, Handoff, gov-device rules |
| Project log row in the Claude doc (find last row number, then insert) | 3-5 per row | AGENTS.md Project log (11 Nov) |
| E-mail: find, read, download, measure, ask to delete, delete | ~6 | Project rules: result e-mails |
| Question dialogs and end-of-turn summary | 2-3 | personal Decisions and End-of-turn summary |

Claude's own rework in R06 cost ~10 more calls: a Linux-only start failure (type names in the window code) and three test-pattern misses (byte-order mark, CRLF, quoted CSV).

## Root causes, ranked

1. Delivery ceremony per change (repo, 13 Nov): every change, even docs-only, goes through a PR, a scan wait, a merge and a verify. About 6 calls plus waiting.
2. One fact written in many places (repo): one decision touches DECISIONS.md, decisions-archive.md, NEXT_PROMPT.md and often go.md and a review doc. About 6 calls.
3. Project log in a Claude doc (repo, 11 Nov): no "append row" or "last row number" read, so each row costs 3-5 calls.
4. Instruction load at its budget (repo + personal): ~12,000 start-read tokens plus the preferences. Every turn re-reads them; long rules also slow decisions in the turn.
5. Claude's rework: about a quarter of R06's calls.

The personal preferences add little on their own (summary format, dialogs, confidence labels: 2-3 calls). They do double some repo rules (independent review, PR-and-merge), so both sets get checked.

## Recommendations (not decided)

- A. Batch the paperwork: one docs commit and one PR per round, not per change. Saves ~6-10 calls per change. **Rec.**
- B. Project log: keep the next row number at the top of the log doc, or write all rows once at the end of the session. Saves 2-4 calls per row.
- C. One place per decision: drop the short index plus archive pair (B2A) and keep one table. Saves 1-2 calls per decision.
- D. tests/run.sh takes a filter (for example `tests/run.sh bundle`) for the edit-test loop; the full suite runs once before push. Saves ~10 s per loop.
- E. Bloat audit (due now: 35 commits since e44c29b) with the target of cutting start-read tokens by 25 %.
