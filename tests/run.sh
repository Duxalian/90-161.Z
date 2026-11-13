#!/usr/bin/env bash
# 90-161.Z test runner (agent workspace). Pass = last line "TESTS pass=N fail=0", exit 0.
# Word COM and PnP cannot run here; those parts are tested on the gov device (docs/gov-test-plan.md).
set -uo pipefail
cd "$(git rev-parse --show-toplevel)"
pass=0; fail=0
ok()  { echo "PASS $1"; pass=$((pass+1)); }
bad() { echo "FAIL $1"; fail=$((fail+1)); }

python3 scripts/bloat_check.py --test >/tmp/bloat.out 2>&1 && ok "bloat_check self-test" || { cat /tmp/bloat.out; bad "bloat_check self-test"; }

scripts/lint.sh >/tmp/lint.out 2>&1 && ok "lint ($(tail -1 /tmp/lint.out))" || { cat /tmp/lint.out; bad "lint"; }

out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path samples/publication.sample.json); rc=$?
[ $rc -eq 0 ] && echo "$out" | tail -1 | grep -q '^VALIDATE fails=0 ' && ok "sample validates ($(echo "$out" | tail -1))" || { echo "$out"; bad "sample validates"; }

# F-040 (Attachment 10 note 4) and PFM 2B (2026-11-12): in a wing or delta publication (T-3) warns, a higher tier such as
# the sample's (T-1) stays, and F-039 does not ask for a tier. Sample = wing with 0 (T-3). Copies add (T-3) to the 3
# untiered statements: wing and delta warn 3 times with no F-039; a non-wing issuer has no F-040 but F-039 warns.
t40=$(mktemp -d)
python3 - "$t40" <<'PY40'
import json, sys
d = json.load(open('samples/publication.sample.json'))
s = json.dumps(d)
for t in ('15 business days.', 'in the record set.', 'coordination is complete.'):
    assert s.count(t) == 1, t; s = s.replace(t, t + ' (T-3)')
d = json.loads(s)
json.dump(d, open(sys.argv[1] + '/wing.json', 'w'))
d['meta']['issuerLine'] = 'SAMPLE DELTA'; d['meta'].pop('byOrderOfUnit', None)
json.dump(d, open(sys.argv[1] + '/delta.json', 'w'))
d['meta']['byOrderOf'] = 'SECRETARY OF THE AIR FORCE'; d['meta']['issuerLine'] = 'SAMPLE HEADQUARTERS'
s = json.dumps(d).replace(' (T-3)', '')
json.dump(json.loads(s), open(sys.argv[1] + '/hq.json', 'w'))
PY40
c40() { pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path "$1" | grep -c "^WARN $2 "; }
s40=$(c40 samples/publication.sample.json F-040); s39=$(c40 samples/publication.sample.json F-039)
w40=$(c40 "$t40/wing.json" F-040); w39=$(c40 "$t40/wing.json" F-039); d40=$(c40 "$t40/delta.json" F-040)
h40=$(c40 "$t40/hq.json" F-040); h39=$(c40 "$t40/hq.json" F-039); rm -rf "$t40"
r40="sample=$s40/$s39 wing=$w40/$w39 delta=$d40 hq=$h40/$h39"
[ "$s40$s39$w40$w39$d40$h40" = "003030" ] && [ "$h39" -eq 3 ] && ok "F-040 and F-039 in wing/delta vs other issuers ($r40, F-040/F-039)" || bad "F-040/F-039 $r40 (want sample=0/0 wing=3/0 delta=3 hq=0/3)"

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

grep -q "\$nb = \$t.Replace('-', \[string\]\[char\]30)" scripts/gov/New-Publication.ps1 && ok "tier numbers use a Word nonbreaking hyphen (T01 r4)" || bad "tier nonbreaking hyphen"
[ "$(ls scripts/gov/90161Z-T01-renderer-test-r*.ps1 | wc -l)" -eq 1 ] && ok "one T01 runner revision" || bad "more than one T01 runner"

