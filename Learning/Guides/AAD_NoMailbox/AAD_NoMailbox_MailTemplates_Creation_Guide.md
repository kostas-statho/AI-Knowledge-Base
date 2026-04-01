# AAD No-Mailbox Mail Templates — Manual Creation Guide

**OIM Designer** | Two templates | ~15 min total

---

## Before You Start

Open these two files in **Notepad** (or any plain-text editor) — you will copy from them:

```
Implementation_Guides\resources\alert_html_body.html
Implementation_Guides\resources\escalation_html_body.html
```

Keep Notepad open beside Designer throughout this guide.

---

## Clean Up (if a partial template exists)

If a previous attempt left a partial `CCC_AAD_NoMailbox_Alert` template:

1. In Designer, left nav → click **Mail Templates**
2. In the object list, right-click `CCC_AAD_NoMailbox_Alert` → **Delete** → confirm
3. Repeat for `CCC_AAD_NoMailbox_Escalation` if it exists

---

## Template 1 — CCC_AAD_NoMailbox_Alert

### Step 1 — Open a new template

1. In Designer's left nav, click **Mail Templates**
2. In the object list (right panel), press **Ctrl+N**
   — a new blank "New mail template" tab opens

### Step 2 — Set the Name

1. Click the **Mail template** field (top of the form)
2. Type exactly:
   ```
   CCC_AAD_NoMailbox_Alert
   ```

### Step 3 — Set the Base Object

1. Click the **Base object** field
2. Type: `AADUser`
3. Wait for the autocomplete dropdown → press **Enter** to confirm
   — the field should show `AADUser`

### Step 4 — Set the Description

1. Click the **Description** field
2. Type:
   ```
   Alert: AAD account active 1+ hour without EXO mailbox
   ```

### Step 5 — Set Importance

1. Find the **Importance** dropdown
2. Select **High**

### Step 6 — Set the Subject

1. Click the **Subject** field
2. Type exactly (including the `$` tokens and square brackets):
   ```
   [ACTION REQUIRED] AAD account '$DisplayName$' has no EXO mailbox (created: $XDateInserted$)
   ```

### Step 7 — Set the HTML Body

1. Switch to **Notepad** — open `alert_html_body.html`
2. Press **Ctrl+A** to select all → **Ctrl+C** to copy
3. Back in Designer, click inside the **top (larger) body editor** — labelled "Page 1 header" in the "Edit mail definition" panel
4. Press **Ctrl+A** to select any existing content
5. Press **Ctrl+V** to paste
   — the editor may briefly show raw HTML — this is correct

### Step 8 — Set the Plain-Text Body

1. Click inside the **bottom body editor** — labelled "Page 1 footer"
2. Press **Ctrl+A**
3. Type or paste the following plain text:

```
ACTION REQUIRED: AAD Account Missing EXO Mailbox (1-Hour Alert)
================================================================

Hello IT Service Desk,

An Azure AD account has been active for MORE THAN 1 HOUR without
an Exchange Online mailbox being provisioned.

ACCOUNT DETAILS
  Display Name    : $DisplayName$
  UPN             : $UserPrincipalName$
  Created (UTC)   : $XDateInserted$
  Account Disabled : $AccountDisabled$

RECOMMENDED ACTIONS
  1. Check M365 Admin Centre for licence and provisioning state.
  2. Verify an Exchange Online plan is assigned.
  3. Review OIM Azure connector sync logs.
  4. Re-provision via OIM Web Portal if sync is stalled.

NOTE: A 4-hour escalation email will follow if unresolved.

---
Automated notification from One Identity Manager. Do not reply.
```

### Step 9 — Save

Press **Ctrl+S** — the template saves and appears in the object list.

---

## Template 2 — CCC_AAD_NoMailbox_Escalation

Repeat all steps with these values:

### Step 1 — Open a new template

Press **Ctrl+N** again (Mail Templates nav must still be selected).

### Step 2 — Name

```
CCC_AAD_NoMailbox_Escalation
```

### Step 3 — Base Object

```
AADUser
```

### Step 4 — Description

```
Escalation: AAD account still without EXO mailbox after 4 hours
```

### Step 5 — Importance

Select **High**

### Step 6 — Subject

```
[ESCALATION] AAD account '$DisplayName$' STILL has no EXO mailbox — 4hrs since $XDateInserted$
```

### Step 7 — HTML Body

1. In Notepad, open `escalation_html_body.html`
2. **Ctrl+A** → **Ctrl+C**
3. Click the **top body editor** in Designer → **Ctrl+A** → **Ctrl+V**

### Step 8 — Plain-Text Body

Click the **bottom body editor**, select all, paste:

```
*** ESCALATION *** AAD Account Missing EXO Mailbox — 4-Hour Escalation
=======================================================================

Hello IT Manager,

An Azure AD account was created OVER 4 HOURS AGO and still has no
Exchange Online mailbox provisioned. Immediate intervention required.

AFFECTED ACCOUNT
  Display Name    : $DisplayName$
  UPN             : $UserPrincipalName$
  Created (UTC)   : $XDateInserted$   <<< OVER 4 HOURS AGO
  Account Disabled : $AccountDisabled$

IMMEDIATE ACTIONS
  1. Contact Service Desk lead — confirm ticket from 1-hour alert.
  2. Log in to M365 Admin Centre and verify licence + provisioning.
  3. Check OIM Azure connector for sync failures.
  4. Perform manual provisioning run if automated sync stalled.
  5. Raise P1 incident if not resolved within 30 minutes.

*** FINAL AUTOMATED NOTIFICATION — manual closure now required ***

---
Automated escalation from One Identity Manager. Do not reply.
```

### Step 9 — Save

Press **Ctrl+S**

---

## Final Step — Commit to Database

After both templates are saved:

1. Click **Commit to database** on the Designer toolbar (first button, top left)
2. Wait for the commit to complete — Designer may show a progress dialog

Both templates are now deployed and available for use in processes.

---

## Verification

After committing:

1. In Designer left nav → **Mail Templates** — both templates appear in the list
2. Click each template — verify Name, Base object, Subject, and both body editors are populated
3. In **Manager** → Notifications → Mail Templates — both templates should be visible there too
