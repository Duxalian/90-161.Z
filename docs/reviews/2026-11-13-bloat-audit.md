# Bloat, drift and assumption audit 1: 13 Nov 26

Method: .claude/bloat-audit.md. Auditor: Claude (self-review; a fresh `reviewer` subagent checked the changes to checks and tests). Machine: cloud container (Linux), the same kind as the baselines in .bloat-audit.json. Start: main f9a91b6 + 40307e3.

## Before and after

| Measure | Before | After | Budget |
|---|---|---|---|
| Start read (~tokens) | 20,982 | 19,742 (-5.9%) | 12,000 (over: B2) |
| docs/DECISIONS.md (bytes) | 57,674 | 56,157 | - |
| docs/NEXT_PROMPT.md (bytes / lines) | 6,693 / 40 | 3,312 / 38 | 40 lines |
| AGENTS.md (bytes) | 19,537 | 19,475 | - |
| Duplicate lines (80+ chars, 2+ files) | 423 | 32 (391 were generated files and fixtures, now ignored) | 20 (over: B3) |
| Tracked files / size | 159 / 5,549,347 B | 159 / 5,544,329 B (-1 file, +1 archive file) | - |
| Big files (over 500 KB) | 2 (ref/dafman90-161.pdf, .txt) | 0 (ref/** ignored: rule source, now checked by checksum) | 0 |
| Timing: tests (s) | 20.7 under load; 13.4 and 14.6 alone | 13.2 | 15.0 +25% |
| Timing: check-in (s) | 0.6 | 0.6 | 1.9 +25% |
| Tests | pass=51 fail=1 | pass=52 fail=1 (same fail, B1) | fail=0 |
| Lint | findings=0 | findings=0 | 0 |
| Dead files removed | - | 1 (docs/genai-prompt.md) | - |
| Rules removed or merged | - | 1 merged (AGENTS.md Gov device: one sentence said twice) | - |
| Decision rows archived (word for word) | - | 11 (docs/decisions-archive.md) | - |
| Key assumptions: high / medium / low / untraced | - | 6 / 4 / 2 / 0 | - |

The timing check reports "FAILED" for tests because the test suite exits 1 (B1), not because it is slow. Baseline 15.0 s stays until the suite passes; then record with `--time --record`.

## Findings by category

| # | Category | What, where | Evidence | Fix or proposal |
|---|---|---|---|---|
| 1 | Drift | go.md uses "email" 6 times (lines 10, 22, 46, 64, 111, 126); tests/check_names.py requires "e-mail" (docs/style-standard.md, PFM 1A 2026-11-11). Main fails since f9a91b6. | `tests/run.sh`: FAIL naming rules | Question B1 (two PFM decisions conflict). |
| 2 | Drift | go.md:148 named a review file by bare path; the date in the path failed the date rule, and the Project rule says link files by raw URL. | check_names.py output | Fixed: raw URL. |
| 3 | Context cost | docs/DECISIONS.md = 56 KB = 71% of start read. 151 rows; 30 rows over 600 characters restate design detail that lives in the linked design docs. | bloat_check.py; row lengths | Archived 11 rows that later rows replace in full. Question B2 for the rest. |
| 4 | Handoff rot | docs/NEXT_PROMPT.md met the 40-line limit with lines of 300-900 characters; 9 bullets restated decisions. | 6,693 B -> 3,312 B | Fixed: state and pointers only. |
| 5 | Duplication | 391 of 423 duplicate lines are in generated files (scripts/gov/paste/*.ps1, flow/provisioning-payload.json, flow/packages) or test fixtures derived from samples/publication.sample.json. | bloat_check.py by file | Fixed: `ignore` globs in .bloat-audit.json (generated files are rebuilt from one source; fixtures copy the sample on purpose). |
| 6 | Duplication | The DODID prompt, secret masking, missing-file check, unblock and step runner block is copied into 4 task scripts (T01 r6, T06 r1, T07 prep r1, T07 test r2) and scripts/build_paste_bundles.py: 31 of the 32 remaining lines. | bloat_check.py | Question B3. |
| 7 | Dead file | docs/genai-prompt.md: the L1 pilot prompt (last referenced in ad7f33b, 11 Nov); replaced by prompts/90161Z-T06-extract-prompt-r2.txt (DECISIONS 2026-11-11 "Build the GenAI.mil extraction prompt", 2026-11-12 "GPT is the GenAI.mil extractor"). No file links to it. Two prompts for one job is a drift risk. | `git grep genai-prompt` = 0 hits | Fixed: deleted (git history keeps it). |
| 8 | Instruction bloat | AGENTS.md Project rules "Gov device (PFM, 2026-11-10)" said "reads it without login" twice. | AGENTS.md:160 | Fixed: merged, same meaning. |
| 9 | Drift (check noise) | scripts/session_checkin.sh prints "template placeholders remain" every session: its exclude list misses kit scripts that hold the PROJECT_NAME placeholder on purpose (scripts/first_use_check.py:93, scripts/drift.py:165, scripts/check.sh:30). The file is baseline-owned (drift.py: same as baseline). | check-in output | Question B4 (fix in the baseline, then sync). |
| 10 | Drift (rule vs repo) | AGENTS.md "Personal data" names a pull-request Action, .github/workflows/pii-guard.yml. It never existed in this repo (`git log --all -- .github/` is empty). The pre-push hook runs the guard, so pushes are covered; pull requests from other people are not. | git log | Question B5. |
| 11 | Performance | Tests: top 3 costs are the F-040/F-039 test (3.9 s: 7 separate pwsh starts), lint (2.75 s), paste-bundle test (0.86 s). One pwsh process for the F-040 cases would save about 3 s (about 22%). | per-line timing of tests/run.sh | Tech debt T1. |
| 12 | Assumption without a test | The ref/ files are the approved DAFMAN edition (DECISIONS 2026-11-10 "Rule source"); ref/SHA256SUMS existed but nothing checked it. | `git grep SHA256SUMS` in tests = 0 | Fixed: test "ref files match ref/SHA256SUMS". |

No findings in: dependencies (Python standard library, pwsh, node for 2 builders), CI minutes (no workflows), agent-made helper files (no _v2/_old/_new files; one revision per task file), unreferenced reviews (7 evidence files with no link are kept: evidence, not dead code).

## Assumption table

| Assumption | Used in | Source | Confidence |
|---|---|---|---|
| Gov device: Windows PowerShell 5.1, Word 16 COM, PnP.PowerShell 1.12.0 | AGENTS.md Commands; scripts/gov | docs/reviews/2026-11-10-gov-env-check.md (measured) | high |
| Gov device reads raw.githubusercontent.com without login | go.md; Project rules | PFM 2026-11-10; R01 ran from it (docs/reviews/2026-11-13-r01-results.md) | high |
| No tenant admin; standard connectors only | Project rules; flow design | PFM 2026-11-10 and 2026-11-12 | high |
| ref/ holds the approved DAFMAN edition (18 Oct 2023, Change 1, Corrective Action 1 May 2026) | all format rules | DECISIONS 2026-11-10; test added | high (file); medium (still current: nothing checks e-Publishing for a newer change) |
| GPT on GenAI.mil extracts reliably | prompts/; Task 6 | Task 6 r1: 12/12 (DECISIONS 2026-11-12) | high (for now) |
| PII guard has its denylist in cloud sessions | pre-push hook | `pii_guard.py --status`: 3 entries from the environment variable | high |
| "Import Package (Legacy)" stays available for T02 | flow/packages | T02 r9 ran (DECISIONS 2026-11-11); NEXT_PROMPT already plans solution-aware flows | medium (Microsoft labels it legacy) |
| Other wings can install without PowerShell or Send As | Project rules "Deployable package" | rights-test-plan.md has fallbacks for E3 (Send As) and PnP; not yet tested on a second tenant | medium |
| Item-level and member read rights behave as designed | roles-and-permissions.md | docs/rights-test-plan.md (go.md Task 11, results pending) | medium |
| Test timings compare across sessions | .bloat-audit.json | same container type; 13.2-20.7 s spread seen this session | medium |
| Purview label applies by code (SetLabel) on the gov device | DECISIONS 2026-11-13; R02 | R02 not run yet | low (test pending: R02, no question needed) |
| Handoff state in the brief for this session: "full baseline sync waits for check: mil" | session brief | .pii-guard:14 already has `check: mil`; main has 7215659 "Full baseline sync ... (PFM 3A)" | low: the brief was stale; 3A is done |

The 24 untraced plan assumptions from 12 Nov stay in their own register (https://claude.ai/artifact/Wdvg7PB2321twKVubQbp2i); this audit did not re-check them.

## Tech-debt register

| # | Item | Owner | Review date |
|---|---|---|---|
| T1 | F-040 test starts pwsh 7 times (3.9 s); merge into one pwsh run | Claude | next audit (27 Nov 26) |
| T2 | Duplicated gov-script block (finding 6), until B3 is answered | the PFM (B3) | next audit |
| T3 | Start read 7,742 tokens over budget, until B2 is answered | the PFM (B2) | next audit |

## Questions for the PFM

Answered 13 Nov 26 (docs/DECISIONS.md): B1A "e-mail" in go.md (fixed: tests 53 pass, 0 fail); B2A short index + archive, draft for PFM approval; B3A build-time insert at each script's next revision; B4A and B5A fixed in the baseline, then synced.

Update 13 Nov 26: B2 merged after PFM approval (1B). Start read 19,742 -> 11,078 tokens (budget 12,000); docs/DECISIONS.md 56,157 -> 21,420 bytes. Tests 53 pass, 0 fail.
