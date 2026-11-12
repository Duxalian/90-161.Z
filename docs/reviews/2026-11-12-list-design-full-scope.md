# List design for the full DAFMAN scope (proposal, 12 Nov 26)

Status: approved by the PFM on 12 Nov 26 for the next provisioning flow (T02 r10; docs/DECISIONS.md). Every addition cites its row in docs/reviews/2026-11-12-dafman-full-gap-check.md (A = first pass, B/E = second pass) or a finding (R1-R18) in docs/reviews/2026-11-12-independent-review.md. Revised 12 Nov 26 after the independent review and PFM decisions 1A 2A 3B 4A 5A.
Rule for the live site: only ADD lists, columns and choice values. Nothing is renamed or deleted, so the 9 lists keep their data. One property change: AO on PFM Publications allows multiple values (PFM, 12 Nov); existing values stay.

## 1. New lists (3)

| List | Columns (type) | Why |
|---|---|---|
| PFM Guidance | Title = Heading; Guidance Key (text, unique, indexed); Audience (choice: AO, Endorser, CSS, Certifying Official, Approving Official, PFM); Screen Order (number); Instructions (multi-line); DAFMAN Reference (text); Done When (multi-line); Active (yes/no) | 12A. House names as on PFM Process Steps and PFM Offices (PFM, 12 Nov; Q12A spelled "DAFMAN Ref" and "Is Active") |
| PFM Recommendations (DAF Form 847) | Title = summary; Direction (choice: Inbound, Outbound); Product (lookup Product Index; Inbound); Target Publication (text: higher-headquarters number and title; Outbound); Tracking Number (text, PFM assigns); Received Date; Originator (person); Paragraph (text); Proposed Change (multi-line); Rationale (multi-line); Emergency (yes/no); Safety (yes/no); Recommendation Status (choice: Received, With OPR, Approved, Disapproved, Incorporated); Disposition (multi-line, required on Disapproved); Disposition Date; Follow-Up Action (lookup PFM Publications); DAF Form 847 Link (URL) | B1 (7.4.5, Attachment 6). Outbound: a wing member recommends a change to a higher-headquarters publication; the initiating level's PFM assigns the tracking number (Table A6.1 Section 3) and the 847 goes up the functional channel (A6.3.1). For ANG the channel is the functional chain to the ANG functional office at NGB (PFM, 12 Nov; R13) |
| PFM Waivers | Title; Product (lookup); Tier (choice: T-1, T-2, T-3, Non-Tiered); Waiver Approver (person); Approval Date; Change Of Command Date (date); Renewal Due (date = Change Of Command Date + 90 days, set by flow); HHQ OPR Notified Date (date); Waiver Approval Link (URL); Waiver Status (choice: Active, Renewal Due, Expired, Withdrawn) | A17 (9.5.3); 9.5.1-9.5.2 (tier and non-tiered periods); 9.6.2 (copy to the higher-headquarters OPR within 30 days, T-1); PFM 4A (date per waiver). Before build: read the waiver chapter of ANGMAN 90-161 (ref/angman90-161.pdf; DECISIONS 2026-11-11 Rec) |

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
| | Directive Guidance Moved (yes/no); Retained Forms Relinked (yes/no) | Figure A5.1 note, A16 (rescind gates) |
| | Section 508 Checked (yes/no) | B4 |
| | Guidance Memorandum Justification (multi-line) | 5.1.7 (T-1; R9) |
| | Also Certifies Current (yes/no) | 7.5.3 (R11): an IC that also certifies the publication current resets Last Certified Current Date |
| PFM Endorsements | No Response Explanation (multi-line); Critical Comment (yes/no) | A7, A21 (critical comment forces Nonconcur) |
| PFM Product Index | Edition Date; Locked (yes/no); Form Type (choice: Command or Field, Headquarters Unit, Office, One-Time, Test, Morale, Welfare, and Recreation); Privacy Act Statement Included (yes/no); Information Collection (choice); OMB Number (text); OMB Expiration (date); Markings (choice: None, CUI, Accountable, Safeguarded); Access Level (choice); Section 508 Checked (yes/no); Contains Waiver (yes/no); Adopted Forms (multi-line text: designation, number, title); Implements (text: higher-headquarters publication numbers) | B2, B3, B5, Table 8.1 and PFM 2A, 8.9.5 (classified left out, PFM 2026-11-11 decision 5), B18, B4, A17, 8.8.2 (R7), A13 |
| PFM Offices | Suggest When (multi-line: Table A3.2 trigger questions, seeded from docs/coordination-table-a3-2.md, PFM 3B); PCM (person, optional) | A24, B19 |

