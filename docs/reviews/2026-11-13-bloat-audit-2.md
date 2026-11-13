# Bloat, drift and assumption audit 2: 13 Nov 26

Method: .claude/bloat-audit.md. Auditor: Claude (self-review). Machine: cloud container (Linux, 4 cores), the same kind as the baselines in .bloat-audit.json. Start: main 90d1252 (66 commits after audit 1 at 3a1a4a5). Audit 1: docs/reviews/2026-11-13-bloat-audit.md.

No fix in this audit falls inside the no-approval exceptions (bloat-audit.md "Rules for the auditor"), so nothing outside this report, the handoff line and `last_audit` changed. Every fix is a proposal (P1-P4 below).

## Before and after

| Measure | Before | After | Budget |
|---|---|---|---|
| Start read (~tokens) | 12,300 (DECISIONS 24,408 B; AGENTS 20,415 B; NEXT_PROMPT 4,355 B) | same; about 11,500 if P2 and P4 are approved | 12,000 |
| Duplicate lines (80+ chars, 2+ files) | 31 | 31 (30 = B3A block, finding 3; 1 = coverage table header, T4) | 20 |
| Tracked files / size | 171 / 5,571,242 B (audit 1: 159 / 5,544,329 B) | same | - |
| Big files (over 500 KB) | 0 | 0 | 0 |
| Timing: tests (s) | 21.7, 20.1, 21.0 (baseline 12.9: +60%) | same; about 12.5 if P1 is approved | 16.1 (+25%) |
| Timing: check-in (s) | 0.9, 0.76 (baseline 0.5) | same | 0.6 (+25%) |
| Tests | pass=55 fail=0 | pass=55 fail=0 | fail=0 |
| Lint | findings=0 (13 files) | findings=0 | 0 |
| Removals proposed / approved / made | - | 0 / 0 / 0 (P1-P4 change, shorten or sync; none deletes a file) | - |
| Rules removed or merged | - | 0 (P2 would merge baseline rules into pointers) | - |
| Key assumptions: high / medium / low / untraced | audit 1: 6 / 4 / 2 / 0 | 8 / 4 / 0 / 0 | - |

Commands: `python3 scripts/bloat_check.py --time`; `tests/run.sh` timed with `$EPOCHREALTIME` (3 runs); per-line cost from a traced copy of tests/run.sh (`PS4='+$EPOCHREALTIME '`); `git ls-files -z | xargs -0 du -cb`. Data as of 13 Nov 26, about 10:00 CT.

## Findings by category

