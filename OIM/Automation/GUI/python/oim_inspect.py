"""
oim_inspect.py — Dump the full UI control tree of a specific OIM window.

Usage:
    python oim_inspect.py                      # inspect first OIM window found
    python oim_inspect.py Designer             # inspect window whose title contains "Designer"
    python oim_inspect.py "Job Queue"          # inspect Job Queue Info
    python oim_inspect.py Designer --depth 4   # limit tree depth (default: 6)
    python oim_inspect.py Designer --filter tree   # only show TreeView controls
    python oim_inspect.py Designer --screenshot    # also save a PNG of the window

Safe: read-only, no interactions.

Output: Human-readable control tree showing every panel, button, tree node,
        text field, grid, and tab — with the exact names needed to interact
        with them programmatically in later scripts.
"""

import sys
import os
import argparse
from datetime import datetime

try:
    from pywinauto import Desktop
    from pywinauto.controls.uia_controls import TreeViewWrapper, EditWrapper
except ImportError:
    print("ERROR: pywinauto not installed. Run: python -m pip install pywinauto pywin32")
    sys.exit(1)


OIM_SIGNATURES = [
    "One Identity Manager",
    "Launchpad",
    "Designer",
    "Manager",
    "Job Queue",
    "Object Browser",
    "DBQueue",
    "Web Designer",
    "Synchronization Editor",
]

# Control types worth highlighting in the output
INTERESTING_TYPES = {
    "Tree":          "TREE",
    "TreeItem":      "  ↳ node",
    "Edit":          "EDIT",
    "Document":      "RICHTEXT",
    "ComboBox":      "COMBO",
    "Button":        "BUTTON",
    "CheckBox":      "CHECKBOX",
    "DataGrid":      "GRID",
    "TabControl":    "TABS",
    "TabItem":       "  → tab",
    "MenuItem":      "  » menu",
    "ToolBar":       "TOOLBAR",
    "StatusBar":     "STATUSBAR",
    "List":          "LIST",
    "ListItem":      "  • item",
    "Pane":          "PANE",
    "Group":         "GROUP",
    "Text":          "label",
    "Hyperlink":     "LINK",
}


def find_window(title_fragment: str):
    """Find an OIM window whose title contains title_fragment.

    Matching rules (in priority order):
    1. Title contains title_fragment AND is an OIM signature window
    2. Title contains title_fragment (any window)
    3. title_fragment is generic (e.g. 'One Identity') → return first OIM signature window found
    """
    desktop = Desktop(backend="uia")
    frag = title_fragment.lower()

    oim_windows = []
    fragment_matches = []

    for win in desktop.windows():
        try:
            t   = win.window_text()
            tl  = t.lower()
            vis = win.is_visible()
            minimised = win.rectangle().left == -32000

            is_oim = any(sig.lower() in tl for sig in OIM_SIGNATURES)
            has_frag = frag in tl

            if not vis or minimised:
                continue

            if is_oim:
                oim_windows.append(win)

            if has_frag and is_oim:
                return win          # best match: fragment + OIM signature

            if has_frag:
                fragment_matches.append(win)

        except Exception:
            pass

    # Fallback 1: fragment matched but not an OIM sig window
    if fragment_matches:
        return fragment_matches[0]

    # Fallback 2: generic search term (e.g. 'One Identity') → first OIM window
    if oim_windows:
        return oim_windows[0]

    return None


def dump_control_tree(ctrl, depth=0, max_depth=6, filter_type=None, output_lines=None):
    """Recursively walk the control tree and collect lines."""
    if output_lines is None:
        output_lines = []
    if depth > max_depth:
        return output_lines

    try:
        ctrl_type  = ctrl.element_info.control_type or "Unknown"
        ctrl_name  = ctrl.window_text() or ctrl.element_info.name or ""
        auto_id    = ctrl.element_info.automation_id or ""
        class_name = ctrl.element_info.class_name or ""

        # Apply filter
        if filter_type and filter_type.lower() not in ctrl_type.lower() \
                       and filter_type.lower() not in class_name.lower():
            # Still recurse children even if this node is filtered
            for child in ctrl.children():
                try:
                    dump_control_tree(child, depth, max_depth, filter_type, output_lines)
                except Exception:
                    pass
            return output_lines

        tag = INTERESTING_TYPES.get(ctrl_type, ctrl_type)
        indent = "  " * depth

        # Format the line
        parts = [f"{indent}[{tag}]"]
        if ctrl_name:
            parts.append(f'"{ctrl_name}"')
        if auto_id and auto_id != ctrl_name:
            parts.append(f"id={auto_id}")
        if class_name:
            parts.append(f"cls={class_name}")

        # For edit fields try to show current value
        if ctrl_type in ("Edit", "Document") and depth <= 4:
            try:
                val = ctrl.get_value()
                if val and len(val) < 80:
                    parts.append(f"= '{val}'")
                elif val:
                    parts.append(f"= '{val[:77]}...'")
            except Exception:
                pass

        output_lines.append(" ".join(parts))

        # Recurse into children
        for child in ctrl.children():
            try:
                dump_control_tree(child, depth + 1, max_depth, filter_type, output_lines)
            except Exception:
                pass

    except Exception as e:
        output_lines.append(f"{'  ' * depth}[ERROR reading control: {e}]")

    return output_lines


