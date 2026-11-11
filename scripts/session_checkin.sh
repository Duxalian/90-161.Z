#!/usr/bin/env bash
# Session check-in: run at the start and the end of each session.
set -uo pipefail

git fetch --quiet origin main 2>/dev/null || echo "warning: fetch of origin/main failed"

echo "branch:      $(git rev-parse --abbrev-ref HEAD)"
echo "head:        $(git rev-parse --short HEAD)"
echo "origin/main: $(git rev-parse --short origin/main 2>/dev/null || echo unknown)"

if counts=$(git rev-list --left-right --count HEAD...origin/main 2>/dev/null); then
  read -r ahead behind <<<"$counts"
  echo "ahead:       $ahead"
  echo "behind:      $behind"
else
  echo "ahead/behind: unknown (shallow clone or no origin/main)"
fi

uncommitted=$(git status --porcelain | wc -l | tr -d ' ')
echo "uncommitted: $uncommitted"
[ "$uncommitted" -gt 0 ] && git status --short

if grep -rIl '{{[A-Z_]*}}' --exclude-dir=.git --exclude=bootstrap.sh --exclude=session_checkin.sh --exclude=sync_baseline.py --exclude=README.md . >/dev/null 2>&1; then
  echo "warning: template placeholders remain; run scripts/bootstrap.sh"
fi
exit 0
