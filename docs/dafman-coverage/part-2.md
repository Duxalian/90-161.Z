# Part 2: lines 1395-2698

Range: ref/dafman90-161.txt lines 1395-2698 (Chapter 3 Process Overview; Chapter 4 Developing Publication Content and Numbering). Read in full by the author of this part.

Legend for the Covered-by column (line numbers are in the repo files as of 12 Nov 26):
PM = docs/process-model.md. LD = docs/reviews/2026-11-12-list-design-full-scope.md (s1 new lists, s2 choices, s3 columns, s4 library, s5 gates). GAP = docs/reviews/2026-11-12-dafman-full-gap-check.md (row id). IR = docs/reviews/2026-11-12-independent-review.md (finding number). DEC = docs/DECISIONS.md (date, line). ARCH = docs/ARCHITECTURE.md. SCH = schemas/lists/<List>.json. PUB = schemas/publication.schema.json. format-rules = docs/format-rules.md (F-, W-, L-, S- ids). PC = scripts/gov/Publication.Common.ps1, NP = scripts/gov/New-Publication.ps1, TP = scripts/gov/Test-Publication.ps1. NEXT_PROMPT = docs/NEXT_PROMPT.md.
Status Renderer = format or content rule that belongs to the document renderer; Covered by names the format-rules ID, or says "Renderer gap" where no rule or code covers it.

