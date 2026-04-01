"""
oim_designer.py — Automate OIM Designer for mail template operations.

Control IDs confirmed via oim_inspect.py (2026-03-28):
  frmMain                             Designer main window
  dockNavigation                      Left nav panel container
  tlcObjects                          Object list tree (mail templates when nav is on that category)
  Navigator / databaseNavigator1      Getting Started quick-links tree
  editIdent_DialogRichMail → TextBox  Mail template name field
  edtDescription → TextBox            Description field
  textBox (lowercase)                 Subject line
  m_RichEditControl [0]               Formatted (HTML) body  — UIA label "Page 1 header"
  m_RichEditControl [1]               Plain text body        — UIA label "Page 1 footer"
  toolBarController                   Main toolbar
  "Commit to database" button         Compile / deploy to DB

Usage (CLI):
  python oim_designer.py list                          # list templates in current view
  python oim_designer.py select "CCC_MyTemplate"       # click a template in the list
  python oim_designer.py read                          # read open template fields
  python oim_designer.py new                           # Ctrl+N – open new template form
  python oim_designer.py set subject "My subject"      # set one field
  python oim_designer.py save                          # Ctrl+S
  python oim_designer.py commit                        # Commit to database

Tested on Designer - viadmin@STATHOPOULOSK\\OneIM (Main Database)
"""

import sys
import time
import argparse

try:
    import win32clipboard
    import win32con
    from pywinauto import Desktop
    from pywinauto.keyboard import send_keys
except ImportError as e:
    print(f"ERROR: Missing dependency — {e}")
    print("Run: pip install pywinauto pywin32")
    sys.exit(1)


# ─────────────────────────────────────────────────────────
# Window
# ─────────────────────────────────────────────────────────

def get_designer_window():
    """
    Find and return the Designer main window (id=frmMain).

    Filters out small MDI child windows / detached panels that also carry
    'Designer' in their title — requires the window to be at least 400×200 px
    and not at the standard minimised position (left == -32000).

    Raises RuntimeError if no valid Designer window is found.
    """
    desktop = Desktop(backend="uia")
    best = None
    best_area = 0
    for win in desktop.windows():
        try:
            title = win.window_text()
            if "Designer" not in title or not win.is_visible():
                continue
            rect = win.rectangle()
            if rect.left == -32000:          # standard minimised position — skip
                continue
            w, h = rect.width(), rect.height()
            if w < 400 or h < 200:           # too small — MDI child or detached panel
                continue
            area = w * h
            if area > best_area:
                best, best_area = win, area
        except Exception:
            pass
    if best is None:
        raise RuntimeError(
            "Designer window not found (or only a small MDI panel is visible).\n"
            "Open Designer from Launchpad first, or run:\n"
            "  py -3 oim_launchpad.py run Designer --wait"
        )
    return best


# ─────────────────────────────────────────────────────────
# Navigation helpers
# ─────────────────────────────────────────────────────────

def get_template_list(win):
    """
    Return the mail template object list tree (id=tlcObjects).
    This control is visible when the Designer nav is on a template category.
    """
    return win.child_window(auto_id="tlcObjects", control_type="Tree")


def list_templates(win) -> list[str]:
    """Return the names of all templates visible in the object list."""
    tl = get_template_list(win)
    return [item.window_text() for item in tl.children(control_type="TreeItem")]


def select_template(win, name: str):
    """
    Click a template by name in the object list to open it for editing.
    Raises LookupError if not found.
    """
    tl = get_template_list(win)
    item = tl.child_window(title=name, control_type="TreeItem")
    item.click_input()
    time.sleep(0.4)
    return item


def new_template(win):
    """
    Open a blank new mail template form.
    Focuses the object list then sends Ctrl+N.
    """
    tl = get_template_list(win)
    tl.click_input()
    time.sleep(0.1)
    send_keys("^n")
    time.sleep(0.6)   # wait for new-template tab to open


def right_click_new(win):
    """
    Alternative: right-click the object list → choose 'New' from context menu.
    Use this if Ctrl+N does not work in the current Designer version.
    """
    tl = get_template_list(win)
    tl.right_click_input()
    time.sleep(0.3)
    send_keys("n")    # 'N' = New (first item in context menu)
    time.sleep(0.6)


# ─────────────────────────────────────────────────────────
# Field readers / writers
# ─────────────────────────────────────────────────────────

def _inner_textbox(container):
    """Get the TextBox child inside a labeled OIM form container."""
    return container.child_window(auto_id="TextBox", control_type="Edit")


def set_name(win, value: str):
    """Set the Mail template name / identifier."""
    container = win.child_window(auto_id="editIdent_DialogRichMail")
    field = _inner_textbox(container)
    field.set_edit_text(value)


def get_name(win) -> str:
    container = win.child_window(auto_id="editIdent_DialogRichMail")
    return _inner_textbox(container).get_value()


