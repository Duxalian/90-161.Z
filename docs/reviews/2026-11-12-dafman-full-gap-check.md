# DAFMAN 90-161 full gap check against the plan (12 Nov 26)

Method: 4 agents each read one quarter of ref/dafman90-161.txt (lines 1-2050, 2050-4100, 4100-6150, 6150-8146) in full and compared it with the plan (walkthrough https://claude.ai/artifact/VLxDqQfhEfWSw4Ckrc52Ki, docs/DECISIONS.md, docs/process-model.md). They reported 80 items (with overlaps). Claude read the cited lines for 30 of them: 25 change the plan (table A), 3 were already in the plan, 1 is wrong, 1 is unclear. "Checked" = Claude read the cited lines. "Reported" = agent finding, not yet checked line by line.
No earlier paragraph-by-paragraph reference existed in the repo; the 11 Nov full-text check produced design rules (r7 design check), not a reference file. This file is that reference.

## A. Rules the plan states wrongly or leaves out (checked)

| # | Rule | DAFMAN | Plan today | Change |
|---|---|---|---|---|
| A1 | A FOIA specialist must review publications before publication (T-1) | 1.5.3 | Mandatory: JAG, CIO, PFM | FOIA review is required; decide who (Decide 13) |
| A2 | The local records manager checks the prescribed processes against the AF RDS during formal coordination (T-3) | 7.1.3 | Not listed | Records review required; decide who (Decide 13) |
| A3 | Coordinate with the local AFR unit when the publication applies to it (T-2) | 1.9 | Not listed | Ask at request; adds Reserve Applicability |
| A4 | The PFM assigns control numbers (at least 3 digits, consecutive in the series) and approves all numbers; supplements carry the parent number + _<unit>SUP; ICs numbered IC-1, IC-2 ... | 4.3.8, 4.3.8.1, 4.3.9 | No numbering step | PFM numbering step at request; IC number per product |
| A5 | Before final legal review, the 673 shows all required coordination or "N/A" | 2.8.13 | Not stated | Gate before Legal |
| A6 | Section I and blocks 21a/22a of the 673 are filled before the tasker; endorsements are transcribed to a master 673 before certification | 5.1.5 | Not stated | Gate before Formal Coordination; master 673 |
| A7 | "Concur-No Response" needs an explanation in the staff package (T-3) | 5.4.3.2 | Not stated | Required justification field |
| A8 | Certifier one level above the OPR and one below the approver; approver may sign both when they coincide (command and field level) | 5.6.3.2.1-5.6.3.2.2 | AO names anyone | App explains and checks the rule |
| A9 | Effective date is the release date; a future date needs justification; never backdated | 3.7.5 | Not stated | Effective Date >= posting date |
| A10 | GMs: expire after 1 year or on IC/rewrite; reissue for up to 1 year with a 673, legal review and both signatures; a wing GM changes only wing publications; one active GM per publication | 4.3.7.2, Table A11.1 item 7, 7.9.1 | "GM expires" only | GM rules and a Reissue GM action |
| A11 | Supplements: GMs, OIs, PDs, PMs, MDs cannot be supplemented; the parent may forbid it | 1.1.3.5.1 | Not checked | Check at request |
| A12 | An OI covers one function only; wider applicability needs an instruction or manual | Table A11.1 item 8 | Not checked | Check at request |
| A13 | Alert OPRs when a higher-headquarters publication they implement changes | 2.6.19 | No trigger | Special review for each child row when a parent changes |
| A14 | Corrective Action: the PFM fixes a processing or administrative error, no 673 | Glossary | No such type | New action type |
| A15 | Forms may be revised or rescinded independently of the prescribing publication; full chain applies | 8.10.1, 8.12.2, Table A5.1 | Publication actions only | Form action types (Decide 14) |
| A16 | Rescinding a publication cancels its forms unless a form is first linked to another prescribing publication; ANG notifies subscribers; a copy goes to the information reports management and control office | 8.12, 8.12.1, 8.12.2 | "Rescind cascades to forms" | Retain-form check; notices |
| A17 | A waiver written into a publication needs the signed approval in the record set; the new commander renews it within 90 days after a change of command, or the OPR revises or rescinds (T-1) | 9.5.3 | Not tracked | Waiver flag and renewal tracker (Decide 14) |
| A18 | Transfer: the current approving authority obtains the new approving authority's concurrence before any other action (T-1) | 7.10.1 | No steps | Transfer steps |
| A19 | Only OPRs or PCMs may initiate an Administrative Change | 7.8.3 | Not stated | Who can start an AC |
| A20 | The command or field PFM, with the senior communications, information and knowledge operations manager, decides who keeps record sets locally (T-3) | 7.2.2.3 | Not decided | Decide 15 |
| A21 | Critical comment = automatic nonconcur, resolved before publication | Glossary, 5.3.3 | CRM link only | Comment type on the CRM |
| A22 | Do not use a tier number at the issuer's own level: (T-3) is redundant in a wing publication | Attachment 10 note 4 | Renderer and T06 sample use (T-3) | Done 2026-11-12: F-040 (warn) in docs/format-rules.md and scripts/gov/Test-Publication.ps1. Open for the PFM: severity, the tier a wing compliance statement carries instead, sample and T06 EXPECTED |
| A23 | Wing ICs use Rule 2: full text, changed elements marked with an asterisk, camera-ready | 7.7.3, 7.7.5 | Not in the renderer | Renderer backlog |
| A24 | Base and wing units coordinate with local offices; Table A3.2 lists the local offices and their triggers | A3.1, A3.2 | AO adds offices freely | Seed PFM Offices with A3.2 offices and trigger questions |
| A25 | Unless stated, days are calendar days | Glossary | Mixed | Store the day type with each limit; 5.2 coordination stays 15 business days |

Wrong agent finding: "15 business days conflicts with calendar days". 5.2 says "15 business days" explicitly. Unclear: 5.2.2 (at least 30 calendar days for wings and units below MAJCOM level) is written for applicability reviews; whether it applies to wing-to-unit coordination is open.

## B. Second pass (12 Nov): the reported items, checked against the text

An agent read each cited paragraph (31 claims after splitting, plus 13 forms and DAF Form 847 items it found). Claude re-read 5 of them (8.5.3, 8.9.1.2, 7.7.7, 5.5.1-5.5.2, Table 8.1): all hold. Result: 26 confirmed, 2 apply only above wing level, 1 wrong; 13 extra confirmed.

| # | Rule | DAFMAN (tier) | What the system must hold or do |
|---|---|---|---|
| B1 | DAF Form 847 goes to the OPR; the originator hears the disposition at each level; the initiating level's PFM assigns the tracking number | 7.4.5, A6.3.3-A6.3.5, Table A6.1 | 847 list: tracking number, publication, paragraph, proposed text, rationale, status, disposition with justification; notice to the originator |
| B2 | Forms: the PFM assigns form numbers in sequence and the edition date on the day the form is posted, and locks the final form | 8.6.1, 8.6.5, A7.6.2.4, A7.18 (T-0) | Form number (next in sequence), edition date set at posting, Locked gate |
| B3 | Privacy Act statement on forms that collect personal data; PII forms need PAO/PAM coordination and approval on the 673 and an SSN justification letter | 8.9.1 (T-0), 8.9.1.2 (T-1) | Collects PII, PAS included and placement; PAO/PAM coordinator row required; letter in the record set |
| B4 | Section 508: local PFMs ensure products not on e-Publishing comply | 8.9.3 (T-0) | Section 508 Checked gate before posting (publications and forms) |
| B5 | Information collections follow AFI 33-324; public collections show the OMB number and expiration | 8.9.4 (T-0), A7.10 (T-0) | Information Collection (None, Internal, Public); OMB number and expiration when Public |
| B6 | Prescribed forms listed on the 673; OPR justifies the form, its data fields and printing | 8.10.1.1-8.10.1.2 (T-1) | Action links its forms; form justification, data fields, printing and distribution |
| B7 | Form record set kept apart from the publication record set; a shared 673 goes in the publication set with a copy in the form set; record set contents listed | 7.2.1, 7.2.3 (T-1) | Record Sets folder per publication and per form; checklist of required items |
| B8 | Coordination package: summary of changes, rationale, blank CRM, 673, current version | Figure A5.1 step 2 | Gate before Formal Coordination |
| B9 | ICs supersede or incorporate active GMs and PMs; ACs go into the next IC or rewrite | 7.7.7, 7.8.4 (T-1) | Gate at IC and rewrite approval |
| B10 | Certification may proceed with an open nonconcur shown; approval needs it resolved or an impasse memo (part of the record set) | Figure A5.1 step 4, 5.5.1-5.5.2 | Open Nonconcurs count; approval gate |
| B11 | Change of OPR only: certifying or approving official, report to the PFM, no outside coordination | 7.10.7 | Action type Change OPR |
| B12 | Privacy Act warning statement when necessary (SORN is referenced inside the statement) | 1.5.4 (T-1) | Privacy Act Warning Required flag |
| B13 | Copyrighted material noted on the 673 | 1.5.6.1 (T-1) | Contains Copyright flag |
| B14 | Contractor AO: final decisions by a government employee | 2.7.2 | AO Is Contractor; Government Decision Maker |
| B15 | Deviation from HHQ: the agreement is cited | 1.4.5 | Deviates From HHQ; Agreement Citation |
| B16 | Less restrictive than HHQ: legal on that issue | 5.7.3 | Less Restrictive flag adds the legal check |
| B17 | Remove track changes and comments before formal coordination; draft header | 4.5.1 | Gate (renderer already marks drafts) |
| B18 | AO recommends the accessibility level | 2.8.3 | Access Level (Public, Restricted, CUI) |
| B19 | PCM optional below HQ DAF | 2.3.2 | Optional PCM per office |
| B20 | PFM appointment letter | 2.6 | Program record item |
| E1 | ANG wing forms are published and managed on the wing site, not AFDPO | 8.4.1, 8.5.3 | No AFIMPT step |
| E2 | A new form posts together with its prescribing publication; the form names it | 8.7, 8.6.7 (T-1) | Gate; Prescribing Publication required |
| E3 | A form that collects personal information must be prescribed in a publication | 8.7.4 (T-3) | Collects PII requires Prescribing Publication |
| E4 | Form actions run full coordination, legal last, then certifier, approver, PFM | 8.10, 8.11.1 | Form actions use the endorsement workflow |
| E5 | Corrective action re-dates a form and adds a supersession line | 8.11.2 | New edition date; supersession text |
| E6 | Forms reviewed with the publication; current forms not re-dated | 8.11.3.2 (T-3) | Review covers linked forms |
| E7 | Test and one-time forms expire within 1 year | Table 8.1 | Form Type; Expires (alert) |
| E8 | Adopt higher-headquarters forms first | 8.1.3 (T-1) | Intake question |
| E9 | CUI forms are marked and protected | 8.9.5 (T-0) | Markings |

Wrong: "information collections need OMB approval" (1.5.1 requires AFI 33-324 compliance; OMB applies to public collections only, 8.2.1, A7.10). Above wing level only: 847 routing through MAJCOM channels (A6.3.1; ANG is not a MAJCOM, 7.3) and CUI titles in the e-Publishing PI (6.2.3).