| Para | Line | Requirement (own words, max 25 words) | Tier | Actor | Applies to ANG wing | Covered by | Status |
|---|---|---|---|---|---|---|---|
| 3.1 | 1399 | Before creating, updating or rescinding a publication the OPR first does the actions in 3.1.1-3.1.8. | - | OPR | Yes | PM:10 (stage 1 Preparation); PFMProcessSteps seed step 1 | Covered |
| 3.1.1 | 1402 | Decide directive or non-directive; never put directive guidance from a rescinded publication into a non-directive one. | - | OPR | Yes | PM:10 ("directive or not"); DEC 2026-11-11 directive-only row (line 44); LD s3 Directive Guidance Moved; LD s5 Rescind | Covered |
| 3.1.2 | 1406 | Decide where new or rescinded guidance belongs; research existing publications for similar subjects to avoid duplicate or conflicting products. | - | OPR | Partial (wing PI, not e-Publishing) | PM:10 ("existing pubs"); LD s3 Directive Guidance Moved (rescind side). No Product Index subject search or duplicate check | Partial |
| 3.1.3 | 1413 | Review record sets of earlier guidance to find SMEs and coordinators and past issues; record set is in OPR or program manager files. | - | OPR | Yes | PM:10 ("prior record set"); DEC 2026-11-12 Q15A (line 18, record sets central in library 90-161.Z); SCH PFMProductIndex.PublicationRecordSetLink | Covered |
| 3.1.4 | 1417 | Contact the PCM for required coordinators, tell the PCM of the proposed action and state the impact or risk of not acting. | - | OPR | Yes | PM:10 ("contact PCM/PFM"); LD s3 PFM Offices PCM (optional person). Impact or risk statement not recorded | Partial |
| 3.1.5 | 1420 | Notify the supporting PFM of the proposed publication or form action. | - | OPR | Yes | PM:10; PM:54 (request is made to the PFM in the app); DEC 2026-11-12 Q5A (line 24) | Covered |
| 3.1.6 | 1421 | Review the DAFMAN for publication or form type, format, coordination and maintenance rules. | - | OPR | Yes | LD s1 PFM Guidance; DEC 2026-11-11 app replaces checklist, AO guide, template (line 81); DEC 2026-11-12 Q12A (line 15) | Covered |
| 3.1.7 | 1424 | Contact the supporting PFM or AFDPO for formatting and processing help; templates are on the AFIMPT website. | - | OPR | Partial (PFM only; no AFDPO/AFIMPT) | DEC 2026-11-12 Q2A (line 23, PFM office runs renderer); DEC 2026-11-11 app replaces template (line 81); ARCH:76 | Covered |
| 3.1.8 | 1426 | Identify guidance and responsibilities to implement from higher authority; for a rescission decide where the current guidance goes. | - | OPR | Yes | LD s3 Directive Guidance Moved (rescind side); PM:10. Higher-authority review is not recorded | Partial |
| 3.2 | 1432 | Drafting builds or changes the publication or form and gathers SME inputs; the OPR does 3.2.1-3.2.4 before formal coordination. | - | OPR | Yes | PM:11 (stage 2 Drafting, 3.2, 4.2.2.1); Target 60 business days | Covered |
| 3.2.1 | 1436 | Obtain inputs from all SMEs. | - | OPR | Yes | PM:11 (stage 2 "Drafting with SMEs") | Covered |
| 3.2.2 | 1440 | Give all relevant information in new drafts; give only necessary updates in revised publications. | - | OPR | Yes | LD s3 PFM Publications Summary Of Changes, Change Rationale (B8); no content check | Partial |
| 3.2.3 | 1442 | Incorporate changes made in other publications, such as organization symbols, office realignments and program names. | - | OPR | Yes | PM:21 (Administrative Change variant, 7.8.10); no trigger when PFM Offices or a parent changes. GAP A13 covers parent change only for special review | Partial |
| 3.2.4 | 1445 | Regularly review publications for administrative changes (symbols, realignment, OPR) and re-read the DAFMAN for type, format and coordination rules. | - | OPR | Yes | PM:21 (Administrative Change); SCH PFMReviews (periodic review, 7.4.2); LD s2 Action Type Change OPR | Partial |
| 3.3 | 1449 | HQ DAF PCMs and OPRs staff packages in ETMS2 (HOI 33-3); ETMS2 is optional for collaboration before formal coordination. | - | PCM | No (HQ DAF ETMS2 only) | DEC 2026-11-10 "90-161.Z is the system of record (no TMT)" (line 107); PM:12 stage 3 uses 3.3 for optional pre-coordination | N/A |
| 3.3 Note | 1456 | ETMS2 is not an official record set for publications. | - | HQ DAF | No (HQ DAF ETMS2 only) | DEC 2026-11-12 Q15A (line 18): wing record sets in library 90-161.Z | N/A |
| 3.3.1 | 1458 | Select the priority level in the ETMS2 tasker. | - | OPR | No (ETMS2 field) | - | N/A |
| 3.3.2 | 1459 | Select AF Publications or AF Forms as the ETMS2 category. | - | OPR | No (ETMS2 field) | - | N/A |
| 3.3.3 | 1461 | Select the action being taken (Coord, Sign, Approve) in ETMS2. | - | OPR | No (ETMS2 field) | - | N/A |
| 3.4 | 1463 | Coordinate with all appropriate offices; Legal is obtained separately after all other coordination; use Tables A3.1 and A3.2. | - | OPR | Yes | PM:14-15 (stages 5, 6); DEC 2026-11-11 coordination order (line 43); docs/coordination-table-a3-2.md; PM:44 | Covered |
| 3.4.1 | 1467 | Heading: coordinating departmental, command and field publications with the ANG. | - | OPR | No (HQ DAF/MAJCOM to NGB) | - | N/A |
| 3.4.1.1 | 1469 | OPRs send all new or rewritten departmental publications to ANG workflow before publishing. | - | OPR | No (departmental OPR only) | - | N/A |
| 3.4.1.1.1 | 1471 | NGB/CF (ANG 2-Ltr) reviews and approves ANG publications; Chief NGB reviews InterService publications. | - | NGB/CF | No (NGB level) | - | N/A |
| 3.4.1.1.2 | 1479 | Submit to ANG workflow; if no response by the 15-business-day suspense (AF/JA excepted) the OPR may mark Concur - No Response. | - | OPR | No (departmental submission to NGB; general rule is 5.4.3) | General Concur-No Response rule: PM:34, PM:56, PM:27; Legal never Concur-No Response (LD s5) | N/A |
| 3.4.1.2 | 1488 | Departmental OPR states ANG applicability in the opening paragraph; NGB/CF concurs or supplies the statement and gives exception justification. | - | OPR | No (departmental OPR/NGB-CF) | Wing applicability statement itself: FR F-025 | N/A |
| 3.4.1.3 | 1500 | If an ANG publication and a departmental or MAJCOM publication conflict, the ANG publication governs until the conflict is resolved. | - | NGB | No (NGB/MAJCOM level) | - | N/A |
| 3.4.1.4 | 1504 | ANG may publish a separate publication for many exceptions; ANG supplements use the parent's number. | - | NGB | No (NGB level; wing supplements use 4.3.8.1) | Wing supplement numbering: PM:54 | N/A |
| 3.4.2 | 1508 | Coordination of departmental and MAJCOM publications with the Civil Air Patrol follows the normal chain of command. | - | OPR | No (departmental/MAJCOM OPR) | - | N/A |
| 3.5 | 1515 | Heading: Air/Space Force Service Authority and Certification. | - | - | - | - | Info |
| 3.5.1 | 1516 | Service Authority is the Air Staff or Space Staff 2-Ltr/L2 (policy) or 3-Ltr/L3 (guidance) giving coordination for their Service. | - | HQ DAF | No (HQ DAF only) | - | N/A |
| 3.5.2 | 1524 | Certifying authority is at the issuing level and certifies need, currency of information, DAF applicability and propriety of content. | - | certifier | Yes | PM:16 (stage 7); PM:57 (certifier one level above OPR); SCH PFMPublications.CertifyingOfficial, CertifiedDate | Covered |
| 3.6 | 1528 | Approving authority is a senior leader at the issuing level; SecAF approves policy publications. | - | approver | Partial (SecAF part is HQ DAF) | PM:17 (stage 8); SCH PFMPublications.ApprovingOfficial, ApprovedDate, DelegationLetterLink | Covered |
| 3.7.1 | 1533 | E-Publishing hosts publications issued at wing, base, delta and above, but does not host ANG wing and subunit publications. | - | AFDPO | No (ANG wing excepted, 3.7.1) | ARCH:76; DEC 2026-11-10 ANG wing posts on own site (line 103) | Info |
| 3.7.1.1 | 1540 | E-Publishing is a public site for unclassified, unrestricted content; restricted products show only unclassified details. | - | AFDPO | No (e-Publishing only) | - | N/A |
| 3.7.1.2 | 1545 | Products at and above wing/base/delta (excluding ANG wings and subunits) are listed on e-Publishing; AFDPO requires submissions per this manual. | - | AFDPO | No (ANG wing excepted, 3.7.1.2) | ARCH:76; DEC 2026-11-10 (line 103) | N/A |
| 3.7.2 | 1548 | Except ANG wings and subunits, finished products go to AFIMPT for AFDPO review and posting. | - | OPR | No (ANG wing excepted, 3.7.2) | ARCH:76; DEC 2026-11-10 (line 103); PM:19 stage 10 posts on wing site | N/A |
| 3.7.3 | 1553 | AOs read the AFIMPT training guide; the publishing manager reviews the uploaded package and returns corrections. | - | AO | No (AFIMPT only) | Wing equivalent: PM:18 stage 9 (PFM receives package); renderer validator FR L3 | N/A |
| 3.7.4 | 1560 | AFIMPT is reached at its website with a certificate. | - | AO | No (AFIMPT only) | - | N/A |
| 3.7.5 | 1562 | Publication date is the effective date; not effective until released; future date only with justification; never backdate. | - | PFM | Yes | PM:58; GAP A9; LD s3 Effective Date Justification; LD s5 Posting (not backdated); FR F-016 | Covered |
| 3.8 | 1569 | Intro: AFDPO format requirements for submissions to e-Publishing. | - | AO | No (AFDPO submission) | FR S-001 (rest of 3.8 not applicable to ANG camera-ready) | N/A |
| 3.8.1 | 1572 | Publications are presented left flush in the standard template unless processed camera-ready. | - | AO | No (AFDPO; camera-ready exempt) | FR F-000, F-012. PM:14 still writes "Word draft (flush left)" for the package (see Observations) | N/A |
| 3.8.2 | 1575 | File names follow the naming convention with no spaces; the AO places figures, tables and graphics where they print. | - | AO | Yes | FR S-001; DEC 2026-11-11 naming rule 7 (line 57, designator.docx) | Renderer |
| 3.8.3 | 1578 | Submit a separate graphic file (.tif, .jpg, .gif, .png) for each figure. | - | AO | No (AFDPO submission) | FR S-001 note; PM:18 stage 9 keeps figure files with the package | N/A |
| 3.8.4 | 1584 | PMs, GMs and supplements to DoD issuances go to AFDPO as camera-ready Word; AFDPO dates the final draft. | - | AO | No (AFDPO submission) | Wing output is camera-ready anyway: FR F-000 | N/A |
| 3.9 | 1589 | Classified products go to AFDPO SIPR workflow in ETMS2 with an e-mail to AFDPO NIPR workflow; never classified on an unclassified network. | T-1 | OPR | No (classified/AFDPO; classified out of scope) | DEC 2026-11-11 (5) classified products left out (line 42) | N/A |
| 4.1 | 1603 | Chapter describes publication content; ICs and ACs are in Chapter 7; templates are on AFIMPT or from the local PFM. | - | OPR | Yes | DEC 2026-11-11 app replaces template (line 81); templates/ folder | Info |
| 4.2.1 | 1609 | A new publication may be needed when existing ones cannot absorb the subject; PFM supplies template and number and receives the approved draft and DAF Form 673. | - | PFM | Yes | PM:54 (PFM assigns number at request); PM:18 (stage 9); DEC line 81 | Covered |
| 4.2.1 Note | 1614 | The steps for rewriting an existing publication are in 7.6. | - | OPR | Yes | PM:21 (Rewrite = stages 4-9) | Covered |
| 4.2.2 | 1616 | Heading: required steps for new publications. | - | - | - | PM:10-19 (stages 1-10) | Info |
| 4.2.2.1 | 1617 | Draft and collaborate with the PCM and necessary SMEs. | - | OPR | Yes | PM:11 (cites 4.2.2.1) | Covered |
| 4.2.2.2 | 1619 | Formal coordination on DAF Form 673; Service Authority for departmental publications; the AO may transcribe coordination. | T-1 | OPR | Partial (Service Authority is HQ DAF) | PM:14 (stage 5); PM:55 (endorsements transcribed to a master 673, 5.1.5) | Covered |
| 4.2.2.3 | 1622 | Legal coordination. | T-1 | coordinator | Yes | PM:15 (stage 6); LD s5 Before Legal | Covered |
| 4.2.2.4 | 1623 | Certifying official endorses the DAF Form 673. | T-1 | certifier | Yes | PM:16 (stage 7) | Covered |
| 4.2.2.5 | 1624 | Approving official endorses the DAF Form 673. | T-1 | approver | Yes | PM:17 (stage 8) | Covered |
| 4.2.2.6 | 1625 | Submit to the PFM for final processing. | - | OPR | Yes | PM:18 (stage 9) | Covered |
| 4.3.1 | 1627 | Series number relates to an AFSC; the AO picks it from Attachment 2 with PFM help; a series covers many publications. | - | AO | Yes | DEC 2026-11-11 PFM Series seeded with 39 series (line 45); SCH PFMSeries; SCH PFMPublications.Series lookup | Covered |
| 4.3.2 | 1630 | Publication number follows the series and a dash; AO requests it from the PFM; a number belongs to one publication. | - | AO | Yes | PM:54 (PFM assigns, approves every number); LD s3 Number Approved. Uniqueness not enforced: SCH PFMProductIndex.PublicationNumber has no unique flag | Partial |
| 4.3.3 | 1634 | Instructions and manuals name the implemented antecedent publication in the opening paragraph; AO gives it when requesting a number. | - | AO | Yes | FR F-024, F-025 (antecedent in opening paragraph); LD s3 Product Index Implements (set at posting). No antecedent field at number request | Partial |
| 4.3.4 | 1642 | A rewrite normally keeps the series and control number; realigned or consolidated publications may take new ones. | - | AO | Yes | DEC 2026-11-11 (3A) each action points to its Product Index row (line 42); SCH PFMProductIndex.SupersededBy | Covered |
| 4.3.5 | 1645 | When consolidating publications use one number or a new one and supersede both; keep written owner concurrence; update implementing/supplementing publications. | - | AO | Yes | - | Gap |
| 4.3.6 | 1652 | When publications of different OPRs are combined, the AO states concurrence designating the owner on the DAF Form 673; children updated. | - | AO | Yes | - | Gap |
| 4.3.7 | 1658 | AFDPO assigns departmental control numbers; printed products with a cover carry series number and title. | - | AFDPO | No (AFDPO/departmental) | - | N/A |
| 4.3.7.1 | 1662 | DAF supplements to DoD issuances carry both the DoD and DAF numbers; AFDPO assigns the control number. | - | AFDPO | No (departmental) | - | N/A |
| 4.3.7.2 (numbering) | 1672 | PM/GM numbering: year-series-sequence for first instance; existing control number plus acronym, year, sequence when revising (AFGM, AFPM examples). | - | AO | No (departmental examples; wing GMs use 4.3.8.2) | See 4.3.8.2 row | N/A |
| 4.3.7.2 (removal) | 1679 | PFMs start actions to remove expired or superseded PMs and GMs from circulation. | - | PFM | Yes | SCH PFMProductIndex.ExpirationDate (GM valid 1 year, 7.9.3) and Product Status; PM:60; NEXT_PROMPT Next design 2 (GM expiry flow) | Covered |
| 4.3.7.2 (reissue) | 1683 | Reissue a PM/GM up to one year using a DAF Form 673, legal review and certifier and approver signatures; number unchanged, reissue date under original. | T-1 | OPR | Yes | PM:59 (Reissue GM); PM:60, PM:66; GAP A10; LD s2 Action Type Reissue Guidance Memorandum | Covered |
| 4.3.7.3 | 1690 | Publications that further implement another should have consecutive control numbers when possible. | - | AFDPO | No (departmental numbering) | - | N/A |
| 4.3.7.4 | 1693 | Air Force TTP numbers are assigned jointly with the LeMay Center and the issuer. | - | AFDPO | No (TTP, HQ DAF) | - | N/A |
| 4.3.7.5 | 1696 | Space Force TTP numbers are assigned jointly with Space Delta 10 and the issuer. | - | AFDPO | No (TTP, HQ DAF) | - | N/A |
| 4.3.8 | 1698 | The PFM assigns command and field control numbers consecutively in the series, at least three digits. | T-1 | PFM | Yes | PM:54; GAP A4; LD s5 Request; LD s3 Number Approved | Covered |
| 4.3.8.1 | 1703 | Supplements and GMs creating supplements carry the parent designator plus unit acronym and SUP; PFMs approve all numbers. | T-1/T-3 | PFM | Yes | PM:54 (parent number + _<unit>SUP); GAP A4; LD s3 Number Approved; SCH PFMProductIndex.ParentPublication (ref 4.3.8.1) | Covered |
| 4.3.8.2 | 1709 | GM numbering: new publication consecutive in series; amending GM uses amended publication number plus acronym and sequence; unchanged on reissue. | - | PFM | Yes | PM:66; IR #9; LD s5 Request (GM numbers per 4.3.8.2) | Covered |
| 4.3.9 | 1719 | The PFM ensures the OPR numbers ICs consecutively (IC-1, IC-2, ...) regardless of year. | T-3 | PFM | Yes | SCH PFMPublications.ICNumber (ref 4.3.9); PM:54; GAP A4 | Covered |
| 4.3.10 | 1722 | Marking of classified and CUI publications and forms follows DoDI 5200.48. | - | OPR | Partial (CUI only; classified out of scope) | LD s3 Product Index Markings, Access Level (CUI); DEC 2026-11-11 (5) (line 42). Renderer has no CUI banner or portion marking | Partial |
| 4.4 | 1727 | AO reviews higher-level policy and publications; OPR confirms the implemented publication gives its organization implementation authority. | - | AO | Yes | PM:10 only names "existing pubs"; no implementation-authority check | Gap |
| 4.5.1 (draft mark) | 1735 | Mark each draft DRAFT—NOT FOR IMPLEMENTATION OR COMPLIANCE in the page header; no watermarks. | - | AO | Yes | format-rules F-010 (draft mode) | Renderer |
| 4.5.1 (track changes) | 1740 | Remove all track changes and comments before tasking formal coordination. | - | AO | Yes | LD s3 Track Changes Removed; LD s5 Before Formal Coordination; GAP B17; FR F-010 | Covered |
| 4.5.2 | 1742 | Order of content: header, opening paragraph, summary of changes, TOC, overview/background, responsibilities, core content, approver signature block, attachments. | T-3 | OPR | Yes | format-rules F-011 | Renderer |
| 4.5.3 | 1747 | Formatting guidelines are in Table 4.1. | - | OPR | Yes | format-rules F-009 | Info |
| 4.5.3.1 | 1748 | Word, 12-point Times New Roman, 1-inch margins, page numbers; tables, figures and attachments use the same font unless another size fits better. | - | OPR | Yes | format-rules F-001, F-002 | Renderer |
| 4.5.3.2 | 1753 | Paragraph numbers end with a period when they precede text. | - | OPR | Yes | format-rules F-003 | Renderer |
| 4.5.3.3 | 1757 | Do not bold subordinate paragraph numbers or titles. | - | OPR | Yes | format-rules F-004 | Renderer |
| 4.5.3.4 | 1758 | Each subordinate paragraph has at least one companion at the same level; integrated supplements excepted. | - | OPR | Yes | format-rules F-005 (PUB meta.integratedSupplement) | Renderer |
| 4.5.3.5 | 1762 | No paragraph numbers beyond seven levels. | - | OPR | Yes | format-rules F-006 | Renderer |
| 4.5.3.6 | 1764 | Tables not created in Word must be identified as figures. | - | OPR | Yes | format-rules F-007 | Renderer |
| 4.5.3.7 | 1765 | Each attachment must have a title. | - | OPR | Yes | format-rules F-008 | Renderer |
| Table 4.1 Volumes | 1771 | Number volumes consecutively with Arabic numerals (Volume 1, Volume 2). | - | OPR | Yes | Renderer gap: F-009 omits volumes; PUB body has chapters and paragraphs only | Renderer |
| Table 4.1 Parts | 1773 | Number parts consecutively with Arabic numerals (Part 1, Part 2). | - | OPR | Yes | Renderer gap: F-009 omits parts; no parts in PUB | Renderer |
| Table 4.1 Chapters | 1774 | Number chapters consecutively with Arabic numerals. | - | OPR | Yes | format-rules F-009; L-009 | Renderer |
| Table 4.1 Sections | 1776 | Sections use capital letters (Section A) or chapter numeral plus letter (Section 1A) when chapters exist; paragraph numbering does not restart. | - | OPR | Yes | format-rules F-009 states it; Renderer gap: PUB chapter has no section level | Renderer |
| Table 4.1 Paragraphs | 1782 | Paragraphs number consecutively (1, 2) or as chapter.sequence (1.1, 1.2) with chapters. | - | OPR | Yes | format-rules F-009 (PUB body.chapters or body.paragraphs) | Renderer |
| Table 4.1 Subparagraphs | 1788 | Subparagraphs extend the main number with periods (1.1.1.) to a maximum of seven levels. | - | OPR | Yes | format-rules F-009, F-006 | Renderer |
| Table 4.1 Figures | 1796 | Figures number consecutively; chapter-based (Figure 1.1) or attachment-based (Figure A2.1). | - | OPR | Yes | format-rules F-009 | Renderer |
| Table 4.1 Tables | 1806 | Tables follow the same numbering procedure as figures. | - | OPR | Yes | format-rules F-009 | Renderer |
| Table 4.1 Attachments | 1807 | Attachments number consecutively; attachment paragraphs take the attachment number (A3.1); sections are A1A, A1B. | - | OPR | Yes | format-rules F-009, F-036 | Renderer |
| Table 4.1 Exception | 1813 | Supplements follow the numbering of the parent publication. | - | OPR | Yes | format-rules F-009 | Renderer |
| 4.5.3.8 | 1817 | For a rewrite, start from the previous final draft in the official record set, AFIMPT or from the PFM. | - | OPR | Yes | PM:10 ("prior record set"); DEC 2026-11-12 Q15A (line 18); LD s4 Record Sets folders | Covered |
| 4.5.3.9 | 1820 | Consider turning on continuous line numbers in the draft before staffing to ease merging CRMs. | - | AO | Yes | CRM has a Line column (PM:38); Renderer gap: F-010 draft mode does not turn on line numbers | Renderer |
| 4.5.4 | 1823 | Front-page header is required for PDs, instructions and manuals in the listed order; publications not processed by AFDPO are formatted by the OPR to look AFDPO-formatted (camera-ready). | T-1 | OPR | Yes (camera-ready branch) | format-rules F-000, F-012; DEC 2026-11-10 camera-ready final (line 103) | Renderer |
| 4.5.4.1 | 1831 | First line: BY ORDER OF THE SECRETARY OF THE AIR FORCE, COMMANDER or CHIEF, NATIONAL GUARD BUREAU. | - | OPR | Yes | format-rules F-013 (PUB meta.byOrderOf) | Renderer |
| 4.5.4.2 | 1833 | Seal or shield: unit publications show the shield (MAJCOM shield, or unit shield with MAJCOM approval); integrated supplements show the DAF seal. | - | OPR | Yes | format-rules F-014, L-007, L-007a; DEC 2026-11-11 shields 1B/1C (lines 35-37) | Renderer |
| 4.5.4.3 | 1842 | Publication type and number, for example DAFI 90-160 or DAFI90-160_AMCSUP. | - | OPR | Yes | format-rules F-015 (PUB meta.typeAndNumber); no F-015 check found in Test-Publication.ps1 | Renderer |
| 4.5.4.3.1 | 1843 | Publications for both USAF and USSF are Department of the Air Force publications with prefix DAF. | - | OPR | Partial (prefix choice; wing designator format not stated) | format-rules F-015 | Renderer |
| 4.5.4.3.2 | 1848 | Publications applying solely to the USAF use the prefix AF. | - | OPR | Partial (prefix choice) | format-rules F-015 | Renderer |
| 4.5.4.3.3 | 1851 | Publications applying solely to the USSF use the prefix SPF, never SF. | - | OPR | No (USSF-only publications) | format-rules F-015 (rule lists SPF) | N/A |
| 4.5.4.4 | 1855 | Date placeholder such as (Date); the final publishing activity (AFDPO, local PFM or OPR) dates it the day it is posted. | - | PFM | Yes | format-rules F-016; PM:58; LD s5 Posting (effective date not backdated) | Renderer |
| 4.5.4.5 | 1858 | AFSC series title in italics. | - | OPR | Yes | format-rules F-017 | Renderer |
| 4.5.4.6 | 1862 | Publication title in all capital letters. | - | OPR | Yes | format-rules F-018 | Renderer |
| 4.5.4.6.1 | 1863 | Titles should match the subject, be concise and use search keywords. | - | OPR | Yes | Advisory; no rule. Human review at PFM check | Info |
| 4.5.4.6.2 | 1866 | Title must not contain policy, instruction, guidance, handbook, pamphlet, catalog, guide, book, or Department of the Air Force, Air Force, Space Force. | - | OPR | Yes | format-rules F-018 (lint) | Renderer |
| 4.5.4.6.3 | 1871 | A supplement keeps the original publication's title minus organizational level identifiers. | - | OPR | Yes | Renderer gap: F-018 does not compare to the parent title (Product Index Parent Publication available) | Renderer |
| 4.5.4.6.4 | 1874 | A supplement to a DoD publication needs a title different from the DoD issuance. | - | OPR | No (supplements to DoD issuances are departmental) | - | N/A |
| 4.5.4.6.5 | 1876 | Classified publications with an unclassified title carry U before the title; classified titles use (U) Classified Title. | T-0 | OPR | No (classified out of scope) | DEC 2026-11-11 (5) (line 42) | N/A |
| 4.5.4.7 | 1881 | Compliance header COMPLIANCE WITH THIS PUBLICATION IS MANDATORY for directive publications only. | - | OPR | Yes | format-rules F-019 (PUB meta.directive) | Renderer |
| 4.5.4.8 | 1884 | Accessibility statement says where the publication is available for distribution (Table 4.2). | - | OPR | Yes | format-rules F-020 (PUB meta.accessibility); wing statement must name the wing site or OPR | Renderer |
| Table 4.2 item 1 | 1889 | Example: available on the e-Publishing website. | - | OPR | No (ANG wing not on e-Publishing) | ARCH:76 | N/A |
| Table 4.2 item 2 | 1891 | Example: This publication is only available directly from the OPR. | - | OPR | Yes | format-rules F-020; sample prompt uses this wording; wording list not extracted (format-rules.md Open) | Renderer |
| Table 4.2 item 3 | 1892 | Example: available for downloading on SIPRNET. | - | OPR | No (classified/SIPRNET) | - | N/A |
| 4.5.4.9 | 1895 | Releasability statement names any distribution limits (Table 4.3). | - | OPR | Yes | format-rules F-020 (PUB meta.releasability) | Renderer |
| Table 4.3 items 1-4 | 1902 | Examples: no restrictions; restricted to NATO; not to foreign nationals; classified or CUI with access approved by the OPR. | - | OPR | Yes | format-rules F-020; LD s3 Access Level (Public, Restricted, CUI) | Renderer |
| 4.5.4.10 | 1910 | OPR line shows organization or office symbol only, no names. | - | OPR | Yes | format-rules F-021 | Renderer |
| 4.5.4.11 | 1912 | Certified By line shows the certifying organization or office symbol. | - | OPR | Yes | format-rules F-021; DEC 2026-11-11 "Certified by:" (line 88) and name line (line 80) | Renderer |
| 4.5.4.12 | 1914 | Supersedes line (rewrites only): number and date, month spelled out, semicolons between entries, omitted if none. | - | OPR | Yes | format-rules F-022 | Renderer |
| 4.5.4.13 | 1920 | Pages line with page count. | - | OPR | Yes | format-rules F-023 | Renderer |
| 4.5.5 | 1921 | Concise opening paragraph cites the antecedent, says what the publication covers and to whom it applies, plus the required statements; not required for PMs and GMs. | - | OPR | Yes | format-rules F-025 (PUB openingParts); PC:30-62 builds it | Renderer |
| 4.5.5 (no policy) | 1923 | Do not put policy or guidance statements in the opening paragraph. | T-3 | OPR | Yes | Renderer gap: no rule in format-rules | Renderer |
| 4.5.5.1 | 1929 | First sentence names the one antecedent publication implemented, in full, with italic title; DoD type spelled after DoD. | - | OPR | Yes | format-rules F-024 | Renderer |
| 4.5.5.2 | 1939 | Applicability statement names the Services and components to which the publication applies. | - | OPR | Yes | format-rules F-025 (PUB openingParts.applicability); TP:129 | Renderer |
| 4.5.5.2.1 | 1945 | Identify unique applicability conditions such as an MOA, MOU or support agreement. | T-1 | OPR | Yes | format-rules F-025 (free-text slot); content not checked | Renderer |
| 4.5.5.2.2 | 1947 | State if a Service is excluded from the publication. | T-1 | OPR | Yes | format-rules F-025 (free-text slot) | Renderer |
| 4.5.5.2.3 | 1948 | Identify applicability to Regular Air Force, USSF, ANG, Air Force Reserve and CAP if included. | T-1 | OPR | Yes | format-rules F-025; LD s3 Applies To AFR Unit (coordination only) | Renderer |
| 4.5.5.2.4 | 1951 | State applicability to non-DAF entities (retirees, contractors, foreign nationals); consult legal on such language. | - | OPR | Yes | format-rules F-025; Legal is a mandatory coordinator (PM:42) | Renderer |
| 4.5.5.2.5 | 1956 | See Table 4.4 for example applicability statements. | - | OPR | Yes | - | Info |
| Table 4.4 items 1-7 | 1962 | Seven example applicability statements for the Services, components, CAP and contractors. | - | OPR | Yes | Examples only; slot is free text (PUB openingParts.applicability) | Info |
| Table 4.4 Note 1 | 1988 | Do not mention a future reserve or guard of the Space Force. | - | OPR | Yes | Renderer gap: no lint | Renderer |
| Table 4.4 Note 2 | 1992 | More specific AFR and ANG applicability may apply; if limited to sections or chapters, add that language after the general statement. | - | OPR | Yes | format-rules F-025 (free-text slot); LD s3 Applies To AFR Unit | Renderer |
| 4.5.5.3 | 1999 | Privacy Act advisory statement when a system of records or SSN collection is required; must include the SORN website link. | T-1 | OPR | Yes | format-rules F-025 (PUB openingParts.privacyAct); PC:44; LD s3 Privacy Act Warning Required | Renderer |
| 4.5.5.4 | 2009 | Copyright statement when the publication has copyrighted material or other statutory requirements (1.5.6). | T-1 | OPR | Yes | format-rules F-025 (PUB openingParts.copyright); PC:16; LD s3 Contains Copyright | Renderer |
| 4.5.5.5 | 2012 | Paperwork Reduction Act statement when collecting from the public; OMB approval needed for such collections. | T-0 | OPR | Yes | format-rules F-025 (PUB openingParts.paperworkReduction); PC:18; LD s3 Information Collection, OMB Number | Renderer |
| 4.5.5.6 | 2020 | Punitive language: say if failure to comply violates UCMJ Article 92 (ANG Title 32 sentence); legal helps early. | T-1 | OPR | Yes | format-rules F-025 (PUB openingParts.punitiveScope); PC:48-51 includes the ANG Title 32 sentence | Renderer |
| 4.5.5.7 | 2028 | State any other statutory requirements in the opening paragraph. | T-1 | OPR | Yes | format-rules F-025 (PUB openingParts.statutory) | Renderer |
| 4.5.5.8 | 2030 | Standard records management statement (AFI 33-322), or any updated text from SAF/CNZA. | - | OPR | Yes | format-rules F-025 (fixed text, PC:6-7); no process to check SAF/CNZA for an updated statement | Renderer |
| 4.5.5.9 | 2042 | Recommending-changes statement with routing, naming DAF Form 847 and the functional chain. | - | OPR | Yes | format-rules F-025 (fixed text, PC:8-9); DEC 2026-11-12 outbound 847 to ANG functional at NGB (line 8); LD s1 PFM Recommendations | Renderer |
| 4.5.5.10 | 2047 | Heading: statement allowing implementing or supplementing publications. | - | OPR | Yes | format-rules F-025 | Info |
| 4.5.5.10.1 | 2048 | State whether the publication may be supplemented and whether supplements go to the higher headquarters OPR before publishing. | - | OPR | Yes | format-rules F-025 (PUB openingParts.supplement); PC:10-12 Table 4.5 | Renderer |
| 4.5.5.10.2 | 2052 | PDs may not be supplemented; say so in the opening paragraph. | - | OPR | No (PDs are HQ DAF) | - | N/A |
| 4.5.5.10.3 | 2054 | OPRs are encouraged to review lower-level supplements for conflicts, less restrictive guidance and incorporation. | - | OPR | Yes | Advisory; SCH PFMProductIndex.ParentPublication lists supplements of a product | Info |
| Table 4.5 item 1 | 2061 | Example: This AFPD may not be supplemented. | - | OPR | No (PD wording) | - | N/A |
| Table 4.5 item 2 | 2062 | Example: may be supplemented at any level, but supplements are routed to the OPR for coordination before certification and approval. | - | OPR | Yes | format-rules F-025; PC:11 | Renderer |
| Table 4.5 item 3 | 2065 | Example: may not be supplemented or further implemented or extended. | - | OPR | Yes | format-rules F-025; PC:12 | Renderer |
| 4.5.5.11 | 2067 | Waiver authority statement in the opening paragraph explaining tier numbers and where to send waiver requests. | T-1 | OPR | Yes | format-rules F-025 (fixed text, PC:14); DEC 2026-11-11 (line 85). Wording mentions tier numbers while F-040 removes tiers on wing statements | Renderer |
| 4.5.5.11 Note 1 | 2074 | OPRs give specific guidance on waiver authorities for exercises and contingencies and define them for their functional area. | - | OPR | Yes | Not in plan | Renderer |
| 4.5.5.11 Note 2 | 2078 | Same duty for T-1, T-2, T-3 and non-tiered waiver authorities in exercises and contingencies. | - | OPR | Yes | Not in plan (same as Note 1) | Renderer |
| 4.5.5.12 | 2085 | Trade names or trademarks: add the endorsement disclaimer as the last sentence of the opening paragraph. | T-3 | OPR | Yes | format-rules F-025 (PUB openingParts.tradeNames); PC:19-20, PC:61; TP:144 | Renderer |
| 4.5.5.13 | 2091 | Lead command instructions name HQ DAF offices that accepted assigned roles. | - | MAJCOM | No (lead command, HQ DAF offices) | - | N/A |
| 4.5.6 | 2094 | Summary of Changes required for ICs and rewrites; brief; none for ACs and new publications; heading bold italic all caps. | T-1 | OPR | Yes | format-rules F-026; LD s3 Summary Of Changes (B8) | Renderer |
| 4.5.6.1 | 2101 | Consider starting with: This document has been revised and should be completely reviewed. Changes include ... | - | OPR | Yes | Sample prompt D4 uses it; advisory | Info |
| 4.5.6.2 | 2103 | IC summary ends with A margin bar (/) indicates newly revised material; no asterisks on camera-ready or waivered formats, margin bars by left border. | - | OPR | Yes | format-rules F-026; PM:68; GAP A23; NP:367; TP:153 | Renderer |
| 4.5.7 | 2110 | Non-directive publications may carry an optional one-page foreword before the title page. | - | OPR | Partial (non-directive only) | DEC 2026-11-11 directive-only tracking (line 44); PUB has no foreword field | N/A |
| 4.5.8 | 2113 | AFDPO generates the TOC for e-Publishing publications of 20 pages or more; OPRs omit it from the draft. | - | AFDPO | No (AFDPO-processed only) | - | N/A |
| 4.5.8.1 | 2117 | Generally no TOC for publications under 20 pages. | - | OPR | Partial (overridden for ANG wing by 4.5.8.2) | DEC 2026-11-11 TOC always (line 79); format-rules F-027 | Renderer |
| 4.5.8.2 | 2118 | OPRs add a TOC for 20+ page publications not processed by AFDPO, and for classified, not electronically posted, or below-wing or ANG wing/subunit publications. | T-1 | OPR | Yes | format-rules F-027; DEC 2026-11-11 (line 79) | Renderer |
| 4.5.8.3 | 2122 | TOC is built only from main paragraph headings. | - | OPR | Yes | format-rules F-027, L-012 | Renderer |
| 4.5.9.1 | 2129 | Supplements to DoD issuances follow the DoD numbering; all other publications follow this manual. | - | OPR | Partial (non-DoD supplements follow this manual) | format-rules F-009 | Renderer |
| 4.5.9.2 | 2132 | Main paragraph numbers and headings are bold with significant words capitalized. | - | OPR | Yes | format-rules F-028 | Renderer |
| 4.5.9.3.1 | 2136 | Directive publications, including ICs, have no bullets; convert old bullets to numbered paragraphs. | T-1 | OPR | Yes | format-rules F-029; sample prompt M6 | Renderer |
| 4.5.9.3.2 | 2140 | Non-directive publications may use simple bullets within a numbered paragraph; no sub-bullets. | - | OPR | Yes | format-rules F-029 | Renderer |
| 4.5.9.4 | 2143 | Provide a concise overview or background section. | - | OPR | Yes | format-rules F-011 | Renderer |
| 4.5.9.5 | 2145 | Policy section is required in PDs only. | - | SecAF | No (PDs are HQ DAF) | - | N/A |
| 4.5.9.5.1 | 2151 | PD policy statements are concise but detailed enough to be clear. | - | SecAF | No (PDs only) | - | N/A |
| 4.5.9.5.2 | 2153 | No responsibilities in a PD policy section and no procedures anywhere in a PD. | T-1 | SecAF | No (PDs only) | - | N/A |
| 4.5.9.5.2.1 | 2158 | Procedures and detailed guidance go in instructions and manuals; PDs hold policy. | - | OPR | No (PD/HQ DAF) | - | N/A |
| 4.5.9.5.2.2 | 2161 | Instructions and manuals will not contain policy; policy is reserved for PDs. | - | OPR | Yes | Not in plan | Gap |
| 4.5.9.6 | 2163 | Roles and responsibilities section is required for all publication types except PMs and GMs. | - | OPR | Yes | format-rules F-011 | Renderer |
| 4.5.9.6.1 | 2165 | Identify key officials, top officials first, and their overarching duties. | - | OPR | Yes | format-rules F-011 (responsibilities section order) | Renderer |
| 4.5.9.6.2 | 2167 | Assign responsibilities to positions, not individuals. | - | OPR | Yes | format-rules F-030 (lint, warn) | Renderer |
| 4.5.9.6.3 | 2172 | Responsibilities are specific but succinct and contain no procedures. | T-3 | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.9.6.4 | 2174 | The responsibilities section is not tiered; state what the official must do, not how. | - | OPR | Yes | Renderer gap: F-039/F-040 do not exclude the responsibilities section | Renderer |
| 4.5.9.6.5 | 2176 | Note: if only an office is named, its head is the responsible party. | - | OPR | Yes | - | Info |
| 4.5.9.6.6 | 2179 | PDs assign responsibilities to HQ DAF officials, commanders and directors; avoid assigning below component level. | - | SecAF | No (PDs only) | - | N/A |
| 4.5.9.7 | 2185 | Core content is required; never title a section Core Content; use command/active voice and plain language. | - | OPR | Yes | format-rules F-031, W-004 | Renderer |
| 4.5.9.7.1 | 2188 | Directive guidance must go in a directive publication, not a non-directive one or a website. | T-1 | OPR | Yes | PM:10 ("directive or not"); DEC 2026-11-11 directive-only (line 44); LD s5 Rescind (Directive Guidance Moved) | Covered |
| 4.5.9.7.2 | 2190 | Spell out an acronym at first use, then use it; list every acronym in Attachment 1; DoD supplements list added acronyms. | - | OPR | Yes | format-rules F-032 (lint, warn); F-035 | Renderer |
| 4.5.9.7.2.1 | 2197 | Chapter and main paragraph headings spell out the term followed by the acronym in parentheses. | - | OPR | Yes | format-rules F-032 | Renderer |
| 4.5.9.7.2.2 | 2201 | Acronyms from widely read newspapers and magazines are acceptable. | - | OPR | Yes | - | Info |
| 4.5.9.7.2.3 | 2203 | Widely understood dictionary acronyms need no spelling out but are listed in Attachment 1. | - | OPR | Yes | format-rules F-032 | Info |
| 4.5.9.7.2.4 | 2207 | More acronyms are acceptable in technical publications for trained Airmen and Guardians. | - | OPR | Yes | - | Info |
| 4.5.9.7.2.5 | 2214 | Acronyms used four times or fewer should be spelled out and deleted from Attachment 1. | - | OPR | Yes | format-rules F-032 | Renderer |
| 4.5.9.7.2.6 | 2219 | Consider the audience; use common sense. | - | OPR | Yes | - | Info |
| 4.5.9.7.3 | 2220 | Spell out office symbols at first use with the symbol in parentheses; afterward use the symbol; list them alphabetically in Attachment 1. | - | OPR | Yes | format-rules F-032, F-035 | Renderer |
| 4.5.9.7.4 | 2226 | Listed elements are bold; do not bold URLs to external sources. | - | OPR | Yes | format-rules F-033 | Renderer |
| 4.5.9.7.4.1 | 2228 | SUMMARY OF CHANGES is bold. | - | OPR | Yes | format-rules F-026 | Renderer |
| 4.5.9.7.4.2 | 2229 | Table of contents chapter numbers and titles are bold. | - | OPR | Yes | format-rules L-012 | Renderer |
| 4.5.9.7.4.3 | 2230 | Section titles are bold. | - | OPR | Yes | Renderer gap: F-033 omits section titles; PUB has no sections | Renderer |
| 4.5.9.7.4.4 | 2231 | Chapter numbers (Chapter 1) are bold. | - | OPR | Yes | format-rules L-009, F-033 | Renderer |
| 4.5.9.7.4.5 | 2232 | Chapter titles are bold and all capital letters. | - | OPR | Yes | format-rules L-009, F-033 | Renderer |
| 4.5.9.7.4.6 | 2233 | Top-level paragraph numbers and titles are bold including the ending period. | - | OPR | Yes | format-rules F-033, F-028 | Renderer |
| 4.5.9.7.4.7 | 2238 | Table numbers and titles are bold including ending punctuation. | - | OPR | Yes | format-rules F-033, F-038; NP:384 | Renderer |
| 4.5.9.7.4.8 | 2239 | Figure numbers and titles are bold including ending punctuation. | - | OPR | Yes | format-rules F-033, F-038 | Renderer |
| 4.5.9.7.4.9 | 2240 | Notes, exceptions and warnings are bold including the colon. | - | OPR | Yes | format-rules F-037 (Note, Exception); Warning not in PUB (renderer gap) | Renderer |
| 4.5.9.7.4.10 | 2241 | Copyright notices are bold (1.5.6.2). | - | OPR | Yes | Renderer gap: F-033 omits; PUB openingParts.copyright renders plain text (PC:16) | Renderer |
| 4.5.9.7.4.11 | 2242 | Internal references are bold. | - | OPR | Yes | Partial: sample prompt R4 bolds table and figure references only; F-033 omits | Renderer |
| 4.5.9.7.4.12 | 2243 | Tier waiver authority numbers are bold. | - | OPR | Yes | format-rules F-033, F-039 | Renderer |
| 4.5.9.7.4.13 | 2244 | Attachment numbers and titles are bold; titles in all capital letters. | - | OPR | Yes | format-rules F-033, L-011 | Renderer |
| 4.5.9.7.4.14 | 2246 | Attachment 1 elements listed in 4.5.9.7.4.14.1-4 are bold. | - | OPR | Yes | See next four rows | Info |
| 4.5.9.7.4.14.1 | 2247 | Attachment 1 category titles (References, Prescribed Forms, and so on) are bold. | - | OPR | Yes | format-rules F-033; NP:457 | Renderer |
| 4.5.9.7.4.14.2 | 2250 | The list of abbreviations and acronyms is bold, the definitions are not. | - | OPR | Yes | NP:467 (term bold, definition plain); not named in F-033 | Renderer |
| 4.5.9.7.4.14.3 | 2251 | The list of office symbols is bold, with the office title fully spelled out. | - | OPR | Yes | Renderer gap: NP:467 bolds the symbol only, not the spelled-out title; not in F-033 | Renderer |
| 4.5.9.7.4.14.4 | 2255 | The list of terms and the definitions is bold. | - | OPR | Yes | Renderer gap: NP:467 bolds terms only, definitions plain | Renderer |
| 4.5.9.7.4.15 | 2256 | Service-added content to a DoD issuance is bold, such as (Added)(DAF). | - | OPR | No (supplements to DoD issuances) | - | N/A |
| 4.5.9.7.5 | 2258 | The OPR may structure core content with the Table 4.1 elements. | - | OPR | Yes | format-rules F-009 | Info |
| 4.5.9.7.6 | 2261 | Put all relevant guidance in one publication; refer to other publications only for more information; cite DAF publications rather than DoD or law. | - | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.9.7.7 | 2267 | Avoid language that extends applicability to retirees, dependents, other Services or foreign nationals. | - | OPR | Yes | Legal mandatory coordinator (PM:42, PM:15); no lint | Partial |
| 4.5.10 | 2270 | Approving official authentication is the last entry before attachments; no wet signatures; the approver signs the DAF Form 673 only; delegation keeps the approver's block. | T-1 | approver | Yes | format-rules F-034, L-006; PM:17 (delegation letter on file); DEC 2026-11-12 Q4A (line 24) | Renderer |
| 4.5.11 | 2275 | Attachments must meet the format rules below. | - | OPR | Yes | format-rules F-035, F-036 | Info |
| 4.5.11.1 | 2277 | Attachment 1 Glossary of References and Supporting Information is required for PDs, instructions and manuals; unnumbered paragraphs with the standard section titles. | T-1 | OPR | Yes | format-rules F-035 | Renderer |
| 4.5.11.1.1 | 2283 | References: designator, number, italic title, original published date; hierarchy order; no URLs. | - | OPR | Yes | format-rules F-035 (no URLs only); Renderer gap: hierarchy order and original-date rule not in F-035 | Renderer |
| 4.5.11.1.2 | 2291 | Prescribed Forms: list forms this publication prescribes; show None if there are none. | T-3 | OPR | Yes | format-rules F-035; NP:460 prints None; DEC 2026-11-11 Prescribing Publication link (line 44) | Renderer |
| 4.5.11.1.3 | 2298 | Adopted Forms: list forms adopted by this publication; show None if there are none. | - | OPR | Yes | format-rules F-035; LD s3 Product Index Adopted Forms | Renderer |
| 4.5.11.1.4 | 2302 | Abbreviations and Acronyms: list alphabetically; spelled out at first use in the text. | - | OPR | Yes | format-rules F-032, F-035; TP:256 alphabetical warn | Renderer |
| 4.5.11.1.4.1 | 2305 | Acronyms must have the same meaning in the text and in Attachment 1. | - | OPR | Yes | Renderer gap: F-032 checks listing, not meaning | Renderer |
| 4.5.11.1.4.2 | 2307 | One acronym may not carry more than one meaning in a publication. | - | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.11.1.5 | 2310 | Office Symbols: list alphabetically; spelled out at first use, then listed in Attachment 1. | - | OPR | Yes | format-rules F-032, F-035 | Renderer |
| 4.5.11.1.6 | 2313 | Terms: define every term used in Attachment 1 so the reader need not read the whole publication; text and definition agree. | - | OPR | Yes | format-rules F-035 | Renderer |
| 4.5.11.1.6.1 | 2318 | Avoid defining terms in the main body. | - | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.11.1.6.2 | 2320 | Do not define terms in Attachment 1 that the body does not use. | - | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.11.1.6.3 | 2322 | Terms defined in parent publications are also defined in the implementing publication with the same meaning. | - | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.5.11.1.6.4 | 2325 | List terms alphabetically. | - | OPR | Yes | TP:255-256 (alphabetical warn for glossary lists); format-rules F-035 | Renderer |
| 4.5.11.2 | 2326 | Additional attachments numbered in sequence (Attachment 2, 3); paragraphs A2.1; sections A2A. | - | OPR | Yes | format-rules F-036, F-009 | Renderer |
| 4.6.1 | 2332 | Citations meet these rules and those in Attachment 4. | - | OPR | Yes | Renderer gap: no citation rules in format-rules (Attachment 4 is in another range) | Renderer |
| 4.6.1.1 | 2337 | Limit references to those directly applicable and listed in Attachment 1; no indefinite references; do not cite drafts or unofficial website guidance. | T-1 | OPR | Yes | Renderer gap: no rule (F-035 lists references only) | Renderer |
| 4.6.1.2 | 2343 | Cite the DoD issuance rather than the statute it implements, but cite a departmental publication that directly implements a statute; verify statutory authority with legal. | T-1/T-3 | OPR | Yes | Legal coordination verifies (PM:15); no lint | Renderer |
| 4.6.1.3 | 2359 | When citing a DoD issuance also cite its DAF implementing publications (check IDAR); if none, give the full reference in Attachment 1. | T-1 | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.6.1.4 | 2369 | Cite designator, number and italic title at first use; later use designator and number only. | T-1 | OPR | Yes | format-rules F-024 (antecedent only); sample prompt R4 italic titles; later-use rule not checked | Renderer |
| 4.6.1.5 | 2375 | Guidelines for referring to organizations and offices. | - | OPR | Yes | See next four rows | Info |
| 4.6.1.5.1 | 2377 | Use the establishment term for the office symbol for the whole organization (AF heraldry, not HQ DAF heraldry). | T-1 | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.6.1.5.2 | 2383 | Use the HQ prefix only for the entire HQ staff. | T-1 | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.6.1.5.3 | 2386 | Refer to a specific HQ office by establishment term and office symbol separated by a virgule. | T-1 | OPR | Yes | Renderer gap: no rule | Renderer |
| 4.6.1.5.4 | 2388 | Write out office titles at first use with the symbol in parentheses; afterward the symbol; list symbols in Attachment 1. | - | OPR | Yes | format-rules F-032, F-035 | Renderer |
| 4.6.2.1 | 2395 | Notes: bold Note with a colon; table and figure notes go below the graphic or in the last table row; superscript references; use sparingly at paragraph end. | - | OPR | Yes | format-rules F-037 (bold, colon); Renderer gap: placement and superscript references not in rule or PUB table | Renderer |
| 4.6.2.2 | 2401 | Use footnotes or endnotes for lengthy legal cites, copyright owners, quoted sources or long explanations; endnotes go before attachments. | - | OPR | Yes | Renderer gap: PUB has no footnote or endnote field | Renderer |
| 4.6.3 | 2404 | Exceptions: state the rule before the exception; bold Exception with a colon; table and figure exceptions go below the graphic or in the last row; use sparingly. | - | OPR | Yes | format-rules F-037; Renderer gap: table exception placement | Renderer |
| 4.6.4 | 2411 | Embed figures and tables where they appear; separate source graphic per non-Word figure; number and title above the item, minimum 8 pt; limit color and graphics. | - | OPR | Yes | format-rules F-038, F-007; PM:18 (figure files to PFM) | Renderer |
| 4.6.4.1 | 2417 | Heading: figures (illustrations). | - | - | - | - | Info |
| 4.6.4.1.1 | 2418 | Use illustrations only for DAF business, public interest, good taste, smallest size; justify color on printed materials on the DAF Form 673. | T-1 | OPR | Partial (color justification applies to printed products) | DEC 2026-11-11 (5) printed products left out (line 42) | N/A |
| 4.6.4.1.2 | 2426 | Embed figures and non-Word tables where they appear; caption above; give a separate source graphic file for each when submitting. | T-3/T-3/T-1 | OPR | Yes | format-rules F-038, F-007; PM:18 (stage 9 figure files) | Renderer |
| 4.6.4.2 | 2432 | Use tables to clarify procedures or data; label columns and rows. | - | OPR | Yes | format-rules F-038 (title); PUB table.columns | Renderer |
| 4.6.5 | 2440 | Compliance statements and tier waiver numbers follow the guidance below; see Table A10.1. | - | OPR | Partial (wing statements untiered except above-wing authority) | format-rules F-039, F-040; DEC 2026-11-12 F-040 row (line 14) | Renderer |
| 4.6.5.1 | 2442 | A sentence that fails the first two criteria is not a compliance statement and is not tiered. | - | OPR | Yes | format-rules F-039 | Renderer |
| 4.6.5.1.1 | 2444 | A compliance statement uses will, must or a directive; shall is no longer favored. | - | OPR | Yes | format-rules F-039, W-001 | Renderer |
| 4.6.5.1.2 | 2446 | A compliance statement names the responsible party. | - | OPR | Yes | format-rules F-039 | Renderer |
| 4.6.5.1.2.1 | 2447 | Do not use personal pronouns (you, your, we, our) in compliance text. | - | OPR | Yes | Renderer gap: no pronoun lint in Test-Publication.ps1 or format-rules | Renderer |
| 4.6.5.1.2.2 | 2451 | If an organization is the responsible party, its commander or director executes or delegates. | - | OPR | Yes | format-rules F-039 | Info |
| 4.6.5.1.3 | 2453 | Directives are clear, understandable, measurable and executable. | - | OPR | Yes | format-rules W-004 (plain language) | Info |
| 4.6.5.1.4 | 2454 | Insert the tier number in bold parentheses right after each compliance statement, such as (T-0). | - | OPR | Partial (wing statements carry no tier except above-wing T-0, T-1, T-2) | format-rules F-039, F-040, F-033; DEC 2026-11-12 (line 14) | Renderer |
| 4.6.5.2 | 2458 | General tier waiver authority guidance. | - | OPR | Partial | See next rows | Info |
| 4.6.5.2.1 | 2459 | Tiering resides at the lowest acceptable level. | - | OPR | Partial (wing: no tier at its own level) | format-rules F-040 | Renderer |
| 4.6.5.2.2 | 2460 | Tier 0 statements (waiver authority outside the DAF) must be tiered at any unit level. | - | OPR | Yes | format-rules F-040 (keeps T-0) | Renderer |
| 4.6.5.2.3 | 2462 | Statements directing action at or below wing/delta, DRU or FOA level must be tiered, with the exceptions in 4.6.5.3. | - | OPR | Partial (wing-issued publications untiered by 4.6.5.3.2) | format-rules F-040; DEC 2026-11-12 (line 14) | Renderer |
| 4.6.5.2.4 | 2465 | AOs may tier compliance statements in tables and figures. | - | AO | Partial (only where tiers apply) | format-rules F-039 | Info |
| 4.6.5.2.5 | 2469 | AOs may tier compliance statements in attachments. | - | AO | Partial (only where tiers apply) | format-rules F-039 | Info |
| 4.6.5.2.6 | 2470 | Blanket or global tier waiver numbers are not allowed. | - | OPR | Yes | format-rules F-039 (no blanket tiers) | Renderer |
| 4.6.5.2.7 | 2471 | Removing will or must may not remove the directive nature; the statement still needs a tier. | - | OPR | Partial (only where tiers apply) | format-rules F-039 | Info |
| 4.6.5.2.8 | 2473 | May and can are not directive; may not and cannot are directive and require tiering. | - | OPR | Partial (only where tiers apply) | format-rules F-039 | Info |
| 4.6.5.3 | 2475 | Heading: exceptions to tiering. | - | - | - | - | Info |
| 4.6.5.3.1 | 2476 | PDs, PMs, MDs and OIs are not tiered. | - | OPR | Yes (OIs and GMs) | Renderer gap: Publication Type is not in PUB meta, so no lint | Renderer |
| 4.6.5.3.2 | 2477 | Publications issued or approved below the T-3 level (wing, delta, DRU, FOA, CC) are not tiered. | - | OPR | Yes | format-rules F-040; DEC 2026-11-12 (line 14) | Renderer |
| 4.6.5.3.3 | 2479 | The OPR may name the squadron commander as waiver authority for non-tiered items in the opening paragraph and leave them untiered. | - | OPR | Yes | Renderer gap: F-025 waiver statement (PC:14) is fixed text with no squadron-commander variant | Renderer |
| 4.6.5.3.4 | 2482 | Statements of a general nature are not tiered. | - | OPR | Yes | format-rules F-039 | Info |
| 4.6.5.3.5 | 2484 | Informational, descriptive and permissive statements (may, can, should) are not tiered. | - | OPR | Yes | format-rules F-039 | Info |
| 4.6.5.3.6 | 2486 | Table and figure headings without compliance statements are not tiered. | - | OPR | Yes | format-rules F-039 | Info |
| 4.6.5.3.7 | 2488 | Compliance items directed at HQ DAF, NAF, MAJCOM or FLDCOM staff need no tier. | - | OPR | No (HQ/NAF/MAJCOM staff guidance) | - | N/A |
| 4.7 | 2490 | A supplement adds detail to a higher headquarters publication for the issuing unit only; none to external law; no same-level supplements to a Sister Service publication. | - | OPR | Yes | PM:54 (what may be supplemented, 1.1.3.5.1); GAP A11; DEC 2026-11-11 Publication Type Supplement (line 44) | Info |
| 4.7.1 | 2498 | Supplements to DoD issuances; other DoD publications may be supplemented and the type follows content. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.1 | 2506 | Only a departmental publication may supplement a DoD issuance; it holds the full DoD text with bold Service-added material. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.2 | 2516 | Three ways the DAF may supplement a DoD issuance (DoDD, DoDI, DoDM). | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.2.1 | 2518 | DoDDs are supplemented by DAFPDs, AFPDs or SPFPDs. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.2.2 | 2522 | DoDIs are supplemented by DAFIs, AFIs or SPFIs. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.2.3 | 2526 | DoDMs are supplemented by DAFMANs, AFMANs or SPFMANs. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.3 | 2530 | Build an integrated supplement from an editable DoD publication obtained from the OSD OPR. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.4 | 2535 | The first added pages carry the header, opening paragraph and summary of changes. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.5 | 2538 | Insert (Added)(DAF), (Added)(USAF) or (Added)(USSF) after each new paragraph number; DoD numbering schema. | T-3 | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.6 | 2544 | Insert the DAF approving authority's authentication after the OSD official's. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.7 | 2546 | Standalone supplements submit only the DAF added material. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.8 | 2551 | The OPR provides a fully formatted camera-ready document for publishing. | T-3 | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.9 | 2553 | Supplements to DoD issuances carry the same weight as directive departmental publications. | - | HQ DAF | No (departmental level) | - | N/A |
| 4.7.1.10 | 2556 | Added material must not contradict the DoD issuance; hold a special review when the supplemented publication changes. | T-0 | HQ DAF | No (departmental supplement; wing rule is 4.7.3.5) | PM:62; GAP A13 | N/A |
| 4.7.2 | 2560 | Command and field supplements to DAF supplements to DoD issuances. | - | OPR | Partial (rare for a wing) | - | Info |
| 4.7.2.1 | 2562 | Build an integrated supplement from an editable copy of the DAF supplement; DAF supplements to DoDDs are not further supplemented. | - | OPR | Partial (rare for a wing) | PM:54 / GAP A11 (supplement check at request); no editable-source step | Info |
| 4.7.2.2 | 2568 | Insert (Added) plus the command or field acronym after each new number, such as (Added)(AMC); DoD numbering schema. | T-1/T-3 | OPR | Partial (rare for a wing) | Renderer gap: no (Added) tag support in PUB or New-Publication.ps1 | Renderer |
| 4.7.2.3 | 2572 | Insert the command or field approving authority's authentication after the OSD or DAF official's. | T-1 | OPR | Partial (rare for a wing) | format-rules F-034 (signature block lines in PUB signature) | Renderer |
| 4.7.2.4 | 2574 | Standalone supplements submit only the added material. | T-1 | OPR | Partial (rare for a wing) | Renderer gap: PUB has no added-material-only mode | Renderer |
| 4.7.2.5 | 2575 | The OPR provides a fully formatted document for publishing. | T-3 | OPR | Partial (rare for a wing) | format-rules F-000 | Renderer |
| 4.7.2.6 | 2576 | When the supplemented publication changes, the subordinate OPR holds a special review to determine currency. | T-2 | OPR | Yes | PM:62 (2.6.19); GAP A13; LD s3 Product Index Implements | Covered |
| 4.7.3 | 2578 | Command and field supplements to DAF/USAF/USSF publications such as DAFIs, AFIs, SPFMANs. | - | OPR | Yes | PM:54; DEC 2026-11-11 Publication Type Supplement (line 44) | Info |
| 4.7.3.1 | 2580 | Submit only the material added to the higher headquarters publication, with paragraph numbers, for standalone or integrated; tell AFDPO which kind. | T-1/T-1 | OPR | Partial (AFDPO part not applicable) | PUB meta.integratedSupplement; Renderer gap: no standalone added-material-only output | Renderer |
| 4.7.3.2 | 2584 | Insert (Added) between each new paragraph, figure, table or attachment number and its content; AFDPO software adds the unit acronym. | T-1 | OPR | Yes (no AFDPO software at the ANG wing) | Renderer gap: no (Added) or (Added-<unit>) support; PM:68 only says wing ICs omit (Added) | Renderer |
| 4.7.3.3 | 2591 | Do not tag (Added) when the number already exists in the basic publication; repeat the number with the acronym; match the basic publication's numbering format. | T-1/T-1 | OPR | Yes | Renderer gap: same as 4.7.3.2 | Renderer |
| 4.7.3.4 | 2598 | Rules for command and field supplements to DAF publications. | - | OPR | Yes | PM:54; GAP A11 | Info |
| 4.7.3.4.1 | 2599 | A PD may not be supplemented. | - | OPR | Yes (request check) | GAP A11; PM:54 | Covered |
| 4.7.3.4.2 | 2600 | A PM may not be supplemented. | - | OPR | Yes (request check) | GAP A11; PM:54 | Covered |
| 4.7.3.4.3 | 2601 | A mission directive may not be supplemented. | - | OPR | Yes (request check) | GAP A11; PM:54 | Covered |
| 4.7.3.4.4 | 2602 | An instruction may be supplemented by a lower-level instruction or a GM unless it says it may not be. | - | OPR | Yes | GAP A11 (parent may forbid); PM:54; LD s5 Request supplement check | Covered |
| 4.7.3.4.5 | 2605 | A manual may be supplemented by a lower-level manual or a GM unless it says it may not be. | - | OPR | Yes | GAP A11; PM:54; LD s5 Request | Covered |
| 4.7.3.4.6 | 2607 | A GM may not be supplemented, but a GM may supplement an instruction or manual. | - | OPR | Yes | GAP A11; PM:54; PM:60 | Covered |
| 4.7.3.4.7 | 2609 | An operating instruction may not be supplemented. | - | OPR | Yes | GAP A11; LD s5 Request | Covered |
| 4.7.3.5 | 2610 | When the supplemented publication changes, the subordinate OPR holds a special review to determine currency. | T-2 | OPR | Yes | PM:62 (2.6.19); GAP A13 | Covered |
| 4.8.1 | 2613 | Obtain PM/GM templates from AFIMPT or the local PFM; general memorandum formatting in AFMAN 33-326 and HOI 33-3 applies; SecAF approves PMs. | - | OPR | Partial (local PFM template; PMs are HQ DAF) | DEC 2026-11-11 app replaces template (line 81). Renderer gap: no GM/memorandum template in PUB or templates/ | Renderer |
| 4.8.1.1 | 2617 | PMs and GMs show in the subject line whether they are a policy or guidance memorandum. | T-3 | OPR | Yes | Renderer gap: no memorandum mode | Renderer |
| 4.8.1.2 | 2619 | Request PM/GM control numbers from the PFM and place them above the date slot. | - | PFM | Yes | PM:54, PM:66, IR #9 (numbering); placement: Renderer gap | Renderer |
| 4.8.1.3 | 2621 | The actual date on a PM or GM is inserted at publication by the publishing authority. | - | PFM | Yes | PM:58; LD s5 Posting; placement: Renderer gap | Renderer |
| 4.8.2 | 2623 | Heading: the first paragraph of a PM or GM. | - | - | - | - | Info |
| 4.8.2.1 | 2624 | HQ DAF GMs start By Order of the Secretary of the Air Force; command and field GMs start By Order of the issuing commander. | T-3 | OPR | Yes | Renderer gap: no GM mode; F-013 covers publication header only | Renderer |
| 4.8.2.2 | 2631 | A GM that changes an existing publication starts with the fixed By Order of ... immediately implements changes ... Compliance is mandatory ... prevails IAW DAFI 90-160. | - | OPR | Yes | Renderer gap: fixed GM text not in PC | Renderer |
| 4.8.2.3 | 2639 | A GM with no existing publication starts with the first-instance wording. | - | OPR | Yes | Renderer gap: fixed GM text not in PC | Renderer |
| 4.8.2.4 | 2646 | A GM supplementing a higher headquarters publication with no existing supplement starts with the first-instance supplement wording. | - | OPR | Yes | Renderer gap: fixed GM text not in PC | Renderer |
| 4.8.3 | 2654 | A new policy or guidance publication issued as a GM includes releasability, applicability, the records management statement and other standard 4.5 statements. | - | OPR | Yes | format-rules F-025 builds these for publications; Renderer gap: no GM mode | Renderer |
| 4.8.4 | 2657 | PMs and all GMs end with one of two void-after-one-year statements. | T-1 | OPR | Yes | GM expiry tracking: SCH PFMProductIndex.ExpirationDate, PM:60; text: Renderer gap | Renderer |
| 4.8.4.1 | 2659 | Statement: void after one year, or on publication of an IC or rewrite of the affected publication, whichever is earlier. | - | OPR | Yes | PM:60 (expire after 1 year or on IC/rewrite); text: Renderer gap | Renderer |
| 4.8.4.2 | 2662 | Statement: void after one year, or on publishing a new publication permanently establishing the guidance, whichever is earlier. | - | OPR | Yes | PM:60; text: Renderer gap | Renderer |
| 4.8.5 | 2665 | The approver does not sign the memorandum; insert only an authentication block; the completed DAF Form 673 is the approval. | T-3 | OPR | Yes | format-rules F-034 (publications); DEC 2026-11-12 Q4A (line 24); GM output: Renderer gap | Renderer |
| 4.8.6 | 2671 | Reissue a PM or GM up to one more year: legal review at least 30 days before expiry, documented on the 673, signed by certifier and approver. | T-1 | OPR | Yes | PM:59; GAP A10; LD s2 Reissue Guidance Memorandum. The 30-day lead time before expiry is not tracked | Partial |
| 4.9 | 2678 | Visual aids use series and control number, name the attributed directive publication, show releasability and a supersession line, placed bottom right. | - | OPR | No (non-directive; not tracked) | DEC 2026-11-11 directive-only tracking (line 44) | N/A |
| 4.10 | 2685 | Heading: standalone command or field publications. | - | - | - | - | Info |
| 4.10.1 | 2686 | A wing issuing standalone publications gives AFDPO a camera-ready version for posting; AFDPO does not tag it. | T-3 | OPR | Partial (ANG wing posts itself; camera-ready applies) | format-rules F-000; ARCH:76; DEC 2026-11-10 (line 103) | Renderer |
| 4.10.2 | 2692 | Wing OPRs deliver updates fully formatted, integrated and camera-ready; integrate ICs and attach any AC or GM before publishing. | T-3 | OPR | Yes | GAP B9; LD s5 IC or rewrite gate; PM:68 (Rule 2 full text); format-rules F-000 | Covered |

