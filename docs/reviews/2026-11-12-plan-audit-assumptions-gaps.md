# Plan audit: assumptions not agreed and engineering gaps (12 Nov 26)

Reviewers: two fresh read-only agents, each with the repo and a narrow brief only (independent review, not self-review). Base: main 3335c04.
The PFM's review doc (decisions go there first): https://claude.ai/artifact/Wdvg7PB2321twKVubQbp2i
Spot-check by the orchestrating agent: 9 of 51 rows checked against the repo (A1, A2, A5, A7, A12, G1, G2, G5, G8); 9 hold. G5 is a risk for r10 and later; r9 works as designed.
Every "Rec" below is an agent recommendation, not a PFM decision.

## Decide first (blocks T02 r10)

| # | Question | Rec |
|---|---|---|
| 1 | One Default environment for every wing: a second wing's solution import can overwrite the first (G1) | B: flows read config from PFM Settings; site URL is the only per-wing binding |
| 2 | 7 of 9 lists editable by all members, Activity Log included (G2, G14) | A: config and log lists Members Read, PFM office Contribute; only flows write the log |
| 3 | r10+ must find lists after the display rename (G5) | A: GetList by URL, check before create |
| 4 | Office mailbox sends need Exchange rights; no fallback (G3) | A: Settings switch, fallback = PFM sends, org box CC and Reply-To |
| 5 | All flows on the PFM's personal connections (G4) | A: connection-swap runbook now + daily health check |
| 6 | Power Apps cannot be shared with a SharePoint group (G8) | A: share with the 2.1A AD group |

## Assumptions without a PFM row or DAFMAN source (24)

| # | Where | Assumption | Sev |
|---|---|---|---|
| A1 | ARCHITECTURE.md:43 | Reminder at due minus 2 workdays; escalate on due date | H |
| A2 | ARCHITECTURE.md:45 | Flow advances the stage by itself when endorsements complete | H |
| A3 | ARCHITECTURE.md:44 | Nonconcur notifies customer and PFM | M |
| A4 | process-model.md:22 | 15-business-day posting goal (Table A5.2 f is the AFIMPT/AFDPO goal) | M |
| A5 | schemas/lists/PFMReviews.json:91 | 180 days "of the response" (7.4.4.3.3 has no start point) | M |
| A6 | process-model.md:17 vs format-rules F-012 | Package flush left (5.1.5) vs DAFMAN-formatted renderer draft | M |
| A7 | process-model.md:77 | PFM confirms every N answer (3.2B: N1, N6, N8, N9 only) | M |
| A8 | schemas/lists/PFMProcessSteps.json:108 | Old 10-step seed; overruled nonconcur gate | M |
| A9 | NEXT_PROMPT.md | Flows before app build order | M |
| A10 | process-model.md:104 | Review e-mails also to the AO | L-M |
| A11 | process-model.md:107 | Auto status report at close; 2.6.8 does not support it | L |
| A12 | list design :12 vs :112 | Waiver Tier has no T-0, rule warns on T-0 | M |
| A13 | DECISIONS.md:46 | Seal px/dpi values (Agent) | M |
| A14 | PFMSettings seed | 30 calendar days guard/reserve seeded while open | L-M |
| A15 | list design :104, :117 | Seed row and column counts disagree | L |
| A16 | sharepoint-lists.md | Stale: item-level off, Endorser text | L |
| A17 | ARCHITECTURE.md:80 | Teams and Approvals assumed | L |
| A18 | DECISIONS.md:65 | Action Status values (Agent) | L |
| A19 | DECISIONS.md:69 | Prefix PFM (Agent within delegation) | L |
| A20 | DECISIONS.md:32 | PFM enters AO by hand (Agent) | L |
| A21 | DECISIONS.md:9 vs :11 | Two 4.6A answers; older not marked replaced | L |
| A22 | guidance/customer-steps.md:72, :86 | Notification promises with no flow rule | L |
| A23 | format-rules.md F-040 | Wing detected by WING/DELTA; misses WG | L |
| A24 | ARCHITECTURE.md:30 | Versioning on everywhere | L |

DAFMAN spot-check: 16 citations; 13 hold, 1 ambiguous (4.5.8.2), 2 do not hold (A4, A11). Legal last at wing level: cite 5.1.8.2, not 5.1.8.1.

## Engineering and operations gaps (27)

H: G1 shared Default environment; G2 member-editable lists; G3 Send As; G4 connection continuity; G5 list lookup after rename; G6 no versioning, changelog, INSTALL.md, rollback or uninstall.
M: G7 run-only connections vs edit-own-rows; G8 app sharing; G9 unindexed filter columns (5,000 threshold); G10 non-delegable search; G11 lookup budget 11 of 12; G12 counter races and trigger loops; G13 no error handling or alerts; G14 editable audit trail; G15 no backup; G16 UTC date shift, time zone, drill weekends; G17 no DLP check, option C premium; G18 no go-live migration of in-flight actions; G19 test lists vs fixed names, no go-live gate; G20 outside endorsers; G21 PFM/alternate role detection.
L: G22 cyber approval at other wings; G23 idle flows turned off; G24 throttling; G25 CUI/PII in reports; G26 mobile; G27 r9 help text.
Details and options per row: the review doc above.

## Cross-site and update channel (answer to the PFM, 12 Nov)

- A canvas app can read lists on any site in the tenant the user can open; per-wing paths need solution environment variables (SharePoint ALM limits; test first).
- Rec: "update available" banner from a central SharePoint Releases list (AppVersion vs newest Version, IfError-guarded); opt-in, PFM-approved copy of config rows; logic changes need a re-import. Rule: keep changeable rules in list rows.
