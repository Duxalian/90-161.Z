# Sweep decisions for the PFM (13 Nov 26)

Answered 14 Nov 26: S1 = the lists go on a new site, so T02 r10 builds all 12 from scratch (no upgrade flow; the PFM first chose A, then said the site is new); S4 confirm all 33, S5 item 1 A, R09 live. Still open: S2, S3, S5 items 3-15, S6 (AGENTS.md lines, T09 allow entry), S7.

Everything in draft PR rhope-ops/90-161.Z#10 that needs the PFM. Nothing in the PR is live until the PFM approves it. Each "Rec" is Claude's recommendation, not a decision. Answer by number (for example "S1 A, S2 approve, S5 all Rec").

## S1. T02 r10 on the live site (highest impact)

r10 creates 12 lists from scratch, which is right for a new wing. The live site already has the 9 r9 lists, and the provisioning flow fails on lists and fields that exist (docs/power-automate-provisioning.md section 3).

- A. **Rec:** Claude builds an upgrade flow (T02 r11): only the changes since r9 (new lists, new columns, new choice values, AO to multiple people, new views and filters, missing seed rows). Data in the lists stays. About 2-3 h of Claude time; tested on the live site like r9.
- B. Delete the 9 lists and run r10. Loses every row now in them (seeds and any test rows).
- C. Add the 113 columns by hand in List settings. Not practical.

## S2. Names the naming check forced (T02 r10)

tests/check_names.py allows only DAFMAN Attachment 1 abbreviations and title case, so the design's CIO, CSS and ID became "Chief Information Officer", "Command Support Staff" and "Review Request Identifier"; some names changed case (for example "Need and Authority", "Law or Regulation Change"); e-mail columns are "... E-Mail". **Rec:** approve as built.

## S3. Waiver tiers

The design lists T-1, T-2, T-3 and Non-Tiered; the waiver warning rule (4.4A) also names T-0. **Rec:** add T-0 (DAFMAN Attachment 10 defines it).

## S4. DAFMAN coverage gaps (docs/reviews/2026-11-13-coverage-gap-sweep.md)

- 33 rows are "does not apply to an ANG wing" candidates (waivers outside wing publications, AFDPO printing, HQ duties, joint base). **Rec:** confirm all 33 as N/A.
- G1-G8, each with options and a Rec in that file: forms software training, feedback, consolidation, forms and publications libraries, administrative change list, Risk Management Framework, form design waivers, mission directives.
- 1 row is covered now (Table A3.2 item 29); 15 are planned; 3 need new renderer rules; 9 need a flow, column or screen.

## S5. Flow package (flow/solution/README.md "Open design choices", 15 items)

The ones that change behavior most:
- 1. Endorsement routing: A (flow creates rows, Legal after the others), B (app creates all, flow unlocks Legal; new status), C (warn only). **Rec:** A.
- 3. No holiday calendar: 15 business days is built as 21 calendar days. **Rec:** add a PFM Holidays setting later; keep 21 days for the first import.
- 6. Reminder and escalation days are empty variables (no invented values). Need the PFM's numbers.
- 8. Extension Date ignored. **Rec:** use the later of Due Date and Extension Date.
Also note: F03 hard-codes 21/30 days while PFM Settings holds the same values; **Rec:** read PFM Settings (one place per value).

## S6. R09 and its new rules

- R09 goes on the bookmark page only after the PFM's review (PFM, 13 Nov). **Rec:** approve after reading the R09 task in go.md.
- AGENTS.md changed in two places: task scripts use the profile folder (no DODID question; PFM, 13 Nov, R09 scope "d") and the Commands line names the new builders. Confirm.
- T09: the window cannot open e-Publishing for the PFM because the e-Publishing website host is not on the `.pii-guard` allow list (only the PFM adds entries). Option: add it.
- T16 PnP retest: optional step; if a route connects, decision 1B is revisited (PnP could then set list permissions, the logo and r11 directly).

## S7. Validator

F-032 still warns for OPR (3 uses) and ANG (1 use) in the sample; DAFMAN 4.5.9.7.2.5 says such acronyms "should generally" be spelled out. **Rec:** keep these warnings.