Row count: 326. Status counts: Covered 41, Partial 11, Gap 4, N/A 63, Info 39, Renderer 168. Of the Renderer rows, 50 name a Renderer gap and 118 cite an existing format-rules ID or code.

## Gaps

Gap, Partial and Renderer-gap rows. Severity: high = blocks a correct ANG wing publication or form action; medium = a required step, record or format element not handled; low = advisory or rare.

| Para | Line | What is missing | Severity | Suggested fix |
|---|---|---|---|---|
| 3.1.2 | 1406 | [Partial] PM:10 ("existing pubs"); LD s3 Directive Guidance Moved (rescind side). No Product Index subject search or duplicate check | low | Add a duplicate-subject prompt to the PFM Guidance row for stage 1 (Done When: Product Index searched); optional view of PFM Product Index by Series |
| 3.1.4 | 1417 | [Partial] PM:10 ("contact PCM/PFM"); LD s3 PFM Offices PCM (optional person). Impact or risk statement not recorded | low | Add a Reason/Impact text to the request (PFM Publications Change Rationale, LD s3) and a stage 1 PFM Guidance Done When |
| 3.1.8 | 1426 | [Partial] LD s3 Directive Guidance Moved (rescind side); PM:10. Higher-authority review is not recorded | low | PFM Guidance Done When for stage 1; Product Index Implements (LD s3) records the antecedent only after posting |
| 3.2.2 | 1440 | [Partial] LD s3 PFM Publications Summary Of Changes, Change Rationale (B8); no content check | low | Content judgement; add to PFM Guidance stage 2 Done When |
| 3.2.3 | 1442 | [Partial] PM:21 (Administrative Change variant, 7.8.10); no trigger when PFM Offices or a parent changes. GAP A13 covers parent change only for special review | low | Flow: when an office symbol changes in PFM Offices, list Product Index rows whose OPR lookup uses it and offer an Administrative Change |
| 3.2.4 | 1445 | [Partial] PM:21 (Administrative Change); SCH PFMReviews (periodic review, 7.4.2); LD s2 Action Type Change OPR | low | Same flow as 3.2.3; ongoing check is not a scheduled item |
| 4.3.2 | 1630 | [Partial] PM:54 (PFM assigns, approves every number); LD s3 Number Approved. Uniqueness not enforced: SCH PFMProductIndex.PublicationNumber has no unique flag | low | Make Publication Number unique and indexed on PFM Product Index, or add a flow duplicate check at Number Approved |
| 4.3.3 | 1634 | [Partial] FR F-024, F-025 (antecedent in opening paragraph); LD s3 Product Index Implements (set at posting). No antecedent field at number request | low | Add Antecedent Publication (text) to the request on PFM Publications, copied to Product Index Implements |
| 4.3.5 | 1645 | [Gap] When consolidating publications use one number or a new one and supersede both; keep written owner concurrence; update implementing/supplementing publications. | low | Add action Consolidate (or a Consolidates field) with Concurrence Link on PFM Publications; flow opens Administrative Change/IC on child rows (Parent Publication) when a number changes |
| 4.3.6 | 1652 | [Gap] When publications of different OPRs are combined, the AO states concurrence designating the owner on the DAF Form 673; children updated. | low | Same Consolidate action: Concurrence Link and Owner OPR checked at the package gate (LD s5 Before Formal Coordination) |
| 4.3.10 | 1722 | [Partial] LD s3 Product Index Markings, Access Level (CUI); DEC 2026-11-11 (5) (line 42). Renderer has no CUI banner or portion marking | low | Renderer: optional CUI marking block when Access Level = CUI; or PFM Guidance text |
| 4.4 | 1727 | [Gap] AO reviews higher-level policy and publications; OPR confirms the implemented publication gives its organization implementation authority. | low | PFM Guidance Done When for stages 1-2 (Audience AO), cite 4.4; optional Authority Reference text on request |
| Table 4.1 Volumes | 1771 | [Renderer gap] Renderer gap: F-009 omits volumes; PUB body has chapters and paragraphs only | low | Add volumes to F-009 and the schema, or record that wing publications are single-volume |
| Table 4.1 Parts | 1773 | [Renderer gap] Renderer gap: F-009 omits parts; no parts in PUB | low | Same as Volumes |
| Table 4.1 Sections | 1776 | [Renderer gap] format-rules F-009 states it; Renderer gap: PUB chapter has no section level | low | Add a sections level to PUB chapter and New-Publication.ps1, or note sections unsupported |
| 4.5.3.9 | 1820 | [Renderer gap] CRM has a Line column (PM:38); Renderer gap: F-010 draft mode does not turn on line numbers | low | Add continuous line numbers to draft mode in New-Publication.ps1 and a rule under F-010 |
| 4.5.4.6.3 | 1871 | [Renderer gap] Renderer gap: F-018 does not compare to the parent title (Product Index Parent Publication available) | low | Add a lint to F-018: supplement title equals Parent Publication title; needs Publication Type in meta |
| 4.5.5 (no policy) | 1923 | [Renderer gap] Renderer gap: no rule in format-rules | low | Add warn rule to F-025: opening purpose text with must/will compliance language |
| Table 4.4 Note 1 | 1988 | [Renderer gap] Renderer gap: no lint | low | Add warn lint on "Space Force Reserve/Guard" to F-025 |
| 4.5.5.8 | 2030 | [Renderer gap] format-rules F-025 (fixed text, PC:6-7); no process to check SAF/CNZA for an updated statement | low | Add a yearly PFM Settings reminder to recheck the records statement; record text version in PFM Settings |
| 4.5.5.11 Note 1 | 2074 | [Renderer gap] Not in plan | low | Add warn lint: wing publication mentions exercise/contingency without a waiver authority paragraph; PFM Guidance text |
| 4.5.5.11 Note 2 | 2078 | [Renderer gap] Not in plan (same as Note 1) | low | Same as Note 1 |
| 4.5.9.5.2.2 | 2161 | [Gap] Instructions and manuals will not contain policy; policy is reserved for PDs. | low | PFM review checklist item at stage 5 (PFM Guidance, Audience PFM); no lint possible |
| 4.5.9.6.3 | 2172 | [Renderer gap] Renderer gap: no rule | low | Add warn lint to F-030 or a PFM review item; no tier on wing text (F-040) |
| 4.5.9.6.4 | 2174 | [Renderer gap] Renderer gap: F-039/F-040 do not exclude the responsibilities section | low | Add lint: no tier marks inside the responsibilities section |
| 4.5.9.7.4.3 | 2230 | [Renderer gap] Renderer gap: F-033 omits section titles; PUB has no sections | low | Add with the Sections level (Table 4.1 Sections row) |
| 4.5.9.7.4.9 | 2240 | [Renderer gap] format-rules F-037 (Note, Exception); Warning not in PUB (renderer gap) | low | Add warnings to PUB paragraph (warnings array) and F-037 |
| 4.5.9.7.4.10 | 2241 | [Renderer gap] Renderer gap: F-033 omits; PUB openingParts.copyright renders plain text (PC:16) | low | Add copyright notice bolding to F-033 and PC:16 output |
| 4.5.9.7.4.11 | 2242 | [Renderer gap] Partial: sample prompt R4 bolds table and figure references only; F-033 omits | low | Add internal paragraph references to F-033 and prompt rule R4 |
| 4.5.9.7.4.14.3 | 2251 | [Renderer gap] Renderer gap: NP:467 bolds the symbol only, not the spelled-out title; not in F-033 | low | Confirm against DAFMAN page 110 and add to F-033 and NP:467 |
| 4.5.9.7.4.14.4 | 2255 | [Renderer gap] Renderer gap: NP:467 bolds terms only, definitions plain | low | Confirm against DAFMAN Attachment 1 and add to F-033 |
| 4.5.9.7.6 | 2261 | [Renderer gap] Renderer gap: no rule | low | Reviewer checklist item at stage 5 (PFM Guidance); lint not practical |
| 4.5.9.7.7 | 2267 | [Partial] Legal mandatory coordinator (PM:42, PM:15); no lint | low | Add keyword warn lint (retirees, dependents, contractors) to F-025/W rules |
| 4.5.11.1.1 | 2283 | [Renderer gap] format-rules F-035 (no URLs only); Renderer gap: hierarchy order and original-date rule not in F-035 | low | Add hierarchy-order and date-form checks to F-035 (Table A4.1 is in another range) |
| 4.5.11.1.4.1 | 2305 | [Renderer gap] Renderer gap: F-032 checks listing, not meaning | low | Add consistency lint to F-032 |
| 4.5.11.1.4.2 | 2307 | [Renderer gap] Renderer gap: no rule | low | Add duplicate-acronym lint to F-032 |
| 4.5.11.1.6.1 | 2318 | [Renderer gap] Renderer gap: no rule | low | Add warn lint ("means", "is defined as" in body) to W rules |
| 4.5.11.1.6.2 | 2320 | [Renderer gap] Renderer gap: no rule | low | Add unused-term lint to F-035 |
| 4.5.11.1.6.3 | 2322 | [Renderer gap] Renderer gap: no rule | low | PFM review item at stage 5 |
| 4.6.1 | 2332 | [Renderer gap] Renderer gap: no citation rules in format-rules (Attachment 4 is in another range) | low | Add a citation rule group to format-rules (4.6.1.1-4.6.1.5) with warn lints |
| 4.6.1.1 | 2337 | [Renderer gap] Renderer gap: no rule (F-035 lists references only) | low | Lint: indefinite phrases ("in current directives") and body references missing from Attachment 1 |
| 4.6.1.2 | 2343 | [Renderer gap] Legal coordination verifies (PM:15); no lint | low | PFM review item; no automated check |
| 4.6.1.3 | 2359 | [Renderer gap] Renderer gap: no rule | low | PFM review item at stage 5 |
| 4.6.1.4 | 2369 | [Renderer gap] format-rules F-024 (antecedent only); sample prompt R4 italic titles; later-use rule not checked | low | Add lint to F-035/F-024: full title only at first use |
| 4.6.1.5.1 | 2377 | [Renderer gap] Renderer gap: no rule | low | PFM review item |
| 4.6.1.5.2 | 2383 | [Renderer gap] Renderer gap: no rule | low | PFM review item |
| 4.6.1.5.3 | 2386 | [Renderer gap] Renderer gap: no rule | low | PFM review item |
| 4.6.2.1 | 2395 | [Renderer gap] format-rules F-037 (bold, colon); Renderer gap: placement and superscript references not in rule or PUB table | low | Add table notes array and superscript refs to PUB table and F-037 |
| 4.6.2.2 | 2401 | [Renderer gap] Renderer gap: PUB has no footnote or endnote field | low | Add notes/endnotes to PUB and a rule; or state they are unsupported |
| 4.6.3 | 2404 | [Renderer gap] format-rules F-037; Renderer gap: table exception placement | low | Same fix as 4.6.2.1 |
| 4.6.5.1.2.1 | 2447 | [Renderer gap] Renderer gap: no pronoun lint in Test-Publication.ps1 or format-rules | low | Add warn lint for you/your/we/our to W-004 |
| 4.6.5.3.1 | 2476 | [Renderer gap] Renderer gap: Publication Type is not in PUB meta, so no lint | low | Add publicationType to PUB meta; F-040 lint flags any tier in an OI |
| 4.6.5.3.3 | 2479 | [Renderer gap] Renderer gap: F-025 waiver statement (PC:14) is fixed text with no squadron-commander variant | low | Add waiverVariant slot to PUB openingParts |
| 4.7.2.2 | 2568 | [Renderer gap] Renderer gap: no (Added) tag support in PUB or New-Publication.ps1 | low | See 4.7.3.2 fix; only if a wing supplements a DAF supplement to a DoD issuance |
| 4.7.2.4 | 2574 | [Renderer gap] Renderer gap: PUB has no added-material-only mode | low | See 4.7.3.1 fix |
| 4.7.3.1 | 2580 | [Renderer gap] PUB meta.integratedSupplement; Renderer gap: no standalone added-material-only output | medium | Add supplement mode to PUB and New-Publication.ps1: standalone (added paragraphs only, parent numbers) and integrated (full text, F-014 seal) |
| 4.7.3.2 | 2584 | [Renderer gap] Renderer gap: no (Added) or (Added-<unit>) support; PM:68 only says wing ICs omit (Added) | medium | Add (Added) and (Added-<unit>) tagging and bold to the renderer for supplements; new format-rules IDs |
| 4.7.3.3 | 2591 | [Renderer gap] Renderer gap: same as 4.7.3.2 | medium | Same as 4.7.3.2; add rule for repeated parent numbers (4.1.1. (AMC)) and Figure 2.1 / Table 3.1 numbering |
| 4.8.1 | 2613 | [Renderer gap] DEC 2026-11-11 app replaces template (line 81). Renderer gap: no GM/memorandum template in PUB or templates/ | medium | Add a GM mode (memorandum layout per AFMAN 33-326) to PUB and New-Publication.ps1, or a GM Word template in templates/ built by script |
| 4.8.1.1 | 2617 | [Renderer gap] Renderer gap: no memorandum mode | medium | Same GM mode (meta.memoType) |
| 4.8.1.2 | 2619 | [Renderer gap] PM:54, PM:66, IR #9 (numbering); placement: Renderer gap | medium | Same GM mode |
| 4.8.1.3 | 2621 | [Renderer gap] PM:58; LD s5 Posting; placement: Renderer gap | low | Same GM mode: (Date) placeholder, final mode dates at posting |
| 4.8.2.1 | 2624 | [Renderer gap] Renderer gap: no GM mode; F-013 covers publication header only | medium | Same GM mode |
| 4.8.2.2 | 2631 | [Renderer gap] Renderer gap: fixed GM text not in PC | medium | Same GM mode: add fixed statement to PC:5 table |
| 4.8.2.3 | 2639 | [Renderer gap] Renderer gap: fixed GM text not in PC | medium | Same GM mode |
| 4.8.2.4 | 2646 | [Renderer gap] Renderer gap: fixed GM text not in PC | medium | Same GM mode |
| 4.8.3 | 2654 | [Renderer gap] format-rules F-025 builds these for publications; Renderer gap: no GM mode | medium | Same GM mode: reuse Get-OpeningParagraph slots |
| 4.8.4 | 2657 | [Renderer gap] GM expiry tracking: SCH PFMProductIndex.ExpirationDate, PM:60; text: Renderer gap | medium | Same GM mode: fixed last-paragraph statement |
| 4.8.4.1 | 2659 | [Renderer gap] PM:60 (expire after 1 year or on IC/rewrite); text: Renderer gap | medium | Same GM mode |
| 4.8.4.2 | 2662 | [Renderer gap] PM:60; text: Renderer gap | medium | Same GM mode |
| 4.8.5 | 2665 | [Renderer gap] format-rules F-034 (publications); DEC 2026-11-12 Q4A (line 24); GM output: Renderer gap | low | Same GM mode |
| 4.8.6 | 2671 | [Partial] PM:59; GAP A10; LD s2 Reissue Guidance Memorandum. The 30-day lead time before expiry is not tracked | low | Flow: reminder at Expiration Date minus 45 days on the Product Index row; legal review date on the Reissue action |

