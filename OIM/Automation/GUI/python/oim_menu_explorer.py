"""
oim_menu_explorer.py — Systematically map all menus, navigation trees,
                        tab pages, and toolbars in OIM GUI tools.

Produces one structured .md file per tool:
  designer_menu_map.md, manager_menu_map.md,
  launchpad_menu_map.md, job_queue_menu_map.md

Usage:
  python oim_menu_explorer.py Designer
  python oim_menu_explorer.py Manager
  python oim_menu_explorer.py Launchpad
  python oim_menu_explorer.py "Job Queue"
  python oim_menu_explorer.py --all
  python oim_menu_explorer.py --all --screenshot --expand-tree

Safe: read-only for nav tree and toolbar. Menu bar requires clicks (opens
      and immediately closes each dropdown). --expand-tree expands nav nodes
      (irreversible — nodes stay expanded after the run).

Imports find_window() and take_window_screenshot() from oim_inspect.py.
"""

import sys
import os
import time
import argparse
from datetime import datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

try:
    from pywinauto import Desktop
    from pywinauto.keyboard import send_keys
except ImportError:
    print("ERROR: pywinauto not installed. Run: pip install pywinauto pywin32")
    sys.exit(1)

# Import shared helpers from sibling script
_script_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, _script_dir)
try:
    from oim_inspect import find_window, take_window_screenshot
except ImportError as e:
    print(f"ERROR: Could not import oim_inspect — {e}")
    print("Ensure oim_inspect.py is in the same folder as this script.")
    sys.exit(1)


# ─────────────────────────────────────────────────────────────────────────────
# Tool configuration (all IDs confirmed via live oim_inspect.py runs 2026-03-28)
# ─────────────────────────────────────────────────────────────────────────────

TOOL_CONFIG = {
    "designer": {
        "title_fragment": "Designer",
        "display_name":   "OIM Designer",
        "menu_bar_id":  "menuBar",           # confirmed
        "toolbar_id":   "toolBarController", # confirmed: Commit/Back/Next + Search
        "nav_pane_id":  "dockNavigation",    # confirmed: 10 category buttons
        "nav_tree_ids": ["Navigator", "tlcObjects"],  # Getting Started + object list
        "tab_ids":      ["tabControl"],      # Properties / Parameters / Extended
        "output_slug":  "designer",
    },
    "manager": {
        "title_fragment": "Manager",
        "display_name":   "OIM Manager",
        "menu_bar_id":  "m_MenuMain",        # confirmed: Database / Object / View / Help
        "toolbar_id":   "m_ToolBarMain",     # confirmed: Home/Back/Forward/Search/New/Save (12 btns)
        "nav_pane_id":  "m_DockNavigation",  # confirmed: 19 navigation category buttons
        "nav_tree_ids": [],                  # sub-category trees discovered at runtime (e.g. id=68400)
        "tab_ids":      ["tabControl"],      # id="Home" by default; expands when object selected
        "output_slug":  "manager",
    },
    "launchpad": {
        "title_fragment": "Launchpad",
        "display_name":   "OIM Launchpad",
        "menu_bar_id":  None,
        "toolbar_id":   None,
        "nav_pane_id":  None,     # 7 category buttons found via NavigationButton controls
        "nav_tree_ids": [],
        "tab_ids":      [],
        "output_slug":  "launchpad",
    },
    "jobqueue": {
        "title_fragment": "JobQueueInfo",   # actual title: "JobQueueInfo.net - ..." (no space)
        "display_name":   "OIM Job Queue Info",
        "menu_bar_id":  None,               # discovered at runtime: Database/Filter/View/Help
        "toolbar_id":   None,               # discovered at runtime: 15 buttons (icon-only, unnamed)
        "nav_pane_id":  None,
        "nav_tree_ids": ["tlcJobChains"],   # confirmed via runtime discovery
        "tab_ids":      [],
        "output_slug":  "job_queue",
    },
}


