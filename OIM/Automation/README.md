# OIM Automation Scripts

Scripts for automating OIM desktop applications (Designer, Manager, Launchpad, Job Queue) and for general window capture/inspection.

---

## Python GUI Automation (`GUI/python/`)

Uses **pywinauto** with UIA (Windows UI Automation) backend. Install: `powershell .\setup.ps1`

| Script | Status | Purpose |
|---|---|---|
| `oim_find.py` | ✅ Ready | List all open OIM windows — returns JSON with handle, title, dimensions |
| `oim_inspect.py` | ✅ Ready | Dump full UIA control tree for any OIM window — use before writing new automation |
| `oim_launchpad.py` | ✅ Ready | Click tools in OIM Launchpad to open them |
| `oim_db_discover.py` | ✅ Ready | Extract live DB schema → `_meta/db_discovery.md` |
| `oim_menu_explorer.py` | ✅ Ready | Document all menus, nav trees, toolbars for any OIM tool |
| `oim_designer.py` | ❌ Not built | Mail template editor automation (control IDs verified — ready to build) |
| `oim_manager.py` | ❌ Not built | Manager navigation and interaction |
| `oim_jobqueue.py` | ❌ Not built | Job queue status reading |
| `setup.ps1` | ✅ Ready | Install Python 3.12 + pywinauto + pywin32 |

### Key Designer Control IDs (verified 2026-03-28)

| Control | auto_id | Purpose |
|---|---|---|
| Main window | `frmMain` | Designer main window |
| Navigation panel | `dockNavigation` | Left nav panel |
| Object tree | `tlcObjects` | Template list tree |
| Template name field | `editIdent_DialogRichMail` | Template identifier |
| HTML body | `m_RichEditControl[0]` | HTML body editor |
| Plain text body | `m_RichEditControl[1]` | Plain text body editor |
| Toolbar | `toolBarController` | Includes "Commit to database" button |

### Usage Examples

```powershell
# List all open OIM windows
python GUI/python/oim_find.py

# Inspect OIM Designer control tree (depth 5)
python GUI/python/oim_inspect.py "Designer" --depth 5 > GUI/data/designer_tree.txt

# Click "Designer" in Launchpad
python GUI/python/oim_launchpad.py --tool "Designer" --wait

# Refresh live DB schema
python GUI/python/oim_db_discover.py --out ../_meta/db_discovery.md
```

---

## Generated Artifacts (`GUI/data/`)

| File | Source | Description |
|---|---|---|
| `GUI_structure_designer.md` | inspect + menu_explorer | **Full Designer GUI reference** — nav tree, form fields, control IDs, inspect commands |
| `GUI_structure_manager.md` | inspect + menu_explorer | **Full Manager GUI reference** — nav categories, toolbar IDs, control IDs, inspect commands |
| `designer_menu_map.md` | `oim_menu_explorer.py` | Designer menus, nav tree, toolbars (raw capture) |
| `manager_menu_map.md` | `oim_menu_explorer.py` | Manager menus, nav categories 19 (raw capture) |
| `launchpad_menu_map.md` | `oim_menu_explorer.py` | Launchpad tool cards |
| `job_queue_menu_map.md` | `oim_menu_explorer.py` | Job Queue menus |
| `SESSION_HANDOFF.md` | Manual | Resume point for Python automation work |
| `Capture.PNG` | `capture_window.ps1` | Window screenshot |

---

## PowerShell Window Scripts (`Window/`)

Lower-level window automation via P/Invoke (Win32 API). Output to `$env:TEMP\oim_*.png`.

| Script | Purpose |
|---|---|
| `capture_window.ps1` | Screenshot any window by title substring |
| `capture_maximized.ps1` | Full-screen capture |
| `listwins.ps1` | Enumerate all visible windows |
| `explore_designer.ps1` | Navigate Designer tree, read fields |
| `extract_treeview.ps1` | Extract TreeView content via cross-process ReadProcessMemory |
| `extract_nav_tree.ps1`, `extract_nav_v2.ps1` | Designer navigation panel extraction |
| `find_root_nav.ps1`, `find_all_sections.ps1` | Schema object category discovery |
| `find_notifications.ps1`, `find_schema_mail.ps1` | Specific schema element lookup |
| `menu_scan.ps1` | Menu bar enumeration |
| `scan_basedata.ps1` | Base data category scanning |
| `nav_keyboard.ps1`, `scroll_and_capture.ps1`, `scroll_more.ps1` | Keyboard + scroll automation |
| `alt_menus.ps1` | Alt-key menu navigation |

---

## Resume: OIM Python Automation

See `GUI/data/SESSION_HANDOFF.md` for full context.

**Next step:** Run Designer and Manager inspects, then build `oim_designer.py`.

```powershell
cd OIM/Automation/GUI/python
python oim_inspect.py "Designer" --depth 5 > ../data/designer_tree.txt
python oim_inspect.py "Manager" --depth 4 > ../data/manager_tree.txt
```

**Build target:** Automate creation of AAD No-Mailbox mail templates:
- `CCC_AAD_NoMailbox_Alert`
- `CCC_AAD_NoMailbox_Escalation`
- Bodies in `Learning/Guides/AAD_NoMailbox/AAD_NoMailbox_MailTemplates_Creation_Guide.md`
