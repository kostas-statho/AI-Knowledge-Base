"""
oim_launchpad.py — Click tool buttons in the OIM Launchpad.

Structure confirmed from inspection:
  Each tool = [PANE id=TaskControl]
                ├── [PANE id=panelText]
                │     ├── [label id=lblTitle]   ← tool name
                │     ├── [BUTTON id=btnRun]    ← click this
                │     └── [label id=lblDescription]
                └── [PANE id=panelImage]

All buttons share id=btnRun — must find via parent TaskControl → lblTitle match.

Usage:
    python oim_launchpad.py list                    # list all available tools
    python oim_launchpad.py run Designer            # click Run for Designer
    python oim_launchpad.py run "Job Queue Info"    # click Run for Job Queue Info
    python oim_launchpad.py run Designer --wait     # click and wait for window to appear
"""

import sys
import time
import argparse

try:
    from pywinauto import Desktop
    from pywinauto.application import Application
except ImportError:
    print("ERROR: pywinauto not installed. Run: python -m pip install pywinauto pywin32")
    sys.exit(1)


# ── Known tools in the Launchpad (from inspection) ──────────────────────────
KNOWN_TOOLS = [
    "Designer",
    "Manager",
    "Job Queue Info",
    "Object Browser",
    "Synchronization Editor",
    "Schema Extension",
    "Database Transporter",
    "Database Compiler",
    "Data Import",
    "Report Editor",
    "Analyzer",
    "Software Loader",
    "Web Installer",
    "Crypto Configuration",
    "Configuration Wizard",
    "System Debugger",
]

# Window title fragments that appear when each tool opens
TOOL_WINDOW_TITLES = {
    "Designer":               "Designer",
    "Manager":                "Manager",
    "Job Queue Info":         "Job Queue",
    "Object Browser":         "Object Browser",
    "Synchronization Editor": "Synchronization Editor",
    "Schema Extension":       "Schema Extension",
    "Database Transporter":   "Database Transporter",
    "Database Compiler":      "Database Compiler",
}


def find_launchpad():
    """Find the Launchpad window."""
    desktop = Desktop(backend="uia")
    for win in desktop.windows():
        try:
            t = win.window_text()
            if "launchpad" in t.lower() or "one identity manager launchpad" in t.lower():
                if win.is_visible():
                    return win
        except Exception:
            pass
    return None


def get_all_task_controls(launchpad_win):
    """
    Walk the Launchpad and collect all TaskControl panes with their tool names.
    Returns list of (tool_name, task_control_pane).
    """
    tasks = []

    def walk(ctrl, depth=0):
        try:
            auto_id = ctrl.element_info.automation_id or ""
            if auto_id == "TaskControl":
                # Found a tool card — read its lblTitle
                try:
                    title_ctrl = ctrl.child_window(auto_id="panelText") \
                                     .child_window(auto_id="lblTitle")
                    tool_name = title_ctrl.window_text().strip()
                    if tool_name:
                        tasks.append((tool_name, ctrl))
                        return  # Don't recurse inside TaskControl
                except Exception:
                    pass

            if depth < 8:
                for child in ctrl.children():
                    try:
                        walk(child, depth + 1)
                    except Exception:
                        pass
        except Exception:
            pass

    walk(launchpad_win)
    return tasks


def list_tools(launchpad_win):
    """Print all tools visible in the Launchpad."""
    tasks = get_all_task_controls(launchpad_win)
    if not tasks:
        print("No tool cards found. Is the Launchpad fully loaded?")
        return

    print(f"\nFound {len(tasks)} tools in Launchpad:\n")
    for i, (name, _) in enumerate(tasks, 1):
        print(f"  {i:2}. {name}")
    print()


