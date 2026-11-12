#!/usr/bin/env python3
"""Generate flow/defs/90161Z-T11-rights-probe-r<N>.json from the CHECKS list below (PFM 2026-11-12: test every
assumption about rights before relying on it). Then run scripts/build_flow_package.py to make the zip.

The flow runs as the person who starts it (the PFM: site collection admin). It records, for each check, the HTTP
status and a short, name-free part of the answer. Read checks come first, then write checks on TEST objects it
creates, then cleanup of those objects. Every step runs even if the step before failed.
Coworker checks (R11, R12) answer "what can a regular member do" without a second login: SharePoint's
getusereffectivepermissions for the address the PFM types. Decoding the permission masks happens in the cloud,
from the result file (docs/rights-test-plan.md "Reading the result").
R13 (ensureuser) adds the group to the site's hidden user list; that entry stays and is harmless.
Results: the run's Result step, and a file 90161Z-T11-rights-result-r<N>.json in the site's default library.
The result holds no names: only status codes, permission masks, principal types and role names."""
import json, pathlib, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
REV = 1
NAME = f"90161Z-T11-rights-probe-r{REV}"
RESULT_FILE = f"90161Z-T11-rights-result-r{REV}.json"
TEST_LIST, TEST_LIB, TEST_GROUP = "PFMRightsProbeTEST", "PFMRightsProbeLib", "PFM Rights Probe TEST"
COWORKER = "encodeUriComponent(concat('i:0#.f|membership|', triggerBody()?['text_1']))"
J = "application/json;odata=verbose"
NM = "application/json;odata=nometadata"  # answers without __metadata, so no site URL lands in the result