Gap-list rows: 72.

## Observations (plan text that conflicts with the DAFMAN or with itself)

1. PM:12 (stage 3 "Pre-coordination (optional)", ref 3.3) and SCH PFMProcessSteps seed step 3 cite 3.3, which is the HQ DAF ETMS2 staffing paragraph. Only its sentence that ETMS2 is optional for collaboration before formal coordination has a wing meaning. The stage is a plan choice, not a DAFMAN stage. Suggested fix: cite 3.3 as "by analogy" or drop the paragraph reference.
2. PM:14 (stage 5) and SCH PFMProcessSteps seed step 5 say "Word draft (flush left)". DAFMAN 3.8.1 exempts camera-ready publications from left-flush, and format-rules F-012 and S-001 already treat 3.8 as an e-Publishing rule. A flush-left draft is only needed if the wing wants one; fix the stage text or state it is a PFM choice.
3. 4.5.5.11 fixed waiver statement (PC:14, format-rules F-025) says authorities are "identified with a tier number following the compliance statement". PFM decision F-040 (DEC line 14) removes tier marks on wing statements. The sentence 4.5.5.11 allows "a reference to an internal paragraph" instead. Suggested fix: a PFM decision on the wing wording, then a second fixed text in PC.
4. format-rules.md "Open" (line 75) says the literal wording of Tables 4.2-4.5 is not extracted, but PC:11-12 already holds Table 4.5 items 2 and 3 verbatim. Update the note. Tables 4.2 and 4.3 are examples with no fixed text, so the free-text slots in PUB are correct; Table 4.2 has no example for a wing site, so F-020 should say the statement must name the wing site or the OPR.
5. F-015 (type and number prefix) is in format-rules but no F-015 check was found in scripts/gov/Test-Publication.ps1 or New-Publication.ps1 (ids searched by comment tag).
6. 4.3.7.2 reissue (T-1) is listed under "Numbering Departmental Publications" but 4.3.8.2 and 4.8.6 repeat it for command and field GMs; the plan treats it as applying to wing GMs (PM:59), which is correct.
