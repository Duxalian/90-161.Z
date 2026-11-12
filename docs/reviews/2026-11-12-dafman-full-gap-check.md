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

## B. Reported, not yet checked line by line

DAF Form 847 intake and routing (7.4.5, Attachment 6); forms management (PFM form numbers 8.6.1, edition date 8.6.5, locking A7.18, Privacy Act statement 8.9.1, PII forms need PAO/PAM approval 8.9.1.2, Section 508 8.9.3, Paperwork Reduction Act 8.9.4, OMB number A7.10); prescribed-form data on the 673 (8.10.1.1-8.10.1.2); separate form record set (7.2.1) and record set contents (glossary, 7.2.3); package adds summary of changes, rationale and current version (Figure A5.1 step 2); ICs absorb active GMs and ACs (7.7.7, 7.8.4); certification may go forward with an outstanding nonconcur shown (Figure A5.1 step 4); Change OPR only (7.10.7); PII: SORN link (1.5.4); information collections need OMB approval (1.5.1); copyright flag (1.5.6.1); contractor AO (2.7.2); deviation from HHQ needs the agreement cited (1.4.5); less restrictive than HHQ needs legal (5.7.3); remove track changes before coordination (4.5.1); accessibility and CUI listing (2.8.3, 6.2.3); PCM optional below HQ DAF (2.3.2); PFM appointment letter (2.6).
