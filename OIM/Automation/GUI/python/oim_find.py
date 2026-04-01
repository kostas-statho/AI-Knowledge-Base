"""
oim_find.py — Discover all open OIM application windows.

Usage:
    python oim_find.py              # print JSON list of OIM windows
    python oim_find.py --watch      # refresh every 3 seconds (watch for new windows)

Output: JSON array, one entry per OIM window found.
Safe: read-only, no interactions.
"""

import json
import sys
import time

try:
    from pywinauto import Desktop
except ImportError:
    print("ERROR: pywinauto not installed. Run: python -m pip install pywinauto pywin32")
    sys.exit(1)


# Window title fragments that identify OIM applications
OIM_SIGNATURES = [
    "One Identity Manager",   # Launchpad (full title)
    "Launchpad",              # Launchpad (short title)
    "Designer",               # OIM Designer
    "Manager",                # OIM Manager
    "Job Queue",              # Job Queue Info
    "Object Browser",         # Object Browser
    "DBQueue",                # DBQueue Processor
    "Web Designer",           # Web Designer
    "Synchronization Editor", # Sync Editor
]


def find_oim_windows() -> list[dict]:
    """Return a list of all open OIM windows with their metadata."""
    desktop = Desktop(backend="uia")
    found = []

    for win in desktop.windows():
        try:
            title = win.window_text()
            cls   = win.class_name()

            if not any(sig.lower() in title.lower() for sig in OIM_SIGNATURES):
                continue

            rect = win.rectangle()
            found.append({
                "title":   title,
                "class":   cls,
                "handle":  win.handle,
                "rect": {
                    "left":   rect.left,
                    "top":    rect.top,
                    "right":  rect.right,
                    "bottom": rect.bottom,
                    "width":  rect.width(),
                    "height": rect.height(),
                },
                "visible":  win.is_visible(),
                "enabled":  win.is_enabled(),
                "minimised": rect.left == -32000,  # Windows minimised sentinel
            })
        except Exception:
            # Some windows are transient (tooltips, popups) — skip silently
            pass

    return found


def print_windows(windows: list[dict]) -> None:
    if not windows:
        print("No OIM windows found. Is the Launchpad or any OIM tool open?")
        return

    print(f"\nFound {len(windows)} OIM window(s):\n")
    for i, w in enumerate(windows, 1):
        status = []
        if not w["visible"]:  status.append("HIDDEN")
        if w["minimised"]:    status.append("MINIMISED")
        if not w["enabled"]:  status.append("DISABLED")
        status_str = f"  [{', '.join(status)}]" if status else ""

        print(f"  [{i}] {w['title']}{status_str}")
        print(f"       Class  : {w['class']}")
        print(f"       Handle : {w['handle']}")
        print(f"       Size   : {w['rect']['width']}x{w['rect']['height']} "
              f"@ ({w['rect']['left']}, {w['rect']['top']})")
        print()


if __name__ == "__main__":
    watch_mode = "--watch" in sys.argv

    if watch_mode:
        print("Watching for OIM windows (Ctrl+C to stop)...\n")
        seen = set()
        try:
            while True:
                windows = find_oim_windows()
                current = {w["handle"] for w in windows}

                # Report newly appeared windows
                for w in windows:
                    if w["handle"] not in seen:
                        print(f"[+] NEW window: {w['title']}  (handle={w['handle']})")
                        seen.add(w["handle"])

                # Report disappeared windows
                gone = seen - current
                for h in gone:
                    print(f"[-] CLOSED window handle: {h}")
                    seen.discard(h)

                time.sleep(3)
        except KeyboardInterrupt:
            print("\nStopped.")
    else:
        windows = find_oim_windows()
        print_windows(windows)
        # Also emit JSON for piping / Claude integration
        print("--- JSON ---")
        print(json.dumps(windows, indent=2))
