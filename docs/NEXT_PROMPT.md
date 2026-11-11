# Next prompt: 90-161.Z

Updated: 2026-11-10 by Claude. Keep this file at 40 lines or fewer. The current request overrides it.

## State

- main: bootstrapped; project rules; DECISIONS; ARCHITECTURE (3-layer format engine); format-rules.md (44 rules, draft, not verified); process-model.md (draft, not verified).
- Literal DAFMAN text in ref/ (PDF + txt). format-rules.md: 1 of 44 rows verified so far.

## Open (in order)

1. Verify format-rules.md and process-model.md against ref/dafman90-161.txt; add Tables 4.2–4.5 wording and Tables A3.1/A3.2 (mandatory coordinators).
2. Write schemas/publication.schema.json (L1) and fake sample publication.
3. Build L2 renderer + L3 validator (platform per Decide).
4. List schemas (Publications, Endorsements, Stages) + provisioning script (per PowerShell module check).
5. Endorsement flow spec; Power Apps YAML.

## Needs the owner

- Transfer path: GitHub login blocked on gov device. Decide: public repo / .mil email / other.
- Run scripts/gov/Test-Environment.ps1 (paste into console; read-only) and paste the output.
- Check Power Automate license for "Populate a Microsoft Word template" (renderer option C).

## Do not

- Put government data in this repo or in Claude chats.
- Let the model set format. Format comes from code.
