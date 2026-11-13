#!/usr/bin/env python3
"""Write the shared task block (scripts/gov/src/task-common.ps1) into each gov task script (PFM B3A and P3, 2026-11-13).

Each scripts/gov/90161Z-T*.ps1 that asks for a DODID holds the block between two marker lines:
    # >>> task-common: generated from scripts/gov/src/task-common.ps1 by scripts/build_task_scripts.py (do not edit)
    # <<< task-common
The text between them is the source from its first "function" line on. Edit only the source, then run this script.
Usage: python3 scripts/build_task_scripts.py [--check]
  --check: write nothing; exit 1 when a block is stale, or a task script asks for the DODID outside the block.
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / 'scripts/gov/src/task-common.ps1'
BEGIN = '# >>> task-common: generated from scripts/gov/src/task-common.ps1 by scripts/build_task_scripts.py (do not edit)'
END = '# <<< task-common'
ASKS_DODID = "Read-Host 'DODID"


def body():
    text = SRC.read_text(encoding='utf-8').replace('\r\n', '\n')
    return text[text.index('\nfunction ') + 1:].rstrip('\n') + '\n'


def main(check):
    block = body()
    stale, unshared, shared = [], [], 0
    for f in sorted((ROOT / 'scripts/gov').glob('90161Z-T*.ps1')):
        text = f.read_text(encoding='utf-8')
        m = re.search(re.escape(BEGIN) + r'\n(.*?)' + re.escape(END) + r'\n', text, re.S)
        outside = text if m is None else text[:m.start()] + text[m.end():]
        if ASKS_DODID in outside:
            unshared.append(f.name)
        if m is None:
            continue
        shared += 1
        if m.group(1) != block:
            stale.append(f.name)
            if not check:
                f.write_text(text[:m.start(1)] + block + text[m.end(1):], encoding='utf-8')
    for n in unshared:
        print('UNSHARED ' + n + ': asks for the DODID outside the task-common block (use Get-TaskId)')
    for n in stale:
        print(('STALE ' if check else 'WROTE ') + n)
    print('TASKCOMMON scripts=%d stale=%d unshared=%d' % (shared, len(stale) if check else 0, len(unshared)))
    return 1 if unshared or (check and stale) else 0


if __name__ == '__main__':
    sys.exit(main('--check' in sys.argv[1:]))
