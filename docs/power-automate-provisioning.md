# Create the 90-161.Z lists with Power Automate

Decided (PFM, 2026-11-10): lists are created by a Power Automate flow, not PowerShell (PnP sign-in did not open on the gov device). The flow runs under your own sign-in. It uses only the SharePoint connector ("Send an HTTP request to SharePoint"), a standard connector: no premium license, no admin.

The flow reads one generated file, `flow/provisioning-payload.json`, and sends each request in order. The site URL is chosen inside the flow; it is never in this repo.

## 1. Get the payload

Open on the gov device and copy all of it (Ctrl+A, Ctrl+C):
https://raw.githubusercontent.com/rhope-ops/90-161.Z/main/flow/provisioning-payload.json

## 2. Build the flow (7 actions)

Power Automate → Create → Instant cloud flow → name `90-161.Z provision lists` → trigger **Manually trigger a flow** → Create.

| # | Action | Rename to | Settings |
|---|---|---|---|
| 1 | Data Operation → **Compose** | `Payload` | Inputs: paste the whole payload file |
| 2 | Control → **Apply to each** | `Create lists` | Select an output: expression `outputs('Payload')?['lists']` |
| 2a | inside 2: SharePoint → **Send an HTTP request to SharePoint** | `Create list` | see "HTTP action settings", Body expression `items('Create_lists')?['body']`, Uri expression `items('Create_lists')?['uri']` |
| 3 | SharePoint → **Send an HTTP request to SharePoint** | `Get Stages ID` | Method GET; Uri `_api/web/lists/getbytitle('Stages')?$select=Id`; header `Accept` = `application/json;odata=verbose`. Settings → Configure run after: tick **is successful** and **has failed** |
| 4 | SharePoint → **Send an HTTP request to SharePoint** | `Get Publications ID` | Same as 3 with `'Publications'` |
| 5 | Control → **Apply to each** | `Create fields and views` | Select an output: expression `outputs('Payload')?['fields']` |
| 5a | inside 5: **Send an HTTP request to SharePoint** | `Create field or view` | Uri expression `items('Create_fields_and_views')?['uri']`; Body expression below |
| 6 | (optional) Control → **Apply to each** | `Seed stages` | Select an output: `outputs('Payload')?['seed']`; inside: HTTP action with Uri `items('Seed_stages')?['uri']`, Body `items('Seed_stages')?['body']` |

HTTP action settings (2a, 5a, 6): Site Address = your site (choose it or "Enter custom value": `https://usaf.dps.mil/sites/<your-site>`); Method = POST; Headers:

```
Accept: application/json;odata=verbose
Content-Type: application/json;odata=verbose
```

Body expression for 5a (it fills in the list IDs that lookup fields need):

```
replace(replace(string(items('Create_fields_and_views')?['body']), '__Stages_ID__', body('Get_Stages_ID')?['d']?['Id']), '__Publications_ID__', body('Get_Publications_ID')?['d']?['Id'])
```

Leave **Concurrency control** off on every Apply to each (the default), so requests run in order.

Seed stages (6) is optional: the stage list in docs/process-model.md is a draft. Skip it until the stages are approved.

## 3. Run and check

Save → Test → Manually → Run flow. In the run history every iteration should be green.

| Check | Pass |
|---|---|
| Create lists | 4 of 4 iterations succeeded |
| Get Stages ID / Get Publications ID | succeeded |
| Create fields and views | 60 of 60 iterations succeeded |
| Site contents | Lists Stages, Publications, Endorsements, PublicationIndex exist |
| Endorsements → Endorser column | Type Person or Group, people only |
| Endorsements → Status column | Choices: Not started, Concur, Concur With Comment, Concur—No Response, Nonconcur, No Comment; default Not started |

Run it once. A second run fails on lists and fields that already exist; that is expected and changes nothing.

If an iteration fails, open it and send only the HTTP status code and the error code (for example `400 / -2130575342`). Do not send URLs or names.

## 4. Set item-level permissions (manual, 2 lists)

Decided (PFM, 2026-11-10): customers see only the rows they created. You (site owner) still see all rows. For **Publications** and **Endorsements**:

List → Settings (gear) → List settings → Advanced settings → Item-level Permissions:
- Read access: **Read items that were created by the user**
- Create and Edit access: **Create items and edit items that were created by the user**
→ OK.

Leave Stages and PublicationIndex readable by all site members.

## Regenerate the payload

Never hand-edit `flow/provisioning-payload.json`. Change `schemas/lists/*.json`, then run `python3 scripts/build_flow_payload.py`. `python3 scripts/build_flow_payload.py --check` fails when the file is stale.
