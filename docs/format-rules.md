# Format and writing rules: 90-161.Z

Source: DAFMAN 90-161, 18 Oct 2023, Change 1 (14 Jul 2025), Corrective Action (1 May 2026).
Extraction status: **draft, not verified**. Agent extracted these through a web summary, not the literal PDF text. Before any rule is used as a hard check, verify its wording against the PDF and set `Verified` to the date.

Goal (the owner, 2026-11-10): the rules force output to look like DAFMAN 90-161 itself. AFIMPT is not used for formatting or tracking.

## How the rules are enforced

| Layer | Mechanism | What it guarantees |
|---|---|---|
| L1 Schema | The model returns content only as structured JSON (header fields, paragraphs with level, tables, attachments). The schema has no font, size or style fields. | The model cannot change format. |
| L2 Renderer | Deterministic code builds the .docx from the JSON. Fonts, margins, numbering, bolding and header block are fixed in code. | Same input gives the same layout every time. |
| L3 Validator | Code checks each rule below and reports pass/fail per rule ID. | "Perfect" = 0 fails on `hard` rules. |

Check type: `schema` = enforced by L1; `render` = enforced by L2; `lint` = checked by L3 on the text; `human` = the owner checks.
Severity: `hard` = blocks output; `warn` = reported only.

## Rules

