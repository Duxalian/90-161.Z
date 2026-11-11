#!/usr/bin/env python3
"""Check every flow/packages/*.zip against the shape of a real tenant export (2026-11-11):
one resource; resource key == assetPaths[0] == definition folder; resource has no id/name;
definition name differs from the folder ID; required files present."""
import json, pathlib, sys, zipfile
bad = 0
zips = sorted((pathlib.Path(__file__).resolve().parent.parent / "flow" / "packages").glob("*.zip"))
if not zips: print("BAD no packages"); sys.exit(1)
for z in zips:
    f = zipfile.ZipFile(z); n = set(f.namelist())
    m = json.loads(f.read("manifest.json")); fm = json.loads(f.read("Microsoft.Flow/flows/manifest.json"))
    keys = list(m["resources"]); a = fm["flowAssets"]["assetPaths"]
    errs = []
    if len(keys) != 1 or a != keys: errs.append(f"resource key {keys} != assetPaths {a}")
    k = keys[0]; r = m["resources"][k]
    if "id" in r or "name" in r: errs.append("resource has id/name (real export has neither)")
    for part in ("definition.json", "apisMap.json", "connectionsMap.json"):
        if f"Microsoft.Flow/flows/{k}/{part}" not in n: errs.append(f"missing {k}/{part}")
    if not errs:
        d = json.loads(f.read(f"Microsoft.Flow/flows/{k}/definition.json"))
        if d["name"] == k: errs.append("definition name equals folder ID (real export differs)")
        if not d["properties"]["definition"].get("triggers"): errs.append("no triggers")
        if not d["id"].endswith("/" + d["name"]): errs.append("definition id does not end with name")
        if f.namelist()[0] != "manifest.json": errs.append("manifest.json is not the first entry")
    for e in errs: print(f"BAD {z}: {e}"); bad += 1
sys.exit(1 if bad else 0)
