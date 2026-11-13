# PII-guard findings in main history (12 Nov 26)

Found when main was pushed to gh-pages (range origin/gh-pages..main, 87 commits). Current tree: `pii_guard.py --all` PASS, 0 findings in 111 files. All findings are in history only. Names are not repeated here.

| # | Commit | Where | Finding | Real or false |
|---|---|---|---|---|
| 1-3 | 4a1f296 (2026-11-11) | scripts/sync_baseline.py, 3 added lines | The owner's first name as the baseline default | Real (first name only). Replaced in a later commit by the role word "the owner". |
| 4 | 58b01d0 (2026-11-11) | commit message, line 5 | The same first name, in the sentence that explains its removal | Real (first name only) |
| 5 | 85a42ac (2026-11-11) | AGENTS.md | the guard's military-domain pattern on a phrase about the mail filter | False: no address, no person |

Removing 1-4 needs a history rewrite and force-push, which AGENTS.md "Git safety" forbids and the pre-push hook blocks. Branches cc/columns-r5, cc/naming, cc/r6 and any clone or fork also hold the commits.

Workaround in use: gh-pages gets one commit that copies index.html from main (f9a4f60), so the push range holds no old commits.
