# Setup and updates: design r1 (12 Nov 26)

Status: design draft. The PFM decided the goals on 12 Nov (docs/DECISIONS.md: initial configuration, update check). Items marked **Rec:** are agent recommendations, not decisions. Items marked **Test** are not proven on the DoD tenant.

## 1. Goals (PFM, 12 Nov)

1. One person with the needed rights sets up 90-161.Z end to end.
2. Setup checks each right first. For each missing right it says whom to ask, what to ask for, and the fallback.
3. The app checks for updates at start and has a manual "Check for updates" button.
4. Every step works for a wing PFM with less access than this PFM (AGENTS.md "Deployable package").

## 2. Setup sequence

The app cannot check rights before it exists, so setup has 4 parts. Each part stops with a clear message, never a half-built site.

| Part | What runs | Where | Result |
|---|---|---|---|
| 0. Preflight | Flow "90161Z Setup Check" (imported first, alone) | Power Automate | A report of each right: PASS, MISSING (with the request text) or UNKNOWN (with the manual check) |
| 1. Lists | Provisioning flow (T02 r10 and later) | Power Automate | Lists, columns, views, seed rows; Schema Version row in PFM Settings |
| 2. App and flows | Solution or package import; connections made by the installer | Power Apps | App and flows bound to the wing's site |
| 3. First-run setup | Setup screen in the app, shown while PFM Settings "Setup Complete" = No | Power Apps | Wing values entered and checked; self-test; Setup Complete = Yes |

## 3. Rights matrix

Each row: what setup needs, how Part 0 detects it, and what to do if it is missing. The request text goes into the preflight report as is, so the installer can paste it into a ticket or e-mail.

| # | Right or prerequisite | Needed for | How Part 0 detects it | If missing: ask whom, for what | Fallback |
|---|---|---|---|---|---|
| R1 | Power Apps and Power Automate in the M365 license | Everything | Implicit: Part 0 runs at all | Base communications help desk: "Power Apps and Power Automate access for my account" | None; stop |
| R2 | Maker rights in the Default environment (import, create flows and apps) | Parts 0-2 | Implicit: import of Part 0 works | Tenant Power Platform admins through the help desk | None; stop |
| R3 | Solution import in the Default environment (needs Dataverse in that environment) | Part 2 (solution route) | **Test**: try importing an empty solution | Same as R2 | Legacy package for flows plus .msapp for the app (works today for flows: T02) |
| R4 | A SharePoint site for the PFM office | Parts 1-3 | Installer enters the site address; Part 0 reads it | Site request through the base SharePoint/communications process | None; stop |
| R5 | Full Control (site owner) on that site: Manage Lists, Manage Permissions | Part 1, permissions | SharePoint REST `effectivebasepermissions` on the web, checked for ManageLists and ManagePermissions | The site owner or site collection admin: "add me to the site Owners group" | Part 1 can run with Manage Lists only; permission steps go to a site owner as a checklist |
| R6 | Site collection admin | Nothing required | REST `currentuser/IsSiteAdmin` (report only) | - | Not needed (Rec: design keeps it optional) |
| R7 | Standard connectors allowed together by the data policy (SharePoint, Office 365 Outlook, Office 365 Users) | Flows | **Test**: Part 0 itself uses SharePoint and Outlook; save fails on a DLP block | Tenant Power Platform admins: "allow SharePoint and Office 365 Outlook in the same data group in the Default environment" | None; stop |
| R8 | A security or M365 group of wing members | Sharing the app (a SharePoint group cannot be used) | Installer enters the group; Part 0 resolves it through Office 365 Users or SharePoint `ensureuser` | Communications squadron: "the AD group of all wing members" | Share with named people; slower upkeep |
| R9 | Send As or Send on Behalf for the PFM office mailbox | Office-mailbox e-mails | **Test**: Part 0 sends a test from the shared mailbox; failure = missing | Exchange admins through the help desk | Send from the installer, office box on CC and Reply-To (Settings switch) |
| R10 | A second person (co-owner, alternate PFM) | Continuity | Installer enters the person; Part 0 checks the account resolves | Wing leadership names an alternate | Setup completes with a warning that stays on the PFM screen |
| R11 | Read access to the central Releases list | Update check | Part 0 reads the list | The product maintainer: "add our wing PFM to the readers" | Manual check on the public hand-off page |
| R12 | Gov computer with Windows PowerShell 5.1 and Word 16 | Renderer | Gov-device task script (scripts/gov/Test-Environment.ps1) | Communications squadron | Format by hand with the DAFMAN template |
| R13 | GenAI.mil access | Draft cleanup | Manual check | Unit GenAI.mil access process | Draft cleanup by hand |

## 4. First-run setup screen (Part 3)

Values the installer enters, each checked before save:

| Value | Check |
|---|---|
| Wing display name (subtitle) | Not empty |
| PFM, alternate PFM (Person) | Both resolve; not the same person |
| PFM office mailbox | Valid address; R9 result decides the send mode |
| Wing members group | Resolves (R8) |
| Time zone | One of the Windows time zones; used by every date-only flow step |
| Releases list address | Read works (R11), else manual check mode |

Self-test at the end: create a fake TEST publication, run one flow round trip, read back the Activity Log row, delete the test rows. Pass = Setup Complete = Yes.

## 5. Update check

| Item | Design |
|---|---|
| Versions | App: a constant `AppVersion` (semantic version). Lists: PFM Settings row "Schema Version", written by each provisioning run. Flows: each flow writes its version to a PFM Settings row on its first run after import |
| Source | Central Releases list (Version, Release Date, Severity Security / Required / Optional, Minimum Schema Version, Notes, Package Link). **Rec:** on a SharePoint site in the same tenant (standard connector). GitHub releases feed through the RSS connector is the second choice (DoD lists it; the tenant data policy may block it) |
| Automatic | At app start, one read, wrapped in IfError. A failed read hides the banner and never blocks the app |
| Manual | "Check for updates" button on the About screen: shows installed app, schema and flow versions, the newest release, and what the update needs (data copy or re-import). If the source cannot be read, it shows the public hand-off page address |
| Banner | Shown to the PFM and alternate only. Severity Security or Required = red; Optional = neutral |
| What an update can be | Data-only (Settings, Process Steps, Guidance, Series, coordination table rows): an opt-in flow copies them after the local PFM approves. Logic (app, flows): the local PFM re-imports; the release notes list the steps |
| Rule | Keep every rule that can change in list rows, not in app or flow code, so most updates are data-only |

## 6. Open items

1. **Test** R3, R7 and R9 on the DoD tenant before the setup flow is built (go.md task).
2. Who hosts the central Releases list long term: this PFM's site (continuity risk at PCS) or an NGB-owned site (Rec, needs an owner).
3. Whether the preflight report goes by e-mail, run output or a list row (Rec: a list row plus e-mail, so it survives the 28-day run history).