# (id, what it answers, method, uri, body or None, extra headers or None, keep expression or None)
CHECKS = [
    ("R01", "Am I a site collection admin", "GET", "_api/web/currentuser?$select=IsSiteAdmin", None, None, None),
    ("R02", "My permission mask on the site", "GET", "_api/web/effectiveBasePermissions", None, None, None),
    ("R03", "Site is group-connected (M365 group) or a hub", "GET", "_api/site?$select=GroupId,IsHubSite,ReadOnly", None, None, None),
    ("R04", "Site template, unique permissions", "GET", "_api/web?$select=WebTemplate,Configuration,HasUniqueRoleAssignments", None, None, None),
    ("R05", "Who has access: principal types and roles (no names)", "GET",
     "_api/web/roleassignments?$expand=Member,RoleDefinitionBindings&$select=Member/PrincipalType,RoleDefinitionBindings/Name", None, None, None),
    ("R06", "Permission levels and what each allows", "GET", "_api/web/roledefinitions?$select=Name,Hidden,BasePermissions", None, None, None),
    ("R07", "Site Members group settings", "GET", "_api/web/associatedmembergroup?$select=Id,AllowMembersEditMembership,OnlyAllowMembersViewMembership", None, None, None),
    ("R07b", "Permission level of the Members group", "GET",
     "_api/web/roleassignments/getbyprincipalid(@{body('R07')?['Id']})/roledefinitionbindings?$select=Name", None, None, None),
    ("R08", "Site time zone", "GET", "_api/web/RegionalSettings/TimeZone?$select=Description,Id", None, None, None),
    ("R09a", "PFM Publications: item-level permissions, versioning", "GET",
     "_api/web/lists/getbytitle('PFM Publications')?$select=ReadSecurity,WriteSecurity,EnableVersioning,MajorVersionLimit,ItemCount,HasUniqueRoleAssignments", None, None, None),
    ("R09b", "PFM Endorsements: item-level permissions, versioning", "GET",
     "_api/web/lists/getbytitle('PFM Endorsements')?$select=ReadSecurity,WriteSecurity,EnableVersioning,MajorVersionLimit,ItemCount,HasUniqueRoleAssignments", None, None, None),
    ("R09c", "PFM Activity Log: permissions, versioning", "GET",
     "_api/web/lists/getbytitle('PFM Activity Log')?$select=ReadSecurity,WriteSecurity,EnableVersioning,MajorVersionLimit,ItemCount,HasUniqueRoleAssignments", None, None, None),
    ("R09d", "PFM Settings: permissions", "GET",
     "_api/web/lists/getbytitle('PFM Settings')?$select=HasUniqueRoleAssignments,ItemCount", None, None, None),
    ("R10", "My permission mask on PFM Publications", "GET", "_api/web/lists/getbytitle('PFM Publications')/effectiveBasePermissions", None, None, None),
    ("R11", "Coworker (regular member) permission mask on the site", "GET",
     "_api/web/getusereffectivepermissions(@u)?@u='@{" + COWORKER + "}'", None, None, None),
    ("R12", "Coworker permission mask on PFM Publications", "GET",
     "_api/web/lists/getbytitle('PFM Publications')/getusereffectivepermissions(@u)?@u='@{" + COWORKER + "}'", None, None, None),
    ("R13", "Wing group resolves; its principal type (1 user, 4 security group, 8 SharePoint group)", "POST", "_api/web/ensureuser",
     {"logonName": "@{triggerBody()?['text_2']}"}, None, "@{body('R13')?['PrincipalType']}"),
    ("R14", "Site Owners group has a Full Control role", "GET",
     "_api/web/associatedownergroup?$select=Id,AllowMembersEditMembership", None, None, None),
    ("W01", "Create a list", "POST", "_api/web/lists",
     {"__metadata": {"type": "SP.List"}, "BaseTemplate": 100, "Title": TEST_LIST}, None, "@{body('W01')?['Id']}"),
    ("W02", "Add a column", "POST", f"_api/web/lists/getbytitle('{TEST_LIST}')/fields",
     {"__metadata": {"type": "SP.Field"}, "FieldTypeKind": 2, "Title": "ProbeText"}, None, "@{body('W02')?['InternalName']}"),
    ("W03", "Set item-level permissions and a version limit", "POST", f"_api/web/lists/getbytitle('{TEST_LIST}')",
     {"__metadata": {"type": "SP.List"}, "ReadSecurity": 2, "WriteSecurity": 2, "EnableVersioning": True, "MajorVersionLimit": 50},
     {"X-HTTP-Method": "MERGE", "IF-MATCH": "*"}, None),
    ("W04", "Give the list its own permissions", "POST",
     f"_api/web/lists/getbytitle('{TEST_LIST}')/breakroleinheritance(copyRoleAssignments=true,clearSubscopes=true)", None, None, None),
    ("W05", "Set Members to Read on that list", "POST",
     f"_api/web/lists/getbytitle('{TEST_LIST}')/roleassignments/addroleassignment(principalid=@{{body('R07')?['Id']}},roledefid=1073741826)", None, None, None),
    ("W06", "Add an item", "POST", f"_api/web/lists/getbytitle('{TEST_LIST}')/items",
     {"__metadata": {"type": "SP.Data.PFMRightsProbeTESTListItem"}, "Title": "probe"}, None, "@{body('W06')?['Id']}"),
    ("W07", "Create a SharePoint group", "POST", "_api/web/sitegroups",
     {"__metadata": {"type": "SP.Group"}, "Title": TEST_GROUP}, None, "@{body('W07')?['Id']}"),
    ("W08", "Create a document library", "POST", "_api/web/lists",
     {"__metadata": {"type": "SP.List"}, "BaseTemplate": 101, "Title": TEST_LIB}, None, "@{body('W08')?['Id']}"),
    ("W09", "Create a folder", "POST", f"_api/web/lists/getbytitle('{TEST_LIB}')/rootfolder/folders/add(url='ProbeFolder')", None, None, None),
    ("W10", "Give the folder its own permissions (per-action Working Files)", "POST",
     f"_api/web/lists/getbytitle('{TEST_LIB}')/rootfolder/folders/getbyurl('ProbeFolder')/ListItemAllFields/breakroleinheritance(copyRoleAssignments=false,clearSubscopes=true)", None, None, None),
    ("X01", "Cleanup: delete the test list", "POST", f"_api/web/lists/getbytitle('{TEST_LIST}')", None,
     {"X-HTTP-Method": "DELETE", "IF-MATCH": "*"}, None),
    ("X02", "Cleanup: delete the test library", "POST", f"_api/web/lists/getbytitle('{TEST_LIB}')", None,
     {"X-HTTP-Method": "DELETE", "IF-MATCH": "*"}, None),
    ("X03", "Cleanup: delete the test group", "POST", "_api/web/sitegroups/removebyid(@{body('W07')?['Id']})", None, None, None),
]
ALL = ["Succeeded", "Failed", "Skipped", "TimedOut"]
HOST = {"apiId": "/providers/Microsoft.PowerApps/apis/shared_sharepointonline", "connectionName": "shared_sharepointonline", "operationId": "HttpRequest"}
AUTH = {"value": "@json(decodeBase64(triggerOutputs().headers['X-MS-APIM-Tokens']))['$ConnectionKey']", "type": "Raw"}


