#!/usr/bin/env python3
"""Check every flow/packages/*.zip against the shape of real tenant exports (2026-11-11):
- flow resource key == assetPaths[0] == definition folder; flow resource has no id/name;
  definition name differs from the folder ID; required files present; manifest.json first.
- with connections: same resource kinds and key sets as tests/fixtures/real-export-sharepoint;
  the flow dependsOn its connector and connection; apisMap/connectionsMap point to resources of the
  right type; connectionReferences have the fixture's keys."""
import json, pathlib, sys, zipfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
FIX = ROOT / "tests" / "fixtures" / "real-export-sharepoint"
FLOW, API, CONN = "Microsoft.Flow/flows", "Microsoft.PowerApps/apis", "Microsoft.PowerApps/apis/connections"

fx = json.loads((FIX / "manifest.json").read_text())
fx_keys = {r["type"]: set(r) for r in fx["resources"].values()}
fx_flow_dir = next((FIX / "Microsoft.Flow" / "flows").glob("*/"))
fx_ref_keys = set(next(iter(json.loads((fx_flow_dir / "definition.json").read_text())["properties"]["connectionReferences"].values())))

def conn_names(actions):
    """connectionName of every OpenApiConnection action, including actions nested in scopes."""
    for act in actions.values():
        host = act.get("inputs", {}).get("host", {}) if isinstance(act.get("inputs"), dict) else {}
        if host.get("connectionName"): yield host["connectionName"]
        yield from conn_names(act.get("actions", {}))
        yield from conn_names(act.get("else", {}).get("actions", {}))
        for case in list(act.get("cases", {}).values()) + [act.get("default", {})]:
            yield from conn_names(case.get("actions", {}))


bad = 0
zips = sorted((ROOT / "flow" / "packages").glob("*.zip"))
if not zips:
    print("BAD no packages"); sys.exit(1)
for z in zips:
    f = zipfile.ZipFile(z); n = set(f.namelist()); errs = []
    m = json.loads(f.read("manifest.json")); fm = json.loads(f.read(FLOW + "/manifest.json"))
    res = m["resources"]; a = fm["flowAssets"]["assetPaths"]
    flows = [k for k, r in res.items() if r["type"] == FLOW]
    if len(flows) != 1 or a != flows:
        errs.append(f"flow resource {flows} != assetPaths {a}")
    else:
        k = flows[0]
        for part in ("definition.json", "apisMap.json", "connectionsMap.json"):
            if f"{FLOW}/{k}/{part}" not in n: errs.append(f"missing {k}/{part}")
        for rk, r in res.items():
            if r["type"] not in fx_keys: errs.append(f"resource {rk}: unknown type {r['type']}")
            elif set(r) != fx_keys[r["type"]]: errs.append(f"resource {rk}: keys {sorted(set(r) ^ fx_keys[r['type']])} differ from real export")
        if not errs:
            d = json.loads(f.read(f"{FLOW}/{k}/definition.json"))
            apis = json.loads(f.read(f"{FLOW}/{k}/apisMap.json")); conns = json.loads(f.read(f"{FLOW}/{k}/connectionsMap.json"))
            refs = d["properties"]["connectionReferences"]
            if d["name"] == k: errs.append("definition name equals folder ID (real export differs)")
            if not d["properties"]["definition"].get("triggers"): errs.append("no triggers")
            if not d["id"].endswith("/" + d["name"]): errs.append("definition id does not end with name")
            if f.namelist()[0] != "manifest.json": errs.append("manifest.json is not the first entry")
            if set(apis) != set(refs) or set(conns) != set(refs): errs.append("apisMap/connectionsMap keys differ from connectionReferences")
            for c in refs:
                if set(refs[c]) != fx_ref_keys: errs.append(f"connectionReferences {c}: keys differ from real export")
                if res.get(apis.get(c), {}).get("type") != API: errs.append(f"apisMap {c} does not point to a connector resource")
                if res.get(conns.get(c), {}).get("type") != CONN: errs.append(f"connectionsMap {c} does not point to a connection resource")
            if set(res[k]["dependsOn"]) != {apis.get(c) for c in refs} | {conns.get(c) for c in refs}: errs.append("flow dependsOn does not list exactly its connectors and connections")
            used = set(conn_names(d["properties"]["definition"]["actions"]))
            if not used <= set(refs): errs.append(f"actions use connections not in connectionReferences: {sorted(used - set(refs))}")
    for e in errs:
        print(f"BAD {z.name}: {e}"); bad += 1
sys.exit(1 if bad else 0)
