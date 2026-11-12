# Working files under AFI 33-322 (12 Nov 26)

Question (PFM, register item 4.6): what is a working file, and what happens to it after posting. Source: AFI 33-322, 23 Mar 2020, incorporating Change 1, 28 Jul 2021 (all 97 pages read; file from the PFM, not committed) and DAFMAN 90-161 7.1-7.2. Analysis by Claude; not a decision until the PFM answers 4.6.

## What AFI 33-322 says

AFI 33-322 never uses the term "working file". It uses "working papers" 4 times (1.3.7.1.1, 4.1.2, 6.1.8.7, glossary "Electronically Stored Information") and "draft" 12 times. The rules that decide the question:

| Rule | Paragraph | Effect on drafts and working papers |
|---|---|---|
| A record is any recorded information made or received for public business and kept as evidence of decisions, procedures or actions; duplicate convenience copies are not records | 1.3, glossary "Records", Attachment 3 | A draft can be a record |
| Drafts can be altered; official records cannot | 1.3 | Drafts are a separate state |
| Non-record material (convenience copies, reference copies) is managed but not scheduled | 1.3.7, glossary "Non-record Material" | Extra copies are non-records |
| Two-part test (printed under the glossary term "Value"): material is a record if (a) it was circulated to others for approval, comment, action or recommendation, and (b) it holds unique information such as substantive annotations or comments | Glossary, "Value" (a), (b) | A draft sent for coordination and returned with comments is a record |
| Destroy draft records as needed | 2.2.4.8 | Uncirculated drafts may be deleted |
| Keep records separate from non-records; mark drafts inside the e-file area, or keep them outside it | 3.4.2, 4.6.1.2, 4.6.2.1 | Drafts and records do not share a folder |
| Do not list draft storage locations on the inventory of records | 4.6.3 | Working Files is not an inventory location |
| In SharePoint, retention starts at each document's date | 6.1.2.4 | Each record set item carries its own date |
| A litigation hold or records freeze covers records, non-records and drafts; deletion stops | 6.1.1.4.3, 9.1.1, 9.1.3 | Any automatic deletion needs a hold check |
| Do not make personal decisions to destroy records | 6.1.1.2 | Only the schedule or a defined rule deletes |

DAFMAN 90-161 7.2.3.5 puts "all documents that show coordination, comments, and other actions" in the publication record set (T-1); 7.2.3.2 the original DAF Form 673; 5.1.5 the original endorsements.

## What that makes of the items in an action's folder

| Item | Status | Where it goes at closeout |
|---|---|---|
| Signed DAF Form 673s, endorsements, CRM with resolutions, impasse memo, delegation letter, the coordination draft as circulated, summary of changes | Record (DAFMAN 7.2.3.2, 7.2.3.5, 5.1.5; AFI two-part test) | Record set of the publication (rule T 33-38 R 07, PFM 2026-11-11) |
| Drafts never sent outside the AO's office; renderer intermediate files (content JSON, draft-mode Word); extra copies | Non-record or draft (AFI 1.3.7, 2.2.4.8) | Deleted when the action closes (posted or cancelled), unless a hold applies |

## Agent recommendation for 4.6 (not a decision)

- Split each action's area in two: records go straight to the action's Record Sets folder through the app (a flow files them, because Record Sets is PFM Office only, 2.4A); Working Files holds drafts only (AFI 3.4.2, 4.6.1.2).
- At closeout a flow deletes the action's Working Files folder, unless PFM Publications "Legal Hold" (yes/no) is set or PFM Settings shows a records freeze (AFI 9.1.3, 6.1.1.4.3).
- The PFM, as base records manager, checks AFRIMS Table 33-38 for any rule written for publication working files; if one exists, it replaces the closeout deletion.
