# Intake: PFM's wing publishing files (2026-11-11)

Source: 5 files the PFM sent (camera-ready template, AO's guide, ANG publishing checklist (fillable PDF, 117 distinct answer sets), old comment matrix, Attachment 1 tracking workbook). No CUI marking in any file. The files themselves are NOT in this public repo; wing names, office symbols and contacts are replaced with [WING] / [OFFICE].

## 1. Process order the PFM uses (AO's guide + checklist)

| # | Step | Owner | DAFMAN ref | Notes |
|---|---|---|---|---|
| 0 | Periodic review: DAF 399 = current / requires revision / obsolete | AO, approver | 7.4, 7.4.2 (every four years) | Checklist Section I. Guide: also on commander request |
| 1 | Drafting: PFM gives AO the template + editable copy; AO drafts camera-ready | AO, PFM | 2.7.2, 3.1.6, 4.5 | Checklist Section II (formatting, 15 blocks) |
| 2 | PFM final-draft review before formal coordination | PFM | 2.6.4 | Checklist block 18 |
| 3 | Informal coordination: scope check against a list of ~22 wing staff/units | AO | Table A3.2 | Checklist Section III |
| 4 | Formal coordination: PFM gives a partially filled DAF 673; order = stakeholders, then records/privacy/FOIA office, then Legal (last) | AO | 5.1, 3.4 | Endorsers write //SIGNED// FIRST M. LAST, Rank, Service, Office Symbol on the 673 (5.1.4.2); AO may transcribe to a master 673 (4.2.2.2) |
| 5 | No response in 15 days after a good-faith request: AO may mark Concur—No Response; not for records/privacy office or Legal | AO | 5.1.4.3, 5.2.1, 5.4.3 | |
| 6 | Certification (typically OPR commander), then approval (lowest commander responsible; may be the same person) | Officials | 5.6.3.2.1, 5.7, 5.7.7 | Not before Legal concurs |
| 7 | Publish: AO gives PFM final .docx + 673 + all correspondence; PFM posts on the wing site | AO, PFM | 6.1.2, 2.8.4, 6.4.1 | |

Checklist Section IV (formal coordination) is referenced but not written ("unfinished").

## 2. Opening paragraph (camera-ready template)

Fixed order and wording, with variable slots:

1. Antecedent: "This [WING TYPE] ([WING ABBR]) Instruction implements [antecedent publication]." (4.5.5.1)
2. Purpose: "It provides guidance and procedures on [purpose] throughout the Air National Guard."
3. Applicability: "This publication applies to all civilian employees and uniformed members of the [WING]." (4.5.5.2)
4. Privacy Act (only if PII is collected): DAFMAN 4.5.5.3 wording with [authority] and [SORN number and title] and the SORN link.
5. Records: DAFMAN 4.5.5.8 wording, verbatim.
6. Recommending changes: DAFMAN 4.5.5.9 example, verbatim.
7. Supplementing: Table 4.5 item 2, verbatim.
8. Waiver: DAFMAN 4.5.5.11 example, but the template says "wing, unit, delta or garrison level" and "Tier" (DAFMAN: "wing, unit, or delta level", "tier"). "garrison" does not appear in DAFMAN 90-161.
9. Trade names (only if used): DAFMAN 4.5.5.12 wording, last sentence.

Conclusion: 6 of 9 parts are fixed text. Code should assemble the paragraph; the model fills only the slots.

## 3. Template and checklist vs DAFMAN 90-161 and the current renderer

| Item | Template / checklist | DAFMAN 90-161 / renderer | Note |
|---|---|---|---|
| Subparagraph indent | 0.3 in per level, but inconsistent (0.19, 0.3, 0.6, 1.5 with 0.3 first-line) | 0.25 in per level (measured, L-002) | Decide |
| Signature block | Right-aligned name, title | Left edge at 4.0 in (measured, L-006) | Decide |
| Cover rules | 1 pt (checklist) | renderer 1.5 pt (not measured) | Fix to 1 pt |
| Sentence spacing | Two spaces before each sentence (checklist) | Renderer types text as given | Add normalization |
| Certified by | Template "Certified by:" + "(Rank First Last)" line; checklist "Certified By:" | PFM decided "Certified by:" (2026-11-11) | Add certifier name line |
| Supersedes | Template "SUPERSEDES:"; checklist "Supersedes:" | "Supersedes:" (4.5.4.12) | Keep DAFMAN |
| Header layout | Left column: By Order, unit, shield; right: number, date, series, title; title aligned to bottom of shield | Same columns | Align title to shield bottom |
| Running header | "[WING ABBR]I XX-XXX  DD MONTH YYYY" + page; alternating; from page 2 | Same, but uses file designator (no spaces) | Separate header designator |
| TOC | Template/checklist: only 20+ pages | 4.5.8.2: also all publications issued at ANG wing level (T-1) | Decide |
| Responsibilities verb | Template "shall:" | Table 1.1: "must", not "shall" | Template outdated |
| Accessibility | Wing site location | Table 4.2 examples | Local config |
| Comment matrix | Old: 5 columns | 5.3 (T-1): 9 columns; new template built (A12.1) | Replaced |
| Attachment 1 tracking | Workbook: acronyms, forms (prescribed), references, each with paragraph | Validator lists acronyms only | Generate this report |

## 4. Checklist Section II as automation

Of the ~60 formatting checks in Section II, about 70% are mechanical (renderer or validator can enforce); the rest need human judgment (accuracy, scope, audience, references, 4.6 relevance). Count by block, Agent estimate: blocks 6, 8, 10, 12, 15 mostly mechanical; 9, 13, 14 mostly human.
