"""
oim_jobqueue.py — Read and monitor the OIM Job Queue Info tool.

Control IDs confirmed via oim_inspect.py (2026-03-28):
  frmMain             Job Queue Info main window
  tlcJobChains        Main job queue TreeList — columns:
                        "Job queue"       (process name — also the tree item text)
                        "Runtime status"  (e.g. Processing, Frozen, Finished, Error)
                        "Executing server"
                        "Start time"
  tlcParameter        Parameters panel (Key / Value for selected job)
  _jqControl          Process detail tree

Usage:
  py -3 oim_jobqueue.py rows               # print all visible job rows
  py -3 oim_jobqueue.py frozen             # print only Frozen rows
  py -3 oim_jobqueue.py errors             # print only Error rows
  py -3 oim_jobqueue.py wait "ProcessName" # poll until named process finishes

Prerequisite: Job Queue Info must be open.
  py -3 oim_launchpad.py run "Job Queue Info" --wait
  (Navigate Launchpad → Tools category first if tool card is not visible.)
"""

import sys
import time
import argparse

try:
    from pywinauto import Desktop
    from pywinauto.keyboard import send_keys
except ImportError as e:
    print(f"ERROR: Missing dependency — {e}")
    print("Run: pip install pywinauto pywin32")
    sys.exit(1)


# ── Column name constants (match the Header button labels in tlcJobChains) ──────
COL_PROCESS  = "Job queue"       # tree item window_text → process/task name
COL_STATUS   = "Runtime status"  # custom child 0 → status value
COL_SERVER   = "Executing server"
COL_STARTED  = "Start time"

# Column order in tlcJobChains (after the tree name column):
_EXTRA_COLS = [COL_STATUS, COL_SERVER, COL_STARTED]

# Status keywords for filtering
_FROZEN_KEYWORDS = {"frozen"}
_ERROR_KEYWORDS  = {"error", "failed", "exception"}


# ── Window ─────────────────────────────────────────────────────────────────────

def get_jobqueue_window():
    """Find the Job Queue Info window. Title contains 'JobQueueInfo' or 'Job Queue'."""
    desktop = Desktop(backend="uia")
    for win in desktop.windows():
        try:
            title = win.window_text()
            if ("JobQueueInfo" in title or "Job Queue" in title) and win.is_visible():
                rect = win.rectangle()
                if rect.left != -32000:
                    return win
        except Exception:
            pass
    raise RuntimeError(
        "Job Queue Info window not found.\n"
        "Open it from Launchpad:\n"
        "  py -3 oim_launchpad.py run \"Job Queue Info\" --wait\n"
        "(Navigate Launchpad to the Tools category first if needed.)"
    )


# ── Tree access ────────────────────────────────────────────────────────────────

def get_job_tree(win):
    """Return the tlcJobChains TreeList control."""
    for d in win.descendants():
        if d.element_info.automation_id == "tlcJobChains":
            return d
    raise RuntimeError(
        "tlcJobChains not found in Job Queue Info window.\n"
        "Make sure the 'Job queue' view is active (View → Job queue)."
    )


def refresh(win):
    """Press F5 to refresh the job queue display."""
    win.set_focus()
    send_keys("{F5}")
    time.sleep(0.5)


# ── Row reading ────────────────────────────────────────────────────────────────

def _read_tree_rows(win) -> list[dict]:
    """
    Read all TreeItem rows from tlcJobChains.

    Each row dict has keys:
      "Job queue"         — process name (from tree item window_text)
      "Runtime status"    — status (from first Custom child, if present)
      "Executing server"  — server name (second Custom child)
      "Start time"        — start timestamp (third Custom child)

    DevExpress TreeList: the first column value is the item's window_text;
    remaining column values are Custom-type child elements in header order.
    Group/header nodes (items that have TreeItem children) are skipped.
    """
    tree = get_job_tree(win)
    rows = []

    for item in tree.descendants(control_type="TreeItem"):
        try:
            # Skip group nodes — they have TreeItem children
            has_child_items = any(
                c.element_info.control_type == "TreeItem"
                for c in item.children()
            )
            if has_child_items:
                continue

            row = {COL_PROCESS: item.window_text()}

            # Read extra column values from Custom children (in column order)
            try:
                customs = [c for c in item.children()
                           if c.element_info.control_type == "Custom"]
                for i, col_name in enumerate(_EXTRA_COLS):
                    if i < len(customs):
                        row[col_name] = customs[i].window_text()
                    else:
                        row[col_name] = ""
            except Exception:
                for col_name in _EXTRA_COLS:
                    row.setdefault(col_name, "")

            rows.append(row)
        except Exception:
            pass

    return rows


