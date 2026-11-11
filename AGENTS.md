# 90-161.Z: agent instructions

This file is the source of truth for every agent on this repo: Claude, GPT, Codex and sub-agents. CLAUDE.md imports it. Put rules specific to this project in "Project rules" at the end.

- Repo: rhope-ops/90-161.Z
- Purpose: Track and manage DAF publications through the DAFMAN 90-161 publishing process at wing/installation level: status tracking, document cleanup and formatting, and endorsement routing.

## Order of authority

1. The PFM's current request.
2. PFM decisions in docs/DECISIONS.md. A newer decision overrides older text.
3. This file.
4. The PFM's personal preferences (Claude only).
5. docs/NEXT_PROMPT.md (the handoff).

Chat history, Project files and remembered copies are not authority. If you cannot read this repo, say so and stop.

## Start of session

- Run `scripts/session_checkin.sh`. Report the branch, uncommitted files, and the ahead/behind count against origin/main.
- Read docs/NEXT_PROMPT.md and docs/DECISIONS.md.
- Find the tools you have and read the environment docs before you say a capability is not available.

## Authority

- Make routine decisions yourself.
- Ask the PFM only about: source authority, content approval, irreversible effects, costs, and security or privacy risk.
- When you ask: give 2–3 options with trade-offs, mark one as your recommendation, and ask all open questions together.
- Your recommendation is not a decision until the PFM approves it.

## Delivery

- Deliver every change without being asked: commit, merge to main, push, verify that origin/main has the commit, and republish the affected artifacts.
- Exception: for a UI or design change that the PFM has not approved, show a preview first (a preview artifact or a branch). Merge after he approves. Delete previews after they ship.
- For changes that are not UI or design, this rule overrides the personal "preview first" rule.
- If a step is blocked, name the step and the cause. If permissions block a step, give the exact commands to paste, one code block for each command.
- Put every deliverable where it survives (repo, doc, artifact) as soon as it exists.

## Reporting

- Report actual checks, counts and limits.
- Keep these states separate: done, published, verified; self-review and independent review; delivery state and checkout state.
- Give full clickable links to files on main, to artifacts and to pull requests. Never give a bare path.
- Give text that the PFM must paste in full, in a code block. Never tell him to find it in git.
- End each work turn with a summary: Decide (lettered options, your recommendation marked **Rec:**), Copy (full text for the PFM to paste), then a table with Step (X of Y), Status (done / published / verified), Risks, Running, Not running, Next step (one recommendation), Links. Leave out empty rows, except Step. Claude follows the PFM's personal preferences for the exact format.

## Git safety

- Never force-push, rewrite published history, reset, clean, stash or discard work to make the state look synchronized. Update branches by merge.
- Pull just before you edit a shared doc. Use small edits. Never rewrite a whole file from an old copy.
- Never commit secrets, tokens or credentials.
- Claude Code enforces part of this section with .claude/settings.json: a deny list, and a Stop hook (scripts/stop_check.py) that blocks the end of a turn while work is uncommitted or unpushed. Do not weaken that file to get past a block: ask the PFM.

## Commands

<!-- Fill in when the project has them. Give exact commands. -->
- Gov-device checks: scripts/gov/Test-Environment.ps1, scripts/gov/Test-PnPConnection.ps1, scripts/gov/Test-PSGallery.ps1 (read-only). The PFM opens them on the gov device from docs/HANDOFF.md.
- Credentials: never store, print, log or ask for passwords in chat. Scripts take them only through Get-Credential at run time.
- Gov-device code target: Windows PowerShell 5.1, Word 16 COM, PnP.PowerShell 1.12.0. No other modules (PSGallery blocked).
- Build: `python3 scripts/build_flow_payload.py` regenerates flow/provisioning-payload.json from schemas/lists (never hand-edit the payload). `node templates/build_crm_template.js` rebuilds templates/CRM_A12-1.docx.
- Test: `tests/run.sh`. Pass = last line `TESTS pass=N fail=0`. Word COM and Power Automate are tested on the gov device: docs/gov-test-plan.md, docs/power-automate-provisioning.md section 3.
- Lint: `scripts/lint.sh` (pwsh 7 + PSScriptAnalyzer, PS 5.1 syntax target; setup in docs/dev-setup.md). Pass = `findings=0`.

## Verification