out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path tests/fixtures/placeholder.publication.json); rc=$?
got=$(echo "$out" | grep -oE '^FAIL [A-Z]+-?[0-9]*' | awk '{print $2}' | sort -u | tr '\n' ' ')
[ $rc -eq 1 ] && [ "$got" = "X-001 " ] && ok "placeholder fixture fails on X-001 only" || { echo "got: $got"; bad "placeholder fixture"; }
python3 scripts/build_messy_draft.py --check && ok "T06 messy draft up to date" || bad "T06 messy draft stale"
for k in ComplianceBefore ComplianceRuleDist ReleaseRuleDist BlockRuleBefore GroupBlankLine TocFontSize; do
  grep -q "^\$$k = " scripts/gov/New-Publication.ps1 || { bad "renderer constant $k (L-008a, L-010c, L-012)"; continue; }
done && ok "renderer cover and TOC constants present (L-008a, L-010c, L-012)"

python3 scripts/build_test_seals.py --check && ok "T07 test seals up to date" || bad "T07 test seals stale"
sealraw=$(mktemp -d); python3 scripts/build_test_seals.py --raw "$sealraw" >/dev/null
out=$(pwsh -NoProfile -File tests/ps/Test-SealTrim.ps1 -RawDir "$sealraw"); rc=$?; rm -rf "$sealraw"
[ $rc -eq 0 ] && [ "$(echo "$out" | grep -c '^PASS')" -eq 4 ] && ok "seal trim matches the reference on 4 test seals (L-007a)" || { echo "$out"; bad "seal trim"; }
out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path tests/fixtures/seal.publication.json); rc=$?
got=$(echo "$out" | grep -oE '^FAIL [A-Z]+-?[0-9a-z]*' | awk '{print $2}' | sort -u | tr '\n' ' ')
[ $rc -eq 1 ] && [ "$got" = "L-007a " ] && ok "unprepared seal fails on L-007a only" || { echo "got: $got"; bad "seal fixture"; }
out=$(pwsh -NoProfile -File scripts/gov/Test-Publication.ps1 -Path tests/fixtures/seal-ok.publication.json); rc=$?
[ $rc -eq 0 ] && echo "$out" | tail -1 | grep -q '^VALIDATE fails=0 ' && ok "prepared seal path accepted (L-007a)" || { echo "$out" | grep FAIL; bad "prepared seal path"; }
grep -q '$pic.Width = \[single\]$ShieldWidth; $pic.Height = \[single\]$ShieldWidth' scripts/gov/New-Publication.ps1 && ok "renderer places seals in the 1.20 in box (L-007)" || bad "renderer seal box"
grep -q "Write-Output ('RENDER-ERROR line '" scripts/gov/New-Publication.ps1 && grep -q "exit 3 }" scripts/gov/New-Publication.ps1 && ok "renderer names the failing line and flags FORMAT-FAIL (T06/T07 cast error)" || bad "renderer error line"