# ─────────────────────────────────────────────────────────────────────────────
# CLI
# ─────────────────────────────────────────────────────────────────────────────

def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        description="Map all menus, nav trees, tab pages, and toolbars of OIM GUI tools."
    )
    p.add_argument(
        "tool", nargs="?",
        help="Tool to explore: Designer, Manager, Launchpad, or 'Job Queue'",
    )
    p.add_argument(
        "--all", action="store_true",
        help="Explore all 4 tools sequentially",
    )
    p.add_argument(
        "--screenshot", action="store_true",
        help="Save a PNG of each tool window (requires: pip install pillow)",
    )
    p.add_argument(
        "--expand-tree", action="store_true",
        help="Expand collapsed nav tree nodes before walking (NOTE: irreversible)",
    )
    p.add_argument(
        "--depth", type=int, default=8,
        help="Max depth for nav tree traversal (default: 8)",
    )
    p.add_argument(
        "--out", type=str, default=_script_dir,
        help="Output directory for .md files (default: script folder)",
    )
    return p


def normalize_tool_slug(name: str) -> str:
    """Map user-supplied name to a TOOL_CONFIG key."""
    n = name.lower().replace(" ", "").replace("_", "").replace("-", "")
    mapping = {
        "designer":      "designer",
        "manager":       "manager",
        "launchpad":     "launchpad",
        "jobqueue":      "jobqueue",
        "jobqueueinfo":  "jobqueue",
    }
    return mapping.get(n, n)


# ─────────────────────────────────────────────────────────────────────────────
# Section 1: Menu Bar
# ─────────────────────────────────────────────────────────────────────────────

def _find_by_automation_id(win, auto_id: str):
    """Find a descendant control by exact automation_id. More reliable than child_window()."""
    try:
        for d in win.descendants():
            try:
                if d.element_info.automation_id == auto_id:
                    return d
            except Exception:
                pass
    except Exception:
        pass
    return None


def _find_menu_bar(win, config: dict):
    """Locate the application menu bar; returns control or None."""
    # Primary: known auto_id — use descendants() for reliable lookup
    if config.get("menu_bar_id"):
        mb = _find_by_automation_id(win, config["menu_bar_id"])
        if mb is not None:
            return mb

    # Fallback: any MenuBar descendant that is not the system/title-bar menu
    try:
        candidates = [
            m for m in win.descendants(control_type="MenuBar")
            if m.element_info.automation_id not in ("MenuBar", "")
        ]
        if candidates:
            return candidates[0]
        all_mb = win.descendants(control_type="MenuBar")
        if all_mb:
            return all_mb[0]
    except Exception:
        pass

    return None



def _is_expandable(ctrl) -> bool:
    """
    Return True if the control's UIA ExpandCollapse state is Collapsed (0) or
    PartiallyExpanded (2) — meaning it has sub-items. State 3 = LeafNode = no children.
    """
    try:
        # UIA_ExpandCollapseStatePropertyId = 30070
        state = ctrl.element_info.element.GetCurrentPropertyValue(30070)
        # 0=Collapsed, 1=Expanded, 2=PartiallyExpanded, 3=LeafNode
        return state in (0, 2)
    except Exception:
        # Fallback: check if it has any children
        try:
            return len(ctrl.children()) > 0
        except Exception:
            return False


