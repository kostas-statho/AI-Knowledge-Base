# OIM Designer — GUI Structure Reference

_Source: pywinauto UIA inspect + oim_menu_explorer.py_
_Window: "Designer - viadmin@STATHOPOULOSK\OneIM (Main Database)"_
_Captured: 2026-03-28 / 2026-03-30_
_Window class: WindowsForms10.Window.8.app.0.378734a_r3_ad1_
_Resolution at capture: 2576×1416 (maximised)_

---

## Window Layout

```
frmMain (id=frmMain)
├── toolStripContainer
│   ├── [toolbar area]  id=toolBarController
│   └── xtraUserControl  id=xtraUserControl
│       ├── [tab host]   id=1320004          ← open document tabs
│       ├── [Navigation] id=dockNavigation   ← left nav panel
│       └── panelContainer1
│           ├── [Tasks]  id=dockMethods      ← right tasks panel
│           └── panelContainer2              ← secondary dock
├── menuBar              id=menuBar
└── statusBar            id=statusBar
```

---

## Menu Bar

| Menu | Key Items |
|---|---|
| **Database** | New connection…, Commit to database…, Reload data, Compile database…, Change management…, Check data consistency…, Run SQL Editor…, Change password…, Settings…, Exit |
| **Process plan** | New, Delete, Start process plan now, Show captions, Refresh |
| **View** | Properties, Navigation, Tasks, Error log, Object import, Search, Close current/all documents, Enable document (submenu), Layout (submenu), Enable quick edit mode |
| **Help** | Process automation help, Community, Support portal, Training, Online documentation, Designer help, Transport history, Info… |

---

## Navigation Panel (id=dockNavigation)

### Top-level Nav Buttons
Clicking each button changes the tree below to that category's objects.

| Button Text | Category | Primary Tree ID |
|---|---|---|
| Getting Started | Quick links to admin tasks | `Navigator` (id=Navigator) |
| One Identity Manager Schema | DB schema — tables, columns, FKs | — |
| Permissions | System user roles and permissions | — |
| Process Orchestration | Process chains, job servers, schedules | `id=658132` (named 67054 in earlier capture) |
| Script Library | VB.NET scripts stored in the DB | — |
| User Interface | Forms, display templates, column defs | — |
| Mail Templates | All DialogRichMail templates | `id=tlcObjects` |
| Documentation | Change tags, documentation entries | — |
| Base Data | System config: languages, countries, etc. | — |
| My Designer | Personal favourites and recent items | — |

---

## Navigation Tree Nodes (verified per category)

### Getting Started (Navigator id=Navigator)
- Getting Started ← root
  - Create system user
  - Edit configuration parameters
  - Edit Job server
  - Edit schedules (64)

### Process Orchestration (TREE id=658132)
Shown when "Process Orchestration" nav button is active.
- Processes
- Customised processes
- Custom processes
- Process automation
- Objects without processes
- Process components
- Single object operations
- Object events

### Process Orchestration — Schedule sub-tree (TREE id=tlcJobAutoStarts)
Shown when "Edit schedules" is selected in Getting Started or Processes.
Active schedules in this environment (38 total):
- Activate deactivated applications
- Microsoft Entra ID delta synchronization
- Calculate attestation objects
- Cancel registration of new external users after final timeout
- **CCC_AADUser_SendNoMailboxAlert** ← custom
- **CCC_AADUser_SendNoMailboxEscalate** ← custom
- CCC_SendMailBeforeExpire ← custom
- Checks if patches are available for synchronization projects
- Check status of provisioning processes
- Clean up application role "Request & Fulfillment\IT Shop\Product owners"
- _(…22 more OIM-standard schedules)_

### Mail Templates (TREE id=tlcObjects)
Shown when "Mail Templates" nav button is active.
Active templates in this environment (3 currently visible):
- CCC_15daysBeforeExpire ← custom
- Onboarding_Success ← custom
- SystemRole_Membership_Lost ← custom

