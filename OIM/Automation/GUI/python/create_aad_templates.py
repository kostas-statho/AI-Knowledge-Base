"""
create_aad_templates.py — Create the two AAD No-Mailbox mail templates in OIM Designer.

Extracts HTML and plain-text bodies from the design document, then calls
oim_designer.create_mail_template() for each template.

Prerequisites:
  - Designer must be open (python oim_launchpad.py run Designer --wait)
  - Designer must be on the Mail Templates category in the nav tree
  - pip install pywinauto pywin32

Usage:
  py -3 create_aad_templates.py
  py -3 create_aad_templates.py --commit    # also commits to database after creating

After running:
  Set Importance = High manually on both templates — the dropdown has no stable auto_id.
"""

import html
import re
import sys
import os
import argparse

# Allow importing oim_designer from the same directory
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    from oim_designer import get_designer_window, create_mail_template, commit_to_database
except ImportError as e:
    print(f"ERROR: Cannot import oim_designer — {e}")
    sys.exit(1)


# ── Document path ──────────────────────────────────────────────────────────────
# Relative to this script: Scripts/OIM_Automation/ → ../../Docs/
_HERE = os.path.dirname(os.path.abspath(__file__))
DOC_PATH = os.path.normpath(os.path.join(_HERE, "..", "..", "Docs",
                                          "AAD_NoMailbox_MailTemplates_Intragen.html"))


# ── Template definitions ───────────────────────────────────────────────────────
# code-block indices (0-based) in the HTML documentation file:
#   0 = Alert subject (not used — hardcoded below)
#   1 = Alert HTML body          ← html_idx
#   2 = Alert plain-text body    ← plain_idx
#   3 = Escalation subject (not used)
#   4 = Escalation HTML body     ← html_idx
#   5 = Escalation plain-text body ← plain_idx
#   6-9 = SQL / VB script blocks (sections 5-7, unrelated)

TEMPLATES = [
    dict(
        name        = "CCC_AAD_NoMailbox_Alert",
        description = "Alert: AAD account active 1+ hour without EXO mailbox",
        base_object = "AADUser",
        subject     = "[ACTION REQUIRED] AAD account '$DisplayName$' has no EXO mailbox"
                      " (created: $XDateInserted$)",
        importance  = "High",
        html_idx    = 1,
        plain_idx   = 2,
    ),
    dict(
        name        = "CCC_AAD_NoMailbox_Escalation",
        description = "Escalation: AAD account still without EXO mailbox after 4 hours",
        base_object = "AADUser",
        subject     = "[ESCALATION] AAD account '$DisplayName$' STILL has no EXO mailbox"
                      " — 4hrs since $XDateInserted$",
        importance  = "High",
        html_idx    = 4,
        plain_idx   = 5,
    ),
]


# ── Extraction ─────────────────────────────────────────────────────────────────

def extract_code_blocks(path: str) -> list[str]:
    """
    Extract all <div class="code-block">...</div> contents from the documentation HTML.
    HTML entities are decoded so the returned strings are ready to paste into Designer.
    """
    with open(path, encoding="utf-8") as f:
        src = f.read()
    raw_blocks = re.findall(r'<div class="code-block">(.*?)</div>', src, re.DOTALL)
    return [html.unescape(block.strip()) for block in raw_blocks]


# ── Main ───────────────────────────────────────────────────────────────────────

def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")

    parser = argparse.ArgumentParser(
        description="Create AAD No-Mailbox mail templates in OIM Designer",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
After running:
  Set Importance = High manually on both templates in Designer.
  (Dropdown control has no stable auto_id — not yet automated.)
""",
    )
    parser.add_argument(
        "--commit", action="store_true",
        help="Commit to database after creating both templates",
    )
    parser.add_argument(
        "--doc", default=DOC_PATH,
        help=f"Path to the HTML design document (default: {DOC_PATH})",
    )
    args = parser.parse_args()

    # Verify document exists
    if not os.path.isfile(args.doc):
        print(f"ERROR: Document not found: {args.doc}")
        print("Check the path or use --doc to specify a different location.")
        sys.exit(1)

    # Extract template bodies
    print(f"[create] Reading design document: {args.doc}")
    blocks = extract_code_blocks(args.doc)
    print(f"[create] Extracted {len(blocks)} code block(s).")

    max_needed = max(t["html_idx"] for t in TEMPLATES) + 1
    if len(blocks) < max_needed:
        print(f"ERROR: Expected at least {max_needed} code blocks, found {len(blocks)}.")
        print("The document may have changed — check the indices in this script.")
        sys.exit(1)

    # Connect to Designer
    print("[create] Connecting to Designer...")
    win = get_designer_window()
    print(f"[create] Connected: {win.window_text()}")

    # Create templates
    for t in TEMPLATES:
        create_mail_template(
            win,
            name        = t["name"],
            description = t["description"],
            base_object = t["base_object"],
            subject     = t["subject"],
            html_body   = blocks[t["html_idx"]],
            plain_body  = blocks[t["plain_idx"]],
            importance  = t["importance"],
        )

    print()
    print("=" * 60)
    print("Both templates created successfully.")
    print("REMINDER: Set Importance = High manually on both templates.")
    print("=" * 60)

    if args.commit:
        print("[create] Committing to database...")
        commit_to_database(win)
        print("[create] Committed.")
    else:
        print("[create] Skipped database commit. Run with --commit to deploy.")


if __name__ == "__main__":
    main()