def http(method, uri, body, headers, after):
    h = {"Accept": NM}
    if method == "POST": h["Content-Type"] = J
    h.update(headers or {})
    p = {"dataset": "@triggerBody()['text']", "parameters/method": method, "parameters/uri": uri, "parameters/headers": h}
    if body is not None: p["parameters/body"] = json.dumps(body)
    return {"runAfter": after, "type": "OpenApiConnection", "inputs": {"parameters": p, "host": HOST, "authentication": AUTH}}


def build():
    actions = {"Results": {"runAfter": {}, "type": "InitializeVariable",
                           "inputs": {"variables": [{"name": "Results", "type": "array", "value": []}]}}}
    prev = "Results"
    for cid, what, method, uri, body, headers, keep in CHECKS:
        actions[cid] = http(method, uri, body, headers, {prev: ALL})
        rec = f"Record_{cid}"
        actions[rec] = {"runAfter": {cid: ALL}, "type": "AppendToArrayVariable", "inputs": {"name": "Results", "value": {
            "id": cid, "what": what, "code": f"@{{outputs('{cid}')?['statusCode']}}",
            "out": keep or f"@{{take(string(body('{cid}')), 3000)}}",
            "err": f"@{{if(greaterOrEquals(int(coalesce(outputs('{cid}')?['statusCode'], 0)), 400), take(string(body('{cid}')), 600), '')}}"}}}
        prev = rec
    actions["Write_Result_File"] = http("POST", f"_api/web/DefaultDocumentLibrary/RootFolder/Files/add(url='{RESULT_FILE}',overwrite=true)",
                                        None, None, {prev: ALL})
    actions["Write_Result_File"]["inputs"]["parameters"]["parameters/body"] = "@{string(variables('Results'))}"
    actions["Result"] = {"runAfter": {"Write_Result_File": ALL}, "type": "Compose", "inputs": "@variables('Results')"}
    return {
        "displayName": f"90161Z T11 Rights Probe r{REV}",
        "description": "Tests what the person who runs it, and an optional coworker, can do on a SharePoint site. Creates TEST objects, then deletes them. Records status codes and permission masks only, no names.",
        "connections": ["shared_sharepointonline"],
        "triggers": {"manual": {"type": "Request", "kind": "Button", "inputs": {"schema": {"type": "object", "properties": {
            "text": {"title": "Site address", "type": "string", "x-ms-dynamically-added": True, "x-ms-content-hint": "TEXT",
                     "description": "Copy it from the browser: everything up to and including the site name"},
            "text_1": {"title": "Coworker e-mail (optional)", "type": "string", "x-ms-dynamically-added": True, "x-ms-content-hint": "TEXT",
                       "description": "A regular site member. If empty, R11 and R12 fail; that is expected"},
            "text_2": {"title": "Wing group e-mail (optional)", "type": "string", "x-ms-dynamically-added": True, "x-ms-content-hint": "TEXT",
                       "description": "The group that gives wing members access. If empty, R13 fails; that is expected"}},
            "required": ["text"]}}}},
        "actions": actions,
    }


if __name__ == "__main__":
    out = ROOT / "flow" / "defs" / f"{NAME}.json"
    text = json.dumps(build(), indent=2, ensure_ascii=False) + "\n"
    if "--check" in sys.argv:
        ok = out.exists() and out.read_text(encoding="utf-8") == text
        print("OK rights probe def" if ok else f"STALE {out.name}: run scripts/build_rights_probe.py"); sys.exit(0 if ok else 1)
    out.write_text(text, encoding="utf-8"); print(f"wrote {out.relative_to(ROOT)} ({len(CHECKS)} checks)")