> **Note:** The full template list requires scrolling. Use `--filter Tree` inspect after
> clicking "Mail Templates" nav button to get all entries.

---

## Toolbar (id=toolBarController)

| Position | Name | Auto ID | Enabled By Default |
|---|---|---|---|
| 1 | Commit to database | — | Yes |
| 2 | Back | — | Yes (context) |
| 3 | Next | — | No (context) |
| 4 | (unnamed) | — | Yes |
| 5 | (unnamed) | — | Yes |
| — | Search label + input | id=ConfigTextbox | — |

---

## Form Fields — Mail Template Editor

When a mail template is open (e.g. from tlcObjects → double-click):

| Field Label | Control ID | Type | Notes |
|---|---|---|---|
| Name (Ident) | `edtName` → child `TextBox` | EDIT | Template identifier, e.g. `CCC_AADUser_SendNoMailboxAlert` |
| Subject display | (unnamed EDIT) | EDIT | Shows "CCC_SendNoMailboxEscalate - AADUser" format |
| max. runtime | `edtStopTime` → child `TextBox` | EDIT | Schedule max runtime setting |
| HTML body | `m_RichEditControl[0]` | Custom/RichEdit | HTML content — requires SendKeys or clipboard paste |
| Plain text body | `m_RichEditControl[1]` | Custom/RichEdit | Plain text fallback |

> **Confirmed via --filter Edit inspect (2026-03-30):**
> `edtName`, `edtStopTime`, unnamed subject EDIT, `textBox` (general purpose)

---

## Key Control ID Summary (for pywinauto scripts)

```python
# Window
app.window(title_re="Designer.*")           # attach to Designer window
win = app["Designer - viadmin@..."]

# Navigation panel
nav = win.child_window(auto_id="dockNavigation")

# Click a nav category button (by text)
nav.child_window(title="Mail Templates", control_type="Button").click()

# Object tree (Mail Templates category)
tree = win.child_window(auto_id="tlcObjects")
node = tree.get_item(["CCC_15daysBeforeExpire"])  # or iterate .children()

# Schedule tree (Getting Started / Process Orchestration)
sched_tree = win.child_window(auto_id="tlcJobAutoStarts")

# Toolbar — Save / Commit
toolbar = win.child_window(auto_id="toolBarController")
toolbar.child_window(title="Commit to database").click()

# Mail template form fields (when template is open)
name_field = win.child_window(auto_id="edtName").child_window(auto_id="TextBox")
name_field.set_text("CCC_MyTemplate")
```

---

## Inspect Commands (run these to refresh this file)

```powershell
cd "C:\Users\OneIM\Knowledge_Base\OIM\Automation\GUI\python"

# Full tree (depth 10)
python oim_inspect.py "Designer" --depth 10 > ../data/designer_tree.txt

# Nav tree only
python oim_inspect.py "Designer" --filter Tree --depth 10

# Form fields when template is open
python oim_inspect.py "Designer" --filter Edit --depth 10

# Grid controls (for list views)
python oim_inspect.py "Designer" --filter Grid --depth 10

# After clicking a nav button (to see that category's tree)
# 1. Click "Mail Templates" in the Designer nav panel
# 2. Then run: python oim_inspect.py "Designer" --filter Tree --depth 10
```

---

## Known Gaps (pending deeper inspect)

| Category | What's Missing |
|---|---|
| One Identity Manager Schema | Table/column browser tree structure, Schema Extension form field IDs |
| Permissions | System user role tree node IDs |
| Script Library | Script category tree, script editor field IDs |
| User Interface | Form category tree, display template IDs |
| Mail Templates | Full list of ALL templates (tree has more than 3 visible currently) |
| Template editor | `m_RichEditControl[0]` and `[1]` exact interaction method (clipboard vs SendKeys) |
| Process Orchestration | Sub-tree under "Custom processes" — expand nodes to see custom chains |

> To fill gaps: open the relevant Designer nav category, then run `python oim_inspect.py "Designer" --filter Tree --depth 10`.
