---
name: oim-process
description: Generate an OIM process chain definition — process steps, parameters, pre/post conditions, and VB.NET event scripts — as a structured spec ready to configure in OIM Designer.
argument-hint: "\"<process name>\" <trigger-event> [<table>]"
user-invocable: true
allowed-tools: "Read, Glob"
---

Generate a complete OIM process chain specification for the given process name and trigger event.

## What to produce

A structured markdown spec covering:
1. **Process overview** — name, table, trigger event, purpose
2. **Parameters** — list of process parameters with type, direction, and default
3. **Process steps** — ordered table with step name, component, parameters mapped
4. **Condition scripts** — any VB.NET pre/post conditions
5. **Configuration notes** — Designer UI path, related processes to check

## Common trigger events

| Event | When it fires |
|---|---|
| `Insert` | After new object created |
| `Update` | After object column changed |
| `Delete` | Before/after object deleted |
| `Custom_<name>` | Manually raised by script or process |
| `Assign_<table>` | When membership assignment created |
| `Remove_<table>` | When membership assignment removed |

## Standard process structure

```
Process: <ProcessName>
Table:   <TableName>
Event:   <TriggerEvent>
Order:   1000  (default; adjust to run before/after built-in processes)

Parameters:
  UID_<Table>  — String, In, from trigger object's UID column
  [additional params]

Steps:
  Step 10 — CheckCondition
    Component: CallProcess
    Condition: [VB.NET: return True/False]

  Step 20 — MainAction
    Component: <Component name, e.g. ADSAccountCreate, MailComponent>
    Parameters:
      Param1 = Value1
      Param2 = Value2

  Step 30 — Notification (optional)
    Component: SendMail
    Parameters:
      MailTemplate = <template name>
      UID_Person   = $par[UID_Person]

Pre-condition script (optional VB.NET):
  ' Only run if person is active
  Return Session.Source().Exists(
      Query.From("Person").Where("UID_Person='" & $par[UID_Person] & "' AND Enabled=1"))

Post-processing script (optional VB.NET):
  ' Log completion
  ...
```

## Key OIM process components

| Component | Purpose |
|---|---|
| `CallProcess` | Invoke another process |
| `ADSAccountCreate` | Create AD account |
| `ADSAccountUpdate` | Update AD account attributes |
| `ExchangeMailboxCreate` | Create Exchange mailbox |
| `SendMail` | Send mail via MailComponent |
| `JobServiceMessage` | Send job service message |
| `ScriptComponent` | Run arbitrary VB.NET |
| `HandleObjectComponent` | Modify the trigger object |

## Rules

1. Always specify `Order` value — default 1000, lower runs first
2. Use `$par[ParameterName]` syntax for parameter references in step values
3. Pre-condition returning `False` aborts the process silently (no error)
4. Never hardcode UIDs — always use parameter references
5. If touching AD/Exchange, check that the account's target system object is `Synchronized` first

## Output

Print the full structured spec in a code block labeled `Process Spec`. Do NOT write files — this is a design document to be manually configured in OIM Designer.

At the end, remind the user to:
- Test with a single object before enabling for all
- Check `Job Queue` after triggering the process
- Verify `Error objects` is empty after the first run
