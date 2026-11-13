# DAFMAN 90-161 coverage map (12 Nov 26)

Every paragraph, subparagraph, table item, note and rule-setting glossary term of DAFMAN 90-161 (ref/dafman90-161.txt, all 8,146 lines), plus the waiver rules of ANGMAN 90-161, mapped to the plan. Each row says whether the rule applies to an ANG wing and where the plan covers it. The PFM asked for "no stone left unturned" (12 Nov 26).

## Files

| Part | DAFMAN lines | Content | Rows |
|---|---|---|---|
| [part-1.md](part-1.md) | 1-1394 | Front matter, Ch 1 overview, Ch 2 roles | 286 |
| [part-2.md](part-2.md) | 1395-2698 | Ch 3 process overview, Ch 4 content and format | 326 |
| [part-3.md](part-3.md) | 2699-3719 | Ch 5 coordination, Ch 6 delivery, Ch 7 management | 288 |
| [part-4.md](part-4.md) | 3720-4773 + ANGMAN 90-161 | Ch 8 forms, Ch 9 waivers, Ch 10 printing, Att 1 references | 217 |
| [part-5.md](part-5.md) | 4774-6714 | Glossary terms, Att 2 series, Att 3 coordinators, Att 4 citations | 114 |
| [part-6.md](part-6.md) | 6715-8146 | Att 5 processing guides (Table A5.1 matrix), Att 6 DAF Form 847, Att 7 form design, Att 10 tiers, Att 11 publication types, Att 12 CRM, Att 13 accounts | 177 |

Columns in each part: Para | Line | Requirement | Tier | Actor | Applies to ANG wing | Covered by | Status. Each part ends with a "Gaps" section (severity and suggested fix). Plan line numbers in "Covered by" refer to commit 5dd9acd; later edits move some lines.

## Counts (1,408 rows)

| Status | Rows | Meaning |
|---|---|---|
| Covered | 383 | The plan implements it (approved design counts; most of it is not built yet) |
| N/A | 314 | Does not apply to an ANG wing (reason in the row) |
| Renderer | 285 | Format or content rule for the renderer: 178 have a rule or code, 107 are "Renderer gap" (37 of them form design, Attachment 7) |
| Info | 201 | Definition or explanation, no requirement |
| Partial | 152 | Some of it is covered |
| Gap | 73 | Applies, nothing covers it |

Recounted 12 Nov 26 after the second independent review: 7.2.3.7 Covered to Partial; ANGMAN 1.7.9 Partial to Covered (PFM 1A); 8.8.6 and ANGMAN 1.7.2 Gap to N/A (PFM 4B, 2A).

## How it was checked