def click_tool(launchpad_win, tool_name: str, dry_run: bool = False) -> bool:
    """
    Find the TaskControl for tool_name and click its Run button.
    Returns True if clicked, False if not found.
    """
    tasks = get_all_task_controls(launchpad_win)

    # Exact match first, then case-insensitive partial
    match = None
    for name, ctrl in tasks:
        if name.lower() == tool_name.lower():
            match = (name, ctrl)
            break
    if not match:
        for name, ctrl in tasks:
            if tool_name.lower() in name.lower():
                match = (name, ctrl)
                break

    if not match:
        print(f"ERROR: Tool '{tool_name}' not found in Launchpad.")
        print(f"Available tools: {', '.join(n for n, _ in tasks)}")
        return False

    found_name, task_ctrl = match
    print(f"Found: '{found_name}'")

    try:
        # Navigate: TaskControl → panelText → btnRun
        run_btn = task_ctrl.child_window(auto_id="panelText") \
                           .child_window(auto_id="btnRun")

        if dry_run:
            print(f"[DRY RUN] Would click Run button for '{found_name}'")
            return True

        print(f"Clicking Run for '{found_name}'...")

        # Bring Launchpad to front first
        launchpad_win.set_focus()
        time.sleep(0.3)

        run_btn.click()
        print(f"Clicked.")
        return True

    except Exception as e:
        print(f"ERROR clicking button: {e}")
        # Fallback: try scrolling into view first
        try:
            task_ctrl.scroll_into_view()
            run_btn = task_ctrl.child_window(auto_id="panelText") \
                               .child_window(auto_id="btnRun")
            run_btn.click()
            print("Clicked (after scroll).")
            return True
        except Exception as e2:
            print(f"Fallback also failed: {e2}")
            return False


def wait_for_tool_window(tool_name: str, timeout: int = 30) -> bool:
    """
    Wait up to `timeout` seconds for the tool window to appear.
    Returns True when detected, False on timeout.
    """
    title_fragment = TOOL_WINDOW_TITLES.get(tool_name, tool_name)
    print(f"Waiting for '{title_fragment}' window (timeout={timeout}s)...", end="", flush=True)

    desktop = Desktop(backend="uia")
    deadline = time.time() + timeout
    while time.time() < deadline:
        for win in desktop.windows():
            try:
                t = win.window_text()
                if title_fragment.lower() in t.lower() and win.is_visible():
                    print(f" found: \"{t}\"")
                    return True
            except Exception:
                pass
        print(".", end="", flush=True)
        time.sleep(1)

    print(" TIMEOUT")
    return False


def main():
    parser = argparse.ArgumentParser(description="Interact with the OIM Launchpad")
    subparsers = parser.add_subparsers(dest="command")

    # list
    subparsers.add_parser("list", help="List all tools in the Launchpad")

    # run
    run_p = subparsers.add_parser("run", help="Click the Run button for a tool")
    run_p.add_argument("tool", help="Tool name (e.g. 'Designer', 'Job Queue Info')")
    run_p.add_argument("--wait", action="store_true",
                       help="Wait for the tool window to appear after clicking")
    run_p.add_argument("--timeout", type=int, default=30,
                       help="Seconds to wait for window (default: 30)")
    run_p.add_argument("--dry-run", action="store_true",
                       help="Show what would be clicked without actually clicking")

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        sys.exit(0)

    # Find Launchpad
    print("Looking for Launchpad window...")
    lp = find_launchpad()
    if not lp:
        print("ERROR: Launchpad not found. Is it open?")
        sys.exit(1)
    print(f"Launchpad found: \"{lp.window_text()}\"")

    if args.command == "list":
        list_tools(lp)

    elif args.command == "run":
        clicked = click_tool(lp, args.tool, dry_run=args.dry_run)
        if clicked and args.wait and not args.dry_run:
            found = wait_for_tool_window(args.tool, timeout=args.timeout)
            if found:
                print(f"'{args.tool}' is ready.")
            else:
                print(f"WARNING: '{args.tool}' window did not appear within {args.timeout}s.")
                print("It may already be open, or may take longer to load.")


if __name__ == "__main__":
    main()