def _enumerate_menu_children(menu_ctrl, depth: int = 0, max_depth: int = 4) -> list:
    """
    Enumerate children of an expanded menu or Menu container.
    WinForms UIA pattern: MenuItem.expand() → child [Menu] → children [MenuItem, ...]
    Returns list of {"name", "shortcut", "enabled", "items"} dicts.
    """
    if depth > max_depth:
        return []
    results = []
    try:
        children = menu_ctrl.children()
    except Exception:
        return results

    for child in children:
        ct = child.element_info.control_type or ""

        # WinForms: expanded MenuItem has one [Menu] child — unwrap it
        if ct == "Menu":
            results.extend(_enumerate_menu_children(child, depth, max_depth))
            continue

        raw = child.window_text() or child.element_info.name or ""

        if ct == "MenuItem":
            name, _, shortcut = raw.partition("\t")
            name = name.strip()
            if not name:
                continue

            enabled = True
            try:
                enabled = child.is_enabled()
            except Exception:
                pass

            sub_items = []
            if depth < max_depth and _is_expandable(child):
                try:
                    child.expand()
                    time.sleep(0.2)
                    sub_items = _enumerate_menu_children(child, depth + 1, max_depth)
                    child.collapse()
                    time.sleep(0.1)
                except Exception:
                    pass

            results.append({
                "name": name,
                "shortcut": shortcut.strip(),
                "enabled": enabled,
                "items": sub_items,
            })
        elif ct == "Separator":
            results.append({"name": "---", "shortcut": "", "enabled": True, "items": []})

    return results


def explore_menu_bar(win, config: dict) -> list:
    """
    Expand each top-level menu item via UIA ExpandCollapse, capture sub-items, collapse.
    Returns list of {"name", "shortcut", "enabled", "items"} dicts.
    """
    mb = _find_menu_bar(win, config)
    if mb is None:
        return []

    try:
        top_items = mb.children(control_type="MenuItem")
        if not top_items:
            top_items = mb.children()
    except Exception:
        return []

    results = []
    for item in top_items:
        raw = item.window_text() or item.element_info.name or ""
        name, _, shortcut = raw.partition("\t")
        name = name.strip()
        if not name:
            continue

        enabled = True
        try:
            enabled = item.is_enabled()
        except Exception:
            pass

        sub_items = []
        if enabled:
            expanded = False
            try:
                item.expand()
                expanded = True
                time.sleep(0.3)
                sub_items = _enumerate_menu_children(item)
            except Exception as e:
                # Fallback: try click_input if expand() fails
                try:
                    item.click_input()
                    expanded = True
                    time.sleep(0.3)
                    sub_items = _enumerate_menu_children(item)
                except Exception:
                    sub_items = [{"name": f"<expand error: {e}>", "shortcut": "",
                                  "enabled": False, "items": []}]
            finally:
                if expanded:
                    try:
                        item.collapse()
                        time.sleep(0.15)
                    except Exception:
                        try:
                            send_keys("{ESCAPE}")
                            time.sleep(0.15)
                        except Exception:
                            pass

        results.append({
            "name": name,
            "shortcut": shortcut.strip(),
            "enabled": enabled,
            "items": sub_items,
        })

    return results


# ─────────────────────────────────────────────────────────────────────────────
# Section 2: Navigation Tree
# ─────────────────────────────────────────────────────────────────────────────

def _walk_tree(tree_ctrl, expand: bool, max_depth: int, depth: int = 0) -> list:
    """Depth-first walk of a Tree control's TreeItem children."""
    nodes = []
    try:
        items = tree_ctrl.children(control_type="TreeItem")
    except Exception:
        return nodes

    for item in items:
        name = item.window_text() or item.element_info.name or ""

        has_children = False
        try:
            has_children = len(item.children(control_type="TreeItem")) > 0
        except Exception:
            pass

        if not has_children:
            # Check UIA ExpandCollapse state (3 = LeafNode = no children)
            try:
                from comtypes import COMError
                state = item.element_info.element.GetCurrentPropertyValue(30070)
                # 0=Collapsed, 1=Expanded, 2=PartiallyExpanded, 3=LeafNode
                has_children = (state != 3)
            except Exception:
                pass

        children = []
        if depth < max_depth:
            if expand and has_children:
                try:
                    item.expand()
                    time.sleep(0.2)
                except Exception:
                    pass
            children = _walk_tree(item, expand=expand, max_depth=max_depth, depth=depth + 1)

        nodes.append({
            "name": name,
            "depth": depth,
            "has_children": has_children,
            "children": children,
        })

    return nodes


