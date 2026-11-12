# List design for the full DAFMAN scope (proposal, 12 Nov 26)

Status: Agent recommendation for PFM review (decision 14A). Nothing is built until the PFM approves. Every addition cites its row in docs/reviews/2026-11-12-dafman-full-gap-check.md (A = first pass, B/E = second pass).
Rule for the live site: only ADD lists, columns and choice values. Nothing is renamed or deleted, so the 9 lists keep their data.

## 1. New lists (3)

| List | Columns (type) | Why |
|---|---|---|
| PFM Guidance | Title = Heading; Guidance Key (text, unique, indexed); Audience (choice: AO, Endorser, CSS, Certifying Official, Approving Official, PFM); Screen Order (number); Instructions (multi-line); DAFMAN Reference (text); Done When (multi-line); Active (yes/no) | 12A |
| PFM Recommendations (DAF Form 847) | Title = summary; Product (lookup Product Index); Tracking Number (text, PFM assigns); Received Date; Originator (person); Paragraph (text); Proposed Change (multi-line); Rationale (multi-line); Emergency (yes/no); Safety (yes/no); Recommendation Status (choice: Received, With OPR, Approved, Disapproved, Incorporated); Disposition (multi-line, required on Disapproved); Disposition Date; Follow-Up Action (lookup PFM Publications); DAF Form 847 Link (URL) | B1 (7.4.5, Attachment 6) |
| PFM Waivers | Title; Product (lookup); Tier (choice T-1, T-2, T-3); Waiver Approver (person); Approval Date; Renewal Due (date, 90 days after a change of command); Waiver Approval Link (URL); Waiver Status (choice: Active, Renewal Due, Expired, Withdrawn) | A17 (9.5.3). The PFM enters the change-of-command date in PFM Settings; a flow sets Renewal Due on every active waiver |

## 2. New choice values on existing columns

| List.Column | Add | Why |
|---|---|---|
| PFM Publications.Action Type | Corrective Action; Reissue Guidance Memorandum; Change OPR; Revise Form | A14, A10, B11, E4 (forms use Product Type = Form with New, Revise Form, Rescind, Transfer) |
| PFM Endorsements.Coordination Role, PFM Offices.Coordination Role | Privacy Act Officer | B3 (PII forms need PAO/PAM approval) |
| PFM Endorsements.Endorsement Status | Not Applicable | A5 (2.8.13: required coordination shown or marked N/A before legal) |
| PFM Activity Log.Event Type | Number Assigned; Notice Sent; Waiver Renewal Due; Recommendation Received | event trail for A4, A16, A17, B1 |

## 3. New columns on existing lists

| List | Column (type) | Why |
|---|---|---|
| PFM Publications | Number Approved (yes/no) | A4 (PFM approves all numbers) |
| | Summary Of Changes (multi-line); Change Rationale (multi-line); Current Version Link (URL); Track Changes Removed (yes/no) | B8, B17 (package gate) |
| | Master DAF Form 673 Link (URL); Open Nonconcurs (number, set by flow); Impasse Memo Link (URL) | A6, B10 |
| | Prescribed Forms (lookup Product Index, multiple); Form Justification, Data Fields Collected, Printing And Distribution (multi-line) | B6 |
| | Applies To AFR Unit; Deviates From HHQ; Less Restrictive Than HHQ; Contains Copyright; Prescribes Paper Records; Contains Waiver (yes/no each) | A3, B15, B16, B13, 7.1.4, A17 |
| | Agreement Citation (text) | B15 |
| | Information Collection (choice: None, Internal, Public) | B5 |
| | AO Is Contractor (yes/no); Government Decision Maker (person) | B14 |
| | Access Level (choice: Public, Restricted, CUI) | B18 |
| | Effective Date Justification (multi-line) | A9 (future date) |
| | Directive Guidance Moved (yes/no); Retained Forms Relinked (yes/no) | Figure A5.1 note, A16 (rescind gates) |
| | Section 508 Checked (yes/no) | B4 |
| PFM Endorsements | No Response Explanation (multi-line); Critical Comment (yes/no) | A7, A21 (critical comment forces Nonconcur) |
| PFM Product Index | Edition Date; Locked (yes/no); Form Type (choice: Permanent, Test, One-Time); Privacy Act Statement Included (yes/no); Information Collection (choice); OMB Number (text); OMB Expiration (date); Markings (choice: None, CUI); Access Level (choice); Section 508 Checked (yes/no); Contains Waiver (yes/no); Adopted Forms (lookup Product Index, multiple); Implements (text: higher-headquarters publication numbers) | B2, B3, B5, E7, E9, B18, B4, A17, 8.12.3, A13 |
| PFM Offices | Suggest When (multi-line: Table A3.2 trigger question); PCM (person, optional) | A24, B19 |

## 4. Library 90-161.Z folders (PFM creates by hand)

Seals; Working Files (one subfolder per action); Record Sets, with Publications and Forms subfolders kept apart (B7, 15A).

## 5. What flows enforce (gates)

Request: PFM numbers and approves (A4); supplement and OI checks (A11, A12). Before Formal Coordination: 673 Section I and blocks 21a/22a, package complete, track changes removed (A6, B8, B17). Before Legal: every row final or Not Applicable (A5). Approval: Open Nonconcurs = 0 or impasse memo (B10). IC or rewrite: active GMs and ACs incorporated (B9). Posting: effective date not backdated (A9), Section 508 checked (B4), new form with its publication, form locked and dated (E2, B2). Rescind: directive guidance moved, retained forms relinked, notices (A16).

## 6. Counts

New lists: 3. New columns: 44 (Publications 27, Endorsements 2, Product Index 13, Offices 2). New choice values: 11.