def set_description(win, value: str):
    """
    Set the Description field via clipboard paste.

    set_edit_text() does not fire OIM's change event on this DevExpress control,
    so the value reverts on save.  Clipboard paste triggers the event correctly.
    """
    container = win.child_window(auto_id="edtDescription")
    field = _inner_textbox(container)
    field.click_input()
    time.sleep(0.1)
    send_keys("^a")
    _clipboard_set(value)
    send_keys("^v")
    time.sleep(0.15)


def get_description(win) -> str:
    container = win.child_window(auto_id="edtDescription")
    return _inner_textbox(container).get_value()


def set_subject(win, value: str):
    """
    Set the Subject line (id=textBox, lowercase) via clipboard paste.

    set_edit_text() does not fire OIM's change event on this control,
    so the value reverts on save.  Clipboard paste triggers the event correctly.
    """
    field = win.child_window(auto_id="textBox", control_type="Edit")
    field.click_input()
    time.sleep(0.1)
    send_keys("^a")
    _clipboard_set(value)
    send_keys("^v")
    time.sleep(0.15)


def get_subject(win) -> str:
    return win.child_window(auto_id="textBox", control_type="Edit").get_value()


def set_base_object(win, value: str):
    """
    Set the Base object field (lookup/autocomplete, no stable auto_id).

    Strategy: Tab from the Description inner TextBox to reach Base object,
    then type to trigger the autocomplete dropdown and confirm with Enter.

    If this breaks across Designer versions, inspect with:
        python oim_inspect.py Designer --filter Edit --depth 10
    and update auto_id here.
    """
    desc_field = _inner_textbox(win.child_window(auto_id="edtDescription"))
    desc_field.click_input()
    time.sleep(0.1)
    send_keys("{TAB}")        # move focus to Base object field
    time.sleep(0.1)
    send_keys("^a")           # select all current text
    send_keys(value)          # type the object name
    time.sleep(0.5)           # wait for autocomplete
    send_keys("{ENTER}")      # confirm the first suggestion
    time.sleep(0.3)


# ─────────────────────────────────────────────────────────
# Rich text body (HTML and plain text)
# ─────────────────────────────────────────────────────────

def _clipboard_set(text: str):
    """Write text to the Windows clipboard (Unicode)."""
    win32clipboard.OpenClipboard()
    try:
        win32clipboard.EmptyClipboard()
        win32clipboard.SetClipboardData(win32con.CF_UNICODETEXT, text)
    finally:
        win32clipboard.CloseClipboard()


def _set_rich_edit(win, found_index: int, content: str):
    """
    Select all content in a DevExpress m_RichEditControl and replace via clipboard paste.

    found_index=0  →  Formatted / HTML body  ("Page 1 header" in UIA tree)
    found_index=1  →  Plain text body         ("Page 1 footer" in UIA tree)

    Uses clipboard paste rather than type_keys so that large HTML bodies
    don't time out and special characters survive intact.

    Retries the control lookup once after a short delay to handle the case where
    the "Edit mail definition" panel hasn't fully loaded yet.
    """
    win.set_focus()
    time.sleep(0.3)
    controls = win.descendants(auto_id="m_RichEditControl")
    if len(controls) == 0:
        # Panel may not have loaded yet — wait and retry once
        time.sleep(1.0)
        controls = win.descendants(auto_id="m_RichEditControl")
    if found_index >= len(controls):
        raise RuntimeError(
            f"m_RichEditControl[{found_index}] not found "
            f"({len(controls)} instance(s) present). "
            f"Make sure a mail template tab is active in Designer."
        )
    ctrl = controls[found_index]
    ctrl.click_input()
    time.sleep(0.2)
    send_keys("^a")            # select all
    time.sleep(0.05)
    _clipboard_set(content)
    send_keys("^v")            # paste
    time.sleep(0.2)


def set_html_body(win, html: str):
    """
    Replace the formatted (HTML) body of the open mail template.
    Pastes via clipboard into m_RichEditControl[0] ("Page 1 header").
    """
    _set_rich_edit(win, 0, html)


def set_plain_body(win, text: str):
    """
    Replace the plain text body of the open mail template.
    Pastes via clipboard into m_RichEditControl[1] ("Page 1 footer").
    """
    _set_rich_edit(win, 1, text)


# ─────────────────────────────────────────────────────────
# Save / commit
# ─────────────────────────────────────────────────────────

def save(win):
    """Save the currently open mail template (Ctrl+S)."""
    send_keys("^s")
    time.sleep(0.4)


def commit_to_database(win):
    """
    Click 'Commit to database' on the Designer toolbar.
    This compiles and deploys all pending schema / config changes to the DB.
    Only call this after saving all templates you want to deploy.
    """
    btn = win.child_window(title="Commit to database", control_type="Button")
    btn.click_input()
    time.sleep(1.5)   # commit takes a moment; increase if DB is slow


# ─────────────────────────────────────────────────────────
# High-level: create a complete mail template
# ─────────────────────────────────────────────────────────