python3 scripts/build_flow_payload.py --check >/dev/null && ok "flow payload up to date" || bad "flow payload stale"
python3 tests/check_palette.py >/dev/null && ok "palette contrast (WCAG AA)" || bad "palette contrast"
python3 scripts/build_rights_probe.py --check >/dev/null && ok "rights probe def up to date" || bad "rights probe def stale"
python3 scripts/build_flow_package.py --check && ok "flow packages up to date" || bad "flow packages stale"
python3 tests/check_flow_package.py && ok "flow packages match real export shape" || bad "flow package shape"
python3 tests/check_flow_defs.py && ok "flow def names and expressions" || bad "flow def names or expressions"
python3 tests/check_names.py && ok "naming rules (PFM 2026-11-11)" || bad "naming rules"
for f in flow/defs/*.json; do python3 -c "import json,sys; json.load(open(sys.argv[1]))" "$f" && ok "json $f" || bad "json $f"; done

python3 - <<'PY' && ok "T02 package: current payload, site address only (PFM 2026-11-12), lookups and list titles last, loops 1 at a time" || bad "T02 package payload or loop concurrency"
import json, zipfile, glob, sys
sys.path.insert(0, 'scripts'); from build_flow_package import literal
z = zipfile.ZipFile(sorted(glob.glob('flow/packages/90161Z-T02-provision-lists-r*.zip'))[-1])
d = json.loads(z.read([n for n in z.namelist() if n.endswith('/definition.json')][0]))['properties']['definition']['actions']
assert d['Payload']['inputs'] == literal(json.load(open('flow/provisioning-payload.json')))
assert literal({'a': ['@x', 'y @{z}', 'ok']}) == {'a': ['@@x', 'y @@{z}', 'ok']}
assert 'Check_Site_Title' not in d and 'Get_Site_Title' not in d
assert d['Payload']['runAfter'] == {}
p = json.load(open('flow/provisioning-payload.json'))
assert all(('Get_' + l[3:] + '_ID') in d for l in p['lookupPlaceholders']), p['lookupPlaceholders']
body = d['Create_Fields_And_Views']['actions']['Create_Field_Or_View']['inputs']['parameters']['parameters/body']
assert all(f'__{l}_ID__' in body for l in p['lookupPlaceholders'])
assert d['Add_Rows']['runAfter'] == {'Create_Fields_And_Views': ['Succeeded']} and d['Apply_Updates']['runAfter'] == {'Add_Rows': ['Succeeded']}
assert len(p['rows']) == 41
assert 'PFMProductIndex' in p['lookupPlaceholders'] and p['listOrder'][-1] == 'PFMReviews'
lo = p['listOrder']; assert lo.index('PFMProductIndex') < lo.index('PFMPublications') < lo.index('PFMReviews'), lo
gv = [r for r in p['fields'] if r['body'].get('Title') == 'PFM - Prescribed Forms by Publication']
q = gv[0]['body']['ViewQuery']
assert q.index('<Where>') < q.index('<GroupBy') < q.index('<OrderBy>'), q
assert [r['body']['__metadata']['type'] for r in p['rows']].count('SP.Data.PFMSeriesListItem') == 39
st = {r['body']['Title']: r['body']['SettingValue'] for r in p['rows'] if r['body']['__metadata']['type'] == 'SP.Data.PFMSettingsListItem'}
assert st == {'CoordinationSuspenseBusinessDays': '15', 'GuardReserveApplicabilityCalendarDays': '30'}, st
nums = [r['body']['SeriesNumber'] for r in p['rows'] if 'SeriesNumber' in r['body']]
assert len(set(nums)) == 39 and 16 in nums and 17 in nums
gets = [a for a in d if a.startswith('Get_') and a.endswith('_ID')]
assert d[gets[0]]['runAfter'] == {'Create_Lists': ['Succeeded', 'Failed']}
assert all(d[b]['runAfter'] == {a: ['Succeeded']} for a, b in zip(gets, gets[1:]))
assert d['Create_Fields_And_Views']['runAfter'] == {gets[-1]: ['Succeeded']}
assert all(u['uri'].startswith('_api/web/lists/getbytitle(') for u in p['updates'])
assert p['updates'][-len(p['listOrder']):] == [u for u in p['updates'] if u['body']['__metadata']['type'] == 'SP.List']
trig = json.loads(z.read([n for n in z.namelist() if n.endswith('/definition.json')][0]))['properties']['definition']['triggers']['manual']['inputs']['schema']
assert set(trig['required']) == {'text'} and set(trig['properties']) == {'text'}
def upstream(a, seen=()):  # every action must sit after the site-title check
    if a == 'Payload': return True
    after = list(d[a]['runAfter'])
    return bool(after) and all(upstream(x) for x in after)
assert all(upstream(a) for a in d if a != 'Payload'), 'an action runs before the payload'
reqs = p['lists'] + p['fields'] + p['rows'] + p['updates']
assert not any(' ' in r['uri'] for r in reqs), 'unencoded space in a request URI'
assert all(l['body'].get('EnableVersioning') for l in p['lists']), 'AppendOnly notes need versioning on every list'
renamed = {}
for i, r in enumerate(p['updates']):
    if r['body']['__metadata']['type'] == 'SP.List': renamed[r['uri']] = i
for i, r in enumerate(p['updates']):
    for u, j in renamed.items():
        assert not (r['uri'].startswith(u + '/') and i > j), 'request uses a list title after its rename'
for k in ('Create_Lists', 'Create_Fields_And_Views', 'Add_Rows', 'Apply_Updates'):
    assert d[k]['runtimeConfiguration']['concurrency']['repetitions'] == 1, k
PY

python3 - <<'PY' && ok "r7 schema rules (DAFMAN design check 2026-11-11)" || bad "r7 schema rules"
import json, glob
S = {json.load(open(f))['list']: json.load(open(f)) for f in glob.glob('schemas/lists/*.json')}
F = lambda l: {f['internalName']: f for f in S[l]['fields']}
pub, end, pi, rv, off = F('PFMPublications'), F('PFMEndorsements'), F('PFMProductIndex'), F('PFMReviews'), F('PFMOffices')
assert pub['ActionType']['choices'] == ['New', 'Rewrite', 'Interim Change', 'Administrative Change', 'Guidance Memorandum', 'Certify Current', 'Rescind', 'Transfer']
assert pub['Product']['lookup']['list'] == 'PFMProductIndex'
assert 'Execution' not in end and not end['EndorserOrder']['required']
assert end['CoordinationStage']['choices'] == ['Privacy Review', 'Formal Coordination', 'Legal'] and end['CoordinationStage']['required']
assert end['CoordinationRole']['choices'] == off['CoordinationRole']['choices'] and 'Legal' in off['CoordinationRole']['choices']
assert 'Publication' not in pi and 'Expired' in pi['ProductStatus']['choices']
assert all(pi[k]['lookup']['list'] == 'PFMProductIndex' for k in ('SupersededBy', 'ParentPublication', 'PrescribingPublication'))
assert rv['OPRResponse']['choices'] == ['Certify Current', 'Requires Revision', 'Requires Transfer', 'Is Obsolete', 'Other', 'No Response']
assert rv['Product']['lookup']['list'] == 'PFMProductIndex' and rv['FollowUpAction']['lookup']['list'] == 'PFMPublications'
steps = S['PFMProcessSteps']['seed']
assert [s['StepNumber'] for s in steps] == list(range(1, 11)) and 'Privacy' in steps[3]['Title']
assert {s['StepNumber']: s.get('TargetBusinessDays') for s in steps if s.get('TargetBusinessDays')} == {2: 60, 5: 20, 6: 20, 7: 10, 8: 10, 10: 15}
PY

python3 - <<'PY' && ok "sample CSVs match schema columns and choices" || bad "sample CSVs"
import csv, glob, json, os
for f in glob.glob('samples/lists/*.csv'):
    S = {x['internalName']: x for x in json.load(open('schemas/lists/' + os.path.basename(f)[:-4] + '.json'))['fields']}
    rows = list(csv.DictReader(open(f, encoding='utf-8')))
    assert set(rows[0]) <= set(S), (f, set(rows[0]) - set(S))
    for r in rows:
        for k, v in r.items():
            if v and S[k]['type'] == 'Choice': assert v in S[k]['choices'], (f, k, v)
PY

python3 scripts/build_list_mockup.py /tmp/pfm-lists-mockup.html | grep -q "9 lists" && ! grep -qE "[0-9]{4}-[0-9]{2}-[0-9]{2}</td>|Not started|Emailed" /tmp/pfm-lists-mockup.html && ok "list mockup builds (T&Q dates and terms)" || bad "list mockup"

python3 - <<'PY' && ok "flow payload XML parses" || bad "flow payload XML"
import json, xml.etree.ElementTree as ET
d = json.load(open('flow/provisioning-payload.json'))
for r in d['fields']:
    b = r['body']
    if 'parameters' in b: ET.fromstring(b['parameters']['SchemaXml'])
    if b.get('ViewQuery'): ET.fromstring('<Q>' + b['ViewQuery'] + '</Q>')
PY

out=$(pwsh -NoProfile -File scripts/gov/Provision-Lists.ps1 -PlanOnly -SchemaPath schemas/lists 2>&1 | tail -1)
[ "$out" = "PLAN lists=9 fields=80 views=18" ] && ok "lists plan ($out)" || bad "lists plan: $out"

node templates/build_crm_template.js >/tmp/crm.out 2>&1 && grep -q "tableWidthDXA=9331 columns=9" /tmp/crm.out && ok "CRM template builds ($(cat /tmp/crm.out | sed s,.*CRM_A12-1.docx,,))" || bad "CRM template build"
# Build is deterministic (fixed dates): a rebuild must match the committed file byte for byte.
git diff --quiet HEAD -- templates/CRM_A12-1.docx && ok "CRM template rebuild matches committed file" || bad "CRM template rebuild differs from committed file (commit the rebuild if the source changed)"

got=$(pwsh -NoProfile -c '. ./scripts/gov/Publication.Common.ps1; ConvertTo-TwoSpaceSentence "Do this. (T-3) Then Mr. A. B. Smith signs. Use e.g. Forms. Done? Yes."')
want="Do this. (T-3)  Then Mr. A. B. Smith signs.  Use e.g. Forms.  Done?  Yes."
[ "$got" = "$want" ] && ok "two-space sentences (L-004)" || { echo "got:  [$got]"; echo "want: [$want]"; bad "two-space sentences"; }

got=$(pwsh -NoProfile -c '. ./scripts/gov/Publication.Common.ps1; $p = Get-Content samples/publication.sample.json -Raw | ConvertFrom-Json; Get-OpeningParagraph $p' | grep -o -E "implements|Ensure all records|DAF Form 847|may be supplemented|authorities to waive" | tr '\n' ',')
[ "$got" = "implements,Ensure all records,DAF Form 847,may be supplemented,authorities to waive," ] && ok "opening paragraph order (4.5.5)" || { echo "got: $got"; bad "opening paragraph order"; }

! grep -rniE "@us\.af\.mil|@mail\.mil|usaf\.dps\.mil/sites/[a-z0-9]" samples tests schemas docs scripts flow templates/build_crm_template.js >/dev/null && ok "no .mil addresses in repo content" || bad "no .mil addresses"

out=$(python3 scripts/build_paste_bundles.py --check 2>&1 | tail -1)
[ "$out" = "PASTE bundles=2 stale=0" ] && ok "paste bundles current ($out)" || bad "paste bundles: $out (run python3 scripts/build_paste_bundles.py)"

# Paste bundle end to end in pwsh (Linux): DODID and C:\Users swapped for a temp root; every written file must equal its
# source (text: BOM and CR removed, same swaps applied). The runner then starts in-process with -Id and stops at Unblock-File (Windows only).
tp=$(mktemp -d); mkdir -p "$tp/u/test1234/OneDrive - United States Air Force"; pb=0; pf=0
for b in scripts/gov/paste/*.ps1; do
  sed -e "s#Read-Host 'DODID (press Enter to use this computer''s profile folder)'#'test1234'#" -e "s#'C:\\\\Users'#'$tp/u'#" "$b" > "$tp/b.ps1"
  pwsh -NoProfile -File "$tp/b.ps1" > "$tp/out.txt" 2>&1; grep -q '^RUN ' "$tp/out.txt" && pb=$((pb+1))
done
while IFS=$'\t' read -r dir src; do
  got="$tp/u/test1234/OneDrive - United States Air Force/90-161.Z/${dir//\\//}/$(basename "$src")"
  case "$src" in *.png) cmp -s "$got" "$src" || pf=$((pf+1));; *) cmp -s <(tail -c +4 "$got" | tr -d '\r') <(sed -e "s#Read-Host 'DODID (press Enter to use this computer''s profile folder)'#'test1234'#" -e "s#'C:\\\\Users'#'$tp/u'#" "$src") || pf=$((pf+1));; esac
done < <(python3 -c "import json;[print(f['dir']+'\t'+f['src']) for b in json.load(open('scripts/paste_bundles.json'))['bundles'] for f in b['files']]")
rm -rf "$tp"
[ $pb -eq 2 ] && [ $pf -eq 0 ] && ok "paste bundles write exact files and start the runner (bundles=$pb mismatches=$pf)" || bad "paste bundles run: started=$pb mismatches=$pf"

echo "TESTS pass=$pass fail=$fail"
[ $fail -eq 0 ]