def explore_nav_tree(win, config: dict, expand: bool = False, max_depth: int = 8) -> list:
    """
    Walk navigation trees and NavBar category buttons.
    Returns list of {"source", "type", "nodes"/"items"} dicts.
    """
    results = []
    captured_ids = set()

    # Pass A: known tree IDs
    for tree_id in config.get("nav_tree_ids", []):
        try:
            tree = win.child_window(auto_id=tree_id, control_type="Tree")
            nodes = _walk_tree(tree, expand=expand, max_depth=max_depth)
            results.append({"source": tree_id, "type": "tree", "nodes": nodes})
            captured_ids.add(tree_id)
        except Exception:
            pass

    # Pass B: NavBar / category button panel — use descendants() for reliable lookup
    nav_pane_id = config.get("nav_pane_id")
    if nav_pane_id:
        pane = _find_by_automation_id(win, nav_pane_id)
        if pane is not None:
            # Filter out system/chrome buttons like Close, Auto Hide, Pin, Maximize, Configure
            _CHROME_BUTTONS = {"close", "auto hide", "pin", "maximize", "minimize",
                               "expand", "configure buttons", "show window list"}
            buttons = []
            seen_names = set()
            for child in pane.descendants():
                try:
                    ct = child.element_info.control_type or ""
                    name = child.window_text() or child.element_info.name or ""
                    name = name.strip()
                    if ct in ("Button", "Custom") and name:
                        if name.lower() not in _CHROME_BUTTONS and name not in seen_names:
                            seen_names.add(name)
                            buttons.append({"name": name, "type": ct.lower()})
                except Exception:
                    pass
            if buttons:
                results.append({"source": nav_pane_id, "type": "nav_buttons", "items": buttons})

    # Launchpad: enumerate NavigationButton category pills + tool cards
    if config.get("output_slug") == "launchpad":
        try:
            nav_btns = []
            tool_cards = []
            for child in win.descendants():
                try:
                    aid = child.element_info.automation_id or ""
                    name = child.window_text() or child.element_info.name or ""
                    if aid == "NavigationButton" and name:
                        nav_btns.append(name)
                    elif aid == "lblTitle" and name:
                        tool_cards.append(name)
                except Exception:
                    pass
            if nav_btns:
                results.append({
                    "source": "NavigationButton",
                    "type": "nav_buttons",
                    "items": [{"name": n, "type": "button"} for n in nav_btns],
                })
            if tool_cards:
                results.append({
                    "source": "tool_cards",
                    "type": "tool_list",
                    "items": [{"name": n, "type": "tool"} for n in tool_cards],
                })
        except Exception:
            pass

    # Pass C: generic Tree fallback
    try:
        for tree in win.descendants(control_type="Tree"):
            aid = tree.element_info.automation_id or ""
            if aid in captured_ids:
                continue
            nodes = _walk_tree(tree, expand=expand, max_depth=max_depth)
            if nodes:
                results.append({"source": aid or "tree", "type": "tree", "nodes": nodes})
                captured_ids.add(aid)
    except Exception:
        pass

    return results


# ─────────────────────────────────────────────────────────────────────────────
# Section 3: Toolbar
# ─────────────────────────────────────────────────────────────────────────────