| ID | Rule | Ref | Check | Sev | Verified |
|---|---|---|---|---|---|
| F-001 | Microsoft Word, Times New Roman 12 pt, 1-inch margins all sides; page numbers included | 4.5.3.1 | render | hard | — |
| F-002 | Tables, figures, attachments use the same font unless another size improves readability or fit | 4.5.3.1 | render | warn | — |
| F-003 | Paragraph numbers end with a period when they precede text (1.1., 1.1.1.) | 4.5.3.2 | render | hard | — |
| F-004 | Subordinate paragraph numbers and titles not bold | 4.5.3.3 | render | hard | — |
| F-005 | Each subparagraph has at least one companion at the same level (not for integrated supplements) | 4.5.3.4 | lint | hard | — |
| F-006 | Max 7 paragraph levels | 4.5.3.5 | schema | hard | — |
| F-007 | Tables not made in Word are figures | 4.5.3.6 | schema | hard | — |
| F-008 | Each attachment has a title | 4.5.3.7 | schema | hard | — |
| F-009 | Numbering per Table 4.1: chapters Arabic; sections capital letters with chapter prefix; paragraphs chapter-based (1.1); figures/tables chapter- or attachment-based (Figure 1.1, Figure A2.1); attachment paragraphs A3.1; supplements follow parent numbering | T4.1 | render | hard | — |
| F-010 | Draft mode: header "DRAFT—NOT FOR IMPLEMENTATION OR COMPLIANCE" on every page; no watermark; no track changes or comments | 4.5.1 | render | hard | — |
| F-011 | Content order: header; opening paragraph; summary of changes (if applicable); TOC (if applicable); overview/background; responsibilities; core content; approver's authentication; attachments | 4.5.2 | schema | hard | — |
| F-012 | Front header flush left, no tabs, single-spaced | 4.5.4 | render | hard | — |
| F-013 | First line "BY ORDER OF THE [SECRETARY OF THE AIR FORCE] [COMMANDER]" | 4.5.4.1 | schema | hard | — |
| F-014 | Unit publications use the unit shield; integrated supplements use the seal | 4.5.4.2 | human | hard | — |
| F-015 | Type and number with correct prefix (DAF / AF / SPF) | 4.5.4.3 | lint | hard | — |
| F-016 | Date placeholder "(Date)" | 4.5.4.4 | render | hard | — |
| F-017 | AFSC series title in italics | 4.5.4.5 | render | hard | — |
| F-018 | Title all caps; no "policy, instruction, guidance, handbook, pamphlet, catalog, guide, book"; no "Department of the Air Force", "Air Force", "Space Force" | 4.5.4.6 | lint | hard | — |
| F-019 | "COMPLIANCE WITH THIS PUBLICATION IS MANDATORY" for directive publications only | 4.5.4.7 | schema | hard | — |
| F-020 | ACCESSIBILITY and RELEASABILITY statements from Tables 4.2 / 4.3 | 4.5.4.8–9 | schema | hard | — |
| F-021 | "OPR:" and "Certified By:" show office symbols, no names | 4.5.4.10–11 | lint | hard | — |
| F-022 | "Supersedes:" month spelled out, entries separated by semicolons; line omitted if none | 4.5.4.12 | render | hard | — |
| F-023 | "Pages:" with page count | 4.5.4.13 | render | hard | — |
| F-024 | Opening paragraph: first sentence names the immediate antecedent publication in full, title italic | 4.5.5.1 | lint | hard | — |
| F-025 | Opening paragraph statements as applicable: applicability, Privacy Act, copyright, PRA, punitive, statutory, records, recommending changes (DAF Form 847), supplementing, waiver authority, trademark disclaimer last | 4.5.5.2–13 | schema | hard | — |
| F-026 | Summary of changes: heading bold italic all caps; brief; rewrites and ICs only; IC last sentence "A margin bar (\|) indicates newly revised material." | 4.5.6 | render | hard | — |
| F-027 | TOC: required by OPR for 20+ pages not processed by AFDPO and for below-wing publications; first-level headings only | 4.5.8 | render | hard | — |
| F-028 | Main headings bold, significant words capitalized | 4.5.9.2 | render | hard | — |
| F-029 | Directive publications: no bullets. Non-directive: simple, non-nested bullets only | 4.5.9.3 | schema | hard | — |
| F-030 | Responsibilities assigned to positions, not individuals | 4.5.9.6 | lint | warn | — |
| F-031 | No section titled "Core Content" | 4.5.9.7 | lint | hard | — |
| F-032 | Acronyms and office symbols spelled out at first use, listed in Attachment 1; headings spell out then acronym; acronyms used 4 times or fewer spelled out | 4.5.9.7.2–3 | lint | warn | — |
| F-033 | Bold list (chapter titles, top-level paragraph numbers/titles, table/figure numbers/titles, Note:/Exception:, tier numbers, attachment titles, Attachment 1 categories); URLs not bold | 4.5.9.7.4 | render | hard | — |
| F-034 | No wet signature on the publication | 4.5.10 | schema | hard | — |
| F-035 | Attachment 1 "GLOSSARY OF REFERENCES AND SUPPORTING INFORMATION": unnumbered sections References, Prescribed Forms, Adopted Forms ("None" if empty), Abbreviations and Acronyms, Office Symbols, Terms; references without URLs | 4.5.11 | schema | hard | — |
| F-036 | Additional attachments numbered in sequence, paragraphs A2.1, A3.1 | 4.5.11.2 | render | hard | — |
| F-037 | "Note:" and "Exception:" bold with colon | 4.6 | render | hard | — |
| F-038 | Figure/table number and title directly above the item; min 8 pt | 4.6 | render | hard | — |
| F-039 | Compliance statements use "will"/"must", name a responsible party, end with bold tier "(T-1)"; no blanket tiers | 4.6.5 | lint | hard | — |
| W-001 | Use "must", not "shall" | T1.1 #5 | lint | hard | — |
| W-002 | Sentences 20 words or fewer; paragraphs 7 sentences or fewer | T1.1 #2 | lint | warn | — |
| W-003 | No all-caps for emphasis | T1.1 #4 | lint | warn | — |
| W-004 | Active voice; plain language | T1.1 #1, 1.2.2 | lint | warn | — |
| S-001 | Final submission format: text flush left in the standard template; figure files TIF/JPG/GIF/PNG, separate; file names without spaces | 3.8 | render | hard | — |

## Open

- Literal wording for Tables 4.2–4.5 and the statements in 4.5.5 is not yet extracted. The renderer must take them from the verified text, not from this summary.
- Wing supplement rules (if any) override or add to this list.
