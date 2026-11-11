# Cover page consistency check (Phase A), 2026-11-11

Method: page 1 of 7 published e-Publishing PDFs opened in the PFM's built-in browser; geometry extracted with pdf.js (text positions, drawn rules, image placement). Units: inches from the page's top-left edge. No estimates: every number below is measured.

Sample: DAFMAN 90-161 (2023, C1, CA 2026); AFI 33-332 JB Charleston SUP (2026); TYNDALLAFBI 33-332 (2023, base instruction); AFI 33-332 Shaw AFB SUP (2025); DAFMAN 90-161 8 FW SUP (2023); DAFMAN 90-161 Maxwell AFB SUP (2024); AFI 33-332 93 AGOW SUP (2023). Hard cases covered: 2-line titles, 3-line organization blocks, "Corrective Actions applied" lines, supplement lines, 3-line Supersedes, certifier names.

## Same on 7 of 7 (layout rules)

| ID | Element | Measured |
|---|---|---|
| L-010a | Left column | "BY ORDER OF THE ..." at x 1.00, lines at y 1.16 and 1.35 (line pitch 0.19 in) |
| L-010b | Right column | Every line right-aligned at x 7.50; widest observed line starts at x 4.63 (column at least 2.87 in) |
| L-007 | Seal/shield | x 1.00, top y 1.47, 1.20 in x 1.20 in (2 of 7: 1.25 in wide) |
| L-010c | Right-column groups | Lines inside a group 0.19 in apart; groups separated by one blank line (0.36 in pitch). Order: issuer + type/number; date (+ change / corrective-action lines); [organization + "Supplement" + supplement date]; series title; title |
| L-010d | Title | All caps, wraps inside the right column; the last title line is NOT aligned to the seal bottom (title end 2.61-3.55 vs seal bottom 2.67-2.72) |
| L-008 | Rules | 3 rules, x 1.00, 6.50 in wide, 0.75-0.80 pt thick: below the compliance line, below RELEASABILITY, below the Supersedes/Pages block |
| L-010e | Compliance line | Centered on the page (1.91-6.59); about 0.42 in below whichever ends lower: the title or the seal |
| L-005 | ACCESSIBILITY / RELEASABILITY | Label at x 1.00; text at x 2.50 (hanging, 1.50 in); continuation lines at 2.50; one blank line between the two statements |
| L-010f | OPR line | "OPR:" at 1.00, office symbol at x 1.50 (tab at 0.50 in); "Certified by:" + office symbol right-aligned at 7.50 on the same line |
| L-010g | Supersedes | "Supersedes:" at 1.00, value at x 2.00 (tab 1.00 in); wrapped lines continue at x 2.00; value format "DESIGNATOR, D Month YYYY" |
| L-010h | Pages | "Pages: N" right-aligned at 7.50, on the Supersedes line (or on its own line when there is no Supersedes line) |
| F-021 | Wording | "Certified by:" (lower-case "by") on 7 of 7 |

## Varies (not a rule)

| Element | Observed | Treatment |
|---|---|---|
| Certifier name line "(Rank First Last)" under Certified by, right-aligned | 5 of 7 (not on DAFMAN 90-161 or Maxwell); DAFMAN Figure 1.1 shows none; 4.5.4.10 forbids names only on the OPR line | Optional field; off by default |
| Left column wrap | "BY ORDER OF THE SECRETARY / OF THE AIR FORCE" (5), "BY ORDER OF THE / SECRETARY OF THE AIR FORCE" (1), "BY ORDER OF THE COMMANDER / [UNIT]" | Line break follows the content: commander + unit on line 2 |
| Title line breaks | DAFMAN breaks "PUBLISHING PROCESSES / AND PROCEDURES" though line 1 could hold "AND" | Allow a manual break in the title; otherwise wrap |

## Effect on the renderer (Phase C)

1. Rules 0.8 pt (was 1.5 pt guess).
2. OPR value tab 0.50 in; Supersedes value tab 1.00 in with hanging indent; Pages right-aligned on the Supersedes line.
3. Right column: blank-line groups as in L-010c.
4. Certifier name: optional meta field `certifiedByName`, rendered as "(…)" right-aligned under Certified by.
5. No title-to-seal alignment (the PFM checklist item is not supported by published covers).
6. Seal box: 1.20 in at x 1.00, top 1.47 in.
