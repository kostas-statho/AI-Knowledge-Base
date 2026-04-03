---
name: oim-vbnet
description: Generate a VB.NET script for an OIM process handler, mail template event, scheduled task, or custom function. Use when adding VB.NET code to OIM Designer.
argument-hint: "\"<description of what the script should do>\" [<category>]"
user-invocable: true
allowed-tools: "Read, Write, Glob"
---

Generate a VB.NET script for use inside the One Identity Manager Designer (process steps, mail template conditions, scheduled tasks, custom functions, or script library entries).

## Categories

Map the request to a category (or accept the user's `<category>` argument):

| Category | Typical use |
|---|---|
| `01_Processes` | Pre/post process steps, condition scripts |
| `02_MailTemplates` | Mail template subject/body scripts |
| `03_Schedulers` | Scheduled task handlers |
| `04_CustomFunctions` | Reusable library functions |
| `05_Provisioning` | AD/AAD/Exchange provisioning events |
| `06_Attestation` | Attestation decision/reminder scripts |
| `07_ITShop` | IT Shop request handling and approvals |
| `08_Roles` | Business role / application role assignment |
| `09_Compliance` | Rule violation handling |
| `10_DataQuality` | Data quality check scripts |
| `11_Notifications` | Notification escalation logic |
| `12_Misc` | Utility scripts, experiments |

## OIM VB.NET Patterns

### Session object (available in all Designer scripts as `Session`)

```vbnet
' Read a value
Dim val As String = Session.Config().GetConfigurationParameter("Custom\Path\Param").Value

' Load a single entity
Dim person As IEntity = Session.Source().GetTree(
    Query.From("Person").Select("UID_Person", "DisplayName").Where("UID_Person='" & uid & "'"),
    EntityLoadType.DelayedLogic
).First()

' Write via unit of work
Using uow As IUnitOfWork = Session.StartUnitOfWork()
    person("FirstName") = "NewValue"
    uow.Put(person)
    uow.Commit()
End Using

' Check if entity exists
Dim exists As Boolean = Session.Source().Exists(Query.From("Table").Where("..."))

' Current user
Dim currentUID As String = Session.User().Uid
```

### Direct manipulation (for scheduler/process context)

```vbnet
' DirectOperations gives raw DB access
Dim ops As IDirectOperations = Session.Source().DirectOperations()
ops.Execute("UPDATE Person SET FirstName='X' WHERE UID_Person='" & uid & "'")
```

### Error handling (always include)

```vbnet
Try
    ' ... logic ...
Catch ex As Exception
    Session.Source().DirectOperations().Execute("..." )
    Throw New Exception("oim-vbnet: " & ex.Message)
End Try
```

### Common table columns

- `Person`: UID_Person, FirstName, LastName, CentralAccount, IsExternal, XDateInserted
- `Department`: UID_Department, Ident_Department, UID_PersonHead
- `ITShopOrg`: UID_ITShopOrg, Ident_Org, UID_AccProduct
- `PersonInDepartment`: UID_Person, UID_Department, XOrigin (1=direct,2=inherited)

## Rules

1. No `Imports` statements — all types are fully qualified or already available in scope
2. Use `Session.Source().GetTree()` not direct SQL for entity reads (respects permissions)
3. All string comparisons: `String.Compare(a, b, StringComparison.OrdinalIgnoreCase) = 0`
4. Return `True`/`False` from condition scripts, never `1`/`0`
5. Log significant actions: `Session.Source().DirectOperations().Execute("INSERT INTO OIM_Log...")`  
   (or use standard OIM logging if available)
6. Never use `Exit Sub` — use structured `Try/Catch/Finally`

## Output

Write the file to `OIM/VBNet/<NN_Category>/descriptive_verb.vb`.

Add the standard metadata header at the top:
```vb
' Purpose: [one-line description]
' Category: [from list above]
' OIM-Ver: 9.3
' Added: [YYYY-MM-DD]
```

State the full file path and where in OIM Designer to paste the script (process step name, mail template field, or script library entry name).
