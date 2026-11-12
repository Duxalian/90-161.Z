# Page 1 and TOC: T01 r3 output vs DAFMAN 90-161 (2026-11-11)

Request: the PFM saw the cover rules did not match DAFMAN 90-161 and asked for a full scan of page 1. Method: PyMuPDF text, span and drawing geometry of page 1 (and the TOC on page 2) of ref/dafman90-161.pdf and of the r3 PDF the PFM rendered with Word (fake sample). Units: inches from the top-left of the page. Fix check: the r3 .docx edited with the r5 settings, rendered with LibreOffice; LibreOffice matched Word's r3 output within 0.01 in on the same gaps. Self-review only; Word confirmation is Task 1 r5.

## Cover spacing (L-008a, L-010c, L-010e)

| Gap | DAFMAN | r3 (Word) | r5 (LibreOffice sim) |
|---|---|---|---|
| Right-column group pitch | 0.358 | 0.383 | 0.358-0.359 |
| Title to COMPLIANCE line (L-010e) | 0.417 | 0.192 | 0.414 |
| COMPLIANCE line to rule | 0.182 | 0.049 | 0.194 |
| Rule to ACCESSIBILITY | 0.285 | 0.250 | 0.286 |
| RELEASABILITY to rule | 0.264 | 0.050 | 0.263 |
| Rule to OPR | 0.394 | 0.250 | 0.383 |
| Supersedes to rule | 0.415 | 0.242 | 0.421 |
| Rule to opening paragraph | 0.369 | 0.442 | 0.352 |

## Matches (no change)

Fonts (Times New Roman 12 pt, bold italic header columns), left column at 1.00 and line pitch 0.192, right column right edge 7.50, COMPLIANCE line centered (1.91-6.64 vs 1.92-6.62), label values at 2.50 (L-005), OPR and Supersedes tabs, rules 6.50 in wide (Word border 6.54: 0.02 in each side, under 2 px at 96 dpi) and 0.72-0.75 pt vs 0.80 pt (L-008 allows 0.75-0.80; Word has no 0.80 pt border), opening paragraph justified 1.00-7.54 with 0.192 line pitch and two spaces between sentences, SUMMARY OF CHANGES bold italic at 1.00, no header or page number on page 1.

## Table of contents (L-011)

| Item | DAFMAN p.2 | r3 | r5 |
|---|---|---|---|
| Size | 11 pt | 12 pt | 11 pt |
| Paragraph entries | not bold, number 1.50, text 2.00 | bold, 1.17 | not bold, 1.50 / 2.00 |
| Chapter entries | bold, wrap at 2.00 | bold, no hang | bold, hang 1.00 in |
| Line / entry pitch | 0.202 / 0.272 | - / 0.261 | exactly 14.5 pt / +5 pt |

DAFMAN's TOC (made by AFDPO) also lists figures and tables. 4.5.8.3 says main paragraph headings only, so 90-161.Z keeps them out.

## Not changed

- Title line pitch: DAFMAN 0.222 (n=1, manual break); the 7-cover study found 0.19 inside groups (L-010c). Kept 0.192.
- Seal: not in the r3 sample; place and size per L-007 (1.00, 1.47, 1.20 in) are untested until a seal file exists (Task 7).
