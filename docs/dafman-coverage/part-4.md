# Part 4: lines 3720-4773 (+ ANGMAN 90-161)

Legend for "Covered by" (all paths under /home/user/90-161.Z): LD = docs/reviews/2026-11-12-list-design-full-scope.md; GC = docs/reviews/2026-11-12-dafman-full-gap-check.md; IR = docs/reviews/2026-11-12-independent-review.md; DEC = docs/DECISIONS.md; PM = docs/process-model.md; FR = docs/format-rules.md; SS = docs/style-standard.md; ARCH = docs/ARCHITECTURE.md; PIschema = schemas/lists/PFMProductIndex.json. A number after a file name is the line number. Note: the full-scope columns in LD are approved (DEC 8) but not yet in schemas/lists (the schemas hold the r9 state), so "Covered" means designed and approved.

| Para | Line | Requirement (own words, max 25 words) | Tier | Actor | Applies to ANG wing | Covered by | Status |
|---|---|---|---|---|---|---|---|
| 8.1 | 3724 | Forms guidance covers all media and whole life cycle; PFMs, OPRs, AOs reduce or eliminate SSNs on forms. | T-1 | PFM, OPR, AO | Yes | PIschema 167 (CollectsPII); GC 46 (B3); LD 42 (Privacy Act Statement Included). No SSN-specific field | Partial |
| 8.1.1 | 3730 | A form is a fixed arrangement of captioned spaces for entering prescribed information; official types are in Table 8.1. | - | all | Yes | DEC 12 (Form Type from Table 8.1) | Info |
| 8.1.2 | 3736 | Remove the designator "IMT" from all forms and publications as soon as possible. | T-1 | OPR, PFM | Yes | FR has no IMT lint rule (grep "IMT" finds nothing in plan) | Renderer |
| 8.1.3 | 3739 | Units adopt forms generated at higher headquarters in their chain whenever possible. | T-1 | OPR, PFM | Yes | GC 71 (E8, intake question); LD 42 (Adopted Forms text). No intake column in LD | Partial |
| 8.2 | 3741 | Form type follows scope of use and form designation; redesignate and reprocess if the user scope changes. | - | OPR | Yes | DEC 12 (Form Type); LD 42 | Info |
| 8.2.1 | 3744 | Manage a form as prescribed if it solicits PRA information, collects from the public, needs OMB approval, or collects Privacy Act data. | T-0 | OPR | Yes | DEC 12; LD 55 (Prescribing Publication required); LD 33, 42 (Information Collection); GC 66 (E3) | Covered |
| 8.2.2 | 3748 | Non-prescribed forms are DD, standard, optional, GSA and GAO forms; instruct users when needed; OPR supplies instructions. | - | OPR | Yes | LD 42 (Adopted Forms text); IR 16 (finding 7) | Info |
| 8.2.3 | 3754 | Items not managed as forms per DoDI 7750.07 (heading). | - | PFM | Yes | - | Info |
| 8.2.3.1 | 3755 | Forms used exclusively for cryptological activities are not managed as forms. | - | PFM | Yes | - | Info |
| 8.2.3.2 | 3756 | Forms used only once as part of a survey are not managed as forms. | - | PFM | Yes | - | Info |
| 8.2.3.3 | 3760 | Largely narrative formatted documents are not forms, unless they solicit Privacy Act/PRA data, collect from the public, or need OMB approval. | - | OPR | Yes | DEC 12 and LD 55 (any form with personal data or PRA is prescribed) | Covered |
| 8.2.3.4 | 3766 | Formatted documents without entry spaces (instruction sheets, notices, placards, form letters) are not forms. | - | PFM | Yes | - | Info |
| 8.2.3.5 | 3769 | Data tools not prescribed in a publication (login screens, sign-in sheets) are not managed as forms. | - | PFM | Yes | - | Info |
| Table 8.1 Departmental | 3779 | Forms used DAF-wide or by HQ DAF; prescribed by a departmental publication; issued by HQ DAF. | - | HQ DAF | No (HQ DAF issues; wing only adopts) | LD 42 (Adopted Forms) for adoption | N/A |
| Table 8.1 Command or Field | 3785 | Forms issued by MAJCOM, base, delta or unit for use in the organization; prescribed by a field publication. | - | OPR, PFM | Yes | DEC 12; LD 42 (Form Type: Command or Field) | Covered |
| Table 8.1 Headquarters unit | 3791 | Forms issued within an organization (e.g., SPF, AF, ACC form); prescribed by an operating instruction. | - | OPR, PFM | Yes | DEC 12; LD 42 (Form Type: Headquarters Unit) | Covered |
| Table 8.1 Non-prescribed exception | 3797 | Non-prescribed forms get instructions as needed; any form with PRA, public, OMB or Privacy Act data must be managed as prescribed. | T-0 | OPR | Yes | DEC 12; LD 55 | Covered |
| Table 8.1 Office | 3804 | Checklists and worksheets for use only inside the originating office; non-prescribed; OPR disseminates. | - | OPR | Yes | DEC 12 (Form Type: Office) | Covered |
| Table 8.1 One-time | 3810 | One-time forms are not reused, expire within 1 year; face shows "(One-time) Expires <date>" after the form number. | - | OPR | Yes | DEC 12 and LD 55 (Expiration Date within 1 year); GC 70 (E7). Face wording not checked anywhere | Partial |
| Table 8.1 Test | 3829 | Test forms last at most 1 year, must convert to permanent by expiry or become obsolete; face shows "(Test) Expires <date>". | - | OPR | Yes | DEC 12 and LD 55 (expiry within 1 year); GC 70 (E7 alert). No auto-obsolete or convert step; face wording not checked | Partial |
| Table 8.1 MWR | 3847 | Morale, Welfare, and Recreation forms for internally imposed MWR requirements; MWR activity pays printing. | - | OPR | Yes | DEC 12 (Form Type: Morale, Welfare, and Recreation) | Covered |
| Table 8.1 Note | 3854 | Instruct users when a non-DAF form (DD, SF, GSA, GAO) is needed; AFDPO may assist, does not monitor non-DAF sites. | - | OPR | Yes | - | Info |
| 8.3 | 3859 | OPR develops draft form, avoids duplicating DAF or DoD forms, prescribes in a directive, coordinates; new pub and forms post together. AFDPO designs and posts. | T-1 | OPR, AFDPO | Partial (AFDPO design/posting part does not apply; no-duplicate, prescribe, coordinate, post together do) | LD 55, 60 and GC 65 (E2, post together); DEC 12 (prescribed in a directive publication); GC 67 (E4 coordination). No duplicate-form check | Partial |
| 8.3.1 | 3873 | A form for USAF and USSF is a "DAF Form" with prefix DAF. | - | AFDPO | No (departmental forms numbered by AFDPO) | - | N/A |
| 8.3.2 | 3875 | A USAF-only form is an "Air Force Form" with prefix AF. | - | AFDPO | No (departmental forms numbered by AFDPO) | - | N/A |
| 8.3.3 | 3877 | A USSF-only form is a "Space Force Form" with prefix SPF; "SF" is not used. | - | AFDPO | No (departmental forms numbered by AFDPO) | - | N/A |
| 8.4 | 3880 | Field Form Development (heading only). | - | - | Yes | - | Info |
| 8.4.1 | 3881 | Field activities design the form, complete metadata, unlock it, submit via AFIMPT; ANG wing forms are published and managed on local sites. | T-3, T-2 | OPR | No (ANG wing excepted, 8.4.1) | GC 64 (E1, no AFIMPT step); ARCH 76 | N/A |
| 8.4.2 | 3885 | Unlocked file follows the naming convention (e.g., ACC201_unlocked.xfdl). | T-3 | OPR | No (AFIMPT submission only) | GC 64 (E1) | N/A |
| 8.4.3 | 3888 | Before AFIMPT submission, save the form as an unlocked form. | - | OPR | No (AFIMPT submission only) | GC 64 (E1) | N/A |
| 8.4.3.1 | 3890 | Go to File, Save As. | - | OPR | No (AFIMPT submission only) | - | N/A |
| 8.4.3.2 | 3891 | Add "_unlocked" to the file name and select Save. | - | OPR | No (AFIMPT submission only) | - | N/A |
| 8.4.3.3 | 3893 | Select Finish; check "overwrite existing file" if previously saved. | - | OPR | No (AFIMPT submission only) | - | N/A |
| 8.4.4 | 3895 | Field activities upload the unlocked form to AFIMPT for AFDPO posting; AFDPO does not process forms below wing level. | T-2 | OPR | No (ANG wing excepted, 8.4.1) | GC 64 (E1) | N/A |
| 8.5 | 3898 | e-Publishing is the official forms repository except ANG wing and subunit forms; classified forms on HQ SIPRNET need unclassified PI titles. | T-1 | OPR, AFDPO | Partial (wing posts own site; classified part out of scope) | PIschema 110 (Posted Location); GC 64 (E1); DEC 42 (classified products left out) | Covered |
| 8.5.1 | 3906 | "Stocked and Issued" forms are distributed by the OPR; OPR tells AFDPO when a reprint is needed. | - | OPR | No (AFDPO reprint; printed products left out, DEC 42) | DEC 42 | N/A |
| 8.5.2 | 3909 | "Stocked and Used" forms are distributed by the OPR inside its organization; OPR tells AFDPO about reprints. | - | OPR | No (AFDPO reprint; printed products left out, DEC 42) | DEC 42 | N/A |
| 8.5.3 | 3915 | ANG field forms go to the local wing PFM and are not sent to AFDPO. | - | OPR, PFM | Yes | GC 64 (E1); ARCH 76; PM 48 (system boundary) | Covered |
| 8.6 | 3917 | Create forms electronically, avoid duplicating HHQ forms; PFMs and developers use Adobe LiveCycle Designer; design standards in Attachment 7. | T-1 | PFM | Yes | Plan does not name LiveCycle Designer or Attachment 7 (grep finds none); LD 42 (Locked) only | Renderer |
| 8.6.1 | 3921 | OPRs request a form control number from the supporting PFM; numbers are assigned sequentially. | - | OPR, PFM | Yes | GC 45 (B2, next in sequence); GC 13 (A4); LD 27 (Number Approved) | Covered |
| 8.6.2 | 3923 | OPR builds a prototype in desktop software; final form designed with the PFM. | - | OPR, PFM | Yes | DEC 24 (Working Files folder holds drafts) | Info |
| 8.6.3 | 3927 | Signatures on Forms (heading). | - | OPR | Yes | - | Info |
| 8.6.3.1 | 3928 | OPR chooses written or electronic signature; no personalized logos, slogans or images in any signature. | T-1 | OPR | Yes | None (FR F-034 covers publications only) | Renderer |
| 8.6.3.2 | 3931 | Use electronic signature (AFI 33-322) wherever possible unless law requires wet signature; OPR states when wet signature needed. | - | OPR | Yes | DEC 24 (Q4A digital 673 signatures). No wet-signature field on form rows | Partial |
| 8.6.3.3 | 3934 | OPR decides wet or electronic signature need and documents it in the prescribing publication. | T-1 | OPR | Yes | - | Gap |
| 8.6.3.4 | 3939 | Standard e-Publishing form is a standalone PDF or eBook; consider these points if responses are extracted to a system of record. | - | OPR | Yes | - | Info |
| 8.6.3.4.1 | 3944 | Keep digitally signed documents digitally (not scanned) in a system such as ARMS to preserve signature integrity; tell users. | - | OPR | Yes | DEC 24 (Q4A signed PDF uploaded), DEC 18 (Q15A record sets). ARMS and no-scan rule not stated | Partial |
| 8.6.3.4.2 | 3954 | A broken electronic chain (printed then scanned) loses signature metadata; wet signature over printed signature is acceptable. | - | OPR | Yes | - | Info |
| 8.6.4 | 3962 | Forms and data collections inside an information system meet this instruction, signature integrity and AFI 17-101 (RMF). | - | OPR | Yes | None (AFI 17-101 not named anywhere in plan) | Gap |
| 8.6.5 | 3966 | PFM assigns the form date to match the day the form is available (e-Publishing, local site or system). | - | PFM | Yes | GC 45 (B2); LD 42 (Edition Date), LD 60 (posting gate) | Covered |
| 8.6.6 | 3968 | If the electronic version differs from the official image, the form OPR or SAF/AAGP may reject it. | - | AFDPO | No (AFDPO/SAF right to reject) | - | N/A |
| 8.6.7 | 3970 | New or revised forms identify the prescribing publication on the form itself. | T-1 | OPR | Yes | GC 65 (E2, "the form names it"); PIschema 76 (Prescribing Publication). Face text not checked | Partial |
| 8.7 | 3972 | A new form and its prescribing publication are published and distributed together; not required for revised forms. | - | OPR, PFM | Yes | LD 60 (new form with its publication); GC 65 (E2) | Covered |
| 8.7.1 | 3974 | The prescribing publication must contain the following (heading). | - | OPR | Yes | - | Info |
| 8.7.1.1 | 3975 | Publication tells organizations and individuals how to use the form. | - | OPR | Yes | None (publication content rule) | Renderer |
| 8.7.1.2 | 3976 | Cite form designation, number and italic title at first mention; later only designation and number. | - | OPR | Yes | None (FR F-024 covers the opening paragraph only) | Renderer |
| 8.7.1.3 | 3981 | State the form's purpose, how to complete it if needed, and how to submit it. | - | OPR | Yes | None (publication content rule) | Renderer |
| 8.7.1.4 | 3982 | Explain where to submit supply requests if the form is printed. | - | OPR | Yes | None (publication content rule) | Renderer |
| 8.7.1.5 | 3983 | List prescribed forms in Attachment 1 under "Prescribed Forms" after References, and on the DAF Form 673; first IC or rewrite moves the list. | - | OPR | Yes | format-rules F-035 (FR 60); GC 49 (B6, forms on the 673) | Renderer |
| 8.7.2 | 3989 | Do not include a copy of the prescribed form in the publication; if needed show a figure with sample entries only. | - | OPR | Yes | None | Renderer |
| 8.7.3 | 3993 | The publication need not be revised when a form is revised, unless the form's instructions change. | - | OPR | Yes | LD 55 (a form change that needs a publication change travels with it) | Covered |
| 8.7.4 | 3998 | A form at any level that collects personal information must be prescribed in an official publication and managed under the Privacy Act. | T-3 | OPR | Yes | DEC 12; GC 66 (E3); LD 55 | Covered |
| 8.8 | 4001 | Publications may adopt an official form from higher-level DAF or other government publications; refer users to the prescribing publication. | - | OPR | Yes | LD 42 (Adopted Forms text); IR 16 (finding 7) | Covered |
| 8.8.1 | 4009 | Cite adopted form designator, number and italic title at first mention; later designation and number. | - | OPR | Yes | None (publication content rule) | Renderer |
| 8.8.2 | 4013 | List adopted forms in Attachment 1 under "Adopted Forms" after Prescribed Forms; do not list a form twice. | - | OPR | Yes | format-rules F-035 (FR 60); LD 42 (Adopted Forms) | Renderer |
| 8.8.3 | 4019 | An adopted form made by another agency follows that agency's guidance; the form OPR aligns with that agency's forms manager. | T-3 | OPR | No (form OPR is the other agency) | - | N/A |
| 8.8.4 | 4023 | Using an adopted form for an unintended purpose or altering its appearance needs written permission from the form's OPR. | - | OPR, AO | Yes | - | Gap |
| 8.8.5 | 4025 | OPR may overprint forms when man-hours saved justify it; do not alter lines or captions; add an "overprint" activity statement at the bottom. | - | OPR | Yes | None (forms designer rule) | Renderer |
| 8.8.6 | 4032 | Information systems that incorporate an existing form need the form OPR's written waiver and a mirror-image of the official form. | T-2 | OPR | Yes | None. LD 11 (PFM Recommendations list holds 847 fields; DAF Form 847 Link kept) not checked against this rule | Gap |
| 8.9 | 4043 | Legal and Security Requirements and Considerations (heading). | - | - | Yes | - | Info |
| 8.9.1 | 4044 | Include a Privacy Act statement on forms collecting personal data for a system of records or asking for an SSN; PAO or PAM helps. | T-0 | OPR | Yes | LD 42 (Privacy Act Statement Included); GC 46 (B3); PIschema 167 (CollectsPII) | Covered |
| 8.9.1.1 | 4051 | If form data is subject to computer matching, add an appropriate warning to the Privacy Act statement. | T-0 | OPR | Yes | - | Gap |
| 8.9.1.2 | 4057 | Process PII/SSN forms only if the PAO or PAM coordinates and approves on the DAF Form 673; package includes the SSN justification letter. | T-1 | PFM, PAO/PAM | Yes | LD 55 (Privacy row in Concur before approval); IR 11 (finding 2); PM 13. SSN justification letter has no column or checklist | Partial |
| 8.9.2 | 4063 | PFMs ensure forms used as postal mailers meet USPS requirements (DoDI 4525.09). | T-0 | PFM | Yes | None (DoDI 4525.09 not named in plan) | Gap |
| 8.9.3 | 4066 | PFMs ensure all forms are Section 508 compliant (AFI 33-393); local PFMs cover products not on e-Publishing. | T-0 | PFM | Yes | LD 38, 42, 60 (Section 508 Checked gate); GC 47 (B4); DEC 48 (Accessibility Checker release gate) | Covered |
| 8.9.4 | 4073 | PFMs ensure forms collecting information comply with AFI 33-324 (Paperwork Reduction Act). | T-0 | PFM | Yes | LD 33, 42 (Information Collection, OMB Number, OMB Expiration); GC 48 (B5) | Covered |
| 8.9.5 | 4076 | Requests for classified, accountable, safeguarded or CUI forms must carry required markings (DoDI 5200.48); AFDPO lists them. | T-0 | OPR, AFDPO | Yes | LD 42 (Markings: None, CUI, Accountable, Safeguarded); GC 72 (E9); IR 26 (17). DoDI 5200.48 not named | Covered |
| 8.9.5.1 | 4083 | Avoid forms that disclose classified information or have classified titles; mark classified blank forms top and bottom. | T-0 | OPR | No (classified out of scope, DEC 42) | DEC 42 ("classified products" left out); LD 42 (classified left out) | N/A |
| 8.9.5.2 | 4092 | Accountable Forms (heading). | - | PFM | Yes | LD 42 (Markings: Accountable) | Info |
| 8.9.5.2.1 | 4093 | Accountable forms are stringently controlled; PFMs ensure they are controlled, safeguarded and accounted for; contact AFDPO for help. | T-1 | PFM | Yes | LD 42 (Markings: Accountable flag only). No control or accounting record | Partial |
| 8.9.5.2.2 | 4101 | Order accountable forms online with an approved DAF Form 1846; sign and return the document receipt in 30 days or the account is disabled. | - | OAR | Partial (wing OAR receives shipments; AFDPO account part does not apply) | DEC 42 (printed products left out). No receipt tracking | Gap |
| 8.9.5.3 | 4117 | Safeguarded forms are not releasable outside DoD; store blank forms in a secure area; no per-form accounting. | - | PFM | Yes | LD 42 (Markings: Safeguarded flag only) | Partial |
| 8.9.5.4 | 4123 | Personnel must mark and protect CUI forms. | T-0 | all | Yes | LD 42 (Markings: CUI), LD 35 (Access Level: CUI); GC 72 (E9) | Covered |
| 8.10 | 4127 | OPRs coordinate all new forms, revised forms and forms marked for cancellation. | T-3 | OPR | Yes | GC 67 (E4, forms use the endorsement workflow); PM 44; LD 55 | Covered |
| 8.10.1 | 4129 | New form drafts circulate with the prescribing publication; revised or cancelled forms may circulate alone; revised form travels with revised publication if process changes. | T-1 | OPR | Yes | LD 55 (form change that needs a publication change); PM 44; GC 24 (A15) | Covered |
| 8.10.1.1 | 4135 | List all prescribed forms on the DAF Form 673; use the Additional Information block for classification, control status, printing. | T-1 | OPR | Yes | GC 49 (B6); LD 30 | Covered |
| 8.10.1.2 | 4138 | OPR justifies the form, the data fields collected, and printing/distribution requirements during coordination. | T-1 | OPR | Yes | LD 30 (Form Justification, Data Fields Collected, Printing And Distribution); GC 49 (B6) | Covered |
| 8.10.1.3 | 4140 | OPR fills in form-specific information during periodic and special reviews. | T-1 | OPR | Yes | PM 21 and GC 69 (E6, reviews cover linked forms). Refresh of form justification at review not a step | Partial |
| 8.10.2 | 4142 | DD Form 67 is needed only for actions on non-DAF forms the DAF owns; submit DAF Form 673 for DAF forms; both go to the local PFM. | - | OPR, PFM | Partial (DAF Form 673 part yes; DD Form 67 only if wing owns a DoD form) | LD 55, GC 67 (E4) for the 673; DD Form 67 not named in plan | Partial |
| 8.10.2.1 | 4147 | OPR submits DD Form 67 to request an action on a DoD form the DAF owns (DoDM 7750.08). | T-0 | OPR | Partial (rare: wing OPR of a DoD form) | - | Gap |
| 8.10.2.2 | 4151 | Certification and approval officials for a form are those for the prescribing publication. | - | certifier, approver | Yes | PM 16-17; GC 67 (E4) | Covered |
| 8.11 | 4153 | A form is amended by Revision or Corrective Action. | - | OPR | Yes | LD 18 (Action Type: Corrective Action, Revise) | Covered |
| 8.11.1 | 4155 | Forms are revised with the prescribing publication or independently; revised forms meet current design standards and are re-dated when published. | - | OPR | Yes | LD 18 ("Revise" for forms); GC 24 (A15), 45 (B2 Edition Date), 67 (E4) | Covered |
| 8.11.1.1 | 4160 | Draft a form prototype and collaborate with the PCM and/or SMEs. | - | OPR | Yes | PM 11 (drafting stage) | Info |
| 8.11.1.2 | 4161 | Formal coordination; legal coordination obtained after all other coordination. | T-1 | OPR | Yes | PM 14-15; GC 67 (E4); PM 44 | Covered |
| 8.11.1.3 | 4163 | Certifying official endorses the DAF Form 673. | T-1 | certifier | Yes | PM 16; GC 67 (E4) | Covered |
| 8.11.1.4 | 4164 | Approving official endorses the DAF Form 673. | T-1 | approver | Yes | PM 17; GC 67 (E4) | Covered |
| 8.11.1.5 | 4165 | OPR submits the form to the PFM for final processing. | T-1 | OPR | Yes | PM 18 (stage 9) | Covered |
| 8.11.2 | 4169 | Corrective actions are purely technical fixes made with forms designers; form is re-dated and gets a supersession line; request via AFIMPT. | - | OPR, PFM | Yes (AFIMPT part does not apply) | GC 23 (A14), 68 (E5 new edition date, supersession); LD 18; PIschema 99 (Superseded By) | Covered |
| 8.11.3 | 4175 | OPR ensures form changes are reflected in the prescribing publication's guidance. | T-3 | OPR | Yes | LD 55; IR 26 (17) | Covered |
| 8.11.3.1 | 4177 | OPRs are encouraged to notify affected offices when a form is amended and posted. | - | OPR | Yes | LD 21 (Notice Sent event type). No amendment trigger | Partial |
| 8.11.3.2 | 4179 | Review all prescribed forms at periodic and special reviews; current forms are not re-dated; the 399 or 673 joins the record set. | T-3 | OPR | Yes | PM 21; GC 69 (E6); DEC 44 (forms grouped by publication); PIschema view line 293 | Covered |
| 8.12 | 4183 | A form is obsolete when superseded, rescinded, or its publication is rescinded; ANG notifies subscribers; coordination same as for development. | - | OPR, PFM | Yes (AFDPO PI/announcement part does not apply) | PM 61; GC 25 (A16); LD 61; DEC 46 (Product Status Superseded, Rescinded) | Covered |
| 8.12.1 | 4191 | Cancelling the publication cancels its forms; one 673 lists each form as obsolete; relink a form that must stay. | - | OPR | Yes | PM 61; LD 37 (Retained Forms Relinked), LD 61; GC 25 (A16) | Covered |
| 8.12.2 | 4197 | Rescinding a form alone: coordinate, certify, approve, send 673 to PFM, copy request to the information reports management and control office. | - | OPR | Yes | PM 61 (copy to information reports management and control office); GC 25 (A16) | Covered |
| 8.12.3 | 4202 | OPRs remove references to obsolete prescribed or adopted forms from active publications as soon as possible. | - | OPR | Yes | PIschema view line 293 links prescribed forms only; Adopted Forms is free text (LD 42) so references cannot be found | Partial |
| 9.1 | 4211 | Purpose of a waiver: enhance mission effectiveness; a unit unable to comply with directive guidance may request a waiver. | - | commander | Yes | LD 12 (PFM Waivers) | Info |
| 9.1.1 | 4214 | An Exception to Guidance (ETG) is a waiver made only for or on behalf of an individual. | - | commander | Yes | - | Info |
| 9.1.2 | 4216 | The commander grants an ETG at the same level that could waive for the unit (e.g., MAJCOM for T-1). | - | commander | Yes | None (PFM Waivers has no waiver-type column) | Gap |
| 9.1.3 | 4223 | No specific form for an individual ETG; DAF Form 679 may be used. | - | commander | Yes | - | Info |
| 9.1.4 | 4226 | Use ETG under this publication only if the directive guidance has no ETG process of its own. | - | commander | Yes | - | Info |
| 9.2 | 4228 | Commanders and directors submit written waiver requests through the chain to the approval authority; waivers can be retroactive. | T-1 | commander | Yes | LD 12 tracks the approved waiver only (Approval Date, Waiver Approver). No Requested Date | Partial |
| 9.2.1 | 4236 | Send the request to the tier waiver approval authority (T-0 to T-3) per Table A10.1. | T-1 | commander | Yes | LD 12 (Tier: T-1, T-2, T-3, Non-Tiered). No T-0 value; Table A10.1 authorities not seeded | Partial |
| 9.2.2 | 4238 | For non-tiered items, commanders may waive (pubs after 1 Jan 2018) unless restricted; send a copy to the HHQ OPR within 30 days. | T-1 | commander | Yes | LD 12 (Non-Tiered; HHQ OPR Notified Date); IR 23 (14). No 30-day due or reminder | Partial |
| 9.2.3 | 4245 | HQ DAF 2-Ltrs/L2s submit waivers to the HQ DAF approving official; HQ DAF organizations go through AFDPO to SAF/AA. | - | HQ DAF | No (HQ DAF level) | - | N/A |
| 9.3 | 4253 | Submit waiver requests on DAF Form 679, or by e-mail or memorandum if the form is unavailable. | T-1 | commander | Yes | LD 12 (Waiver Approval Link stores the signed 679). Request itself not tracked | Partial |
| 9.3.1 | 4255 | Request cites the reference and text of the requirement being waived. | T-1 | commander | Yes | LD 12 has Product lookup only; no waived publication or paragraph column | Partial |
| 9.3.2 | 4257 | Request gives the rationale and explains why granting it does not cause the adverse consequences of the tier. | T-1 | commander | Yes | LD 12 (679 kept via link). Not validated | Partial |
| 9.3.2.1 | 4262 | Rationale: cost of compliance creates unacceptable risk. | - | commander | Yes | - | Info |
| 9.3.2.2 | 4263 | Rationale: expected cost of compliance outweighs the benefit. | - | commander | Yes | - | Info |
| 9.3.2.3 | 4264 | Rationale: cannot comply for lack of resources. | - | commander | Yes | - | Info |
| 9.3.3 | 4265 | Request states the time period or circumstance for which the waiver is needed. | T-1 | commander | Yes | LD 12 has no Waiver Expiration or period-end column | Gap |
| 9.3.4 | 4266 | Request lists risk mitigation measures the commander will use during the waiver period. | T-1 | commander | Yes | LD 12 (679 kept via link) | Partial |
| 9.3.5 | 4268 | Request states the impact if the waiver is disapproved. | T-1 | commander | Yes | LD 12 (679 kept via link) | Partial |
| 9.4 | 4269 | Return approval or denial within 30 days of submission; denials explain; effective period starts at approval. | - | approver | Yes | LD 12 (Approval Date). No Requested Date, no Disapproved status, no 30-day measure | Partial |
| 9.4.1 | 4273 | The approval authority may approve, disapprove or modify the waiver request. | - | approver | Yes | LD 12 Waiver Status: Active, Renewal Due, Expired, Withdrawn (no Requested or Disapproved) | Gap |
| 9.4.2 | 4275 | Commanders document the decision to waive in a written or electronic record copy. | T-2 | commander | Yes | LD 12 (Waiver Approval Link); DEC 18 (central record sets) | Covered |
| 9.5 | 4277 | Waiver Period (heading). | - | - | Yes | LD 12 | Info |
| 9.5.1 | 4278 | T-1/T-2/T-3 waivers last no longer than the requested period or 90 days past the commander's tour; they expire 90 days after change of command unless renewed. | - | commander, PFM | Yes | LD 12 (Change Of Command Date, Renewal Due = +90 days, Waiver Renewal Due event); DEC 10 (4A). Requested period end not stored | Partial |
| 9.5.2 | 4283 | Non-tiered waiver period is set by the approver in the approval message; not more than 90 days past the commander's tour. | - | approver | Yes | LD 12 (Non-Tiered value). Approver's period end not stored | Partial |
| 9.5.3 | 4286 | A waiver written into a publication needs the signed approval in the package and record set; renew within 90 days of change of command or the OPR revises or rescinds. | T-1 | OPR | Yes | GC 26 (A17); LD 12, 31, 42 (Contains Waiver); DEC 10. No trigger that opens a Revise or Rescind action when a waiver lapses | Partial |
| 9.6 | 4294 | Processing Approved Waivers (heading). | - | - | Yes | LD 12 | Info |
| 9.6.1 | 4295 | The approved waiver is part of the approver's and requestor's official records and must be filed (AFI 33-322). | T-1 | commander | Yes | LD 12 (Waiver Approval Link). AFI 33-322 not named in plan docs | Covered |
| 9.6.2 | 4297 | Send a copy of the approved waiver to the HHQ publication OPR within 30 days (e-mail with completed 679 suffices). | T-1 | commander | Yes | LD 12 (HHQ OPR Notified Date); IR 23 (14). No 30-day due or reminder | Partial |
| 9.6.3 | 4301 | During the waiver period the requesting commander will do the following (heading). | - | commander | Yes | - | Info |
| 9.6.3.1 | 4302 | Implement approved risk controls to reduce or eliminate the risk. | T-2 | commander | Yes | - | Gap |
| 9.6.3.2 | 4304 | Actively work toward compliance by reducing cost and fixing resource shortfalls. | T-2 | commander | Yes | - | Gap |
| 9.6.3.3 | 4306 | Re-evaluate risk throughout the waiver period and adjust controls. | T-3 | commander | Yes | - | Gap |
| 9.6.3.4 | 4308 | Keep at least the previous commander's waivers on file. | T-2 | commander | Yes | LD 12 (Waiver Status Expired keeps the row); no delete rule stated | Partial |
| 10.1 | 4318 | AFDPO provides printing support; except ANG wings, procurement and distribution cover printing, storage and dissemination. | - | AFDPO | No (ANG wing excepted, 10.1) | DEC 42 (printed products left out) | N/A |
| 10.2 | 4322 | Except ANG wings, OPRs get AFDPO Logistics funding approval and submit GPO Form 952 and specifications. | T-2 | OPR | No (ANG wing excepted, 10.2) | DEC 42 | N/A |
| 10.3 | 4331 | Physical Product Storage and Distribution from the Army MDD (heading). | - | PFM | No (ANG wing excepted, 10.3.1) | - | N/A |
| 10.3.1 | 4332 | Except ANG wings, field PFMs request AFDPO storage and distribution support before sending product to the Army MDD. | T-1 | PFM | No (ANG wing excepted, 10.3.1) | DEC 42 | N/A |
| 10.3.2 | 4342 | PFM reorders stock, sends printing documentation to AFDPO before sending product to the Army MDD, gives disposition for old stock. | T-1 | PFM | No (Army MDD stock; ANG wing excepted, 10.3.1) | DEC 42 | N/A |
| 10.4 | 4351 | Social Protocol Stationery (heading). | - | - | No (general officer stationery) | - | N/A |
| 10.4.1 | 4352 | Social protocol stationery is for official social functions hosted or attended by general officers. | - | protocol officer | No (general officer stationery) | - | N/A |
| 10.4.2 | 4360 | Protocol officers order stationery online; a separate account needs a DAF Form 1846 signed by the general officer. | - | protocol officer | No (protocol officers, not PFM) | - | N/A |
| 10.4.3 | 4368 | Assigned general officers and SES members may use stationery; retired officers and selectees may not use it until promoted. | - | protocol officer | No (general officer stationery) | - | N/A |
| 10.4.4 | 4377 | Field activities will not supplement this section or consolidate command requirements for stationery; do not order stock for transient officers. | T-3 | all | Yes | No wing supplement exists (AGENTS.md Project rules; ARCH 81). No action needed | Info |
| 10.4.5 | 4382 | Specialty and unique products (place cards, note pads) are used only by HQ DAF; SAF/AAO orders them. | - | HQ DAF | No (HQ DAF organizations only) | - | N/A |
| 10.5 | 4393 | Store blank safeguard forms locked and out of reach; accountable forms in a locked cabinet in a locked room, not with classified; destroy accountable forms unusable. | T-1 | PFM | Partial (only if the wing stocks such forms) | LD 42 (Markings flag only); DEC 42 (printed products left out) | Partial |
| Signature block | 4402 | Approving official signature block for the manual. | - | HQ DAF | No (departmental authentication) | - | N/A |
| Att 1 References | 4410 | List of laws, DoD, DAF and AF references (4411-4493); one row below per reference the plan relies on. | - | all | Yes | style-standard 7 names AFH 33-337; FR 60 (F-035 Attachment 1 structure) | Info |
| Att 1 Statutes | 4411 | 5 USC 552 (FOIA), 5 USC 552a (Privacy Act), 29 USC 794d (Section 508), 44 USC 3501 (PRA). | - | all | Yes | Privacy Act, Section 508, PRA rules covered by concept (LD 38, 42; GC 46-48) but never cited by citation | Info |
| Att 1 AFI 33-322 | 4475 | Records Management and Information Governance Program; cited by 8.6.3.2, 9.6.1. | - | all | Yes | Not named in plan docs. Only in renderer records statement (scripts/gov/Publication.Common.ps1:7) and DEC 46 uses the AFRIMS RDS | Info |
| Att 1 AFI 33-324 | 4476 | Information Collections and Reports Management Program; cited by 8.2.1, 8.9.4. | - | all | Yes | Named: GC 48 (B5), GC 74; LD 33 (Information Collection) | Info |
| Att 1 AFI 33-332 | 4478 | Privacy and Civil Liberties Program; SSN guidance cited by 8.1, 8.7.4, 8.9.1.2. | - | all | Yes | Not named in plan docs (only inside a sample publication, docs/reviews/2026-11-11-cover-consistency.md:5) | Info |
| Att 1 AFI 33-393 | 4482 | Section 508 accessibility; cited by 8.9.3. | - | all | Yes | Not named in plan (Section 508 gate only: LD 38, GC 47) | Info |
| Att 1 DoDI 5200.48_DAFI16-1403 | 4431 | CUI; markings for classified, CUI and controlled forms, 8.9.5, 8.12.2. | - | all | Yes | Not named in plan (Markings choice only: LD 42, GC 72) | Info |
| Att 1 DoDI 7750.07 / DoDM 7750.08 | 4433 | DoD forms management policy and procedures; form definition, items not managed as forms, DD Form 67. | - | all | Yes | Not named in plan | Info |
| Att 1 DoDI 4525.09_DAFI36-3804 | 4425 | Postal operations; cited by 8.9.2 for mailer forms. | - | PFM | Yes | Not named in plan | Info |
| Att 1 AFI 17-101 | 4470 | Risk Management Framework for IT; cited by 8.6.4. | - | OPR | Yes | Not named in plan | Info |
| Att 1 DAFI 90-160 | 4464 | Publications and Forms Management; companion policy of this manual. | - | all | Yes | Named only in DEC 47 (ANGMAN note) | Info |
| Att 1 DAFI 38-101 | 4484 | Manpower and Organization; defines commanders and directors (9.2). | - | commander | Yes | Not named in plan | Info |
| Att 1 DoDM 5200.01V3_DAFMAN16-1404V3 | 4440 | Protection of classified information; disposition of controlled stock (10.5). | - | PFM | Partial | Not named in plan | Info |
| Att 1 AFH 33-337 | 4489 | The Tongue and Quill; writing style. | - | all | Yes | SS 7 and SS 21-46 (style rules) | Info |
| Att 1 Prescribed Forms (list) | 4495 | Forms this manual prescribes: DAF 399, 673, 679, 847, 1846; AF 1900-1914, 1937-1940, 2519, 3126-3153, 3990-3991. | - | all | Yes | See rows below | Info |
| Att 1 DAF Forms 399 and 673 | 4496 | Publication/Form Status Request and Action Request, the status and action forms. | - | OPR, PFM | Yes | PM 18, 21; LD 29 (Master DAF Form 673 Link); DEC 24 (Q4A) | Covered |
| Att 1 DAF Form 679 | 4498 | Publication Compliance Item Waiver Request. | - | commander | Yes | LD 12 (Waiver Approval Link). Form not named in LD; named only in DEC 47 | Partial |
| Att 1 DAF Form 847 | 4499 | Recommendation for Change of Product. | - | all | Yes | LD 11 (PFM Recommendations); GC 44 (B1); PM 69 | Covered |
| Att 1 DAF Form 1846 | 4500 | Request for and Record of Organizational Account (AFDPO ordering). | - | OAR | No (AFDPO ordering accounts; DEC 42) | DEC 42 | N/A |
| Att 1 AF Forms 1900-1914, 1937-1940, 3990-3991 | 4501 | General officer and SES invitations, place cards, note paper, envelopes. | - | protocol officer | No (general officer stationery) | - | N/A |
| Att 1 AF Forms 2519, 3126-3153 | 4523 | All-purpose checklist and general-purpose blank forms. | - | all | Yes | - | Info |
| Att 1 Adopted Forms (list) | 4533 | AF 310, DAF 688A, AF 1768, DD 67, GPO 952, GPO 3868, AFMC 181 adopted by this manual. | - | all | Yes | See rows below | Info |
| Att 1 DD Form 67 | 4537 | Form Processing Action Request; needed for actions on DoD forms the DAF owns (8.10.2.1). | - | OPR | Partial (rare) | Not named in plan | Info |
| Att 1 GPO Forms 952 and 3868 | 4538 | Printing request forms used with AFDPO printing (10.2). | - | OPR | No (ANG wing excepted, 10.2) | - | N/A |
| Att 1 AF 310, DAF 688A, AF 1768, AFMC 181 | 4534 | Document receipt, credentials, staff summary sheet, project order forms. | - | all | Yes | - | Info |
| Att 1 Abbreviations and Acronyms | 4542 | List of abbreviations; wing publications spell out other terms (4.5.9.7.2). | - | all | Yes | SS 33 (names use only Attachment 1 abbreviations, tested); FR 57 (F-032); FR 60 (F-035) | Covered |
| Att 1 Office Symbols | 4699 | HQ DAF and Space Force office symbols and titles. | - | all | Yes | docs/coordination-table-a3-2.md (Table A3.2 seed offices); FR 60 | Info |
| ANGMAN Opening | p1 | ANGMAN 90-161 (15 Jun 2023) defines ANG tier waivers for all ANG units; may not be supplemented at wing level; NGB-A2/6 waives it; records per AFI 33-322, ANGMAN 33-322. | - | all | Yes | DEC 47 (ANGMAN Rec: tier waivers on DAF Form 679, no wing supplement). Not yet a source for LD 12 | Partial |
| ANGMAN 1 Overview | p2 | ANG Waiver Repository (Intelink) is the authoritative waiver source; each wing sets an alert; only AF publication compliance items can be waived; wings use the ANG Tier Waiver Workflow Guide. | - | Wing Waiver POC | Yes | None. LD 12 does not mention the repository, the alert or the workflow guide | Gap |
| ANGMAN 1 Note | p2 | Effective period of a waiver starts when approved, not when submitted. | - | approver | Yes | LD 12 (Approval Date); same as DAFMAN 9.4 | Covered |
| ANGMAN 1.1-1.3 | p2 | NGB/CF concurs on T-0, sets Tier 1 delegation; ANGRC/CC delegates Tier 2 to directors; NGB-A2/6 is the ANG POC for DAFMAN 90-161. | - | NGB, ANGRC | No (NGB/ANGRC level) | - | N/A |
| ANGMAN 1.4 | p3 | ANG directorate workflow managers route, enter into ETMS2 within 1 duty day, staff within 30 days, upload Tier 0-1 waivers. | - | WFM | No (NGB directorate level) | - | N/A |
| ANGMAN 1.5.1-1.5.6 | p3 | ANG directorate AOs check for an existing ANG-wide waiver, validate the 679, and finish Tier 0-2 staffing in 30 days; the wing waits for the result. | - | ANG AO | No (NGB directorate level) | - | N/A |
| ANGMAN 1.5.7 | p4 | After 679 Section III is decided, the ANG AO uploads the waiver to the repository and e-mails the unit the approved or disapproved waiver. | - | ANG AO | Partial (wing receives and files the decision) | LD 12 (Approval Date, Waiver Approval Link). No Disapproved status | Partial |
| ANGMAN 1.5.8-1.5.9 | p4 | Directorate AOs review their waivers yearly and after new publications; keep records per AFI 33-322 (T-1). | T-1 | ANG AO | No (NGB directorate level) | - | N/A |
| ANGMAN 1.5.10 | p4 | Temporary, not-to-exceed, invalid or superseded waivers are archived once expired; affected wings are notified. | - | ANG AO | Partial (wing must update its record on notice) | LD 12 (Waiver Status: Expired, Withdrawn). No NTE date, no notice-received event | Partial |
| ANGMAN 1.6 and 1.8 | p4 | ANG IG and wing IGs include waivers in the evaluation process and consult the repository (T-2 for wing IG). | T-2 | IG | Partial (wing IG reads waiver records) | ARCH 79 (all site members read all rows); LD 12 | Partial |
| ANGMAN 1.7.1 | p5 | Wing Commander ensures the wing complies with this manual and the ANG Waiver Guide and files waivers per AFI 33-322 and DAFMAN 90-161. | T-2 | commander | Yes | LD 12 (Waiver Approval Link). Guide not referenced | Partial |
| ANGMAN 1.7.2 | p5 | Wing Commander appoints a Wing Waiver POC in writing. | - | commander | Yes | None (no Wing Waiver POC role in PFM Offices, PFM Settings or LD 12) | Gap |
| ANGMAN 1.7.3 | p5 | All tiered waivers are submitted and coordinated electronically on DAF Form 679 and uploaded to the ANG Waiver Repository. | T-1 | commander | Yes | LD 12 (Waiver Approval Link). No repository-upload flag | Partial |
| ANGMAN 1.7.4 | p5 | Waivers are not approved permanent for temporary conditions; mitigation is determined. | T-2 | commander | Yes | None (no Permanent or Temporary NTE type in LD 12) | Gap |
| ANGMAN 1.7.5 | p5 | Waivers are identified by HHQ publication requirements with the correct tier; other-MAJCOM or AFI rules may name approvers even for non-tiered waivers. | T-1 | commander | Yes | LD 12 (Tier, Waiver Approver). No Table A10.1 or HHQ-specific authority seed | Partial |
| ANGMAN 1.7.6 | p5 | Before ANGRC submission, wing organizations with functional responsibility coordinate on the tiered waiver; POC clears unclear intent. | T-2 | commander | Yes | None (no coordination record for waivers; PFM Endorsements is per publication action) | Gap |
| ANGMAN 1.7.7 | p5 | Keep a delegation letter on file if the Wing Commander delegates non-tier and Tier 3 approval to squadron commanders. | T-2 | commander | Yes | None (PM 17 delegation letter is for publication approval, not waivers) | Gap |
| ANGMAN 1.7.8 | p5 | One DAF Form 679 per tiering level; a form may not cover several tiers. | T-2 | commander | Yes | LD 12 (Tier is one choice per row, one row per waiver). Not checked against the 679 | Partial |
| ANGMAN 1.7.9 | p5 | Within 90 days of a Wing Commander change of command, an MFR lists all wing waivers as revalidated, instead of renewing each waiver; unvalidated ones leave the repository. | T-2 | commander, Wing Waiver POC | Yes | DEC 10 and LD 12 plan a per-waiver Change Of Command Date and Renewal Due. Conflicts with ANGMAN's wing-wide MFR; no MFR link or revalidation date | Partial |
| ANGMAN 1.7.10 | p5 | Keep a copy of the prior Wing Commander's waivers per AFI 33-322 and ANGMAN 33-322. | T-1 | commander | Yes | LD 12 (rows kept; Expired status); DEC 46 (records rule covers 673 and 399 only) | Partial |
| ANGMAN 1.9.1 | p6 | Wing Waiver POC is appointed in writing by the Wing Commander. | - | commander | Yes | None | Gap |
| ANGMAN 1.9.2 | p6 | POC sets an alert on the repository to see what other wings and the ANG waive. | - | Wing Waiver POC | Yes | None | Gap |
| ANGMAN 1.9.3 | p6 | POC checks the repository to confirm the new waiver was created once received from the requester. | T-2 | Wing Waiver POC | Yes | None (no Repository Entry Verified field) | Gap |
| ANGMAN 1.9.4-1.9.5 | p6 | POC ensures the most current DAF Form 679 is used and the proper tier is annotated. | T-2 | Wing Waiver POC | Yes | LD 12 (Tier). No form-version check | Partial |
| ANGMAN 1.9.6-1.9.7 | p6 | POC ensures the workflow guide checklist was used, block 9 meets HHQ rules, and base/HHQ coordination and Section II digital signatures are done. | T-2 | Wing Waiver POC | Yes | None | Gap |
| ANGMAN 1.9.8 | p6 | Name each waiver file like T-1_DAFI90-160_183 WG; add the paragraph if several waivers on one publication. | - | Wing Waiver POC | Yes | None (no waived-publication or paragraph column in LD 12 to build the name) | Gap |
| ANGMAN 1.9.9 | p6 | POC sends Tier 0, 1, 2 waivers to the ANG directorate workflow mailbox by publication series (Attachment 2); unsure goes to the SACO box. | T-2 | Wing Waiver POC | Yes | None (could be PFM Guidance rows, LD 10) | Gap |
| ANGMAN 1.9.10-1.9.11 | p6 | POC keeps initiators informed of waiver status and monitors the repository for the AO upload. | T-2 | Wing Waiver POC | Yes | LD 12 (Waiver Status). No requested or submitted status, no upload check | Partial |
| ANGMAN 1.9.12 | p6 | POC maintains the wing's waivers in the repository, watching expiration dates and changes to referenced publications; record sets kept per directive publications. | T-2 | Wing Waiver POC | Yes | LD 12 (Renewal Due, Waiver Renewal Due event). No expiry date and no alert when the referenced publication changes (GC 22 A13 covers wing products only) | Partial |
| ANGMAN 2 | p6 | The repository holds all ANG waivers; each wing keeps its current waivers there, including Tier 3, non-tiered and disapproved. | - | Wing Waiver POC | Yes | None | Gap |
| ANGMAN 2.1-2.2 | p7 | ANG AOs upload decided waivers with the standard name and all columns completed; wing paragraph added to the name when several exist. | T-2 | ANG AO | Partial (name format is set by the repository) | None | Gap |
| ANGMAN 2.3.1-2.3.3 | p7 | Wing POC adds the paragraph waived, a description and the tier (non-tier or 0-3) in the repository. | T-2 | Wing Waiver POC | Yes | LD 12 (Tier incl. Non-Tiered; no T-0 value). No paragraph or description column | Partial |
| ANGMAN 2.3.4-2.3.5 | p7 | Mark each waiver Approved permanent, Approved Temporary Not to Exceed, or Disapproved (keep disapproved rows); enter the NTE date from the 679. | T-2 | Wing Waiver POC | Yes | LD 12 Waiver Status has no Disapproved; no Duration choice or NTE date | Gap |
| ANGMAN 2.3.6-2.3.7 | p7 | Enter the initiator and DSN for contacts; add notes (e.g., whether still a good waiver). | T-2 | Wing Waiver POC | Yes | None (LD 12 has no Initiator or Notes) | Gap |
| ANGMAN 2.3.8 | p7 | The repository is a visual aid, not the official record; file the approved waiver per DAFMAN records rule (cites 9.7.1; current DAFMAN is 9.6.1). | T-1 | Wing Waiver POC | Yes | LD 12 (Waiver Approval Link). Plan unaware of the 9.7.1 versus 9.6.1 citation | Partial |
| ANGMAN 2.3.9 | p7 | File the copy of the waiver received from the AO per AFI 33-322 and ANGMAN 33-322. | - | Wing Waiver POC | Yes | LD 12 (Waiver Approval Link); DEC 18 (central record sets) | Covered |
| ANGMAN Att 1 | p8 | References: AFI 33-322, DAFI 90-160, DAFMAN 90-161, AFI 90-201, ANGMAN 33-322 (date TBD); adopted forms DAF 673, 679, 847. | - | all | Yes | DEC 47 names AFI 33-322, ANGMAN 33-322 and DAF Form 679 | Info |
| ANGMAN Att 2 | p10 | Series-to-directorate table with ANG directorate workflow mailboxes, used for Tier 0-2 routing. | - | Wing Waiver POC | Yes | None (mailboxes change monthly; could be a PFM Guidance row, not committed to the public repo) | Gap |