- Before you report "verified", run the checks in Commands and report the results.
- For UI work, verify by measuring, not by looking: screenshots at 375 px and 1440 px width, light and dark, measured spacing, and contrast against WCAG AA (4.5:1 text, 3:1 large text and UI parts). Report the numbers.

## Checks

- Never repin an approval, add an exemption, skip a test or edit a generated report to make a check pass.
- Never hand-edit generated files. Change the source and rebuild.

## Decisions

- Record each PFM decision, with its date, in docs/DECISIONS.md or its canonical document.
- Mark agent recommendations as recommendations, not as PFM decisions.
- Do not silently change approved decisions or sources. Raise open items with options. Never invent values.

## Handoff

- The current request overrides an older handoff.
- Keep status in repo files, never only in chat.
- Keep docs/NEXT_PROMPT.md short (40 lines or fewer). Put detailed evidence in docs/reviews/.

## Delegation

- When you delegate or run more than one agent, read `.claude/orchestration.md` first: agents (`scout`, `worker`, `reviewer`), model routing, briefs, review and merge, lanes.
- Delegate only substantial independent work (about 30 minutes or more) with bounded files and measurable done criteria. Give parallel agents disjoint files.
- Ask for concise findings with evidence paths.
- Before a merge of changes to code, checks or scripts, the `reviewer` subagent gets only the diff and the brief, not the author's conclusions (model per `.claude/orchestration.md`). Docs-only changes skip this review.
- Check delegated output (diff, touched files, no approval or exemption changes) before you report it as done.

## Unattended work

- Work the PFM expects done while he is away needs a running owner before the turn ends: a started agent or a one-time scheduled task.
- A scheduled task needs a prompt that stands alone and permission to commit, push to main and republish without a person.
- Background work stops at the usage limit. Say when that can interrupt it.

## Boundaries

- Do not change account-wide settings, plugins or skills as a side effect of project work.

## Project rules

- Data boundary (PFM, 2026-11-10): government data stays in DoD365 and GenAI.mil only. Never put real drafts, publication content, names, emails, office symbols or comments in this repo or in a Claude chat. Use fake sample data. Sanitize bug reports.
- Platform (PFM, 2026-11-10): frontend and data on SharePoint Lists, Power Automate and Power Apps in DoD365. The PFM is a site collection administrator with PowerShell access to SharePoint (2026-11-10). Assume no tenant admin rights and standard connectors only, until the PFM confirms otherwise.
- Scope (PFM, 2026-11-10): ANG wing publications (supplements, OIs, local publications and forms). ANG wing publications post to the wing's own site, not through AFIMPT (DAFMAN 90-161 1.1.3.2, 6.4). No wing supplement exists.
- Gov-device hand-off (PFM, 2026-11-11): tasks for the PFM's work computer go in docs/HANDOFF.md (his voice, raw.githubusercontent.com URLs one per line, no code). He opens its bookmarked raw URL. Do not email the military address: Gmail-to-.mil mail is filtered (7 of 7 sent after 05:22 CT 2026-11-11 never arrived, no bounce). Keep open tasks at the top; move finished ones to Done.
- Gov device access (PFM, 2026-11-11): the Claude app is blocked on the gov device and nothing can be emailed to it. The PFM types the first address by hand; after that he can copy, paste and bookmark inside the page. Keep any address he must type short (one per task, ideally one bookmark for all tasks).
- Gov device (PFM, 2026-11-10): GitHub login is blocked on the gov device. The repo is public (PFM, 2026-11-10), so the gov device reads it without login. This repo is public: never commit the wing's name or location, the wing's site path, people's names, emails, office symbols or any government data.
- Wing files (PFM, 2026-11-11): the wing template, AO guide and ANG checklist shape the customer process 90-161.Z takes a customer through. They never supply rules; on any contradiction DAFMAN 90-161 wins.
- Source authority: DAFMAN 90-161 is the rule source. Cite the paragraph for every stage, time limit and format rule. Never invent a value. See docs/DECISIONS.md for the approved edition.
- Formatting (PFM, 2026-11-10): rules force output to look like DAFMAN 90-161. Format comes from code, never from the model. Rule catalog: docs/format-rules.md. Do not use AFIMPT for formatting or tracking.
- System of record (PFM, 2026-11-10): 90-161.Z owns endorsement tracking (no TMT).
- Architecture: docs/ARCHITECTURE.md. Process: docs/process-model.md.

<!-- Add rules for this project below. Date each PFM decision, for example "(PFM, 2026-11-09)". -->
