# Orchestration: more than one agent

Read this file when you delegate work or run more than one agent. AGENTS.md "Delegation" points here. the PFM's decisions (2026-11-10): the orchestrator stays on Opus; models are chosen per task with the routing table below.

## Agents (.claude/agents/)

| Agent | Model | Tools | Use |
|---|---|---|---|
| `scout` | haiku | Read, Grep, Glob | Searches, file lists, summaries of test or log output |
| `worker` | sonnet | Read, Edit, Write, Bash, Grep, Glob; guard hook | One brief-ready task on its own branch |
| `reviewer` | sonnet | Read, Grep, Glob, Bash; guard hook | Fresh review: diff and brief only |

`scripts/worker_guard.py` (PreToolUse hook) blocks push to main or master, every force-push form, rebase, reset --hard, clean and branch deletes for `worker`; with `--readonly` it also blocks every git verb that changes the repo, for `reviewer`. It is a seat belt for honest mistakes, not a security boundary: it cannot see file writes or commands built at run time.

## Model routing

Pass a model on the Agent call only where this table says so.

| Work | Agent | Model |
|---|---|---|
| Search, file lists, summaries of test or log output | `scout` | haiku |
| Task from a brief | `worker` | sonnet |
| Worker task that failed its checks 2 times, a refactor over 5+ files, a performance fix | `worker` | opus (model on the call) |
| Fresh review of a routine diff | `reviewer` | sonnet |
| Fresh review of data or save migrations, git or hook tools, security, or a refactor that must not change behavior | `reviewer` | opus (model on the call) |
| Merges, conflict choices, design, artifacts, deploys | orchestrator | opus |

Log the model with each delegated task (in the handoff or the project's task log), so first-attempt pass rates can be compared by model.

## When to delegate

- Size rule: AGENTS.md "Delegation". A subagent spends tokens loading its context before it starts, so do smaller tasks yourself.
- Keep for the orchestrator: merges, conflict choices, design and open decisions, artifacts, deploys, release versions.
- One worker at a time by default. Two only when their allowed files do not overlap. Start each worker with `isolation: "worktree"`.

## Brief (put it in the Agent prompt)

- Goal and why, with the doc sections it implements.
- Branch name (`cc/<topic>`) and base commit.
- Allowed files: name every file it may touch.
- Done criteria that can be measured (numbers, test names, PASS lines).
- Checks to run.
- "No design decisions: list candidates with trade-offs."
- The model, when the routing table says opus.

## Review and merge

1. Scope: `git diff --stat origin/main...origin/<branch>`. Flag files outside the brief.
2. Update by merge, never rebase: `git checkout -B review/<branch> origin/<branch> && git merge origin/main`. When intents conflict, stop and list the choice for the PFM.
3. Fresh review: `reviewer` with only the diff and the brief. Verify each finding before you report it.
4. Checks: the commands in AGENTS.md "Commands". Report before and after numbers.
5. Merge: `git checkout main && git merge --no-ff review/<branch>`, confirm `git merge-base --is-ancestor origin/main HEAD`, push, verify origin/main. UI or design changes the PFM has not approved wait for his yes (AGENTS.md "Delivery").

## Lanes (fill in per project, in AGENTS.md "Project rules")

| Lane | Owner | Files | May push to |
|---|---|---|---|
| Orchestrator | Claude (Opus) | Everything not in another lane | main |
| Worker | `worker` subagent | Only its brief's files | its own `cc/<topic>` branch |
| GPT / Codex (if used) | Codex | Per brief | its own `gpt/<topic>` branch |
