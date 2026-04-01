# OIM Manager — GUI Structure Reference

_Source: pywinauto UIA inspect + oim_menu_explorer.py_
_Window: "Manager - viadmin@STATHOPOULOSK\OneIM (Main Database)"_
_Captured: 2026-03-28 / 2026-03-30_
_Window class: WindowsForms10.Window.8.app.0.33c0d9d_r3_ad1_
_Resolution at capture: 2576×1416 (maximised)_

---

## Window Layout

```
SessionForm (id=SessionForm)
├── m_ToolStripContainer (id=m_ToolStripContainer)
│   └── m_DockingArea (id=m_DockingArea)
│       ├── id=133032          ← result list pane
│       ├── id=68424           ← document/form pane
│       └── Navigation (id=m_DockNavigation) ← left nav
├── m_ToolBarMain (id=m_ToolBarMain)  ← main toolbar
├── m_MenuMain   (id=m_MenuMain)      ← menu bar
└── m_StatusBar  (id=m_StatusBar)
```

---

## Menu Bar (id=m_MenuMain)

| Menu | Key Items |
|---|---|
| **Database** | New connection…, Close connection, Start simulation, Change management…, Export data, Show deferred operations, Pending changes, Check data consistency…, Change password…, Settings…, Exit |
| **Object** | New (ctx), Save (ctx), Define scheduled time (ctx), Delete (ctx), Schedule delete… (ctx), Discard changes (ctx), Reload, Properties… (ctx), Reapply templates (ctx), Add to favorites, Back, Forward |
| **View** | Navigation, Result list, Documents, Favorites, Tasks, Error log, Process information, Object import, Database search, Home, Close current/all documents, Enable document (submenu), Layout (submenu), Enable quick edit mode, Show field definition |
| **Help** | Community, Support portal, Training, Online documentation, Form help, Info… |

> *(ctx)* = context-sensitive, disabled unless an object is selected.

---

## Toolbar (id=m_ToolBarMain)

| # | Name | Notes |
|---|---|---|
| 1 | Home | Always enabled — returns to Home panel |
| — | separator | — |
| 3 | Back | Context — disabled if no nav history |
| 4 | Forward | Context — disabled if no nav history |
| — | separator | — |
| 6 | Database search | Always enabled |
| — | label (spacer) | Wide label used as search box label |
| 7 | New | Context — disabled if no nav node selected |
| 8 | Save | Context — disabled until object is dirty |
| 9–12 | (unnamed) | Context — Delete, Reload, etc. |
| 13 | (unnamed) | Always enabled |
| — | separator | — |
| 15 | (unnamed) | Always enabled |

---

## Navigation Panel (id=m_DockNavigation)

### Top-level Nav Category Buttons
Each button loads that domain's object tree into the left panel.

| Button Text | Domain | Key OIM Tables |
|---|---|---|
| Identities | Persons, accounts, employee data | Person, ADSAccount, AADUser |
| Organizations | Departments, cost centres | Department, ProfitCenter, Locality |
| Business Roles | Org tree roles | Org, BaseTree, PersonInOrg |
| Entitlements | AD groups, system roles, service items | ESet, AccProduct, ADSGroup |
| IT Shop | Requests, shelves, approvals | PersonWantsOrg, ITShopOrg, AccProduct |
| Attestation | Policies, runs, cases | AttestationPolicy, AttestationRun, AttestationCase |
| Identity Audit | Compliance, SOD, risk | NonCompliance, QERPolicy, QERRiskIndex |
| Company Policies | QER policies | QERPolicy |
| Report Subscriptions | Scheduled reports | ReportSubscription |
| Unified Namespace | UNS objects | UNS* tables |
| Custom Target Systems | Custom-defined target systems | UNS* / custom |
| Active Directory | AD domains, accounts, groups | ADSDomain, ADSAccount, ADSGroup |
| Universal Cloud Interface | UCI connector objects | UCI* tables |
| Cloud Target Systems | CSM objects | CSM* tables |
| Microsoft Entra ID | AAD users, groups, orgs | AADUser, AADGroup, AADOrganization |
| Data synchronization | Sync projects and journals | DPRProjectionConfig, DPRJournal |
| One Identity Manager Administration | Job servers, schedules, DB queue | JobQueue, JobHistory, DPRShell |
| Devices & Workdesks | Hardware / workdesk objects | Hardware, Workdesk |
| My One Identity Manager | User favourites, personal filters | — |

### Home Panel (TREE id=199334)
Shown on first load (no nav category selected):
- Info system
- IT Shop wizards
- Organizational overviews
- Target system overviews
- Data quality analysis
- Filters

