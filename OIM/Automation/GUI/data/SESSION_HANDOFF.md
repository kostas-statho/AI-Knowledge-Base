# OIM Python GUI Automation — Session Handoff

> **Resume point:** Python is now installed. Pick up from Step 4 below.
> All scripts are written and ready. We just need Designer + Manager control trees, then build the interaction layer.

---

## What We Are Building

A Python automation suite using `pywinauto` that can:
1. Discover open OIM windows
2. Inspect their control trees (read-only)
3. Click Launchpad tool buttons to open tools
4. Navigate Designer tree, create/edit mail templates, processes, schema extensions
5. Read Job Queue status

Integrates with Claude Code — after each action, captures a screenshot PNG that Claude reads via vision to verify results.

---

## Scripts Written (all in this folder)

| File | Status | Purpose |
|---|---|---|
| `setup.ps1` | Done | Installs Python 3.12 + pywinauto + pywin32 |
| `oim_find.py` | Done | Lists all open OIM windows (read-only) |
| `oim_inspect.py` | Done | Dumps full control tree of any OIM window |
| `oim_launchpad.py` | Done | Clicks Run buttons in the Launchpad |
| `oim_designer.py` | **NOT YET** | Navigate Designer tree, edit fields |
| `oim_manager.py` | **NOT YET** | Navigate Manager, edit objects |
| `oim_jobqueue.py` | **NOT YET** | Read Job Queue grid rows |

---

## Step 1 — Verify Python and packages

```powershell
python --version
python -c "import pywinauto; print('pywinauto OK:', pywinauto.__version__)"
python -c "import win32gui; print('pywin32 OK')"
```

If packages are missing:
```powershell
pip install pywinauto pywin32
```

---

## Step 2 — Verify existing scripts work

```powershell
cd "C:\Users\OneIM\Knowledge_Base\Scripts\OIM_Automation"

# List open OIM windows
python oim_find.py

# List Launchpad tools
python oim_launchpad.py list
```

Expected from `oim_find.py` (these were open in the previous session):
- `Designer - viadmin@STATHOPOULOSK\OneIM (Main Database)`
- `Manager - viadmin@STATHOPOULOSK\OneIM (Main Database)`
- `Launchpad`

---

## Step 3 — Inspect Designer and Manager (CRITICAL — do this first)

These inspects were NOT completed in the previous session (Python wasn't in PATH for the bash shell). Run them now and paste the output to Claude.

```powershell
python oim_inspect.py "Designer" --depth 5 > designer_tree.txt
python oim_inspect.py "Manager" --depth 4 > manager_tree.txt
```

Then show Claude both files:
```powershell
Get-Content designer_tree.txt
Get-Content manager_tree.txt
```

Claude needs this output to know the **exact control IDs** for:
- The navigation tree panel in Designer
- The property grid fields (Name, Base object, Subject, Body)
- The toolbar buttons (Save, Compile, New)
- The Manager object list grid and form fields

---

## Step 4 — What Claude will build from the inspect output

Once Designer and Manager trees are provided, Claude will write:

### `oim_designer.py`
Functions to:
- `navigate_to(node_path)` — expand tree and select a node, e.g. `["Notifications", "Mail templates"]`
- `right_click_new()` — right-click selected node → New
- `set_field(field_name, value)` — write to a property grid field by label
- `get_field(field_name)` — read a property grid field value
- `save()` — click Save / Ctrl+S
- `compile()` — trigger database compile

### `oim_jobqueue.py`
Functions to:
- `get_all_rows()` — read entire Job Queue grid
- `get_frozen()` — return only Frozen rows
- `get_errors()` — return only Error rows
- `wait_for_process(name, timeout)` — poll until process finishes

---

## Step 5 — Build target: Mail Template creation end-to-end

The ultimate goal for this sprint: automate creating the two mail templates for the AAD No-Mailbox alerting process (designed in the documentation session):

**Template 1:** `CCC_AAD_NoMailbox_Alert`
- Base object: `AADUser`
- Importance: High
- Subject: `[ACTION REQUIRED] AAD account '$DisplayName$' has no EXO mailbox (created: $XDateInserted$)`
- HTML body: in `Docs/AAD_NoMailbox_MailTemplates_Intragen.html` (Section 3)
- Plain-text body: in same document

**Template 2:** `CCC_AAD_NoMailbox_Escalation`
- Base object: `AADUser`
- Importance: High
- Subject: `[ESCALATION] AAD account '$DisplayName$' STILL has no EXO mailbox — 4hrs since $XDateInserted$`
- HTML body + plain-text: in `Docs/AAD_NoMailbox_MailTemplates_Intragen.html` (Section 4)

---

## Key Technical Findings from Previous Session

### Launchpad control structure (confirmed via oim_inspect.py)

Every tool card follows this exact pattern:
```
[PANE id=TaskControl]
  └── [PANE id=panelText]
        ├── [label id=lblTitle]   ← tool name text, e.g. "Designer"
        └── [BUTTON id=btnRun]   ← click this to launch
```

Navigation categories on left panel:
- `id=NavigationButton`: "Manage", "Configure", "Change Extend", "Tools", "Documentation", "Favorites", "Search"

Connected as: `STATHOPOULOSK\OneIM` — Development system, user `viadmin`

### pywinauto approach confirmed

- Backend: `uia` (Windows UI Automation) — correct for OIM WinForms/.NET apps
- Find windows via: `Desktop(backend="uia").windows()`
- Find controls via: `win.child_window(auto_id="controlId")`
- All OIM buttons have unique `auto_id` values matching their Designer control names

### Why `allowed-tools` in skill frontmatter doesn't restrict tools
Known pywinauto GitHub issue #18837 — not enforced. Documented but not relied upon.

---

## Commands Quick Reference

```powershell
cd "C:\Users\OneIM\Knowledge_Base\Scripts\OIM_Automation"

# Discovery
python oim_find.py                          # list OIM windows
python oim_find.py --watch                  # watch for new windows

# Inspection (read-only, safe)
python oim_inspect.py Launchpad --depth 3
python oim_inspect.py Designer --depth 5
python oim_inspect.py Manager --depth 4
python oim_inspect.py Designer --filter Tree    # only tree controls
python oim_inspect.py Designer --filter Edit    # only text fields
python oim_inspect.py Designer --filter Grid    # only grids

# Launchpad
python oim_launchpad.py list                    # list all tools
python oim_launchpad.py run Designer --wait     # open Designer and wait
python oim_launchpad.py run "Job Queue Info" --wait
python oim_launchpad.py run Designer --dry-run  # simulate only
```

---

## Related Documents (Knowledge Base)

| Document | Location | Content |
|---|---|---|
| Mail Template HTML doc | `Docs/AAD_NoMailbox_MailTemplates_Intragen.html` | Full template bodies, process design, troubleshooting |
| OIM Discover skill | `.claude/commands/oim-discover.md` | Screenshot + vision analysis skill |
| Process flowchart | `image (15).png` | Original process diagram we are implementing |

---

## Prompt to start the new session

Paste this to Claude at the start of the new session:

> I'm continuing OIM Python GUI automation work. Python is now installed. All scripts are in `C:\Users\OneIM\Knowledge_Base\Scripts\OIM_Automation\`. Please read `SESSION_HANDOFF.md` in that folder and pick up from Step 3 — I need to run the Designer and Manager inspects and then build `oim_designer.py` and `oim_jobqueue.py`.
