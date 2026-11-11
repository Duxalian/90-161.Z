#!/usr/bin/env python3
"""Build Power Automate import packages (.zip, "Import Package (Legacy)") from flow/defs/*.json.

Output: flow/packages/<name>.zip. Deterministic (IDs from uuid5 of the name, fixed zip timestamps, stored not deflated),
so --check can compare the committed zip with a fresh build. Never hand-edit the zip.
Supports flows without connections only; connector support comes after the import test passes.
"""
import argparse, io, json, pathlib, sys, uuid, zipfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
DEFS, OUT = ROOT / "flow" / "defs", ROOT / "flow" / "packages"
NS = uuid.UUID("6f1c2b4e-9d0a-4c5e-8b7a-90161a000000")
SCHEMA = "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#"
STAMP = (2026, 1, 1, 0, 0, 0)


def dumps(o):
    return json.dumps(o, indent=2, ensure_ascii=False) + "\n"


def summary(d):
    acts = []
    def walk(a):
        for v in a.values():
            acts.append({"type": v["type"]})
            walk(v.get("actions", {}))
    walk(d["actions"])
    trig = [{"type": t["type"], **({"kind": t["kind"]} if "kind" in t else {})} for t in d["triggers"].values()]
    return {"triggers": trig, "actions": acts}


def build(src: pathlib.Path) -> bytes:
    d = json.loads(src.read_text(encoding="utf-8"))
    for k in ("displayName", "triggers", "actions"):
        if k not in d:
            raise ValueError(f"{src.name}: missing '{k}'")
    if d.get("connections"):
        raise ValueError(f"{src.name}: connections are not supported yet")
    name = src.stem
    flow_id = str(uuid.uuid5(NS, "flow:" + name))
    res_id = str(uuid.uuid5(NS, "resource:" + name))
    files = {
        "manifest.json": {
            "schema": "1.0",
            "details": {
                "displayName": d["displayName"],
                "description": d.get("description", ""),
                "createdTime": "2026-01-01T00:00:00.0000000Z",
                "packageTelemetryId": str(uuid.uuid5(NS, "telemetry:" + name)),
                "creator": "N/A",
                "sourceEnvironment": "",
            },
            "resources": {
                res_id: {
                    "id": f"/providers/Microsoft.Flow/flows/{flow_id}",
                    "name": flow_id,
                    "type": "Microsoft.Flow/flows",
                    "suggestedCreationType": "New",
                    "creationType": "Existing, New, Update",
                    "details": {"displayName": d["displayName"]},
                    "configurableBy": "User",
                    "hierarchy": "Root",
                    "dependsOn": [],
                }
            },
        },
        "Microsoft.Flow/flows/manifest.json": {
            "packageSchemaVersion": "1.0",
            "flowAssets": {"assetPaths": [flow_id]},
        },
        f"Microsoft.Flow/flows/{flow_id}/definition.json": {
            "name": flow_id,
            "id": f"/providers/Microsoft.Flow/flows/{flow_id}",
            "type": "Microsoft.Flow/flows",
            "properties": {
                "apiId": "/providers/Microsoft.PowerApps/apis/shared_logicflows",
                "displayName": d["displayName"],
                "definition": {
                    "$schema": SCHEMA,
                    "contentVersion": "1.0.0.0",
                    "parameters": {
                        "$connections": {"defaultValue": {}, "type": "Object"},
                        "$authentication": {"defaultValue": {}, "type": "SecureObject"},
                    },
                    "triggers": d["triggers"],
                    "actions": d["actions"],
                },
                "connectionReferences": {},
                "definitionSummary": summary(d),
                "templateName": "",
                "flowFailureAlertSubscribed": False,
                "isManaged": False,
            },
        },
        f"Microsoft.Flow/flows/{flow_id}/apisMap.json": {},
        f"Microsoft.Flow/flows/{flow_id}/connectionsMap.json": {},
    }
    buf = io.BytesIO()
    with zipfile.ZipFile(buf, "w", zipfile.ZIP_STORED) as z:
        for path in sorted(files):
            info = zipfile.ZipInfo(path, STAMP)
            info.compress_type = zipfile.ZIP_STORED
            info.create_system = 3
            info.external_attr = 0o644 << 16
            z.writestr(info, dumps(files[path]))
    return buf.getvalue()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true", help="fail if a committed package differs from a fresh build")
    a = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    stale = 0
    for src in sorted(DEFS.glob("*.json")):
        data, dst = build(src), OUT / (src.stem + ".zip")
        if a.check:
            if not dst.exists() or dst.read_bytes() != data:
                print(f"STALE {dst.relative_to(ROOT)}"); stale += 1
        else:
            dst.write_bytes(data); print(f"BUILT {dst.relative_to(ROOT)} bytes={len(data)}")
    sys.exit(1 if stale else 0)


if __name__ == "__main__":
    main()