def get_all_rows(win) -> list[dict]:
    """Refresh and return all visible job rows."""
    refresh(win)
    return _read_tree_rows(win)


def get_frozen(win) -> list[dict]:
    """Return only rows whose Runtime status is 'Frozen'."""
    return [r for r in get_all_rows(win)
            if any(kw in r.get(COL_STATUS, "").lower() for kw in _FROZEN_KEYWORDS)]


def get_errors(win) -> list[dict]:
    """Return only rows with an error/failed status."""
    return [r for r in get_all_rows(win)
            if any(kw in r.get(COL_STATUS, "").lower() for kw in _ERROR_KEYWORDS)]


def wait_for_process(win, process_name: str, timeout: int = 120, poll: int = 3) -> bool:
    """
    Poll until a process matching process_name is no longer in the queue.

    Returns True if the process disappeared (completed) within timeout seconds.
    Returns False on timeout.

    process_name: partial, case-insensitive match against the 'Job queue' column.
    """
    deadline = time.time() + timeout
    print(f"[jobqueue] Waiting for '{process_name}' (timeout={timeout}s)...")
    while time.time() < deadline:
        rows = get_all_rows(win)
        running = [r for r in rows
                   if process_name.lower() in r.get(COL_PROCESS, "").lower()]
        if not running:
            print(f"[jobqueue] '{process_name}' no longer in queue — done.")
            return True
        statuses = {r.get(COL_STATUS, "?") for r in running}
        print(f"[jobqueue]   {len(running)} row(s) still running "
              f"(status: {', '.join(statuses)})... polling in {poll}s")
        time.sleep(poll)

    print(f"[jobqueue] Timeout — '{process_name}' may still be running.")
    return False


# ── CLI ────────────────────────────────────────────────────────────────────────

def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    parser = argparse.ArgumentParser(description="Read OIM Job Queue Info")
    sub = parser.add_subparsers(dest="cmd", required=True)

    sub.add_parser("rows",   help="Print all visible job rows")
    sub.add_parser("frozen", help="Print only Frozen rows")
    sub.add_parser("errors", help="Print only Error rows")

    p_wait = sub.add_parser("wait", help="Poll until a named process finishes")
    p_wait.add_argument("name", help="Partial process name to match")
    p_wait.add_argument("--timeout", type=int, default=120,
                        help="Seconds before giving up (default: 120)")
    p_wait.add_argument("--poll", type=int, default=3,
                        help="Polling interval in seconds (default: 3)")

    args = parser.parse_args()
    win = get_jobqueue_window()
    print(f"[jobqueue] Connected: {win.window_text()}")

    if args.cmd == "rows":
        rows = get_all_rows(win)
        print(f"{len(rows)} row(s):")
        for r in rows:
            print(f"  [{r.get(COL_STATUS, '?'):12}] {r.get(COL_PROCESS, '?')}")

    elif args.cmd == "frozen":
        rows = get_frozen(win)
        print(f"{len(rows)} frozen row(s):")
        for r in rows:
            print(f"  {r}")

    elif args.cmd == "errors":
        rows = get_errors(win)
        print(f"{len(rows)} error row(s):")
        for r in rows:
            print(f"  {r}")

    elif args.cmd == "wait":
        result = wait_for_process(win, args.name, args.timeout, args.poll)
        sys.exit(0 if result else 1)


if __name__ == "__main__":
    main()