## Gaps

Counts here are Gap and Partial rows with a substantive missing item. Rows with a small caveat are grouped.

| Para | Line | What is missing | Severity | Suggested fix |
|---|---|---|---|---|
| 8.1 | 3724 | No SSN-specific flag; only generic CollectsPII | low | PFM Product Index: "Collects Social Security Number" (yes/no), tied to the SSN justification letter gate |
| 8.1.2 | 3736 | No lint for the retired "IMT" designator | low | docs/format-rules.md: add warn rule; Test-Publication.ps1 check |
| 8.1.3 | 3739 | No intake question to adopt a higher-headquarters form first | low | PFM Guidance row plus an intake step in PFM Process Steps |
| 8.3 | 3859 | No duplicate-form check against DAF, USAF, USSF and DoD forms | low | Form request gate: "Existing form searched" (yes/no) on PFM Publications |
| Table 8.1 One-time, Test | 3810, 3829 | Face wording "(One-time)/(Test) Expires <date>" not checked; Test form has no convert-or-obsolete step | low | PFM Product Index: flow at Expiration Date sets Product Status Rescinded unless converted; PFM Guidance text |
| 8.6 | 3917 | Adobe LiveCycle Designer and Attachment 7 design standards not named; no forms-designer rule set | low | Renderer backlog / docs/format-rules.md forms section |
| 8.6.3.1-8.6.3.3 | 3928-3934 | No rule on signature logos; wet-signature need and its documentation in the prescribing publication not tracked | low | PFM Product Index "Wet Signature Required" (yes/no); renderer lint for prescribing paragraph |
| 8.6.3.4.1 | 3944 | ARMS filing and no-scan rule for digitally signed documents not stated | low | PFM Guidance row; record-set checklist (LD 50) |
| 8.6.4 | 3962 | AFI 17-101 (RMF) not considered for the Power App as an information system | low | docs/ARCHITECTURE.md risk row; PFM decision whether the app needs an authorization |
| 8.6.7 | 3970 | Check that the form face names its prescribing publication not in a gate | low | Posting gate in LD 60: "Face names prescribing publication" (yes/no) |
| 8.7.1.1-8.7.4 | 3975-3998 | Prescribing-publication content rules (cite form, purpose, supply requests, no copy of form) absent from renderer | low | docs/format-rules.md: lint rules for form citations (see 8.7.1.2, 8.7.2, 8.8.1) |
| 8.8.4 | 4023 | No step for written permission before altering or repurposing an adopted form | low | PFM Guidance row; "Adopted Form Altered" flag on Product Index |
| 8.8.5 | 4025 | Overprint statement rule not in forms designer rules | low | Forms designer standard (Renderer backlog) |
| 8.8.6 | 4032 | No check whether the Power App or PFM Recommendations list duplicates DAF Form 847/673/679 fields, which needs the form OPR's written waiver | medium | PFM decision; if yes, request written waiver from the OPR (AFDPO) before build; record in docs/DECISIONS.md |
| 8.9.1.1 | 4051 | Computer matching warning for the Privacy Act statement not tracked | low | PFM Product Index: "Subject To Computer Matching" (yes/no) or checklist item |
| 8.9.1.2 | 4057 | SSN justification letter (PAO or PAM accepted) not tracked | medium | PFM Product Index: "SSN Justification Letter Link"; Privacy row gate; record-set checklist |
| 8.9.2 | 4063 | Postal mailer forms (USPS, DoDI 4525.09) not checked | low | PFM Product Index: "Used As Mailer" (yes/no) plus PFM Guidance row |
| 8.9.5.2.1, 8.9.5.2.2, 8.9.5.3, 10.5 | 4093-4398 | Accountable and safeguarded forms: Markings flag only; no control, receipt (30 days) or storage record | low | Left out by PFM (DEC 42). If the wing stocks them: PFM Product Index "Stock Location" and a receipt due date |
| 8.10.2, 8.10.2.1 | 4142-4147 | DD Form 67 not named; needed only if the wing owns a DoD form | low | PFM Guidance row; Action Type gate on Product Type Form |
| 8.10.1.3 | 4140 | Form justification not refreshed at periodic reviews | low | PFM Reviews: checklist item or review step |
| 8.11.3.1 | 4177 | No notice trigger when a form is amended | low | PFM Activity Log "Notice Sent" at posting of a Revise or Corrective Action |
| 8.12.3 | 4202 | References to obsolete forms in active publications cannot be found (Adopted Forms is free text) | medium | On form rescind or supersede, flow opens a special review on the Prescribing Publication; search Adopted Forms text; or make adopted forms a lookup |
| 9.1.2 | 4216 | No Exception to Guidance (individual) type | low | PFM Waivers: Waiver Type choice (Unit Waiver, Exception to Guidance) |
| 9.2, 9.3, 9.4, 9.4.1 | 4228-4273 | Requests not tracked: no Requested Date, no Requested or Disapproved status, no 30-day approval measure | medium | PFM Waivers: Requested Date; Waiver Status add Requested, Disapproved (ANGMAN 2.3.4 keeps disapproved rows) |
| 9.2.1 | 4236 | No T-0 tier value; Table A10.1 authorities not seeded | medium | PFM Waivers.Tier add T-0; PFM Guidance row for Table A10.1 and ANGMAN approvers |
| 9.2.2, 9.6.2 | 4238, 4297 | HHQ OPR copy date is stored but no 30-day due date or reminder | medium | PFM Waivers: HHQ OPR Notice Due (Approval Date + 30); reminder flow |
| 9.3.1 | 4255 | Waived publication and paragraph not stored | medium | PFM Waivers: "Waived Publication" and "Waived Paragraph" (text) |
| 9.3.3, 9.5.1, 9.5.2 | 4265, 4278, 4283 | No expiration or period-end date; renewal date only | medium | PFM Waivers: "Waiver End Date" (date), "Approval Period" choice (Permanent, Temporary NTE) |
| 9.5.3 | 4286 | No trigger to open a Revise or Rescind action when a waiver in a publication lapses | medium | Flow at Waiver Status Expired where Product.Contains Waiver = Yes |
| 9.3.2, 9.3.4, 9.3.5, 9.6.3.1-9.6.3.4 | 4257-4308 | Rationale, mitigation, impact, risk re-evaluation and keeping prior waivers not tracked beyond the 679 link | low | Rely on the 679 link; optional "Risk Re-evaluation Due" date on PFM Waivers |
| ANGMAN Opening, 1 Overview | p1-p2 | ANGMAN 90-161 not yet used for waiver tracking although DEC 17 puts waivers in scope; ANG Waiver Repository, wing alert, workflow guide absent | medium | Add "In ANG Waiver Repository" (yes/no) and "Repository Entry Verified Date" to PFM Waivers; update DEC 47 and LD 12 |
| ANGMAN 1.7.2, 1.9.1 | p5-p6 | Wing Waiver POC (appointed in writing) has no place in the system | medium | PFM Settings key "WingWaiverPOC" (person) or PFM Offices Coordination Role "Waiver POC" |
| ANGMAN 1.7.4, 2.3.4-2.3.5 | p5, p7 | Permanent versus Temporary NTE, NTE date, Disapproved retained | medium | PFM Waivers: Approval Period choice, Waiver End Date, status Disapproved |
| ANGMAN 1.7.6, 1.9.6-1.9.7 | p5-p6 | Wing functional coordination, 679 block 9 and digital signature checks before ANGRC submission | medium | PFM Waivers: coordination checklist; reuse PFM Endorsements with a waiver link |
| ANGMAN 1.7.7 | p5 | Delegation letter for squadron commander approval of non-tier and Tier 3 waivers | medium | PFM Waivers: "Delegation Letter Link" (URL), required when Approver is not the Wing Commander |
| ANGMAN 1.7.9 | p5 | Conflict: ANGMAN uses a wing-wide MFR within 90 days of a Wing Commander change; plan uses per-waiver renewal (DEC 10, 4A) | high | PFM decision: keep 4A per-approver dates and add "Revalidated By MFR" plus "MFR Link" per waiver, with a Wing Commander change date in PFM Settings |
| ANGMAN 1.9.2, 1.9.3, 1.9.9, 2, Att 2 | p6, p10 | Repository alert, repository check, routing of Tier 0-2 by series, directorate mailboxes | low | PFM Guidance rows (no mailboxes in the public repo); status "Sent To ANG" in PFM Waivers |
| ANGMAN 1.9.8, 2.1 | p6-p7 | Naming convention for waiver files not supported | low | PFM Waivers: computed Title "T-1_DAFI90-160_<unit>" from Tier, Waived Publication, Waived Paragraph |
| ANGMAN 2.3.6-2.3.8 | p7 | Initiator, DSN, notes; ANGMAN cites DAFMAN 9.7.1 for records, current DAFMAN is 9.6.1 | low | PFM Waivers: Initiator (person), Notes; note citation in docs/process-model.md |
| 8.5, Att 1 refs | 3898, 4431-4482 | Plan does not name AFI 33-322, AFI 33-332, AFI 33-393, DoDI 5200.48 (only AFI 33-324 is named) | low | Add a References section to docs/process-model.md citing them with the rules that use them |