| # | Category | What, where | Evidence | Fix or proposal |
|---|---|---|---|---|
| 1 | Performance | tests/run.sh starts pwsh 19 times. 12 of them run scripts/gov/Test-Publication.ps1 once each (0.73-0.78 s each = about 9.4 s). pwsh start alone = 0.23 s; the rest is module and script load each time. Audit 1 tech debt T1 (3.9 s then) grew with new tests (F-020, placeholder, seal, seal-ok). | trace: lint 4.9 s; 12 validations 9.4 s; 12 validations in one pwsh process: 1.47 s, same exit codes and last lines | P1 |
| 2 | Performance | Lint 2.75 s (audit 1) -> 4.9 s. Top file costs: generated round bundle 90161Z-R04-round-r2.ps1 1.21 s (94 KB, embeds the task scripts), New-Publication.ps1 0.93 s. The bundle is the only check of the runner-window code (tests/run.sh: "The window path ... cannot run here: lint only"), so it stays in lint. | per-file Invoke-ScriptAnalyzer timing | Accepted (T5) |
| 3 | Drift (decision not applied) | B3A (PFM, 13 Nov: one source for the gov task-script block, "applied at each script's next revision"). T01 went r6 -> r7 in 8d30d1c (13 Nov, Round R03) with the block still copied. The decision has no check, so the next revision can miss it again. | `git log --follow` T01 r7; bloat_check: 30 of 31 duplicate lines are this block in 5 files | P3 |
| 4 | Drift (baseline) | Baseline rhope-ops/archimedes_lever moved ecfd8a8 -> bc233b9 (20 commits): host-limit rule, AGENTS.md reference text moved to `.claude/project-log.md` and file headers, newer log_check, timeline, bloat_check, sync_baseline. AGENTS.md is instruction text, so a sync is the PFM's call (AGENTS.md "Untrusted input"). | `python3 scripts/drift.py`: 13 of 43 items differ; baseline AGENTS.md 13,709 -> 12,414 B (-1,295 B, about -324 tokens here) | P2 |
| 5 | Instruction bloat / context cost | docs/DECISIONS.md index rule: "one line per current decision, 200 characters or fewer". 3 of 149 rows break it: lines 11 (545 chars) and 12 (423 chars), both "Wing PowerPoint master", and line 100 (202 chars, Seals). The two PowerPoint rows are a side task outside this repo's purpose and repeat delivery detail the archive already holds. | `awk` length of column 2 | P4 |
| 6 | Stale docs | Old owner name: docs/brief/installer.json (5), docs/DECISIONS.md (1, the rename record itself), docs/decisions-archive.md (2, history). installer.json fixed 2026-11-13 (name added to the denylist); built deck at the next brief rebuild (DECISIONS 2026-11-13). | git grep for the old owner name | No action (planned) |
| 7 | Stale docs | docs/NEXT_PROMPT.md:7 said audit 2 is due. | this audit | Fixed: line now points to this report and P1-P4. |
| 8 | Dead files | 16 files have no reference by file name. All are read by a glob (samples/lists/*.csv, schemas/lists/*.json, docs/brief/*.json, flow/defs/*.json), are evidence in docs/reviews (kept, as in audit 1), or are .nojekyll (needed by GitHub Pages). | name scan over `git ls-files` | None |
| 9 | Superseded revisions | No file outside docs/reviews and the decision files names an older revision of a gov script, flow def or prompt. | revision scan | None |
| 10 | Check noise | `python3 scripts/log_check.py` with no argument fails: docs/LOG.md does not exist because the log is the private Claude doc (Project rules). check.sh and pre-push pass, so it blocks nothing. drift.py already knows ("kept elsewhere"). | log_check output | Fixed upstream by P2 if the newer log_check reads Project rules; else T6. |

No findings in: CI minutes (1 workflow, pull_request and workflow_dispatch only), dependencies (Python standard library, pwsh, node for 2 builders), agent helper files (no _v2/_old/_new files), PII guard (`--status`: 3 denylist entries).

## Proposals for the PFM (Step 5.4)

| # | What, where | Why it exists | Evidence it is not needed as is | Saving | Risk | REC |
|---|---|---|---|---|---|---|
| P1 | tests/run.sh: run the 12 Test-Publication.ps1 checks in one pwsh process (`& script; $LASTEXITCODE`), same inputs and pass criteria | Each test was added as its own pwsh call, one per rule fix | 1.47 s vs 9.4 s measured, same results | about 8 s per test run (-40%), every session and every push (pre-push runs check.sh) | A script that leaks state between runs could mask a failure; mitigated by a fresh reviewer and by keeping the exit-code checks | A: do it |
| P2 | Sync baseline bc233b9 (AGENTS.md sections, .claude/project-log.md, kit scripts) | Baseline is the kit source; this repo pins ecfd8a8 | drift.py: 13 items differ | about 324 start-read tokens (12,300 -> about 11,976, under budget) | Instruction text changes; Project rules stay as they are | A: sync now |
| P3 | B3A: one source for the task-script block | PFM B3A, 13 Nov | T01 r7 missed it | 30 duplicate lines; one fix place for DODID masking | A new revision of each script means new file names on the gov device | A: add a test that fails when a gov task-script revision newer than today's lacks the generated block, so the next revision cannot skip it |
| P4 | DECISIONS.md lines 11, 12, 100: shorten to 200 characters or fewer; full text stays in docs/decisions-archive.md | Written before or outside the short-index rule | 545 / 423 / 202 chars | about 200 tokens | None: full text kept word for word in the archive | A: shorten; draft lines for PFM approval |

## Assumption table

| Assumption | Used in | Source | Confidence |
|---|---|---|---|
| Gov device: Windows PowerShell 5.1, Word 16 COM, PnP.PowerShell 1.12.0; code also runs on PowerShell 7 | AGENTS.md Commands | docs/reviews/2026-11-10-gov-env-check.md; PFM 5.3A | high |
| Gov device reads raw.githubusercontent.com without login | go.md | R01-R03 ran from it | high |
| No tenant admin; standard connectors only | Project rules | PFM 2026-11-10, 2026-11-12 | high |
| ref/ holds the approved DAFMAN edition | format rules | DECISIONS 2026-11-10; test "ref files match ref/SHA256SUMS" | high (file); medium (no check for a newer change on e-Publishing) |
| GPT on GenAI.mil extracts reliably | prompts/; Task 6 | Task 6 r1 12/12 | high (one sample) |
| PII guard has its denylist in cloud sessions | pre-push | `pii_guard.py --status`: 3 entries | high |
| Purview label applies by code on the gov device | renderer | R02: PDF labeled, one MSIP label (docs/reviews/2026-11-13-r02-results.md) | high (was low in audit 1) |
| ISSM allows paste rounds without elevated credentials | go.md "How a paste task works" | PFM report 13 Nov in go.md | high (PFM statement) |
| "Import Package (Legacy)" stays available for T02 | flow/packages | T02 r9 ran; solution-aware flows planned (PFM 5.6A) | medium |
| Other wings can install without PowerShell or Send As | Project rules | fallbacks documented, not tested on a second tenant | medium |
| Item-level and member read rights work as designed | roles-and-permissions.md | rights-test-plan.md (Task 11 results pending) | medium |
| Test timings compare across sessions | .bloat-audit.json | same container type; 3 runs this session within 1.6 s | medium |

Audit 1's stale-brief assumption (low) is closed: the handoff no longer carries it.

## Tech-debt register

| # | Item | Owner | Review date |
|---|---|---|---|
| T1 | Test runtime (finding 1) until P1 is answered | the PFM (P1) | next audit (27 Nov 26) |
| T2 | Duplicated gov-script block until B3A is applied (P3) | Claude | next revision of each task script |
| T3 | Start read 300 tokens over budget until P2/P4 | the PFM (P2, P4) | next audit |
| T4 | Coverage table header line counts as a duplicate in 6 files (docs/dafman-coverage/part-*.md); the header is needed in each file | Claude | next audit (fix in the baseline bloat_check: skip table header lines) |
| T5 | Lint 4.9 s, 1.2 s of it the generated round bundle | Claude | next audit |
| T6 | log_check default path fails with a private log | Claude | after P2 |

Timing baselines in .bloat-audit.json stay at 12.9 s and 0.5 s: re-recording at 21 s would hide finding 1. Record again after P1.

## Update 13 Nov 26: proposals answered and made

PFM answers (docs/DECISIONS.md): P1 do it, P2 sync now, P3 apply to all 4 now (not only a test), P4 draft lines (approved as drafted).

| Measure | Before | After | How measured |
|---|---|---|---|
| tests/run.sh (s) | 21.7 / 20.1 / 21.0 | 12.5, 12.7, 14.8; new baseline recorded with `--time --record` | `$EPOCHREALTIME` around `tests/run.sh` |
| Tests | pass=55 fail=0 | pass=56 fail=0 (+1: task-common check) | `tests/run.sh` |
| Start read (~tokens) | 12,300 | 11,887 (budget 12,000) | `python3 scripts/bloat_check.py` |
| Duplicate lines | 31 | 36 (the 4 generated block copies; see below) | same |
| Baseline drift | 13 of 43 items differ | 1 of 44 (docs/FIRST_USE.md, tuned per project) | `python3 scripts/drift.py` |

Made: P1 tests/ps/Invoke-Validations.ps1 (9 inputs in one pwsh process; same 55 PASS lines word for word). P2 sync_baseline --apply (AGENTS.md, kit scripts, .claude/project-log.md). P3 scripts/gov/src/task-common.ps1 + scripts/build_task_scripts.py (check fails on a stale copy or a DODID prompt outside the block); T01 r8, T06 r2, T07 seal prep r2, T07 seal test r3; R04 bundle r3 also writes seal prep r2 into T07; go.md Round R04 r3 and Task 7 Part B. P4 3 index lines shortened; the 2 PowerPoint rows' full text copied word for word to docs/decisions-archive.md. Also fixed (same files): docs/gov-test-plan.md named 2 retired bundles.

Independent review (fresh `reviewer` subagent, diff and brief only): no major findings; 4 minor. Fixed: (1) helper now also captures Write-Host lines (6>&1). Accepted: (2) seal prep now trims -Id like the other runners; (3) Task 7 Part A has no current bundle (stated in docs/gov-test-plan.md); (4) go.md committed with this update.

The 30 B3A duplicate lines remain in the duplicate count: they are now generated copies of one source (same as the round bundle), checked by `build_task_scripts.py --check`. Tech debt T2 closed; T4 open, now also covering these copies (proposal for the next audit: let bloat_check skip text between generated-block markers, in the baseline).

Timing baselines: tests re-recorded at 12.2 s (`--time --record`). Check-in kept at 0.5 s: its 0.76-0.9 s runs are mostly `git fetch` (0.40 s measured, network-bound); the script did not change. Tech debt T7 (Claude, next audit): measure check-in without the fetch, or accept network variance in the limit (PFM's call).
