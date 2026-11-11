#!/usr/bin/env python3
"""Claude Code Stop hook: block the end of a turn while work is not on GitHub.

Blocks (exit 2, reason on stderr) when the checkout has uncommitted changes, or
commits that its upstream branch does not have, or a branch that was never pushed.
Allows the stop on the second try in a row (stop_hook_active), so a turn that must
end anyway (for example, near the usage limit, or when PFM said hold) can end.
Outside a git repo, or when git fails, it allows the stop.

Configured in .claude/settings.json ("hooks" > "Stop"). Manual run:
    echo '{}' | python3 scripts/stop_check.py; echo "exit $?"
Standard library only.
"""
import json
import os
import subprocess
import sys

REPO_DIR = None


def git(*args):
    r = subprocess.run(["git", *args], cwd=REPO_DIR, capture_output=True, text=True)
    if r.returncode != 0:
        raise RuntimeError(r.stderr.strip())
    return r.stdout.strip()


def problems():
    found = []
    dirty = git("status", "--porcelain")
    if dirty:
        found.append(f"{len(dirty.splitlines())} uncommitted file(s)")
    branch = git("rev-parse", "--abbrev-ref", "HEAD")
    try:
        upstream = git("rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}")
    except RuntimeError:
        upstream = None
    if upstream:
        ahead = int(git("rev-list", "--count", f"{upstream}..HEAD") or 0)
        if ahead:
            found.append(f"{ahead} commit(s) on {branch} not pushed to {upstream}")
    elif branch != "HEAD":
        found.append(f"branch {branch} has no upstream (never pushed)")
    return found


def main():
    try:
        data = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        data = {}
    if not isinstance(data, dict):
        data = {}
    if data.get("stop_hook_active"):
        return 0
    global REPO_DIR
    REPO_DIR = os.environ.get("CLAUDE_PROJECT_DIR") or data.get("cwd") or None
    try:
        found = problems()
    except (RuntimeError, OSError, ValueError):
        return 0
    if not found:
        return 0
    print(
        "Work is not on GitHub: " + "; ".join(found) + ". "
        "Commit and push, or say why it must wait, then stop again.",
        file=sys.stderr,
    )
    return 2


if __name__ == "__main__":
    sys.exit(main())
