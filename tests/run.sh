#!/usr/bin/env bash
# 90-161.Z test runner (agent workspace). Pass = last line "TESTS pass=N fail=0", exit 0.
# Word COM and PnP cannot run here; those parts are tested on the gov device (docs/gov-test-plan.md).
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
pass=0; fail=0
ok()  { echo "PASS $1"; pass=$((pass+1)); }
bad() { echo "FAIL $1"; fail=$((fail+1)); }

scripts/lint.sh >/tmp/lint.out 2>&1 && ok "lint ($(tail -1 /tmp/lint.out))" || { cat /tmp/lint.out; bad "lint"; }

out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path samples/publication.sample.json); rc=$?
[ $rc -eq 0 ] && echo "$out" | tail -1 | grep -q '^VALIDATE fails=0 ' && ok "sample validates ($(echo "$out" | tail -1))" || { echo "$out"; bad "sample validates"; }

out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path tests/fixtures/bad.publication.json); rc=$?
got=$(echo "$out" | grep -oE '^FAIL [A-Z]+-?[0-9]*' | awk '{print $2}' | sort -u | tr '\n' ' ')
want="F-005 F-013 F-018 F-020 F-021 F-022 F-025 F-026 F-029 F-031 F-033 F-034 F-035 F-037 SCHEMA W-001 "
[ $rc -eq 1 ] && [ "$got" = "$want" ] && ok "bad fixture fails on expected rules" || { echo "got:  $got"; echo "want: $want"; bad "bad fixture"; }

for f in samples/publication.sample.json tests/fixtures/bad.publication.json schemas/publication.schema.json schemas/lists/*.json flow/provisioning-payload.json; do
  python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" && ok "json $f" || bad "json $f"
done

python3 - <<'PY' && ok "sample matches JSON schema" || bad "sample matches JSON schema"
import json, sys
try:
    import jsonschema
except ImportError:
    print("jsonschema not installed"); sys.exit(1)
jsonschema.validate(json.load(open('samples/publication.sample.json')), json.load(open('schemas/publication.schema.json')))
PY

python3 scripts/build_flow_payload.py --check >/dev/null && ok "flow payload up to date" || bad "flow payload stale"
python3 scripts/build_flow_package.py --check && ok "flow packages up to date" || bad "flow packages stale"
python3 tests/check_flow_package.py && ok "flow packages match real export shape" || bad "flow package shape"
python3 tests/check_flow_defs.py && ok "flow def names and expressions" || bad "flow def names or expressions"
for f in flow/defs/*.json; do python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" && ok "json $f" || bad "json $f"; done

python3 - <<'PY' && ok "T02 package embeds the current payload; loops run 1 at a time" || bad "T02 package payload or loop concurrency"
import json, zipfile, glob
z = zipfile.ZipFile(sorted(glob.glob('flow/packages/90161Z-T02-provision-lists-r*.zip'))[-1])
d = json.loads(z.read([n for n in z.namelist() if n.endswith('/definition.json')][0]))['properties']['definition']['actions']
assert d['Payload']['inputs'] == json.load(open('flow/provisioning-payload.json'))
for k in ('Create_lists', 'Create_fields_and_views'):
    assert d[k]['runtimeConfiguration']['concurrency']['repetitions'] == 1, k
PY

python3 - <<'PY' && ok "flow payload XML parses" || bad "flow payload XML"
import json, xml.etree.ElementTree as ET
d = json.load(open('flow/provisioning-payload.json'))
for r in d['fields']:
    b = r['body']
    if 'parameters' in b: ET.fromstring(b['parameters']['SchemaXml'])
    if b.get('ViewQuery'): ET.fromstring('<Q>' + b['ViewQuery'] + '</Q>')
PY

out=$(pwsh -NoProfile -File scripts/gov/Provision-Lists.ps1 -PlanOnly -SchemaPath schemas/lists 2>&1 | tail -1)
[ "$out" = "PLAN lists=4 fields=25 views=5" ] && ok "lists plan ($out)" || bad "lists plan: $out"

cp templates/CRM_A12-1.docx /tmp/crm_before.docx
node templates/build_crm_template.js >/tmp/crm.out 2>&1 && grep -q "tableWidthDXA=9331 columns=9" /tmp/crm.out && ok "CRM template builds ($(cat /tmp/crm.out | sed s,.*CRM_A12-1.docx,,))" || bad "CRM template build"
zip -d templates/CRM_A12-1.docx '*/' >/dev/null 2>&1; true

got=$(pwsh -NoProfile -c '. ./scripts/gov/Publication.Common.ps1; ConvertTo-TwoSpaceSentence "Do this. (T-3) Then Mr. A. B. Smith signs. Use e.g. Forms. Done? Yes."')
want="Do this. (T-3)  Then Mr. A. B. Smith signs.  Use e.g. Forms.  Done?  Yes."
[ "$got" = "$want" ] && ok "two-space sentences (L-004)" || { echo "got:  [$got]"; echo "want: [$want]"; bad "two-space sentences"; }

got=$(pwsh -NoProfile -c '. ./scripts/gov/Publication.Common.ps1; $p = Get-Content samples/publication.sample.json -Raw | ConvertFrom-Json; Get-OpeningParagraph $p' | grep -o -E "implements|Ensure all records|DAF Form 847|may be supplemented|authorities to waive" | tr '\n' ',')
[ "$got" = "implements,Ensure all records,DAF Form 847,may be supplemented,authorities to waive," ] && ok "opening paragraph order (4.5.5)" || { echo "got: $got"; bad "opening paragraph order"; }

! grep -rniE "@us\.af\.mil|@mail\.mil|usaf\.dps\.mil/sites/[a-z0-9]" samples tests schemas docs scripts flow templates/build_crm_template.js >/dev/null && ok "no .mil addresses in repo content" || bad "no .mil addresses"

echo "TESTS pass=$pass fail=$fail"
[ $fail -eq 0 ]