def explore_toolbar(win, config: dict) -> list:
    """
    Enumerate all toolbar buttons.
    Returns list of {"name", "auto_id", "enabled", "tooltip"} dicts.
    """
    toolbar = None

    # Primary: known ID — use descendants() for reliable lookup
    if config.get("toolbar_id"):
        toolbar = _find_by_automation_id(win, config["toolbar_id"])

    # Fallback: toolbar with most Button children (most likely the main one)
    if toolbar is None:
        try:
            best, best_count = None, 0
            for tb in win.descendants(control_type="ToolBar"):
                try:
                    cnt = len(tb.children(control_type="Button"))
                    if cnt > best_count:
                        best, best_count = tb, cnt
                except Exception:
                    pass
            toolbar = best
        except Exception:
            pass

    if toolbar is None:
        return []

    buttons = []
    try:
        for child in toolbar.children():
            ct = child.element_info.control_type or ""
            if ct == "Button":
                name = child.window_text() or child.element_info.name or ""
                auto_id = child.element_info.automation_id or ""
                enabled = True
                try:
                    enabled = child.is_enabled()
                except Exception:
                    pass

                tooltip = ""
                try:
                    tooltip = child.element_info.element.GetCurrentPropertyValue(30013) or ""
                except Exception:
                    pass

                buttons.append({
                    "name": name or auto_id or "(unnamed)",
                    "auto_id": auto_id,
                    "enabled": enabled,
                    "tooltip": str(tooltip).strip(),
                })
            elif ct == "Separator":
                buttons.append({"name": "---", "auto_id": "", "enabled": True, "tooltip": ""})
    except Exception:
        pass

    return buttons


# ─────────────────────────────────────────────────────────────────────────────
# Section 4: Tab Pages
# ─────────────────────────────────────────────────────────────────────────────

def explore_tabs(win) -> list:
    """
    Enumerate all TabControl / TabItem controls.
    Returns list of {"tab_control_id", "tabs"} dicts.
    """
    results = []
    seen_ids = set()

    try:
        for tab_ctrl in win.descendants(control_type="TabControl"):
            aid = tab_ctrl.element_info.automation_id or ""
            key = aid or str(tab_ctrl.handle)
            if key in seen_ids:
                continue
            seen_ids.add(key)

            tabs = []
            try:
                for tab_item in tab_ctrl.children(control_type="TabItem"):
                    name = tab_item.window_text() or tab_item.element_info.name or ""
                    if name:
                        tabs.append(name)
            except Exception:
                pass

            if tabs:
                results.append({"tab_control_id": aid or "tabControl", "tabs": tabs})
    except Exception:
        pass

    return results


# ─────────────────────────────────────────────────────────────────────────────
# Markdown writer
# ─────────────────────────────────────────────────────────────────────────────

def _render_menu_items(items: list, indent: int = 0) -> list:
    """Recursively render menu items as markdown bullet lines."""
    lines = []
    prefix = "  " * indent
    for item in items:
        name = item["name"]
        if name == "---":
            lines.append(f"{prefix}- ---")
            continue
        enabled_tag = "`[enabled]`" if item.get("enabled", True) else "`[disabled]`"
        shortcut = f"  `{item['shortcut']}`" if item.get("shortcut") else ""
        if indent == 0:
            lines.append(f"{prefix}- **{name}**{shortcut}  {enabled_tag}")
        else:
            lines.append(f"{prefix}- {name}{shortcut}  {enabled_tag}")
        if item.get("items"):
            lines.extend(_render_menu_items(item["items"], indent + 1))
    return lines


def _render_nav_nodes(nodes: list, indent: int = 0) -> list:
    """Recursively render tree nodes as indented bullet lines."""
    lines = []
    prefix = "  " * indent
    for node in nodes:
        name = node["name"]
        marker = "+" if node.get("has_children") and not node.get("children") else ""
        lines.append(f"{prefix}- {name}{marker}")
        if node.get("children"):
            lines.extend(_render_nav_nodes(node["children"], indent + 1))
    return lines


