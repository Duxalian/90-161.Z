# Next prompt: 90-161.Z

Updated: 2026-11-10 by Claude. Keep this file at 40 lines or fewer. The current request overrides it.

## State

- main: bootstrapped; project rules; DECISIONS; ARCHITECTURE (3-layer format engine); format-rules.md (44 rules, draft, not verified); process-model.md (draft, not verified).
- Rule extraction came from a web summary of the PDF, not literal text.

## Open (in order)

1. Verify format-rules.md and process-model.md against the literal DAFMAN 90-161 PDF; add Tables 4.2–4.5 wording and Tables A3.1/A3.2 (mandatory coordinators).
2. Write schemas/publication.schema.json (L1) and fake sample publication.
3. Build L2 renderer + L3 validator (platform per Decide).
4. List schemas (Publications, Endorsements, Stages) + provisioning script (per PowerShell module check).
5. Endorsement flow spec; Power Apps YAML.

## Needs the owner

- Attach the DAFMAN 90-161 PDF (public, no releasability restrictions) and the wing supplement if one exists.
- Run the PowerShell capability check (read-only) and paste the output.
- Renderer platform decision.

## Do not

- Put government data in this repo or in Claude chats.
- Let the model set format. Format comes from code.