Lookup and person columns on PFM Publications after this design: 9 (Product, Series, Process Step, OPR, Requester, AO, Certifying Official, Approving Official, Government Decision Maker), 11 with Created By and Modified By. The list view lookup threshold is 12. Flows and the app query explicit column lists. AO allows multiple people and the app stops at 2 (Q1; PFM, 12 Nov); a multi-value column still counts once, so the count stays at 11 (R5).
Action and product: Information Collection, Access Level, Section 508 Checked and Contains Waiver are on both lists. The action value is what the action proposes; at posting a flow copies it to the product; after posting the product value is the record (R6).

## 4. Library 90-161.Z folders (PFM creates by hand)

Seals; Working Files (one subfolder per action); Record Sets, with Publications and Forms subfolders kept apart (B7, 15A).

## 5. What flows enforce (gates)

- Request: PFM numbers and approves (A4); GM numbers per 4.3.8.2 (new publication: consecutive in the series; amending: parent number + GM number; unchanged on reissue); supplement and OI checks (A11, A12); a GM changes only an instruction, manual or supplement of the wing (7.9.1, Table A11.1 item 7); an IC never changes a GM (7.7.6); an AC changes only office symbols, e-mail addresses and links unless the PFM grants a waiver (7.8.2); an AC is started by the OPR or a PCM (7.8.3).
- Form action: a form change that requires a change to the publication travels with the revised publication (8.10.1, 8.11.3). Prescribing Publication is required for Form Type Command or Field and Headquarters Unit, and for any form that collects personal data or is under the Paperwork Reduction Act (8.2.1, 8.7.4; PFM 2A). Test and One-Time forms get an Expiration Date within 1 year (Table 8.1). A form that collects personal data needs a Privacy row in Concur before approval (8.9.1.2).
- Before Formal Coordination: 673 Section I and blocks 21a/22a, package complete, track changes removed (A6, B8, B17).
- Before Legal: every coordinator row final or Not Applicable, every comment adjudicated (A5, 5.1.8.1). An open nonconcur does not stop Legal or Certification; it shows on the package (Figure A5.1 step 4; PFM 1A). Legal is never Concur—No Response (5.4.3).
- Certification and approval: when coordination is 365 days old or less and the draft has no significant change, the 673 states that no re-coordination is needed (5.1, 2.8.2.2); older coordination asks the AO to re-coordinate. Approval: Open Nonconcurs = 0 or an impasse memo in the record set (B10, 5.5.2; PFM 1A).
- IC or rewrite: active GMs and ACs incorporated (B9). A GM is followed by a new publication, rewrite or IC within 1 year (Table A5.1 note 1). An IC with Also Certifies Current resets the review clock (7.5.3).
- Posting: effective date not backdated (A9), Section 508 checked (B4), new form with its publication, form locked and dated (E2, B2).
- Rescind: directive guidance moved, retained forms relinked, notices (A16). A rescind that follows a "No Response" review is the PFM rescission: 673 to the certifying and approving officials only, no coordination stages (7.11.5.5, 7.4.4.4).
- Renderer (not a list gate): wing ICs use Rule 2 with manual margin bars, no asterisks, no "(Added)" (7.7.5, 7.7.8.5; gap row A23). Forms for internal collections carry an RCS block (A7.10).

## 6. Counts

New lists: 3. New columns: 46 (Publications 29, Endorsements 2, Product Index 13, Offices 2). New choice values: 13 (Action Type 4; Coordination Role 2 on 2 lists = 4; Endorsement Status 1; Event Type 4). Seed rows: 22 PFM Offices rows from Table A3.2.
