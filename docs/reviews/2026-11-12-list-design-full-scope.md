# List design for the full DAFMAN scope (proposal, 12 Nov 26)

Status: approved by the PFM on 12 Nov 26 for the next provisioning flow (T02 r10; docs/DECISIONS.md). Every addition cites its row in docs/reviews/2026-11-12-dafman-full-gap-check.md (A = first pass, B/E = second pass) or a finding (R1-R18) in docs/reviews/2026-11-12-independent-review.md. Revised 12 Nov 26 after the independent review and PFM decisions 1A 2A 3B 4A 5A. Revised again 12 Nov 26 after the second independent review (https://claude.ai/artifact/VNBoH8i4SNy7do6py58YNM; PFM 1A-5A): AO email columns, Applies To Level, Delegation Letter Link, Review Needed By, PFM Guidance path columns, view filters, counts.
Rule for the live site: only ADD lists, columns and choice values. Nothing is renamed or deleted, so the 9 lists keep their data. Two property changes: AO on PFM Publications allows multiple values (the AO and at most one alternate; PFM 12 Nov, 2A); PFM Product Index Publication Number enforces unique values (section 3a). Existing values stay. Three view filters change (section 5a).

## 1. New lists (3)

| List | Columns (type) | Why |
|---|---|---|
| PFM Guidance | Title = Heading; Guidance Key (text, unique, indexed); Audience (choice: AO, Any Member, Coordinator, CSS, Certifying Official, Approving Official, PFM); Screen Order (number); Instructions (multi-line); DAFMAN Reference (text); Done When (multi-line); Active (yes/no); Applies To (multi-choice: the Action Type values, plus Help Panel); Process Step (lookup PFM Process Steps, optional) | 12A. House names as on PFM Process Steps and PFM Offices (PFM, 12 Nov; Q12A spelled "DAFMAN Ref" and "Is Active"). Applies To and Process Step hold the screen path, so the app shows only the screens an action needs and the PFM can change the order without an app edit (review finding 14). "Coordinator" is the DAFMAN word for the offices that review (5.1); the live PFM Endorsements columns keep "Endorser" (add-only rule) |
| PFM Recommendations (DAF Form 847) | Title = summary; Direction (choice: Inbound, Outbound); Product (lookup Product Index; Inbound); Target Publication (text: higher-headquarters number and title; Outbound); Tracking Number (text, PFM assigns); Received Date; Originator (person); Paragraph (text); Proposed Change (multi-line); Rationale (multi-line); Emergency (yes/no); Safety (yes/no); Recommendation Status (choice: Received, With OPR, Approved, Disapproved, Incorporated); Disposition (multi-line, required on Disapproved); Disposition Date; Follow-Up Action (lookup PFM Publications); DAF Form 847 Link (URL) | B1 (7.4.5, Attachment 6). Outbound: a wing member recommends a change to a higher-headquarters publication; the initiating level's PFM assigns the tracking number (Table A6.1 Section 3) and the 847 goes up the functional channel (A6.3.1). For ANG the channel is the functional chain to the ANG functional office at NGB (PFM, 12 Nov; R13) |
| PFM Waivers | Title; Product (lookup; the wing publication that contains the waiver); Waived Publication (text: higher-headquarters number); Waived Paragraph (text); Tier (choice: T-1, T-2, T-3, Non-Tiered); Waiver Approver (person); Approved By Delegation (yes/no; ANGMAN 1.7.7); Delegation Letter Link (URL; required when Approved By Delegation = Yes); Approval Date; Waiver End Date (date; Not To Exceed); Renewal Basis (choice: Wing Commander Memorandum, Delegated Commander); Change Of Command Date (date; Delegated Commander only); Renewal Due (date, set by flow); Revalidated By Memorandum Date (date); HHQ OPR Notified Date (date; due Approval Date + 30 days); ANG Waiver Repository Link (URL); Waiver Approval Link (URL); Waiver Status (choice: Active, Renewal Due, Expired, Withdrawn) | Only waivers written into wing publications (DAFMAN 9.5.3; PFM 2A, 12 Nov). The Wing Waiver POC keeps the wing waiver program in the ANG Waiver Repository (ANGMAN 1.7.2, 1.9). Renewal: within 90 days of a Wing Commander change of command one Memorandum for Record revalidates all wing waivers (ANGMAN 1.7.9; PFM 1A, replaces 4A); waivers a delegated squadron commander approved renew 90 days after that commander's change (DAFMAN 9.5.1). A lapsed waiver opens a revise or rescind action on the product (9.5.3). Copy to the higher-headquarters OPR within 30 days (9.6.2) |

## 2. New choice values on existing columns

| List.Column | Add | Why |
|---|---|---|
| PFM Publications.Action Type | Corrective Action; Reissue Guidance Memorandum; Change OPR; Revise | A14, A10, B11, E4. "Revise" is the Table A5.1 form action, used only with Product Type = Form; forms also use New, Rescind, Transfer, Certify Current |
| PFM Endorsements.Coordination Role, PFM Offices.Coordination Role | CIO; PFM | Q6, Q13 (mandatory rows). The privacy official who approves forms with personal data (PAO or PAM, 8.9.1.2) uses the existing value Privacy (R2) |
| PFM Endorsements.Endorsement Status | Not Applicable | A5 (2.8.13: required coordination shown or marked N/A before legal) |
| PFM Activity Log.Event Type | Number Assigned; Notice Sent; Waiver Renewal Due; Recommendation Received | event trail for A4, A16, A17, B1 |

## 3. New columns on existing lists

| List | Column (type) | Why |
|---|---|---|
| PFM Publications | Number Approved (yes/no) | A4 (PFM approves all numbers) |
| | Summary Of Changes (multi-line); Change Rationale (multi-line); Current Version Link (URL); Track Changes Removed (yes/no) | B8, B17 (package gate) |
| | Master DAF Form 673 Link (URL); Open Nonconcurs (number, set by flow); Impasse Memo Link (URL) | A6, B10, PFM 1A |
| | Form Justification, Data Fields Collected, Printing And Distribution (multi-line) | B6 (8.10.1.2). The forms of an action are the Product Index rows whose Prescribing Publication is this product (one link, stored on the form; DECISIONS 2026-11-11). No Prescribed Forms column (R5, R6) |
| | Applies To AFR Unit; Deviates From HHQ; Less Restrictive Than HHQ; Contains Copyright; Prescribes Paper Records; Contains Waiver; Privacy Act Warning Required (yes/no each) | A3, B15, B16, B13, 7.1.4, A17, B12 (1.5.4, T-1; R10) |
| | Agreement Citation (text) | B15 |
| | Information Collection (choice: None, Internal, Public) | B5 |
| | AO Is Contractor (yes/no); Government Decision Maker (person) | B14 |
| | Access Level (choice: Public, Restricted, CUI) | B18 |
| | Effective Date Justification (multi-line) | A9 (future date) |
| | All Comments Adjudicated (yes/no; the AO confirms before Legal, the PFM spot-checks; PFM 3.3A) |
| | Directive Guidance Moved (yes/no); Retained Forms Relinked (yes/no) | Figure A5.1 note, A16 (rescind gates) |
| | Section 508 Checked (yes/no) | B4 |
| | Guidance Memorandum Justification (multi-line) | 5.1.7 (T-1; R9) |
| | Also Certifies Current (yes/no) | 7.5.3 (R11): an IC that also certifies the publication current resets Last Certified Current Date |
| | AO 1 Email; AO 2 Email (text, indexed; a flow writes them from AO) | PFM 3A (12 Nov): a Power Apps filter on a multi-person column is not delegable; the app filters on these text columns |
| | Applies To Level (choice: Wing And Units Below; Wing Staff Only; Group And Units Below; Group Staff Only; Squadron And Units Below; Squadron Staff Only; Flight; Section) | PFM 4A (12 Nov); Table A11.1 item 8 (OI = staff of one function; units below = instruction or manual). Squadron and flight values are by analogy. Sets the type check (N6) and the officials (N11) |
| PFM Endorsements | No Response Explanation (multi-line); Critical Comment (yes/no) | A7, A21 (critical comment forces Nonconcur) |
| PFM Product Index | Edition Date; Locked (yes/no); Form Type (choice: Command or Field, Headquarters Unit, Office, One-Time, Test, Morale, Welfare, and Recreation); Privacy Act Statement Included (yes/no); Information Collection (choice); OMB Number (text); OMB Expiration (date); Markings (choice: None, CUI, Accountable, Safeguarded); Access Level (choice); Section 508 Checked (yes/no); Contains Waiver (yes/no); Adopted Forms (multi-line text: designation, number, title); Implements (text: higher-headquarters publication numbers); Applies To Level (choice, as on PFM Publications) | B2, B3, B5, Table 8.1 and PFM 2A, 8.9.5 (classified left out, PFM 2026-11-11 decision 5), B18, B4, A17, 8.8.2 (R7), A13; Applies To Level copied at posting (PFM 4A) |
| PFM Process Steps | Applies To (multi-choice: the action types); seed = the walkthrough stages 0-12 (13 rows), each with the action types it applies to, from Table A5.1 (docs/dafman-coverage/part-6.md, section "Applies To fill", same stage numbers) | PFM 1A (12 Nov, procedure gaps); PFM 1A (12 Nov, review: one stage table) |
| PFM Offices | Suggest When (multi-line: Table A3.2 trigger questions, seeded from docs/coordination-table-a3-2.md, PFM 3B); PCM (person, optional) | A24, B19 |
| | Org Box Email (text) | PFM 1.3A (12 Nov): stage 0 and S4 e-mail the organization's CSS org box |
| | Level (choice: Wing, Group, Squadron, Flight, Section); Parent Office (lookup PFM Offices); Leader (person: the commander or director); Leader Title (text, for example Commander) | PFM 1.5A, 1.6A (12 Nov): the app names the approving and certifying officials from the scope (5.6.3, 5.7.6.3) and checks who leads an office. Office keeps the office's name; Leader is the person. The PFM fills them once and updates them at each change of leader |
| PFM Endorsements | Transcribed (yes/no); Endorsement Evidence Link (URL) | PFM 1.4A (12 Nov): an answer that came by e-mail is entered by the AO or the PFM, with the e-mail attached (5.1.4.3) |

Lookup and person columns on PFM Publications after this design: 9 (Product, Series, Process Step, OPR, Requester, AO, Certifying Official, Approving Official, Government Decision Maker), 11 with Created By and Modified By. The list view lookup threshold is 12. Flows and the app query explicit column lists. AO holds the AO and at most one alternate (PFM 2A, 12 Nov); a multi-value column still counts once, so the count stays at 11 (R5). AO 1 Email and AO 2 Email are text, so they add no lookup (PFM 3A).
Action and product: Information Collection, Access Level, Section 508 Checked and Contains Waiver are on both lists. The action value is what the action proposes; at posting a flow copies it to the product; after posting the product value is the record (R6).

## 3a. Additions: new-publication path and out-of-cycle review (approved by the PFM, 12 Nov, 3A)

From docs/process-model.md "New publication request" (DAFMAN 3.1) and "Special review out of cycle" (7.4.3, 7.4.4). Lookup and person count on PFM Publications unchanged (11).

| List | Change | Why |
|---|---|---|
| PFM Product Index | Product Status: add value In Development. The PFM creates the product row when it assigns the number (N9), so the Product lookup is set from the request and the number is reserved. "Library - Active" shows only Active rows; three other views get a filter so readers and the record-set views do not show it (section 5a) | 4.3.8 (numbers consecutive; PFM tracks numbers, 2.6.3) |
| PFM Product Index | Publication Number: enforce unique values (indexed). Before the change, T02 r10 counts duplicate and blank values on the live list and reports them instead of failing; blank-value behavior is tested on the test site first | 4.3.2 (one number per product) |
| PFM Reviews | Requesting Official (person); Review Reason (choice: Commander Request, Mission Change, Implemented Publication Change, Law Or Regulation Change, Policy Change, Reorganization, Other); Review Request ID (text, one per request, groups a batch); Review Scope (multi-line); Review Needed By (date, optional: the date the requester needs answers) | Special review out of cycle (process-model S1-S7; 7.4.3 wording). Lookup and person count on PFM Reviews: 3 (+ Created By, Modified By) = 5 |
| PFM Activity Log | Event Type: add Review Requested | Trail for S1 |
| PFM Publications | Need And Authority (multi-line: what it implements, why, risk of not acting); Existing Guidance Checked (yes/no); Implements PD Directly (yes/no) | N3-N5, N7 (3.1.2, 3.1.4, 3.1.8, 1.1.3.6.4) |

## 4. Library 90-161.Z folders (PFM creates by hand)

Seals; Working Files (one subfolder per action); Published (posted publications and forms, read for all members; PFM 3.6B); Record Sets, with Publications and Forms subfolders kept apart (B7, 15A); Delegation Letters (PFM 1.7A, 12 Nov; checked at each change of command). Permissions (PFM batch 2, 12 Nov): each Working Files action folder gets its own permissions from a flow (AO, alternate, the action's coordinators, the PFM office group; 2.3B); Record Sets and Delegation Letters: PFM Office group and co-owners only (2.4A). The PFM Office group is a new SharePoint group with the people who work the PFM org box (3.7B). Published: read for all members, edit for the PFM Office group (3.6B). Site Members = the wing's existing directory group (2.1A); the app is shared with it (2.6A).

## 5. What flows enforce (gates)

- Request: PFM numbers and approves (A4); GM numbers per 4.3.8.2 (new publication: consecutive in the series; amending: parent number + GM number; unchanged on reissue); supplement and OI checks (A11, A12); a GM changes only an instruction, manual or supplement of the wing (7.9.1, Table A11.1 item 7); an IC never changes a GM (7.7.6); an AC changes only office symbols, e-mail addresses and links unless the PFM grants a waiver (7.8.2); an AC is started by the OPR or a PCM (7.8.3).
- Form action: a form change that requires a change to the publication travels with the revised publication (8.10.1, 8.11.3). Prescribing Publication is required for Form Type Command or Field and Headquarters Unit, and for any form that collects personal data or is under the Paperwork Reduction Act (8.2.1, 8.7.4; PFM 2A). Test and One-Time forms get an Expiration Date within 1 year (Table 8.1). A form that collects personal data needs a Privacy row in Concur before approval (8.9.1.2).
- Before Formal Coordination: 673 Section I and blocks 21a/22a, package complete, track changes removed (A6, B8, B17).
- Before Legal: every coordinator row final or Not Applicable, every comment adjudicated (A5, 5.1.8.1). An open nonconcur does not stop Legal or Certification; it shows on the package (Figure A5.1 step 4; PFM 1A). Legal is never Concur—No Response (5.4.3).
- Certification and approval: when coordination is 365 days old or less and the draft has no significant change, the 673 states that no re-coordination is needed (5.1, 2.8.2.2); older coordination asks the AO to re-coordinate. Approval: Open Nonconcurs = 0 or an impasse memo in the record set (B10, 5.5.2; PFM 1A).
- IC or rewrite: active GMs and ACs incorporated (B9). A GM is followed by a new publication, rewrite or IC within 1 year (Table A5.1 note 1). An IC with Also Certifies Current resets the review clock (7.5.3).
- Posting: effective date not backdated (A9), Section 508 checked (B4), new form with its publication, form locked and dated (E2, B2).
- Rescind: directive guidance moved, retained forms relinked, notices (A16). A review with no answer by the due date opens a PFM rescind action (PFM 5A, 12 Nov; 7.4.4.4): 673 to the certifying and approving officials only, no coordination stages (7.11.5.5).
- Renderer (not a list gate): wing ICs use Rule 2 with manual margin bars, no asterisks, no "(Added)" (7.7.5, 7.7.8.5; gap row A23). Forms for internal collections carry an RCS block (A7.10).

## 5a. View changes (filters only; no data changes)

| List | View | Add filter | Why |
|---|---|---|---|
| PFM Product Index | Library - All Including Old | Product Status is not In Development | Readers do not see reserved numbers |
| PFM Product Index | PFM - Not Active | Product Status is not In Development | The view lists record sets due for destruction |
| PFM Product Index | PFM - Review Due | Product Status is not In Development | No review before posting |

## 6. Counts

Recounted 12 Nov 26 (second independent review, finding 11), sections 1-5a.

| Item | Count |
|---|---|
| New lists | 3, with 45 columns (PFM Guidance 10, PFM Recommendations 17, PFM Waivers 18) |
| New columns on existing lists | 67: PFM Publications 36 (section 3: 33; 3a: 3), PFM Product Index 14, PFM Offices 7, PFM Reviews 5, PFM Endorsements 4, PFM Process Steps 1 (batch 1 added 7, 12 Nov) |
| New choice values | 15: Action Type 4; Coordination Role 2 on 2 lists = 4; Endorsement Status 1; Event Type 5 (4 + Review Requested); Product Status 1 (In Development) |
| Property changes | 2: AO allows multiple values; Publication Number unique |
| View filter changes | 3 (section 5a) |
| Lookup and person columns (with Created By and Modified By) | PFM Publications 11, PFM Product Index 7, PFM Offices 6, PFM Reviews 5, PFM Recommendations 5, PFM Waivers 4, PFM Guidance 3; all under the threshold of 12 |
| Seed rows | PFM Offices 22 (Table A3.2); PFM Settings 2 (PFM Office Mailbox; Escalation Weekdays for the org-box notice, 2.5B; values entered by the PFM); PFM Process Steps 13 (stages 0-12); PFM Guidance: the approved screens of docs/guidance/customer-steps.md, after the PFM's content approval |

## 7. Batch 4 additions (PFM, 12 Nov)

| List | Change | Why |
|---|---|---|
| PFM Recommendations | Squadron Concurrence, Group Concurrence, Wing Concurrence (choice each: Concur, Concur With Remarks, Nonconcur); Squadron Concurrence Date, Group Concurrence Date, Wing Concurrence Date | PFM 4.5A; Table A6.1 sections 3-5 (outbound 847s) |
| PFM Offices | Seed 2 more mandatory rows: Privacy (Coordination Role Privacy), Information Collections (Coordination Role Information Collections) | PFM 4.2A; Table A3.1 item 3 |
| PFM Waivers | Flow rule: warn when Tier is T-0, T-1 or T-2 and the Waiver Approver is a wing person (a Leader in PFM Offices) | PFM 4.4A; Table A10.1 |
| PFM Settings | Working File Disposition Rule (the AFRIMS rule the PFM names) | PFM 4.6A |

Testing (PFM 5.7B, 12 Nov): no test site; T02 r10 runs its checks on the live site with lists named with a TEST prefix and removes them afterwards.

Counts after batch 4: PFM Recommendations 23 columns (new lists 51); PFM Settings seed rows 3; PFM Offices seed rows 22 + 2 mandatory. Columns on existing lists unchanged (67).
