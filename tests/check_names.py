#!/usr/bin/env python3
"""Naming rules (PFM 2026-11-11, docs/DECISIONS.md; naming doc rules 2-6 and Title Case):
- list URL name: PFM + PascalCase, no spaces; display title: "PFM " + Title Case words;
- column internal names: PascalCase, acronyms in capitals, no spaces; display names: Title Case;
- one meaning per label: a display name used in two lists maps to the same internal name;
- view names: "<audience> - <what>", Title Case;
- flow display names: test flows "90161Z T<NN> <Title Case words> r<N>"."""
import json, pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SMALL = {"a", "an", "and", "or", "of", "the", "to", "for", "in", "on", "by", "with"}
bad = []

def title_case(s):
    words = re.split(r"[ /]+", s)
    return all(w and (w[0].isupper() or w[0].isdigit() or (i > 0 and w in SMALL)) for i, w in enumerate(words))

labels = {}
for f in sorted((ROOT / "schemas" / "lists").glob("*.json")):
    d = json.loads(f.read_text(encoding="utf-8"))
    if not re.fullmatch(r"PFM[A-Z][A-Za-z]+", d["list"]): bad.append(f"{f.name}: URL name {d['list']!r}")
    if f.stem != d["list"]: bad.append(f"{f.name}: file name must equal URL name")
    t = d.get("title", "")
    if not (t.startswith("PFM ") and title_case(t)): bad.append(f"{f.name}: title {t!r}")
    for c in d["fields"]:
        if not re.fullmatch(r"[A-Z][A-Za-z0-9]*", c["internalName"]): bad.append(f"{f.name}: internal name {c['internalName']!r}")
        if not title_case(c["displayName"]): bad.append(f"{f.name}: display name {c['displayName']!r}")
        prev = labels.setdefault(c["displayName"], c["internalName"])
        if prev != c["internalName"]: bad.append(f"{f.name}: label {c['displayName']!r} means {prev} elsewhere")
    for v in d.get("views", []):
        m = re.fullmatch(r"([A-Z][A-Za-z]*) - (.+)", v["name"])
        if not (m and title_case(m.group(2))): bad.append(f"{f.name}: view name {v['name']!r}")
for f in sorted((ROOT / "flow" / "defs").glob("*.json")):
    n = json.loads(f.read_text(encoding="utf-8"))["displayName"]
    m = re.fullmatch(r"90161Z T\d{2} (.+) r\d+", n)
    if not (m and title_case(m.group(1))): bad.append(f"{f.name}: flow name {n!r}")
print("\n".join(bad) or "OK names")
sys.exit(1 if bad else 0)