def take_window_screenshot(win, out_dir: str) -> str:
    """Capture the window to a PNG and return the path."""
    import ctypes
    import win32gui
    import win32ui
    from PIL import Image  # pip install pillow

    hwnd = win.handle
    rect = win.rectangle()
    w, h = rect.width(), rect.height()

    wDC    = win32gui.GetWindowDC(hwnd)
    dcObj  = win32ui.CreateDCFromHandle(wDC)
    cDC    = dcObj.CreateCompatibleDC()
    dataBitMap = win32ui.CreateBitmap()
    dataBitMap.CreateCompatibleBitmap(dcObj, w, h)
    cDC.SelectObject(dataBitMap)
    cDC.BitBlt((0, 0), (w, h), dcObj, (0, 0), 0x00CC0020)

    bmpinfo = dataBitMap.GetInfo()
    bmpstr  = dataBitMap.GetBitmapBits(True)
    img = Image.frombuffer("RGB", (bmpinfo["bmWidth"], bmpinfo["bmHeight"]),
                           bmpstr, "raw", "BGRX", 0, 1)

    ts   = datetime.now().strftime("%Y%m%d_%H%M%S")
    path = os.path.join(out_dir, f"oim_inspect_{ts}.png")
    img.save(path)

    dcObj.DeleteDC(); cDC.DeleteDC()
    win32gui.ReleaseDC(hwnd, wDC)
    win32gui.DeleteObject(dataBitMap.GetHandle())
    return path


def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    parser = argparse.ArgumentParser(description="Inspect OIM window control tree")
    parser.add_argument("title", nargs="?", default="One Identity",
                        help="Fragment of window title to match (default: 'One Identity')")
    parser.add_argument("--depth", type=int, default=6,
                        help="Max tree depth to traverse (default: 6)")
    parser.add_argument("--filter", type=str, default=None,
                        help="Only show controls whose type/class contains this string")
    parser.add_argument("--screenshot", action="store_true",
                        help="Also save a PNG screenshot of the window")
    parser.add_argument("--out", type=str,
                        default=os.environ.get("TEMP", "C:/Windows/Temp"),
                        help="Directory for screenshot output")
    args = parser.parse_args()

    print(f"\nSearching for OIM window containing: '{args.title}'...")
    win = find_window(args.title)

    if win is None:
        print(f"\nERROR: No visible OIM window found matching '{args.title}'.")
        print("Open an OIM tool first, then re-run.")
        print("\nCurrently open windows matching OIM signatures:")
        desktop = Desktop(backend="uia")
        for w in desktop.windows():
            try:
                t = w.window_text()
                if t:
                    print(f"  - {t}")
            except Exception:
                pass
        sys.exit(1)

    title = win.window_text()
    rect  = win.rectangle()
    print(f"\nFound: \"{title}\"")
    print(f"Size : {rect.width()}x{rect.height()} @ ({rect.left}, {rect.top})")
    print(f"Class: {win.class_name()}")

    if args.screenshot:
        try:
            path = take_window_screenshot(win, args.out)
            print(f"Screenshot saved: {path}")
        except Exception as e:
            print(f"Screenshot failed (Pillow may not be installed): {e}")
            print("Install with: pip install pillow")

    print(f"\n{'═' * 60}")
    print(f" CONTROL TREE  (depth≤{args.depth}"
          + (f", filter='{args.filter}'" if args.filter else "") + ")")
    print(f"{'═' * 60}\n")

    lines = dump_control_tree(win, max_depth=args.depth, filter_type=args.filter)
    for line in lines:
        print(line)

    print(f"\n{'═' * 60}")
    print(f" Total controls printed: {len(lines)}")
    print(f"{'═' * 60}")
    print("\nTip: Use --filter Tree to see only the nav tree nodes.")
    print("     Use --filter Edit to see only text input fields.")
    print("     Use --filter Grid to see data grids.")


if __name__ == "__main__":
    main()