def write_markdown(
    tool_slug: str,
    tool_title: str,
    display_name: str,
    menu_items: list,
    nav_nodes: list,
    toolbar_buttons: list,
    tab_pages: list,
    screenshot_path: str | None,
    out_dir: str,
) -> str:
    """Write the .md file and return its path."""
    filename = f"{tool_slug}_menu_map.md"
    out_path = os.path.join(out_dir, filename)
    ts = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    lines = [
        f"# {display_name} — Menu Map",
        f"_Generated: {ts}_  ",
        f'_Window: "{tool_title}"_',
        "",
        "---",
        "",
    ]

    # ── Menu Bar ──
    lines += ["## Menu Bar", ""]
    if menu_items:
        lines += _render_menu_items(menu_items)
    else:
        lines += ["_No standard menu bar found._"]
    lines += ["", "---", ""]

    # ── Navigation Tree ──
    lines += ["## Navigation Tree", ""]
    if nav_nodes:
        for section in nav_nodes:
            source = section["source"]
            stype = section.get("type", "")

            if stype == "tool_list":
                lines.append(f"### Tool Cards")
                for item in section.get("items", []):
                    lines.append(f"- {item['name']}")
            elif stype == "nav_buttons":
                lines.append(f"### Navigation Buttons / Categories [{source}]")
                for item in section.get("items", []):
                    lines.append(f"- [{item.get('type', 'button')}] {item['name']}")
            else:
                lines.append(f"### {source}")
                lines += _render_nav_nodes(section.get("nodes", []))
            lines.append("")
    else:
        lines += ["_No navigation tree found._", ""]
    lines += ["---", ""]

    # ── Tab Pages ──
    lines += ["## Tab Pages", ""]
    if tab_pages:
        for tc in tab_pages:
            lines.append(f"### TabControl [{tc['tab_control_id']}]")
            for tab in tc["tabs"]:
                lines.append(f"- {tab}")
            lines.append("")
    else:
        lines += ["_No tab controls found (or no object selected)._", ""]
    lines += ["---", ""]

    # ── Toolbar ──
    lines += ["## Toolbar", ""]
    if toolbar_buttons:
        lines.append("| # | Name | Auto ID | Enabled |")
        lines.append("|---|------|---------|---------|")
        for i, btn in enumerate(toolbar_buttons, 1):
            name = btn["name"]
            if name == "---":
                lines.append(f"| | --- | | |")
                continue
            aid = btn.get("auto_id", "")
            enabled = "Yes" if btn.get("enabled", True) else "No"
            lines.append(f"| {i} | {name} | {aid} | {enabled} |")
    else:
        lines += ["_No toolbar found._"]
    lines += ["", "---", ""]

    # ── Screenshots ──
    lines += ["## Screenshots", ""]
    if screenshot_path:
        png_name = os.path.basename(screenshot_path)
        lines.append(f"![{tool_slug}]({png_name})")
    else:
        lines += [
            "_Run with `--screenshot` to generate._",
            "_Note: requires `pip install pillow`_",
        ]
    lines.append("")

    content = "\n".join(lines)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(content)

    return out_path


# ─────────────────────────────────────────────────────────────────────────────
# Orchestrator
# ─────────────────────────────────────────────────────────────────────────────

