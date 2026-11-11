#!/usr/bin/env python3
"""Generate the Power Automate provisioning payload from schemas/lists/*.json.

Output: flow/provisioning-payload.json with three arrays the flow pastes into Compose actions:
  lists  - create each list (run first)
  fields - create fields, then views (lookup list IDs are placeholders __<List>_ID__ filled in the flow)
  seed   - optional Stages rows (process model is draft; see docs/process-model.md)
Every request is a SharePoint REST call relative to the site: {"method", "uri", "body"}.
Do not hand-edit the output. Change the schemas and run: python3 scripts/build_flow_payload.py
"""
import glob, json, os, sys
from xml.sax.saxutils import escape, quoteattr

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def load():
    schemas = {}
    for f in sorted(glob.glob(os.path.join(ROOT, 'schemas', 'lists', '*.json'))):
        d = json.load(open(f, encoding='utf-8'))
        schemas[d['list']] = d
    return schemas

def order(schemas):
    deps = {n: {f['lookup']['list'] for f in s['fields'] if f['type'] == 'Lookup'} for n, s in schemas.items()}
    done, out = set(), []
    while len(out) < len(schemas):
        ready = sorted(n for n in schemas if n not in done and deps[n] <= done)
        if not ready:
            sys.exit('lookup cycle in schemas')
        out += ready; done |= set(ready)
    return out

def field_xml(f):
    a = [f'Name={quoteattr(f["internalName"])}', f'StaticName={quoteattr(f["internalName"])}',
         f'DisplayName={quoteattr(f["displayName"])}', f'Required="{"TRUE" if f.get("required") else "FALSE"}"']
    inner = ''
    t = f['type']
    if t == 'Note': a += ['Type="Note"', 'NumLines="6"']
    elif t == 'DateTime': a += ['Type="DateTime"', 'Format="DateOnly"']
    elif t == 'URL': a += ['Type="URL"', 'Format="Hyperlink"']
    elif t == 'Choice':
        a += ['Type="Choice"']
        inner = '<CHOICES>' + ''.join(f'<CHOICE>{escape(c)}</CHOICE>' for c in f['choices']) + '</CHOICES>'
    elif t == 'Lookup':
        a += ['Type="Lookup"', 'List="{__%s_ID__}"' % f['lookup']['list'],
              f'ShowField={quoteattr(f["lookup"].get("showField", "Title"))}']
    elif t in ('Text', 'Number', 'Boolean'): a += [f'Type="{t}"']
    else: sys.exit(f'unsupported field type {t}')
    if f.get('default') not in (None, ''):
        inner += f'<Default>{escape(str(f["default"]))}</Default>'
    return '<Field ' + ' '.join(a) + '>' + inner + '</Field>'

def view_query(v):
    q = ''
    w = v.get('where')
    if w:
        q += f'<Where><{w["op"]}><FieldRef Name={quoteattr(w["field"])}/><Value Type={quoteattr(w["type"])}>{escape(str(w["value"]))}</Value></{w["op"]}></Where>'
    if v.get('orderBy'):
        q += '<OrderBy>' + ''.join(f'<FieldRef Name={quoteattr(o["field"])} Ascending="{"TRUE" if o.get("ascending", True) else "FALSE"}"/>' for o in v['orderBy']) + '</OrderBy>'
    return q

def lit(s):  # OData string literal
    return "'" + s.replace("'", "''") + "'"

def build():
    schemas = load()
    lists, fields, seed = [], [], []
    for name in order(schemas):
        s = schemas[name]
        lists.append({'method': 'POST', 'uri': '_api/web/lists',
                      'body': {'__metadata': {'type': 'SP.List'}, 'Title': name, 'BaseTemplate': 100,
                               'Description': s.get('description', ''), 'ContentTypesEnabled': False}})
        base = f'_api/web/lists/getbytitle({lit(name)})'
        for f in s['fields']:
            if f.get('builtIn'):
                continue
            fields.append({'method': 'POST', 'uri': base + '/fields/createfieldasxml',
                           'body': {'parameters': {'__metadata': {'type': 'SP.XmlSchemaFieldCreationInformation'},
                                                   'SchemaXml': field_xml(f), 'Options': 24}}})  # 8 internal name hint + 16 add to default view
        for v in s.get('views', []):
            fields.append({'method': 'POST', 'uri': base + '/views',
                           'body': {'__metadata': {'type': 'SP.View'}, 'Title': v['name'], 'PersonalView': False,
                                    'ViewQuery': view_query(v), 'RowLimit': 100}})
            vb = base + f'/views/getbytitle({lit(v["name"])})/viewfields'
            fields.append({'method': 'POST', 'uri': vb + '/removeallviewfields', 'body': {}})
            for fld in v['fields']:
                fields.append({'method': 'POST', 'uri': vb + f'/addviewfield({lit("LinkTitle" if fld == "Title" else fld)})', 'body': {}})
        for row in s.get('seed', []) or []:
            item = {'__metadata': {'type': f'SP.Data.{name}ListItem'}}
            item.update(row)
            seed.append({'method': 'POST', 'uri': base + '/items', 'body': item})
    return {'generatedFrom': 'schemas/lists/*.json', 'listOrder': order(schemas),
            'lookupPlaceholders': sorted({f['lookup']['list'] for s in schemas.values() for f in s['fields'] if f['type'] == 'Lookup'}),
            'lists': lists, 'fields': fields, 'seed': seed}

if __name__ == '__main__':
    out = build()
    path = os.path.join(ROOT, 'flow', 'provisioning-payload.json')
    text = json.dumps(out, ensure_ascii=False, indent=1) + '\n'
    if '--check' in sys.argv:
        ok = os.path.exists(path) and open(path, encoding='utf-8').read() == text
        print('PAYLOAD up to date' if ok else 'PAYLOAD stale: run scripts/build_flow_payload.py'); sys.exit(0 if ok else 1)
    open(path, 'w', encoding='utf-8').write(text)
    print(f"PAYLOAD lists={len(out['lists'])} fieldsAndViews={len(out['fields'])} seed={len(out['seed'])} order={','.join(out['listOrder'])}")