def create_mail_template(
    win,
    *,
    name: str,
    description: str,
    base_object: str,
    subject: str,
    html_body: str,
    plain_body: str,
    importance: str = "High",   # Low / Normal / High — set manually for now
) -> None:
    """
    Create a new mail template end-to-end.

    importance is noted but NOT yet automated — OIM's importance field is a
    dropdown with no stable auto_id in the current inspect output.
    Set it manually after running this function, or extend set_importance()
    once the control ID is confirmed via --filter Combo inspect.

    Example:
        win = get_designer_window()
        create_mail_template(
            win,
            name="CCC_AAD_NoMailbox_Alert",
            description="Alert: AAD account has no EXO mailbox",
            base_object="AADUser",
            subject="[ACTION REQUIRED] AAD account '$DisplayName$' has no EXO mailbox",
            html_body=open("body_alert.html").read(),
            plain_body="ACTION REQUIRED: ...",
        )
    """
    print(f"[designer] Creating: {name}")

    new_template(win)

    print(f"[designer]   name        → {name}")
    set_name(win, name)

    print(f"[designer]   description → {description[:60]}")
    set_description(win, description)

    print(f"[designer]   base object → {base_object}")
    set_base_object(win, base_object)

    print(f"[designer]   subject     → {subject[:70]}")
    set_subject(win, subject)

    print(f"[designer]   html body   → {len(html_body):,} chars")
    set_html_body(win, html_body)

    print(f"[designer]   plain body  → {len(plain_body):,} chars")
    set_plain_body(win, plain_body)

    print(f"[designer]   saving...")
    save(win)

    print(f"[designer]   DONE — {name}")
    if importance != "Normal":
        print(f"[designer]   REMINDER: set Importance = {importance} manually "
              f"(dropdown not yet automated)")


# ─────────────────────────────────────────────────────────
# CLI
# ─────────────────────────────────────────────────────────

def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    parser = argparse.ArgumentParser(
        description="Automate OIM Designer mail template operations",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python oim_designer.py list
  python oim_designer.py select "CCC_15daysBeforeExpire"
  python oim_designer.py read
  python oim_designer.py new
  python oim_designer.py set name "CCC_AAD_NoMailbox_Alert"
  python oim_designer.py set subject "[ACTION REQUIRED] AAD account..."
  python oim_designer.py set html_body "<html>...</html>"
  python oim_designer.py save
  python oim_designer.py commit
""",
    )

    sub = parser.add_subparsers(dest="cmd", required=True)

    sub.add_parser("list",   help="List templates visible in object list")
    sub.add_parser("read",   help="Print fields of the currently open template")
    sub.add_parser("new",    help="Open a new blank template form (Ctrl+N)")
    sub.add_parser("save",   help="Save the current template (Ctrl+S)")
    sub.add_parser("commit", help="Commit to database (deploys all changes)")

    p_select = sub.add_parser("select", help="Click a template by name")
    p_select.add_argument("name")

    p_set = sub.add_parser("set", help="Set a single field on the open template")
    p_set.add_argument(
        "field",
        choices=["name", "description", "base_object", "subject", "html_body", "plain_body"],
    )
    p_set.add_argument("value", help="Value to set (use @path/to/file.html to read from file)")

    args = parser.parse_args()

    win = get_designer_window()
    print(f"[designer] Connected: {win.window_text()}")

    if args.cmd == "list":
        names = list_templates(win)
        print(f"Templates ({len(names)}):")
        for n in names:
            print(f"  - {n}")

    elif args.cmd == "select":
        select_template(win, args.name)
        print(f"Selected: {args.name}")

    elif args.cmd == "read":
        try:
            print(f"Name:        {get_name(win)}")
        except Exception as e:
            print(f"Name:        <error: {e}>")
        try:
            print(f"Description: {get_description(win)}")
        except Exception as e:
            print(f"Description: <error: {e}>")
        try:
            print(f"Subject:     {get_subject(win)}")
        except Exception as e:
            print(f"Subject:     <error: {e}>")

    elif args.cmd == "new":
        new_template(win)
        print("New template form opened.")

    elif args.cmd == "set":
        value = args.value
        if value.startswith("@"):
            path = value[1:]
            with open(path, encoding="utf-8") as f:
                value = f.read()
            print(f"[designer] Read {len(value):,} chars from {path}")

        dispatch = {
            "name":        lambda v: set_name(win, v),
            "description": lambda v: set_description(win, v),
            "base_object": lambda v: set_base_object(win, v),
            "subject":     lambda v: set_subject(win, v),
            "html_body":   lambda v: set_html_body(win, v),
            "plain_body":  lambda v: set_plain_body(win, v),
        }
        dispatch[args.field](value)
        print(f"Set [{args.field}] = {value[:80]}{'...' if len(value) > 80 else ''}")

    elif args.cmd == "save":
        save(win)
        print("Saved.")

    elif args.cmd == "commit":
        commit_to_database(win)
        print("Committed to database.")


if __name__ == "__main__":
    main()
