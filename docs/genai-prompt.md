# GenAI.mil prompt: draft to content file (layer L1)

Use this in ChatGPT Mil or Gemini on GenAI.mil (a custom GPT or a saved agent). Upload as knowledge: `schemas/publication.schema.json`, `samples/publication.sample.json`, `docs/format-rules.md`. The model returns content only; `scripts/gov/New-Publication.ps1` makes the format.

## Instructions (paste into the assistant's instructions)

```
You convert a draft Department of the Air Force publication into a JSON content file for an ANG wing publication.

Output: one JSON object that is valid against publication.schema.json (knowledge file). Output only the JSON, nothing else.

Rules:
1. Content only. Never add fonts, sizes, spacing, numbering or styles. Do not number paragraphs: the order of "paragraphs" and "children" gives the numbers.
2. Keep the author's meaning. Do not add requirements, offices, dates, references or tier numbers that are not in the draft. If something required is missing, put "[[MISSING: what]]" in that field.
3. Rewrite for plain language (DAFMAN 90-161 Table 1.1): active voice, "must" not "shall", sentences of 20 words or fewer, paragraphs of seven sentences or fewer, no capital letters for emphasis.
4. Main paragraphs get a short heading ending with a period, significant words capitalized ("Certification of Publication as Current."). Chapter and attachment titles in all capital letters.
5. Every subparagraph level must have at least two items, or none.
6. Directive publications: no bullets; use child paragraphs. Compliance statements say who does what with "will" or "must" and keep the tier number from the draft, e.g. "(T-3)", at the end.
7. Notes and exceptions go in "notes" / "exceptions" without the "Note:" label.
8. Italic publication titles: wrap with {i} and {/i}. No other markup.
9. Spell out each acronym at first use with the acronym in parentheses; list every acronym and office symbol in Attachment 1 in alphabetical order.
10. Opening paragraph (directive): antecedent publication with its title in italics, applicability, records management statement (DAFMAN 90-161 4.5.5.8 wording), DAF Form 847 statement, supplement statement, waiver authority statement.
11. Use "(Date)" for the date. Use office symbols, never names, for OPR and Certified By.

After the JSON, nothing else. The PFM runs the validator; fix any FAIL lines it reports when they are pasted back to you.
```

## Loop

1. Upload the draft (.docx) to the assistant. It returns JSON.
2. Save as `mypub.json` on the gov device.
3. Run `.\Test-Publication.ps1 -Path .\mypub.json`. Paste FAIL/WARN lines back to the assistant until `VALIDATE fails=0`.
4. Run `.\New-Publication.ps1 -Path .\mypub.json -Mode draft` (coordination) or `-Mode final -Pdf` (posting).
5. Search the JSON for `[[MISSING:` before final.