- 6 agents (standard tier) each read one line range in full and the plan documents. Agent findings are not verified until the checks below.
- Mechanical check (all 1,408 rows): every row with a paragraph number was matched to its cited DAFMAN line. 36 rows cite a later sentence inside the paragraph; none cites a wrong paragraph. 50 numbered items are not rows of their own: section headings, the sample text inside Figure 7.1, and the online-ordering steps of Attachments 8-9 (grouped, N/A).
- Claude read the DAFMAN text for every high and medium gap named in the summary below, and a random sample of 70 Covered and N/A rows (seed 7): 69 hold, 1 is doubtful (3.4.1.3: "the ANG publication governs" during a conflict; written for NGB-level ANG publications, but a wing could read it as its own).
- The 4 errors found in the Table A3.2 seed are fixed (commit 6570315). PFM Series matches Table A2.1 (39 of 39).
- Second independent review (12 Nov 26, https://claude.ai/artifact/VNBoH8i4SNy7do6py58YNM): 54 rows sampled (Python random seed 11, 9 per part: 24 N/A, 24 Covered, 6 Partial or Info): 53 hold; 7.2.3.7 changed to Partial. Row and status counts matched the table above.

## Gaps by theme (high and medium; low ones are in each part's Gaps section)

| # | Theme | Rows (part: para) | Sev | Status |
|---|---|---|---|---|
| T1 | Action paths from Table A5.1 ("Applies To" on PFM Process Steps) | 6: Table A5.1 rows | high | Decided (PFM 1A, 12 Nov); in the list design; matrix in part-6 |
| T2 | ANGMAN 1.7.9: one wing memorandum revalidates all waivers within 90 days of a Wing Commander change of command | 4: ANGMAN 1.7.9 | high | Decided (PFM 1A, 12 Nov; replaces 4A); in the list design (PFM Waivers) |
| T3 | Waiver scope: ANGMAN gives the wing waiver program to a Wing Waiver POC and the ANG Waiver Repository (DAF Form 679); PFM Waivers would copy it | 4: ANGMAN 1, 1.7.2-1.7.7, 1.9, 2; 9.2-9.6 | medium | Decided (PFM 2A, 12 Nov): PFM Waivers tracks only waivers written into wing publications |
| T4 | Posting duties: notice to OPR and AO when posted and effective; GM posted "on top" of the publication it amends; remove expired and obsolete products and links from the wing site; GM expiry makes its forms obsolete; close the action | 1: 2.6.9; 3: 6.1.4, 6.6.2, 7.9.3.3, 7.11.1, 7.11.7.3; 6: Fig A5.1 step 6 | medium | Flow rules (docs/flow-rules.md, PFM 2A; not written yet) |
| T5 | Record-set contents checklist (originals of endorsements, shared 673 copy, SSN justification letter, waivers, reviews) | 3: 5.1.5, 7.2.3-7.2.3.8; 4: 8.9.1.2 | medium | List design or flow rules |
| T6 | Supplement and implementation rules: no supplement to a DoD issuance; new departmental guidance makes a wing instruction revise or rescind; references to obsolete forms | 1: 1.1.3.5.1, 1.1.3.6.4; 4: 8.12.3 | medium | 1.1.3.5.1 and 1.1.3.6.4: in process-model N4, N5. 8.12.3 (remove references to obsolete forms from active publications): open, needs a flow rule (docs/flow-rules.md) |
| T7 | DAF Form 847 levels: squadron, group, wing concurrence (Concur, Concur With Remarks, Nonconcur, returned) and a notice to the originator at each level | 6: Table A6.1 Sec 3-5, A6.3.5 | medium | List design change |
| T8 | Systems that copy a form's fields (the app and lists hold DAF Form 673, 399, 847, 679 data) need the written waiver of the OPR of the form's prescribing publication | 4: 8.8.6 | medium | Decided (PFM 4B, 12 Nov): does not apply; rows now N/A |
| T9 | Renderer: supplement mode ("(Added)", standalone added material), GM memorandum mode, "Corrective Actions applied on", "Certified Current on", copyright lines, AFR applicability statements, citation rules (Table A4.1), a validator rule against asterisks in wing ICs | 1: 1.5.6.2-3, 1.6.3; 2: 4.7.3, 4.8; 3: 6.3.2-3, 7.5.2, 7.7.8.5; 5: Table A4.1 | medium | Renderer backlog |
| T10 | Forms: no form design rule catalog (Attachment 7, 37 rows), no form number gate, no form test step | 6: A7.x, A7.6.2.3, A7.16 | medium | Checklist for the PFM (forms are built in the forms designer, 8.6) |
| T11 | Open: 5.2.2 (30 calendar days for wing-to-unit applicability); disposition rule for working files | 1: front matter; 3: 5.2.2 | medium | PFM decision (already open) |
| T12 | New publication when none exists; commander or other out-of-cycle special review | process-model sections added 12 Nov | - | Added on PFM request (12 Nov); list design section 3a approved (PFM 3A) |
| T13 | Found by the second independent review: (a) Table A3.1 item 3 also names the privacy official and the Federal Register and information-collection reviews as mandatory command or field coordinators (5: Table A3.1 item 3); (b) no check of the waiver approver against Table A10.1 for T-1 and T-2 (6: Gaps); (c) the fixed waiver statement of 4.5.5.11 says a tier number follows each compliance statement, while F-040 removes tier marks from wing statements (2: Observation 3); (d) joint base rows N/A while part-5 asks the PFM to confirm (1: 1.1.3.3; confirmed not a joint base, PFM 12 Nov) | 2, 5, 6 | medium | PFM decisions (assumption register, 12 Nov) |
