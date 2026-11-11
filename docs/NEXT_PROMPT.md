# Next prompt: 90-161.Z

Updated: 2026-11-10 by Claude. Keep this file at 40 lines or fewer. The current request overrides it.

## State

- main: bootstrapped; project rules; DECISIONS; ARCHITECTURE (3-layer format engine); format-rules.md (44 rules, draft, not verified); process-model.md (draft, not verified).
- Literal DAFMAN text in ref/ (PDF + txt). format-rules.md: 1 of 44 rows verified so far.

## Env (2026-11-10)

- Gov device: PS 5.1 FullLanguage, scripts allowed, Word COM OK, PnP.PowerShell 1.12.0, no PSGallery. See docs/reviews/2026-11-10-gov-env-check.md.

## Open (in order)

1. Verify format-rules.md and process-model.md against ref/dafman90-161.txt; add Tables 4.2–4.5 wording and Tables A3.1/A3.2 (mandatory coordinators).
2. Write schemas/publication.schema.json (L1) and fake sample publication.
3. Build L2 renderer + L3 validator in PowerShell + Word COM (scripts/gov/), PS 5.1, no extra modules.
4. List schemas (Publications, Endorsements, Stages) + provisioning script (per PowerShell module check).
5. Endorsement flow spec; Power Apps YAML.

## Needs PFM

- Run scripts/gov/Test-PnPConnection.ps1 and paste the output (tests PnP 1.12 -UseWebLogin, no app registration).
- Check Power Automate license for "Populate a Microsoft Word template" (renderer option C).

## Do not

- Put government data in this repo or in Claude chats.
- Let the model set format. Format comes from code.
