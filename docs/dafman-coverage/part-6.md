# Part 6: lines 6715-8146

Abbreviations in Covered by: pm = docs/process-model.md; ld = docs/reviews/2026-11-12-list-design-full-scope.md; gc = docs/reviews/2026-11-12-dafman-full-gap-check.md; dec = docs/DECISIONS.md; fr = docs/format-rules.md; arch = docs/ARCHITECTURE.md. A number after the colon is a line in that file. Schema names are in schemas/lists/. Approved design items (ld) are not yet in schemas/lists/ (no PFMWaivers, PFMRecommendations or PFMGuidance schema exists yet).

| Para | Line | Requirement (own words, max 25 words) | Tier | Actor | Applies to ANG wing | Covered by | Status |
|---|---|---|---|---|---|---|---|
| Figure A5.1 step 1 PFM | 6724 | AO contacts the Approving Official's PFM for review of format, structure and advice on the action | - | AO | Yes | pm:10 (stage 1 "contact PCM/PFM", 3.1) | Covered |
| Figure A5.1 step 1 PCM | 6726 | Contact the PCM (if assigned) to size the changes, set coordination priority and list coordinators | - | AO | Partial (priority level is an ETMS2 term) | ld:43 (PCM column on PFM Offices); pm:10 stage 1 | Partial |
| Figure A5.1 step 1 SMEs | 6728 | Use SMEs and working groups; let organizations named in the draft's roles review and give input | - | AO | Yes | pm:11 stage 2 (drafting with SMEs); pm:42 (AO adds functional-interest offices, 5.1.3). No prompt for organizations named in draft roles | Partial |
| Figure A5.1 step 1 proofread | 6730 | Proofread and edit until a fully developed draft exists | - | AO | Yes | pm:11 stage 2 exit "Draft meets format rules"; fr:34 F-010 | Covered |
| Figure A5.1 step 1 note | 6731 | Before rescinding, move any mandatory directive guidance into another publication such as a Guidance or Policy Memorandum | - | AO | Yes | ld:37 (Directive Guidance Moved); ld:61 (rescind gate) | Covered |
| Figure A5.1 step 2 tools | 6736 | Staff the publication/form package to required offices with approved collaborative tools | - | AO | Yes (90-161.Z is the wing's tool) | arch:35-43 (section 4 endorsement flow) | Covered |
| Figure A5.1 step 2 ETMS2 task | 6738 | For DAF publications create an ETMS2 task, set its priority, use the standard task names | - | AO | No (DAF-level ETMS2 task) | - | N/A |
| Figure A5.1 step 2 title change | 6741 | If the title or type changes, the ETMS2 task shows the new type and title | - | AO | No (ETMS2 task only) | - | N/A |
| Figure A5.1 step 2 summary | 6742 | Include a summary of changes (4.5.6, if applicable) and the rationale for each change | - | AO | Yes | ld:28 (Summary Of Changes, Change Rationale); ld:56 (gate before Formal Coordination) | Covered |
| Figure A5.1 step 2 upload | 6743 | Upload draft, blank comment resolution matrix, DAF Form 673 and current version of the publication | - | AO | Yes | pm:14 stage 5 package; ld:28 (Current Version Link); templates/CRM_A12-1.docx; dec:24 (Q3A Working Files) | Covered |
| Figure A5.1 step 2 task coordinators | 6745 | Task mandatory and applicable coordinators to review and coordinate | - | AO | Yes | pm:42 (mandatory in PFM Offices, AO adds); arch:37-39 | Covered |
| Figure A5.1 step 2 AFIMPT dates | 6746 | Recommend the AO update start and completion dates in AFIMPT | - | AO | No (wing does not use AFIMPT) | arch:76 (risk row) | N/A |
| Figure A5.1 step 3 consolidated 673 | 6750 | Consolidated DAF Form 673 shows all coordination transcribed from the formal coordinators | - | AO | Yes | pm:55 (endorsements to a master 673); ld:29 (Master DAF Form 673 Link) | Covered |
| Figure A5.1 step 3 AF/JA | 6751 | For DAF publications AF/JA routes to SAF/GC as it deems appropriate | - | HQ DAF | No (departmental legal routing) | - | N/A |
| Figure A5.1 step 4 certifier | 6755 | Certifying official at the issuing level certifies need and consistency with implemented policy | - | certifier | Yes | pm:16 stage 7; pm:57 (certifier one level above OPR, 5.6.3.2) | Covered |
| Figure A5.1 step 4 package | 6757 | Package includes the 673 and shows whether comments are resolved or nonconcurs remain | - | AO | Yes | pm:14 stage 5 exit; ld:29 (Open Nonconcurs); ld:57 | Covered |
| Figure A5.1 step 4 upload | 6759 | After the certifier signs the 673, upload the updated 673 and route for approval | - | certifier | Yes | dec:24 (Q4A digital signature, flow records dates); PFMPublications.json CertifiedDate | Covered |
| Figure A5.1 step 4 AFIMPT dates | 6761 | Recommend the AO update dates in AFIMPT | - | AO | No (wing does not use AFIMPT) | arch:76 | N/A |
| Figure A5.1 step 5 approver | 6765 | Approving authority at the issuing level implements policy and approves the package | - | approver | Yes | pm:17 stage 8; pm:42 (5.7) | Covered |
| Figure A5.1 step 5 SecAF | 6767 | Publications needing SecAF approval (e.g., PDs) follow HOI 33-3 routing | - | HQ DAF | No (SecAF/PD level only) | - | N/A |
| Figure A5.1 step 5 upload | 6772 | After the approver signs the 673, upload it in supporting documents and route for publishing | - | approver | Yes | dec:24 (Q4A, Q5A); PFMPublications.json ApprovedDate, DelegationLetterLink | Covered |
| Figure A5.1 step 5 AFIMPT dates | 6774 | Recommend the AO update dates in AFIMPT | - | AO | No (wing does not use AFIMPT) | arch:76 | N/A |
| Figure A5.1 step 6 send | 6778 | Send to the PFM for publishing; departmental products go to AFDPO | - | AO | Partial (PFM branch only) | pm:18 stage 9; pm:48 (system boundary) | Covered |
| Figure A5.1 step 6 AFIMPT | 6780 | Use AFIMPT to submit packages to be posted on the e-Publishing website | - | AO | No (wing site, not e-Publishing) | arch:76; pm:48 | N/A |
| Figure A5.1 step 6 final package | 6781 | Final package: signed 673, final draft in correct format, figure files, OPR and AO information | - | AO | Yes | pm:18 stage 9; dec:24 (Q5A upload, flow notifies PFM); fr:36 F-000 | Covered |
| Figure A5.1 step 6 close task | 6783 | AO closes the task when the publication is posted | - | AO | Partial (equivalent close in 90-161.Z) | pm:19 stage 10 exit "Posted on wing site". ActionStatus has no Closed value (PFMPublications.json) | Partial |
| Table A5.1 columns / Applies To | 6787 | Matrix gives per action which of coordination, OPR sign, certify, approve, create/change apply | - | PFM | Yes | dec:7 (Applies To column on PFM Process Steps decided); pm:21 (variants prose). Not in ld or schemas/lists/PFMProcessSteps.json | Partial |
| Table A5.1 Publications New | 6822 | New publication: coordination, certifying sign, approving sign; creates a publication | - | all | Yes | pm:9-19 (full path); pm:54 (numbering); PFMPublications.json ActionType New | Covered |
| Table A5.1 Publications Rewrite | 6823 | Rewrite: coordination, certify, approve; physically changes the publication | - | all | Yes | pm:21 ("Rewrite = stages 4-9") | Covered |
| Table A5.1 Publications IC | 6824 | Interim change: coordination, certify, approve; physically changes the publication | - | all | Yes | pm:21 ("interim change = stages 4-9"); ld:59 (IC absorbs GM and AC) | Covered |
| Table A5.1 Publications AC | 6825 | Administrative change: OPR sign and approving sign only; attached to publication, no physical change | - | all | Yes | pm:21 (no coordination, 3-Ltr/L3 approves, 7.8.10); pm:59, ld:54 (who starts, scope). OPR signature not a field | Partial |
| Table A5.1 Publications PM or GM | 6826 | PM/GM: legal review only (SAF/AA also for PMs); certify, approve; attached, no physical change | - | all | Partial (GM only; PM is HQ DAF) | pm:21 (GM = local legal review, 5.1.7); pm:60, pm:66; ld:59. Certify and approve steps not stated for GM | Partial |
| Table A5.1 Publications Periodic review | 6828 | Periodic review: OPR sign only; no coordination, certify or approve | - | all | Yes | pm:21 (399 within 30+ days); schemas/lists/PFMReviews.json (Periodic) | Covered |
| Table A5.1 Publications Certify current | 6829 | Certify Current: OPR sign and approving sign; marks the publication; no coordination or certifier | - | all | Yes | pm:21 (7.5.1, 7.5.2); pm:67 (7.5.3); PFMReviews.json Form399Link | Covered |
| Table A5.1 Publications Rescind | 6830 | Rescind: coordination, certify, approve; no creation or change mark | - | all | Yes | pm:61 (8.12); ld:61 (gates). Stage path not stated in pm:21 | Partial |
| Table A5.1 Publications Transfer | 6831 | Transfer: coordination, certify, approve | - | all | Yes | pm:59 (7.10.1 concurrence first); stage path not stated in pm:21 | Partial |
| Table A5.1 Forms New | 6834 | New form: coordination, certify, approve (no create mark printed) | - | all | Yes | ld:18 (form actions); ld:55 (form gates); gc:67 (E4 forms use endorsement workflow) | Covered |
| Table A5.1 Forms Revise | 6835 | Revise form: coordination, certify, approve | - | all | Yes | ld:18 ("Revise" Action Type for forms); gc:67 (E4) | Covered |
| Table A5.1 Forms Periodic review | 6836 | Form periodic review: OPR sign only | - | all | Yes | pm:21 (forms reviewed with publication, 8.11.3.2); PFMReviews.json | Covered |
| Table A5.1 Forms Certify current | 6837 | Form certify current: OPR sign and approving sign; response needs DAF Form 399 or 673 (note 4) | - | all | Yes | ld:18 (Certify Current for forms); pm:21; PFMReviews.json Form399Link | Covered |
| Table A5.1 Forms Rescind | 6838 | Form rescind: coordination, certify, approve | - | all | Yes | ld:18; pm:61 (A16 retained forms) | Covered |
| Table A5.1 Forms Transfer | 6839 | Form transfer: coordination, certify, approve | - | all | Yes | ld:18; pm:59 | Covered |
| Table A5.1 note 1 | 6842 | A GM must be followed by a new, rewrite or IC action within one year of publishing | - | OPR | Yes | ld:59; ld:58 (IC or rewrite gate); pm:66 | Covered |
| Table A5.1 note 2 | 6844 | PM/GM require only legal review; add SAF/AA review for PMs only | - | coordinator | Partial (GM legal review only) | pm:21 (GM = local legal review) | Covered |
| Table A5.1 note 3 | 6846 | OPR, AO and PCM decide coordinators; at least the mandatory ones | - | OPR | Yes | pm:42; ld:43 | Covered |
| Table A5.1 note 4 | 6849 | Certify Current response needs a completed DAF Form 399 or DAF Form 673 | - | OPR | Yes | pm:18 (stage 9, 399 for certify-current); PFMReviews.json Form399Link | Covered |
| Table A5.2 a drafting | 6855 | Drafting and editing goal 60 business days | - | AO | Yes | pm:11 (60); PFMProcessSteps.json seed step 2 | Covered |
| Table A5.2 b coordination | 6858 | Formal coordination goal 20 business days: 15 to coordinate, 5 to adjudicate comments | - | coordinator | Yes | pm:14 (20); pm:27 (15 days, 5.2). The 5 adjudication days are not a separate value | Partial |
| Table A5.2 c legal | 6861 | Legal review goal 20 business days; AF/JA decides SAF/GC review for departmental products | - | coordinator | Partial (legal 20 days only) | pm:15 (20) | Covered |
| Table A5.2 d certify | 6864 | Certify goal 10 business days including staffing to the certifier | - | certifier | Yes | pm:16 (10) | Covered |
| Table A5.2 e approve | 6866 | Approve goal 10 business days including staffing to the approver | - | approver | Yes | pm:17 (10) | Covered |
| Table A5.2 f publish | 6868 | Publish goal under 20 business days (table value 15), upload and submit to AFDPO or PMO | - | PFM | Partial (PMO branch; no AFDPO) | pm:19 stage 10 (15, steps 9-10 together). Text says "under 20", value says 15 | Covered |
| A6.1 | 6878 | Attachment 6 does not apply to flight manuals (AFI 11-215) | - | all | No (flight manuals not wing publications) | - | N/A |
| A6.2 submit on 847 | 6881 | All personnel recommend changes to DAF publications on DAF Form 847; emergency vs routine | - | all | Yes | ld:11 (PFM Recommendations: Emergency, Safety, Direction); pm:69 | Covered |
| A6.2 not for typos | 6885 | Do not use DAF Form 847 for omitted words, typos or print errors unless they mislead | - | all | Yes | - | Info |
| A6.3.1 channel | 6890 | Wing-level 847s go through MAJCOM/FLDCOM channels to the functional OPR; FOAs and DRUs via parent | - | OPR | Yes | dec:8 item 3 (outbound to ANG functional office at NGB); ld:11; pm:69 | Covered |
| A6.3.1 OPR authority | 6897 | Publication OPR (front page) accepts or not; acceptance does not change the publication; OPR starts IC, GM or rewrite | - | OPR | Yes | ld:11 (Follow-Up Action lookup, Incorporated); pm:69; gc:44 (B1) | Covered |
| A6.3.2 info copies | 6901 | Submitting MAJCOM forwards information copies to other using MAJCOMs; they send comments to the OPR | - | MAJCOM | No (MAJCOM function) | - | N/A |
| A6.3.3 disapproval | 6904 | Submitting unit, MAJCOM and OPR may disapprove; return down the chain with justification on the 847 | - | OPR | Yes | ld:11 (Disposition required on Disapproved); gc:44 (B1) | Covered |
| A6.3.4 final disposition | 6908 | OPR tells the submitting MAJCOM/FLDCOM the final disposition | - | OPR | Partial (inbound OPR to submitter) | ld:11 (Disposition, Disposition Date); ld:21 (Notice Sent event). No distinct notice to the submitting channel | Partial |
| A6.3.5 inform originator | 6910 | Inform the originator of the disposition at each level of the approval process | - | all | Yes | gc:44 (B1 notice to originator); ld:21 (Notice Sent). Status is not tracked per level | Partial |
| Table A6.1 Section 1 Blocks 1-3 | 6917 | Date submitted, publication number, publication name | - | all | Yes | ld:11 (Received Date; Product or Target Publication) | Covered |
| Table A6.1 Section 1 Blocks 4-5 | 6920 | Mark emergency incident and safety incident related | - | all | Yes | ld:11 (Emergency, Safety) | Covered |
| Table A6.1 Section 1 Blocks 6-7 | 6924 | Date of basic publication and date of latest IC | - | all | Yes | PFMProductIndex.json EffectiveDate; ld:11 has no column. The 847 file itself (DAF Form 847 Link) holds the block | Partial |
| Table A6.1 Section 1 Blocks 8-9 | 6927 | Page number and paragraph or figure of the recommended change | - | all | Yes | ld:11 (Paragraph; page held on the 847 file) | Partial |
| Table A6.1 Section 1 Blocks 10, 13 | 6931 | Not applicable (flight manuals only) | - | all | No (flight manuals only) | - | N/A |
| Table A6.1 Section 1 Blocks 11-12 | 6934 | List the OPR; note attached supporting documents, legible and showing what is wrong | - | all | Yes | PFMProductIndex.json OPR (via Product); ld:11 (DAF Form 847 Link holds attachments) | Covered |
| Table A6.1 Section 1 Blocks 14-16 | 6942 | Text to change, proposed text, rationale; "EMERGENCY RECOMMENDATION" first for emergencies | - | all | Yes | ld:11 (Proposed Change, Rationale, Emergency) | Covered |
| Table A6.1 Section 2 Blocks 17-22 | 6953 | Originator's organization, DSN, phone, mailing address, e-mail, organizational level | - | all | Yes | ld:11 (Originator person column). Organizational level (block 22) not stored | Partial |
| Table A6.1 Section 2 Blocks 23-24 | 6962 | Originator name, grade and signature | - | all | Yes | ld:11 (Originator); signature on the 847 file (DAF Form 847 Link) | Covered |
| Table A6.1 Sections 3-8 intro | 6964 | Use sections 3-8 from the originator's level upward; each level signed by commander or director | - | commander | Partial (wing and below) | ld:11 (functional chain note); no per-level coordination record | Partial |
| Table A6.1 Section 3 tracking number | 6970 | The initiating level's PFM assigns the tracking number | - | PFM | Yes | ld:11 (Tracking Number, PFM assigns); ld:21 (Number Assigned event); gc:44 | Covered |
| Table A6.1 Section 3 concurrence | 6973 | Mark level of concurrence; "CONCUR WITH REMARKS" with suggested wording; "NONCONCUR" returns the form to the originator | - | commander | Yes | ld:11 Recommendation Status has no Concur or Returned value | Gap |
| Table A6.1 Section 3 routing | 6981 | Route to next organizational level with information copy to the originator | - | PFM | Yes | ld:11 (Recommendation Status With OPR); ld:21 (Notice Sent). No route-to-next-level step | Partial |
| Table A6.1 Section 4 group | 6986 | Group level concurrence, same marks and routing as Section 3 | - | commander | Yes | Same gap as Section 3 concurrence | Gap |
| Table A6.1 Section 5 wing | 6996 | Wing/Delta concurrence, same marks and routing; nonconcur returns to originator | - | commander | Yes | Same gap as Section 3 concurrence | Gap |
| Table A6.1 Section 6 NAF | 7006 | Numbered Air Force concurrence, same marks and routing | - | commander | No (NAF level, above wing) | - | N/A |
| Table A6.1 Section 7 MAJCOM | 7019 | MAJCOM/FLDCOM/DRU/FOA concurrence, same marks and routing | - | MAJCOM | No (above wing; ANG uses NGB) | dec:8 item 3 | N/A |
| Table A6.1 Section 8 HQ DAF | 7029 | HQ DAF concurrence; route to publication OPR with information copy to originator | - | HQ DAF | No (HQ DAF level) | - | N/A |
| Table A6.1 Section 9 intro | 7038 | OPR makes final review; completing the 847 does not change the publication; OPR returns form to originator and keeps a copy in the record set | - | OPR | Yes | ld:11 (Follow-Up Action, DAF Form 847 Link); ld:50 (Record Sets). No gate that a copy is filed | Partial |
| Table A6.1 Blocks 25-30 | 7049 | Publication OPR symbol, Approve or Disapprove, remarks, approver name and title, signature, date of final action | - | OPR | Yes | ld:11 (Recommendation Status Approved/Disapproved, Disposition, Disposition Date). Header says blocks 25-31, text lists 25-30 | Covered |
| A7.1 design guidelines | 7061 | Forms must be easy to fill in, logical and well laid out; GSA handbook; waiver when function precludes the standard | - | all | Yes | - | Renderer: Renderer gap |
| A7.1 waiver | 7070 | A waiver of these form design standards may be granted for a special requirement | - | approver | Yes | ld:12 (PFM Waivers is for tier waivers only). No form-design waiver record | Gap |
| A7.2.1 size | 7073 | Printed forms are 8.5 x 11 inches except postcards | - | all | Yes | - | Renderer: Renderer gap |
| A7.2.2 postcard | 7074 | Postcard forms 3.5 x 5 inches minimum, 4.25 x 6 inches maximum | - | all | Yes | - | Renderer: Renderer gap |
| A7.2.3 two-page | 7076 | Two-page forms need not be printed front and back unless the OPR requires it | - | all | Yes | - | Renderer: Renderer gap |
| A7.3.1 border | 7079 | Body of the form is enclosed in a lined border except certificates, tags, labels | - | all | Yes | - | Renderer: Renderer gap |
| A7.3.2 border weight | 7081 | Border is 1.5 point solid on all four sides | - | all | Yes | - | Renderer: Renderer gap |
| A7.3.3 margins | 7082 | Page margins are 0.5 inch unless special requirements | - | all | Yes | - | Renderer: Renderer gap |
| A7.3.4 section lines | 7083 | 1 point solid lines divide primary sections | - | all | Yes | - | Renderer: Renderer gap |
| A7.3.5 hairlines | 7084 | Hairline type for lines within sections | - | all | Yes | - | Renderer: Renderer gap |
| A7.4.1 box style | 7086 | Box style with upper-left captions on fillable fields | - | all | Yes | - | Renderer: Renderer gap |
| A7.4.2 order | 7087 | Items numbered in fill-in order, number at upper left before the caption | - | all | Yes | - | Renderer: Renderer gap |
| A7.4.3 grouping | 7089 | Group common items; sections allowed; section title flush left | - | all | Yes | - | Renderer: Renderer gap |
| A7.4.4 typed name | 7092 | Separate field from signature for the signer's typed name (NARA) | - | all | Yes | - | Renderer: Renderer gap |
| A7.4.5 mailers | 7094 | Mailers and self-mailers follow USPS regulations | - | all | Yes | - | Renderer: Renderer gap |
| A7.5.1 fonts | 7100 | Arial for captions; Times New Roman 10 point for fillers | - | all | Yes | - | Renderer: Renderer gap |
| A7.5.2 italics | 7102 | Optional italics for words, phrases or instructions in parentheses | - | all | Yes | - | Renderer: Renderer gap |
| Table A7.1 items 1-7 | 7105 | Table A7.1 font sizes and casing for title, disclosure, PAS, section, caption, number and supersession text | - | all | Yes | - | Renderer: Renderer gap |
| A7.6.1 title | 7118 | Title at top center or left inside border; brief; no words such as "form" or "label" | - | all | Yes | - | Renderer: Renderer gap |
| A7.6.2.1 number placement | 7123 | Form number and edition date bottom left margin outside the border | - | all | Yes | - | Renderer: Renderer gap |
| A7.6.2.2 designation | 7125 | Designation in capitals showing scope (AF, ACC, 375 WG) | - | all | Yes | - | Renderer: Renderer gap |
| A7.6.2.3 number | 7127 | "Form" follows the designation then the number; numbers assigned in sequence as forms are created | - | PFM | Yes | gc:45 (B2 form number next in sequence). ld:54 numbering gate names publications only | Partial |
| A7.6.2.4 edition date | 7130 | Edition date YYYYMMDD under the number; placeholder for coordination; local PFM sets the official date at publication | - | PFM | Yes | ld:42 (Edition Date); ld:60 (form locked and dated); gc:45 (B2) | Covered |
| A7.6.3 reverse page | 7136 | Second page shows "(Reverse)" if printed front and back, else "Page ___ of ___" | - | all | Yes | - | Renderer: Renderer gap |
| A7.6.4 prescribing publication | 7143 | Identify the prescribing publication on new and revised forms (footer or title block) | - | OPR | Yes | ld:55 (Prescribing Publication gate); PFMProductIndex.json PrescribingPublication. Print placement is a designer task | Covered |
| A7.7 releasability | 7146 | Releasability statement at the bottom only if access is restricted, with fixed preface | - | OPR | Yes | ld:35 and ld:42 (Access Level). Statement text on the form is not rendered | Renderer: Renderer gap |
| A7.8 supersession notice | 7154 | Centered supersession notice at the bottom outside the border (e.g., PREVIOUS EDITIONS ARE OBSOLETE) | - | all | Yes | gc:68 (E5 supersession text on corrective action). Placement not rendered | Renderer: Renderer gap |
| A7.9 non-standard software | 7159 | If AFDPO software is not used, show the software name and vendor lower right on page 1 | - | all | Yes | - | Renderer: Renderer gap |
| A7.10 OMB and RCS | 7164 | Public-collection forms show OMB control number and expiration; internal-collection forms have an RCS block | T-0 | all | Yes | ld:33 (Information Collection); ld:42 (OMB Number, OMB Expiration); ld:62 (RCS block named under Renderer). No forms renderer | Partial |
| A7.10.1 RCS position | 7168 | RCS block top right inside border; OMB block above it if both | - | all | Yes | ld:62 names the RCS block; format-rules has no forms rule | Renderer: Renderer gap |
| A7.10.2 RCS not printed | 7173 | OMB number and date are part of the approved form; RCS block must exist but number is not listed | T-0 | all | Yes | ld:62; format-rules has no forms rule | Renderer: Renderer gap |
| A7.10.3 disclosure notice | 7177 | Forms with an OMB number show the agency disclosure notice below the title and OMB number | T-0 | all | Yes | ld:33 (Information Collection = Public); no forms renderer | Renderer: Renderer gap |
| Table A7.2 notice text | 7184 | DoD agency disclosure notice wording (burden, WHS, OMB statement) | - | all | Yes | - | Renderer: Renderer gap |
| A7.11 PAS placement | 7196 | Privacy Act statement on the face, back, tear-off, or separate sheet, with fixed notations | - | OPR | Yes | ld:42 (Privacy Act Statement Included); placement not rendered | Renderer: Renderer gap |
| A7.12 instructions | 7207 | Place instructions consistently; brief in captions, tool tips, columns, or separate page; long ones in the publication | - | all | Yes | - | Renderer: Renderer gap |
| A7.13 acronyms | 7216 | Spell out acronyms at first use then use the acronym | - | all | Yes | fr:57 F-032 covers publications only | Renderer: Renderer gap |
| A7.14 graphics | 7220 | No decorative illustrations or official logos; only functional graphics | - | all | Yes | - | Renderer: Renderer gap |
| A7.15.1 field names | 7227 | Use the OPR's data elements if the form has a database | - | OPR | Yes | ld:42 (Data Fields Collected, ld:30) | Partial |
| A7.15.2 field format | 7229 | Fixed field lengths per data standards (DoDI 8320.02), consistent across forms | - | all | Yes | - | Renderer: Renderer gap |
| A7.15.2.1 date field | 7233 | Date field is YYYYMMDD, 8 characters fixed | - | all | Yes | - | Renderer: Renderer gap |
| A7.15.2.2 ID fields | 7235 | SSN field numeric NNN-NN-NNNN if approved; DoD ID 10-digit numeric | T-0 | all | Yes | ld:42 and gc:46 (B3 collects-PII flags). Field format not rendered | Renderer: Renderer gap |
| A7.15.2.3 addresses | 7238 | Addresses may be separate items per component; database-friendly entry | - | all | Yes | - | Renderer: Renderer gap |
| A7.15.3 signature fields | 7240 | Separate block for the signer's typed name (NARA) | T-0 | all | Yes | - | Renderer: Renderer gap |
| A7.16 testing | 7242 | Form designer, AFDPO and OPR test the completed electronic form before release | - | OPR | Yes | - | Gap |
| A7.17 accessibility | 7244 | Design simple, usable forms with meaningful captions and clear instructions for all users | - | all | Yes | ld:38 and ld:42 (Section 508 Checked); gc:47 (B4) | Covered |
| A7.18 locking | 7246 | Final electronic forms are locked by the final publishing activity (local PFM below wing) | T-0 | PFM | Yes | ld:42 (Locked); ld:60; gc:45 (B2) | Covered |
| A8.1 physical products | 7256 | Order Portal steps to update a general account for physical products | - | all | No (Order Portal user account, not wing posting) | - | N/A |
| A8.2 electronic CUI | 7263 | WMS steps to verify personal information for electronic CUI products | - | all | No (WMS user account) | - | N/A |
| A9.1 account request | 7277 | Steps to request an organizational ordering account on DAF Form 1846; sent to AFDPO | - | all | No (AFDPO physical-product account) | - | N/A |
| A9.2 order status | 7290 | Users check order status in Order Portal | - | all | No (Order Portal use) | - | N/A |
| Table A10.1 T-0 | 7305 | T-0 may appear at any level; no DAF waiver; request goes through command channels to HQ DAF OPR for non-DAF authority | T-0 | commander | Partial (wing repeats T-0, no waiver path) | fr:65 F-040 (keep T-0); dec:14; ld:12 Tier list has no T-0 | Partial |
| Table A10.1 T-1 | 7368 | T-1 is departmental level only; MAJCOM/CC waives (ANG: NGB/CF, delegable no lower than ANGRC/CC) with approver coordination | T-1 | commander | Partial (wing repeats HHQ T-1 only) | fr:65 F-040; ld:12 (PFM Waivers Tier, Waiver Approver). No authority check; wing-originated T-1 not flagged | Partial |
| Table A10.1 T-2 | 7442 | T-2 is for departmental, MAJCOM/FLDCOM and ANG levels; MAJCOM/CC waives (ANG: NGB/CF, delegable to ANGRC/CC or NGB Directors) | T-2 | commander | Partial (wing repeats HHQ T-2 only) | fr:65 F-040; ld:12. No authority check; wing-originated T-2 not flagged | Partial |
| Table A10.1 T-3 | 7498 | T-3 for departmental through NAF levels and wing supplements/instructions; Wing or Delta CC waives, delegable to squadron/CC | T-3 | commander | Yes | fr:65 F-040 (no T-3 at own level); ld:12 (Tier T-3, Waiver Approver). Delegation limit not checked | Partial |
| Table A10.1 note 1 | 7547 | USSF-wide waivers are approved by the CSO or written designee | - | commander | No (USSF-wide only) | - | N/A |
| Table A10.1 note 2 | 7548 | For units under a combatant command the COMAFFOR counts as MAJCOM/CC equivalent | - | commander | No (combatant command units) | - | N/A |
| Table A10.1 note 3 | 7551 | Waivers can be retroactive unless law or higher authority bars it (1.2.9) | - | commander | Yes | ld:12 (Approval Date) | Info |
| Table A10.1 note 4 | 7554 | Do not use a tier at the issuer's own level (T-3 redundant in a wing publication) | - | OPR | Yes | fr:65 F-040; dec:14; gc:31 (A22) | Covered |
| Table A11.1 item 1 PD | 7567 | Policy Directives are SecAF orders issued at departmental level | - | HQ DAF | No (departmental issuance) | - | N/A |
| Table A11.1 item 2 PM | 7584 | Policy Memoranda are SecAF orders issued at HQ DAF | - | HQ DAF | No (HQ DAF issuance) | - | N/A |
| Table A11.1 item 3 AFMD/SPFMD | 7622 | Departmental mission directives issued at HQ DAF | - | HQ DAF | No (HQ DAF issuance) | - | N/A |
| Table A11.1 item 3 HQDAFMD | 7634 | HQ DAF mission directives use HOI 90-1; numbers from AFDPO | - | HQ DAF | No (HQ DAF issuance) | - | N/A |
| Table A11.1 item 3 Intra-organization MD | 7645 | MAJCOM, FLDCOM, FOA, DRU and below may issue subordinate MDs; the PFM assigns the number | - | PFM | Partial (wing issuance unclear) | dec:44; PFMPublications.json PublicationType has no Mission Directive | Gap |
| Table A11.1 item 4 Instructions Dept | 7663 | DAFIs, AFIs, SPFIs are HQ DAF orders; may be supplemented below HQ DAF unless the publication says otherwise | - | OPR | Partial (parent may forbid supplement) | pm:54 (1.1.3.5.1 check at request); gc:20 (A11) | Covered |
| Table A11.1 item 4 Instructions issuing org | 7682 | Organization instructions need a supplement to extend HHQ scope; review, revise or rescind when HHQ guidance changes | - | OPR | Yes | pm:54 (supplement check); pm:62 (2.6.19 special review of implementing rows). Extend-scope rule not checked | Partial |
| Table A11.1 item 5 Manuals Dept | 7711 | DAFMANs, AFMANs are HQ DAF orders giving "how to" detail | - | HQ DAF | No (departmental issuance) | - | N/A |
| Table A11.1 item 5 Manuals issuing org | 7737 | Command or field manuals do not implement HHQ manuals; use supplements where practicable; may stand without an instruction | - | OPR | Yes | pm:54 (supplement check at request). No manual-versus-supplement prompt | Partial |
| Table A11.1 item 6 Checklist Dept | 7761 | Instructional checklists and addenda support an instruction or manual; not for data collection or inspection (use a form) | - | OPR | Yes | PFMPublications.json PublicationType includes Instructional Checklist. No data-collection check | Gap |
| Table A11.1 item 6 Checklist issuing org | 7773 | Issuing organizations below HQ DAF issue checklists the same way to support their publications | - | OPR | Yes | dec:44; PFMPublications.json PublicationType | Covered |
| Table A11.1 item 7 GM Dept | 7777 | GMs are interim guidance; expedited coordination (5.1.7); expire after one year, on supersession, or on IC or rewrite; one active per level | - | OPR | Yes | pm:60; pm:66; ld:59; PFMProductIndex.json ProductStatus Expired | Covered |
| Table A11.1 item 7 GM forms | 7821 | A GM may prescribe forms; Chapter 8 duties apply if it revises or issues a form | - | OPR | Yes | ld:55 (form gates travel with publication). No GM-specific form gate | Partial |
| Table A11.1 item 7 GM issuing org | 7827 | Command or field GMs change only their own publications, never a HHQ publication; may implement HHQ GMs or revised HHQ publications except PDs | - | OPR | Yes | pm:60 and pm:66 (wing GM changes only wing publications); ld:54 (gate) | Covered |
| Table A11.1 item 8 HOI | 7843 | Headquarters OIs serve a headquarters staff (HQ DAF, MAJCOM, FLDCOM, NAF, group) and do not apply to wings | - | OPR | No (wing is not a headquarters staff) | - | N/A |
| Table A11.1 item 8 OI process | 7863 | OIs use the same template and process: mandatory formal coordinators, certification, approval | - | OPR | Yes | pm:9-19 (stages); fr:25-71 (publication format) | Covered |
| Table A11.1 item 8 Issuing Unit | 7883 | Unit OIs cover one subordinate function only; wider applicability needs an instruction or manual; post locally | - | OPR | Yes | pm:54 (OI scope check); gc:21 (A12); pm:48 (wing site) | Covered |
| Table A11.1 item 9 Special Pub System | 7904 | Special publication systems need AFDPO approval and a parent publication link | - | HQ DAF | No (needs AFDPO approval) | - | N/A |
| Table A11.2 item 1 Pamphlet | 7945 | Pamphlets are informational; may mention reports and forms but not prescribe them; all levels may issue | - | OPR | Yes | dec:44 (only directive publications tracked) | Partial |
| Table A11.2 item 2 Doctrine/TTP | 7959 | Doctrine and TTPs issued by LeMay Center and designated organizations | - | HQ DAF | No (LeMay Center only) | - | N/A |
| Table A11.2 item 3 Handbook | 7973 | Handbooks are reference books; all levels may issue | - | OPR | Yes | dec:44 (not tracked) | Partial |
| Table A11.2 item 4 Visual Aid | 7985 | VAs are posters; permanent VAs show the related publication number; temporary VAs expire in 180 days or less and need no number or record set | - | OPR | Yes | dec:44 (not tracked) | Partial |
| Table A11.2 item 5 Special Pub System | 8031 | Special publication systems issued at HQ DAF; AFDPO approval needed | - | HQ DAF | No (needs AFDPO approval) | - | N/A |
| Figure A12.1 header and columns | 8070 | Sample CRM: classification line, series line, then columns Item, Source, Type, Page, Para, Line #, Comment, Rationale, Resolution | - | AO | Yes | templates/CRM_A12-1.docx (build_crm_template.js:25-32); dec:89; pm:38 (CRM columns) | Covered |
| Figure A12.1 resolution code | 8073 | Column header reads A/R/P but the key defines A/R/M | - | PFM | Yes | dec:90 (A/R/M chosen); build_crm_template.js:25 | Covered |
| Figure A12.1 critical | 8087 | Critical comments (law, safety, materiel, waste, unreasonable burden) result in a nonconcur | - | coordinator | Yes | pm:56 (critical = nonconcur, 5.3.3); ld:41 (Critical Comment); pm:38 | Covered |
| Figure A12.1 substantive | 8092 | Substantive comments are usually not enough for nonconcur; several together may be; name the comments behind the nonconcur | - | coordinator | Yes | pm:38 (Type of comment); template note. No field names the basis comments | Partial |
| Figure A12.1 administrative | 8098 | Administrative comments cover typographical, grammatical or formatting errors | - | coordinator | Yes | pm:38 (Administrative type); build_crm_template.js:41 | Covered |
| Figure A12.1 resolution actions | 8101 | Sponsor accepts, rejects or modifies each comment using A/R/M | - | AO | Yes | dec:90; build_crm_template.js:43; PFMEndorsements.json NonconcurResolution | Covered |
| A13.1 POA step 1 | 8113 | Prepare DAF Form 1846 for a publication organizational account; requestor needs .mil, .gov or .edu e-mail | T-2 | AO | Partial (only if the wing orders AFDPO products) | - | Gap |
| A13.2 POA step 2 | 8116 | Organizational account representative sends the approved 1846 to the publishing office for PFM signature, then AFDPO | - | PFM | Partial (PFM signs when a wing office needs a POA) | - | Gap |
| A13.3 POA step 3 | 8119 | Submit the completed 1846 to AFDPO by e-mail or fax; account details return to the representative | T-2 | all | No (AFDPO submission by the requester) | - | N/A |
| A13.4 changing POA | 8123 | Changes need a revised 1846 with revision block marked and account number filled | T-2 | all | Partial (PFM signature only) | - | Gap |
| A13.5 changing OAR | 8126 | A new representative needs a revised 1846 with new OAR and approving official names and signatures | T-2 | PFM | Partial (PFM signature only) | - | Gap |
| A13.6 add or delete items | 8130 | Adding or deleting items or cancelling the account needs a 1846 with OAR and approver signatures | T-1 | PFM | Partial (PFM signature only) | - | Gap |
| A13.7 contractors | 8134 | Contractor POA requests go to contracting officers only; contractor needs a .mil e-mail address | T-1 | all | No (contracting officer function) | - | N/A |
| A13.7.1 contractor 1846 | 8137 | Contracting officer adds contract number, expiration and authorized physical products to the 1846 | T-1 | all | No (contracting officer function) | - | N/A |
| A13.7.2 contractor one-time | 8140 | Contractors use general accounts or the contracting officer for one-time or unrestricted products | T-1 | all | No (contracting officer function) | - | N/A |

## Gaps

| Para | Line | What is missing | Severity | Suggested fix |
|---|---|---|---|---|
| Figure A5.1 step 1 PCM | 6726 | No prompt to ask the PCM about change size or coordinator list; PCM column only on PFM Offices | low | Add a PFM Guidance entry for step 1 (PCM contact, optional below HQ DAF). |
| Figure A5.1 step 1 SMEs | 6728 | Organizations named in the draft roles are not suggested as coordinators | low | Add a request-time question: which organizations does the draft assign duties to; add them as PFM Offices rows. |
| Figure A5.1 step 6 close task | 6783 | No Closed/Completed Action Status or close rule at posting; ActionStatus has On Track, On Hold, Stalled only | medium | Add Closed to Action Status (or close by Process Step = Posting plus Posted date) and set it in the posting flow. |
| Table A5.1 columns / Applies To | 6787 | Resolved (12 Nov): Applies To is in the list design (section 3); the fill below uses the walkthrough stages 0-12 (PFM 1A); the OPR signature is given at stage 10, no new stage | high | Seed PFM Process Steps from the fill below in T02 r10 |
| Table A5.1 Publications AC | 6825 | OPR signature and date are not recorded on an Administrative Change; Process Steps has no AC path | medium | Add OPR Signed Date on PFM Publications; AC Applies To = OPR sign, approve, post only. |
| Table A5.1 Publications PM or GM | 6826 | Certify and approve steps for a GM, and legal-only coordination, not written as stage path; no OPR sign | medium | Applies To for GM: stages 1, 2, 6, 7, 8, 9, 10 (legal only, no Formal Coordination or Privacy stage unless the PFM adds one). |
| Table A5.1 Publications Rescind | 6830 | Stage path for Rescind not stated (coordination, certify, approve, no create/change) | medium | Applies To for Rescind: stages 1, 4-10 per matrix; record that the step list differs after a PFM rescission (7.11.5.5). |
| Table A5.1 Publications Transfer | 6831 | Stage path for Transfer not stated beyond the first concurrence step (7.10.1) | medium | Applies To for Transfer: new approving authority concurrence first, then stages 5-10. |
| Table A5.2 b coordination | 6858 | 5 business days for adjudication are not a separate target; only 20 total and 15 suspense exist | low | Add a TargetBusinessDays note on step 5 (15 + 5) or a Settings value for adjudication days. |
| A6.3.4 final disposition | 6908 | No separate notice to the submitting channel (ANG functional office/MAJCOM equivalent) on final disposition | low | Add a Notice Sent event that names the submitting channel when Recommendation Status closes. |
| A6.3.5 inform originator | 6910 | Originator is told only at disposition; no notice at each level | medium | Flow: notify the originator on every Recommendation Status change. |
| Table A6.1 Section 1 Blocks 6-7 | 6924 | Basic publication date and latest IC date are not columns on PFM Recommendations | low | Read them from the Product Index (EffectiveDate) and the latest IC row; or add two date columns for outbound items. |
| Table A6.1 Section 1 Blocks 8-9 | 6927 | Page number is not a column (Paragraph only) | low | Add Page (text) or rename Paragraph to Page And Paragraph. |
| Table A6.1 Section 2 Blocks 17-22 | 6953 | Originator organization level (block 22) and contact details are not columns | low | Add Originator Level (choice) or read contacts from the person field. |
| Table A6.1 Sections 3-8 intro | 6964 | No record of which functional levels (squadron, group, wing) have signed an outbound 847 | medium | Add per-level concurrence fields or a child list for 847 coordination. |
| Table A6.1 Section 3 concurrence | 6973 | Recommendation Status has no Concur, Concur With Remarks, Nonconcur or Returned To Originator value | medium | Add Concurrence Level and Returned To Originator values to PFM Recommendations; Nonconcur returns the row to the originator. |
| Table A6.1 Section 3 routing | 6981 | No route-to-next-level step for outbound 847s | low | Add Current Level (choice) and a flow notice when routed up. |
| Table A6.1 Section 4 group | 6986 | Group-level concurrence not tracked | medium | Same fix as Section 3 concurrence. |
| Table A6.1 Section 5 wing | 6996 | Wing-level concurrence and commander/director signature not tracked | medium | Same fix as Section 3 concurrence; wing level is the PFM office's own step. |
| Table A6.1 Section 9 intro | 7038 | No gate that the completed 847 copy is filed in the publication record set | low | Add 847 copy to the record set checklist (gap check B7) and a Recommendation Status Closed gate. |
| A7.1 design guidelines | 7061 | Forms designer/renderer rule: Forms must be easy to fill in, logical and well laid out; GSA handbook; waiver when function precludes the standard (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.1 waiver | 7070 | No record or authority for waiving form design standards | low | Add a note in PFM Guidance; decide whether a form-design waiver is a PFM Waivers row or a note on the form. |
| A7.2.1 size | 7073 | Forms designer/renderer rule: Printed forms are 8.5 x 11 inches except postcards (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.2.2 postcard | 7074 | Forms designer/renderer rule: Postcard forms 3.5 x 5 inches minimum, 4.25 x 6 inches maximum (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.2.3 two-page | 7076 | Forms designer/renderer rule: Two-page forms need not be printed front and back unless the OPR requires it (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.3.1 border | 7079 | Forms designer/renderer rule: Body of the form is enclosed in a lined border except certificates, tags, labels (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.3.2 border weight | 7081 | Forms designer/renderer rule: Border is 1.5 point solid on all four sides (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.3.3 margins | 7082 | Forms designer/renderer rule: Page margins are 0.5 inch unless special requirements (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.3.4 section lines | 7083 | Forms designer/renderer rule: 1 point solid lines divide primary sections (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.3.5 hairlines | 7084 | Forms designer/renderer rule: Hairline type for lines within sections (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.4.1 box style | 7086 | Forms designer/renderer rule: Box style with upper-left captions on fillable fields (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.4.2 order | 7087 | Forms designer/renderer rule: Items numbered in fill-in order, number at upper left before the caption (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.4.3 grouping | 7089 | Forms designer/renderer rule: Group common items; sections allowed; section title flush left (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.4.4 typed name | 7092 | Forms designer/renderer rule: Separate field from signature for the signer's typed name (NARA) (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.4.5 mailers | 7094 | Forms designer/renderer rule: Mailers and self-mailers follow USPS regulations (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.5.1 fonts | 7100 | Forms designer/renderer rule: Arial for captions; Times New Roman 10 point for fillers (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.5.2 italics | 7102 | Forms designer/renderer rule: Optional italics for words, phrases or instructions in parentheses (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| Table A7.1 items 1-7 | 7105 | Forms designer/renderer rule: Table A7.1 font sizes and casing for title, disclosure, PAS, section, caption, number and supersession text (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.6.1 title | 7118 | Forms designer/renderer rule: Title at top center or left inside border; brief; no words such as "form" or "label" (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.6.2.1 number placement | 7123 | Forms designer/renderer rule: Form number and edition date bottom left margin outside the border (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.6.2.2 designation | 7125 | Forms designer/renderer rule: Designation in capitals showing scope (AF, ACC, 375 WG) (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.6.2.3 number | 7127 | Numbering gate in ld:54 covers publications only; form number sequence and "Form" naming are not gated | medium | Extend the PFM numbering step to forms (next number in the wing form series, designation plus Form). |
| A7.6.3 reverse page | 7136 | Forms designer/renderer rule: Second page shows "(Reverse)" if printed front and back, else "Page ___ of ___" (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.7 releasability | 7146 | Forms designer/renderer rule: Releasability statement at the bottom only if access is restricted, with fixed preface (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.8 supersession notice | 7154 | Forms designer/renderer rule: Centered supersession notice at the bottom outside the border (e.g., PREVIOUS EDITIONS ARE OBSOLETE) (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.9 non-standard software | 7159 | Forms designer/renderer rule: If AFDPO software is not used, show the software name and vendor lower right on page 1 (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.10 OMB and RCS | 7164 | OMB number/expiration columns exist; the RCS block and placement need a forms renderer | medium | Add RCS and OMB block rules to a forms format-rules catalog. |
| A7.10.1 RCS position | 7168 | Forms designer/renderer rule: RCS block top right inside border; OMB block above it if both (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.10.2 RCS not printed | 7173 | Forms designer/renderer rule: OMB number and date are part of the approved form; RCS block must exist but number is not listed (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.10.3 disclosure notice | 7177 | Forms designer/renderer rule: Forms with an OMB number show the agency disclosure notice below the title and OMB number (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| Table A7.2 notice text | 7184 | Forms designer/renderer rule: DoD agency disclosure notice wording (burden, WHS, OMB statement) (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.11 PAS placement | 7196 | Forms designer/renderer rule: Privacy Act statement on the face, back, tear-off, or separate sheet, with fixed notations (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.12 instructions | 7207 | Forms designer/renderer rule: Place instructions consistently; brief in captions, tool tips, columns, or separate page; long ones in the publication (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.13 acronyms | 7216 | Forms designer/renderer rule: Spell out acronyms at first use then use the acronym (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.14 graphics | 7220 | Forms designer/renderer rule: No decorative illustrations or official logos; only functional graphics (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.15.1 field names | 7227 | Data elements from the OPR are held as free text only | low | Keep Data Fields Collected as the list of OPR data elements; check against the form at posting. |
| A7.15.2 field format | 7229 | Forms designer/renderer rule: Fixed field lengths per data standards (DoDI 8320.02), consistent across forms (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.15.2.1 date field | 7233 | Forms designer/renderer rule: Date field is YYYYMMDD, 8 characters fixed (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.15.2.2 ID fields | 7235 | Forms designer/renderer rule: SSN field numeric NNN-NN-NNNN if approved; DoD ID 10-digit numeric (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.15.2.3 addresses | 7238 | Forms designer/renderer rule: Addresses may be separate items per component; database-friendly entry (no forms rules in docs/format-rules.md; forms renderer does not exist) | low | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.15.3 signature fields | 7240 | Forms designer/renderer rule: Separate block for the signer's typed name (NARA) (no forms rules in docs/format-rules.md; forms renderer does not exist) | medium | Add a forms rule catalog (F-1xx) and validator for Attachment 7; see summary fix below |
| A7.16 testing | 7242 | No test step for completed electronic forms (designer, AFDPO, OPR) | medium | Add a Form Tested By OPR gate (yes/no and date) before posting a new or revised form; AFDPO part is N/A for the wing. |
| Table A10.1 T-0 | 7305 | PFM Waivers Tier has no T-0; no routing note for T-0 relief requests | low | Add a PFM Guidance entry: T-0 cannot be waived by the DAF; send through command channels to the HHQ OPR. |
| Table A10.1 T-1 | 7368 | Waiver Approver is free; no check against NGB/CF (delegable to ANGRC/CC); wing-originated T-1 not flagged | medium | Add Tier-to-authority lookup (read ANGMAN 90-161 first) and a validator warn for T-1 text originated at the wing. |
| Table A10.1 T-2 | 7442 | Same as T-1 for T-2 (NGB/CF, ANGRC/CC or NGB Directors) | medium | Same fix as T-1. |
| Table A10.1 T-3 | 7498 | Delegation limit (no lower than squadron/CC) not checked on Waiver Approver | low | Add an approver-level check or guidance text in the waiver form. |
| Table A11.1 item 3 Intra-organization MD | 7645 | PublicationType has no Mission Directive; unclear whether a wing may issue one ("and below") | low | Ask the PFM: add Mission Directive to Publication Type or record the exclusion in DECISIONS. |
| Table A11.1 item 4 Instructions issuing org | 7682 | Rule that an instruction needs a supplement to extend HHQ scope is not asked at request | low | Add to the request-time supplement check (1.1.3.5.1). |
| Table A11.1 item 5 Manuals issuing org | 7737 | Manual versus supplement choice for implementing HHQ manuals not prompted | low | Add to the request-time supplement check. |
| Table A11.1 item 6 Checklist Dept | 7761 | No warning that checklists must not collect or inspect data (use a form) | low | Add a request-time question for Instructional Checklist and a PFM Guidance line. |
| Table A11.1 item 7 GM forms | 7821 | No GM-specific gate when a GM revises or issues a form | low | Extend ld:55 form gate to GM actions (Chapter 8 duties). |
| Table A11.2 item 1 Pamphlet | 7945 | Excluded from tracking by decision (directive only); pamphlets may not prescribe forms or reports | low | PFM to confirm exclusion; if tracked later add Pamphlet to Publication Type. |
| Table A11.2 item 3 Handbook | 7973 | Excluded from tracking by decision (directive only) | low | Same as pamphlet. |
| Table A11.2 item 4 Visual Aid | 7985 | Excluded from tracking; VA number format, related-publication mark and 180-day expiry not handled | low | Same as pamphlet; if tracked add expiry alert (Expiration Date exists on Product Index). |
| Figure A12.1 substantive | 8092 | No field names the substantive comments behind a nonconcur | low | Add Basis Comments (text) to PFM Endorsements, required on Nonconcur with substantive comments only. |
| A13.1 POA step 1 | 8113 | No tracking of DAF Form 1846 for AFDPO organizational accounts | low | Out of scope unless the wing orders AFDPO physical products; record that in DECISIONS. |
| A13.2 POA step 2 | 8116 | PFM signature of DAF Form 1846 has no record or guidance | low | Same as A13.1; add a PFM Guidance line if kept. |
| A13.4 changing POA | 8123 | Revised DAF Form 1846 for account changes not tracked | low | Same as A13.1. |
| A13.5 changing OAR | 8126 | Change of organizational account representative not tracked | low | Same as A13.1. |
| A13.6 add or delete items | 8130 | 1846 for additions, deletions or cancellation not tracked | low | Same as A13.1. |

Summary fix for all Renderer-gap rows: the repo has a renderer and validator for publications only (docs/format-rules.md F-000 to S-001). Decide whether wing forms are built in the 90-161.Z renderer (add a forms catalog from A7.2-A7.18) or by a forms designer in Adobe/InfoPath-type tooling on the gov device; the PFM locks and dates the form either way (A7.6.2.4, A7.18, ld:42).

## Table A5.1 matrix

Read from the PDF page 168 (x-position of each X checked with pdftotext -bbox) and matched to the text layout at lines 6822-6839. Columns: Coordination | OPR Sign | Certifying Official sign | Approving Official sign | Creates Publication or Form / Physically Changes Publication or Form | Action item attached to publication, no physical changes.

action | coordination | OPR sign | certifier | approver | creates/changes pub or form | notes
Publications New | X | - | X | X | X (creates) | full path; PFM numbers it (4.3.8)
Publications Rewrite | X | - | X | X | X (physically changes) | -
Publications IC | X | - | X | X | X (physically changes) | absorbs active GMs and ACs (7.7.7)
Publications AC | - | X | - | X | - | attached to the publication, no physical change; only OPR or PCM starts it (7.8.3)
Publications PM or GM | X (note 2: legal review only; SAF/AA also for PMs) | - | X | X | - | attached, no physical change; note 1: follow up with new, rewrite or IC within one year; wing issues GMs only
Publications Periodic review | - | X | - | - | - | note 4 marker printed on this row; OPR answers on DAF Form 399
Publications Certify current | - | X | - | X | X (physically changes: certified-current mark) | note 4: response needs completed DAF Form 399 or 673 (marker not printed on this row)
Publications Rescind | X | - | X | X | - | -
Publications Transfer | X | - | X | X | - | -
Forms New | X | - | X | X | - (no mark printed) | printed as read; header says creates, but no X
Forms Revise | X | - | X | X | - (no mark printed) | printed as read
Forms Periodic review | - | X | - | - | - | -
Forms Certify current | - | X | - | X | - | note 4 marker on this row: needs DAF Form 399 or 673
Forms Rescind | X | - | X | X | - | -
Forms Transfer | X | - | X | X | - | -

### Applies To fill for PFM Process Steps (stage numbers = the walkthrough stages 0-12, the only stage table; PFM 1A, 12 Nov)

Derived from the matrix above and the stage meanings in docs/process-model.md (6 Formal Coordination, 7 Legal, 8 Certification, 9 Approval, 10 Submission, 11 Final build and posting, 12 Periodic review). Stages 0 to 5 (AO appointment, request, drafting, clean and format, pre-coordination, privacy review) are not in Table A5.1 and follow the plan. Items marked Rec are agent recommendations with their DAFMAN basis (second independent review, 12 Nov); the PFM confirms them in the assumption register.

- New, Rewrite, IC (publications): stages 0-11 (5 privacy review per Table A3.1 note 2).
- Forms New, Revise, Rescind, Transfer: stages 1-3 as needed, 6, 7, 8, 9, 10, 11. Rec: stage 11 applies to Rescind and Transfer too (the PFM removes obsolete products and their links, 7.11.1, 8.12, and keeps the PI current, 6.4.2).
- Publications Rescind, Transfer: stages 1, 6, 7, 8, 9, 10, 11 (Rec for 11, as above). Transfer starts with the new approving authority's concurrence (7.10.1).
- GM: stages 1, 2, 3, 7 (legal only), 8, 9, 10, 11. Rec: no stage 5 and no stage 6 (Table A5.1 note 2 and 5.1.7: only legal review; 2.8.1 ties the privacy review to formal coordination, which a GM does not have).
- AC: stages 1, 9, 10, 11. The OPR signature (Table A5.1 "OPR sign") is given at stage 10, so no new stage is needed. No Formal Coordination, Legal or Certification.
- Periodic review (publication or form): stage 12 (PFM Reviews, DAF Form 399; OPR sign only).
- Certify current: OPR sign and approver sign (no coordination, no certifier): stages 1, 9, 10, 11 (Rec for 11: the PFM marks "Certified Current on", 7.5.2).