---

## Nav Sub-tree Structure (key categories)

> Sub-trees are dynamically loaded when a nav button is clicked.
> Run `python oim_inspect.py "Manager" --filter Tree --depth 10` after clicking
> a nav category to capture the full sub-tree.

### Identities (typical sub-tree)
```
Identities
├── Employees                     ← Person, IsExternal=0
├── External users
├── Service accounts
├── Shared mailboxes
├── System users
└── User accounts
    ├── Active Directory
    ├── Microsoft Entra ID
    └── ...
```

### Active Directory (typical sub-tree)
```
Active Directory
├── Domains                       ← ADSDomain
├── User accounts                 ← ADSAccount
├── Groups                        ← ADSGroup
├── Containers                    ← ADSContainer
└── Computers
```

### IT Shop (typical sub-tree)
```
IT Shop
├── Service catalog               ← AccProduct
├── Shelves / categories          ← ITShopOrg
├── Shopping cart                 ← PersonWantsOrg (OrderState=New)
├── Pending requests
└── Request history               ← PersonWantsOrg (all states)
```

---

## Form Fields — Object Editor

> Manager opens one form per object. Form field control IDs vary by object type.
> Use `python oim_inspect.py "Manager" --filter Edit --depth 10` after opening a
> specific object form to get its field IDs.

### Common form field patterns

```python
# After navigating to an object and opening its form:
form = win.child_window(auto_id="68424")           # document pane

# Standard text field (most OIM forms):
field = form.child_window(title="<FieldLabel>", control_type="Edit")

# Or by auto_id (use --filter Edit to discover):
name_field = form.child_window(auto_id="<edit_auto_id>")
name_field.set_text("new value")

# Save button
win.child_window(auto_id="m_ToolBarMain").child_window(title="Save").click()
```

### Known form control IDs (general)
| Control | ID | Notes |
|---|---|---|
| Nav panel | `m_DockNavigation` | Left panel |
| Result list | `133032` | Middle list of objects |
| Document area | `68424` | Right form/editor |
| Toolbar Save | title="Save" in `m_ToolBarMain` | Context-enabled |
| Toolbar New | title="New" in `m_ToolBarMain` | Context-enabled |

---

## Key Control ID Summary (for pywinauto scripts)

```python
from pywinauto import Desktop

app = Desktop(backend="uia")
win = app.window(title_re="Manager.*OneIM.*")

# Navigation
nav = win.child_window(auto_id="m_DockNavigation")

# Click a nav category (by exact button text)
nav.child_window(title="Identities", control_type="Button").click()
nav.child_window(title="Active Directory", control_type="Button").click()

# Toolbar actions
toolbar = win.child_window(auto_id="m_ToolBarMain")
toolbar.child_window(title="New").click()
toolbar.child_window(title="Save").click()
toolbar.child_window(title="Database search").click()

# Result list (after nav category loaded)
result_list = win.child_window(auto_id="133032")

# Document/form pane (when object is open)
doc_pane = win.child_window(auto_id="68424")
```

---

## Inspect Commands (run these to refresh this file)

```powershell
cd "C:\Users\OneIM\Knowledge_Base\OIM\Automation\GUI\python"

# Full tree (depth 10)
python oim_inspect.py "Manager" --depth 10 > ../data/manager_tree.txt

# Nav tree only (run AFTER clicking a nav button)
python oim_inspect.py "Manager" --filter Tree --depth 10

# Form fields when object is open
python oim_inspect.py "Manager" --filter Edit --depth 10

# Grid controls (result lists, grids)
python oim_inspect.py "Manager" --filter Grid --depth 10
```

---

## Known Gaps (pending deeper inspect)

| Category | What's Missing |
|---|---|
| Identities | Sub-tree node IDs for Employees, External users, etc. |
| Identities / Person form | Form field auto_id values for Name, CentralAccount, Email, etc. |
| Active Directory / Group form | Field IDs for CN, DistinguishedName, GroupType |
| IT Shop / Request form | Field IDs for product selection, justification, valid-until |
| Attestation / Case form | Field IDs for decision (Approve/Deny), justification |
| Result list grid | Grid column IDs for sorting/filtering programmatically |
| Navigation breadcrumb | How to read current nav path from control tree |

> To fill gaps:
> 1. Click the relevant nav category in Manager
> 2. Open a specific object
> 3. Run `python oim_inspect.py "Manager" --filter Edit --depth 10`
> 4. Update the Known Gaps section with discovered IDs
