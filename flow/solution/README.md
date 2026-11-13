# 90-161.Z flows: draft solution (r1)

DRAFT. Not imported until the PFM reviews it (PFM 5.6A: solution-aware flows). Source: `flow/solution/defs/*.json`. Build: `python3 scripts/build_flow_solution.py` writes `90161Z-flows-solution-r1.zip` (never hand-edit it); `--check` compares. Check: `python3 tests/check_flow_solution.py`.

Solution: unmanaged, unique name `PFM90161Z`, version 1.0.0.1, publisher prefix `pfm`. Connection references: SharePoint and Office 365 Outlook (pick your own connections at import). Operation IDs (`GetOnUpdatedItems`, `GetItems`, `GetItem`, `PostItem`, `PatchItem`, `SendEmailV2`) and the solution XML layout are written from memory of Microsoft's formats; no import has been tried. Expect fixes after the first import.

## Environment variables (type Text, so no site address is in the repo)

| Schema name | Meaning | Default in the zip |
|---|---|---|
| pfm_SiteUrl | SharePoint site address | empty: set at import |
| pfm_ListPublications, pfm_ListActivityLog, pfm_ListReviews, pfm_ListEndorsements, pfm_ListProductIndex, pfm_ListProcessSteps | List names | the list titles in schemas/lists (for example `PFM Publications`) |
| pfm_ReminderLeadDays | F03: days before the suspense for the advance reminder | empty: the PFM sets it |
| pfm_EscalationLagDays | F03: days after the suspense for the escalation | empty: the PFM sets it |

## Flows

| Flow | What it does | DAFMAN 90-161 | Trigger | Reads | Writes |
|---|---|---|---|---|---|
| F01 Activity Log | Logs a row when a Publications row is opened, or when Action Type, Process Step or Action Status differs from the last logged state (a note edit logs nothing) | none (PFM design) | SharePoint "When an item is created or modified" on PFM Publications, one at a time | Publications: Title, ActionType, ProcessStep, ActionStatus, Editor; Activity Log: Publication, EventType, EventDetails | Activity Log: Title, Publication, EventType (Status Changed), EventBy, EventDetails |
| F02 Next Review Due | Next Review Due = 4 years after the later of Effective Date and Certified Current Date; opens a Periodic Reviews row from 6 months before it, if no Periodic review is open or opened in the current cycle | 7.4.2, 7.4.4 | Recurrence, weekdays 07:00 Central | Product Index (Active): EffectiveDate, CertifiedCurrentDate, NextReviewDue, PublicationNumber; Reviews: Product, ReviewType, OPRResponse, ReviewOpened | Product Index: NextReviewDue; Reviews: Title, Product, ReviewType, ReviewOpened, OPRResponseDue (opened + 30 days, as the Reviews schema says) |
| F03 Suspense reminders | Sets a default suspense on open endorsement rows without one (15 business days = 21 calendar days; 30 calendar days for Guard or Reserve Applicability rows); sends one reminder, warning or escalation e-mail per row and tier. Escalation copies the AO and the Requester. Legal is never offered "Concur - No Response" | 5.2, 5.2.1, 5.2.2, 5.4.3, 5.4.3.2 | Recurrence, weekdays 07:00 Central (Windows time zone "Central Standard Time", which follows daylight saving time) | Endorsements: EndorsementStatus, DueDate, CoordinationStage, CoordinationRole, Endorser, Publication; Publications: AO, Requester; Activity Log: Title | Endorsements: DueDate; Activity Log: Title, Publication, EventType (Reminder Sent), EventDetails; e-mail via Office 365 Outlook "Send an email (V2)" |
| F04 Status report | E-mails an HTML table of PFM Publications actions, one table per Process Step in step order | 2.6.8; DECISIONS 2026-11-11 | Manual button; asks for the recipient e-mail | Publications; Process Steps | Activity Log: EventType Status Report E-Mailed; e-mail |

Tiers in F03 (days relative to the suspense): Escalation at or after pfm_EscalationLagDays past; Warning from the suspense day; Reminder from pfm_ReminderLeadDays before. Each tier is sent once per row (a Reminder Sent row in the Activity Log is the memory). The flow never changes an Endorsement Status.

Why F02 uses a recurrence: the 6-month review task opens on a date, not on an edit, so a daily check serves both the date calculation and the task. An item trigger on Product Index would also need a timer. The same weekday 07:00 schedule as F03 is reused (open choice 7).

## Not built: endorsement routing (Legal last, stage gating)

Candidates (open choice 1):
- A. Flow on Publications ProcessStep change: when the step moves to Formal Coordination, create Endorsements rows from PFM Offices (MandatoryCoordinator, IsActive); when all non-Legal rows have a response and no Nonconcur is open, create the Legal rows (CoordinateLast) and move the step. Pro: one place, matches 5.1.8.2. Con: the flow moves the process step, which the PFM may want to do by hand.
- B. Power Apps creates all rows at once; a flow only hides or unlocks Legal rows (a status such as "Waiting" is needed on Endorsements, which has no such column). Pro: simple flow. Con: needs a new choice value and the app to enforce the order.
- C. Flow only warns: it lets all rows run, and e-mails the PFM when Legal responds before the others. Pro: no schema change. Con: does not enforce 5.1.8.2.

## Open design choices

1. Endorsement routing: A, B or C above.
2. Polling interval of the F01 trigger (draft: 1 minute) and whether F01 should log every edit instead of state changes.
3. Suspense: no business-day calendar or holiday list exists in the repo, so 15 business days = 21 calendar days (weekends only). Options: keep; add a holiday list in PFM Settings; the PFM sets every DueDate by hand.
4. Suspense start: the draft starts it on the first weekday run after the row exists. Options: start when the step moves to Formal Coordination (needs routing); use the row's Created date. Legal rows get no default suspense (their start depends on routing; open choice 1). Privacy Review rows do get one.
5. 5.2.2 (30 calendar days) is applied to the Guard Applicability and Reserve Applicability roles only; the process model says whether it covers wing-to-unit coordination is open (gap check).
6. Reminder thresholds (pfm_ReminderLeadDays, pfm_EscalationLagDays) have no value in the repo; calendar days vs weekdays; who is copied on escalation (draft: AO and Requester; the PFM is not copied); sending from the running user's mailbox vs a shared mailbox (Outlook "Send an email from a shared mailbox (V2)" needs Send As rights; DECISIONS: fallback required for wings without it).
7. Run time of F02 (draft: same as F03) and whether Date columns are date-only (the flows read the first 10 characters; a date-time column in Central could shift a day).
8. An approved extension (5.2.1): F03 ignores ExtensionDate. Options: use the later of DueDate and ExtensionDate; add an "extension approved" flag.
9. "Open action" for F04 and for stage counts: PFM Publications has no closed flag, so F04 lists every row. Options: exclude rows at the last step; add a closed status or date.
10. F04 recipient: typed at run time (draft). Option: the person who runs it (needs the Office 365 Users connector, "Get my profile (V2)").
11. List names: titles (draft) or list GUIDs in the environment variables. GUIDs are safer if a list is renamed.
12. F02 also skips opening a second Periodic review when one was opened in the current cycle and already answered; the brief says only "if none open".
13. E-mail text has no link to the item (the list URL names are not in the repo). Option: add a pfm_ list-URL variable.
14. The publisher option value prefix (random, derived from the name) and the publisher name `pfm90161z` are placeholders; the PFM may set a real one before import.
15. Solution XML, operation IDs and the `Publication/Id eq N` filter style are unverified until a first import (see the top of this file).