def explore_tool(slug: str, args: argparse.Namespace) -> bool:
    """Run all exploration sections for one tool. Returns True on success."""
    config = TOOL_CONFIG.get(slug)
    if config is None:
        print(f"[explorer] ERROR: Unknown tool slug '{slug}'. "
              f"Valid: {', '.join(TOOL_CONFIG)}")
        return False

    title_frag = config["title_fragment"]
    print(f"\n[explorer] ─── {title_frag} ───────────────────────────────")
    print(f"[explorer] Searching for window containing '{title_frag}'...")

    win = find_window(title_frag)
    # Verify the window actually matches — find_window() falls back to any OIM window
    tool_title = win.window_text() if win else ""
    if win is None or title_frag.lower() not in tool_title.lower():
        print(f"[explorer] ERROR: {title_frag} is not open. Skipping.")
        print(f"           Open it from the Launchpad (Tools category) or run:")
        print(f"             python oim_launchpad.py run \"{title_frag.replace('JobQueueInfo', 'Job Queue Info')}\" --wait")
        return False
    print(f"[explorer] Found: \"{tool_title}\"")

    # Focus the window before any interaction
    try:
        win.set_focus()
        time.sleep(0.3)
    except Exception:
        pass

    # Section 1: Menu Bar
    print(f"[explorer]   Scanning menu bar...")
    menu_items = explore_menu_bar(win, config)
    print(f"[explorer]   → {len(menu_items)} top-level menu(s) found")

    # Section 2: Navigation Tree
    expand = getattr(args, "expand_tree", False)
    if expand:
        print(f"[explorer]   Scanning nav tree (expand=True — NOTE: nodes will stay expanded)...")
    else:
        print(f"[explorer]   Scanning nav tree (static)...")
    nav_nodes = explore_nav_tree(win, config, expand=expand, max_depth=args.depth)
    total_nodes = sum(
        len(s.get("nodes", s.get("items", []))) for s in nav_nodes
    )
    print(f"[explorer]   → {len(nav_nodes)} tree section(s), ~{total_nodes} top-level node(s)")

    # Section 3: Toolbar
    print(f"[explorer]   Scanning toolbar...")
    toolbar_buttons = explore_toolbar(win, config)
    print(f"[explorer]   → {len(toolbar_buttons)} toolbar item(s) found")

    # Section 4: Tab Pages
    print(f"[explorer]   Scanning tab pages...")
    tab_pages = explore_tabs(win)
    print(f"[explorer]   → {len(tab_pages)} tab control(s) found")

    # Screenshot
    screenshot_path = None
    if args.screenshot:
        print(f"[explorer]   Taking screenshot...")
        try:
            screenshot_path = take_window_screenshot(win, args.out)
            print(f"[explorer]   → Saved: {screenshot_path}")
        except Exception as e:
            print(f"[explorer]   Screenshot failed: {e}")
            print("             Install Pillow: pip install pillow")

    # Write output
    out_path = write_markdown(
        tool_slug=config["output_slug"],
        tool_title=tool_title,
        display_name=config.get("display_name", tool_title.split(" - ")[0].strip()),
        menu_items=menu_items,
        nav_nodes=nav_nodes,
        toolbar_buttons=toolbar_buttons,
        tab_pages=tab_pages,
        screenshot_path=screenshot_path,
        out_dir=args.out,
    )
    print(f"[explorer]   Written: {out_path}")
    return True


# ─────────────────────────────────────────────────────────────────────────────
# Entry point
# ─────────────────────────────────────────────────────────────────────────────

def main():
    parser = build_parser()
    args = parser.parse_args()

    if not args.all and not args.tool:
        parser.error("Specify a tool name or use --all.\n"
                     "Examples:\n"
                     "  python oim_menu_explorer.py Designer\n"
                     "  python oim_menu_explorer.py --all")

    os.makedirs(args.out, exist_ok=True)

    if args.all:
        slugs = list(TOOL_CONFIG.keys())
    else:
        slug = normalize_tool_slug(args.tool)
        if slug not in TOOL_CONFIG:
            parser.error(f"Unknown tool '{args.tool}'. "
                         f"Valid: Designer, Manager, Launchpad, 'Job Queue'")
        slugs = [slug]

    results = {}
    for slug in slugs:
        results[slug] = explore_tool(slug, args)

    print("\n[explorer] ── Summary ──────────────────────────────────────")
    for slug, ok in results.items():
        status = "OK" if ok else "SKIPPED (not open)"
        cfg = TOOL_CONFIG[slug]
        out = f"{cfg['output_slug']}_menu_map.md"
        print(f"  {cfg['title_fragment']:20s} {status}  →  {out}")

    successful = sum(1 for ok in results.values() if ok)
    print(f"\n[explorer] {successful}/{len(results)} tool(s) documented.")
    if successful > 0:
        print(f"[explorer] Output directory: {args.out}")


if __name__ == "__main__":
    main()
