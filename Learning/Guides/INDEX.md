# Learning/Guides — Implementation Guide Index

> Step-by-step scenario guides for specific OIM implementation tasks.
> New scenarios: create a `Learning/Guides/ScenarioName/` subfolder, add files, then add a row here.

---

## Scenarios

| Scenario | Folder | Files | Status | OIM Ver | Added |
|---|---|---|---|---|---|
| AAD No-Mailbox Provisioning | `AAD_NoMailbox/` | 6 | Complete | 9.3 | 2026-03-28 |
| Control 3 — AD Group Audit | `Control3_ADGroup_Audit/` | 1 | New | 9.3 | 2026-04-01 |
| O3 Mailbox Conversion | `O3EMailbox_Conversion/` | 1 | New | 9.3 | 2026-04-01 |

---

## Scenario Details

### AAD_NoMailbox — Azure AD No-Mailbox Provisioning

Covers the full workflow for provisioning AAD users who do not have an Exchange mailbox, including alert and escalation notification process chains.

| File | Purpose |
|---|---|
| `aad_nomailbox_implementation_guide.html` | Full implementation walkthrough |
| `AAD_NoMailbox_BareMinimum.html` | Minimal viable implementation |
| `AAD_NoMailbox_MailTemplates_Creation_Guide.md` | Step-by-step: create alert + escalation mail templates in Designer |
| `AAD_NoMailbox_ProcessChain_Guide.html` | Full process chain configuration |
| `AAD_NoMailbox_ProcessChain_Improvements.html` | Enhanced process chain with improvements |
| `AAD_NoMailbox_ProcessChain_Simplified.html` | Simplified process chain variant |

**Email tokens used:** `$DisplayName$`, `$UserPrincipalName$`, `$XDateInserted$`
**Template names:** `CCC_AAD_NoMailbox_Alert`, `CCC_AAD_NoMailbox_Escalation`
**HTML bodies:** `resources/alert_html_body.html`, `resources/escalation_html_body.html`

---

## Shared Resources (`resources/`)

| File | Purpose |
|---|---|
| `alert_html_body.html` | HTML body for alert email templates |
| `escalation_html_body.html` | HTML body for escalation email templates |
| `"image (15).png"` | Process chain diagram |

---

## Adding a New Scenario

1. Create `Learning/Guides/NewScenario/`
2. Put all scenario files inside it
3. Add shared HTML fragments to `resources/`
4. Add row to this INDEX.md
5. Add row to root `INDEX.md`
6. Commit: `/git-commit-push`
