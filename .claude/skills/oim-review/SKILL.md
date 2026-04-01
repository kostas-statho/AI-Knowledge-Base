---
name: oim-review
description: Audit an OIM CompositionAPI plugin file or directory for correctness, best practices, security, and completeness. Use before deploying a plugin or after making significant changes.
argument-hint: "<file-or-directory-path>"
user-invocable: true
allowed-tools: "Read, Grep, Glob"
---

Read the specified file(s) and audit them against the OIM plugin checklist below. Do NOT modify any files — report findings only.

## Checklist

### Correctness
- [ ] Every `await` has `.ConfigureAwait(false)` — zero exceptions
- [ ] Strings with `\n` use `$"..."` interpolation, not `string.Format` with verbatim strings
- [ ] `using var u = qr.Session.StartUnitOfWork()` wraps all DB writes (not bare PutAsync)
- [ ] `UnitOfWork.CommitAsync(ct)` is called after every `PutAsync`
- [ ] `TryGetAsync` result is checked for `.Success` before accessing `.Result`

### Security
- [ ] No raw SQL string concatenation with user input (use parameterised queries or OIM Query API)
- [ ] Eligibility/permission check before performing any action (e.g. ExistsAsync to verify user is the eligible approver)
- [ ] No hardcoded credentials or UIDs

### OIM Conventions
- [ ] Namespace is `QBM.CompositionApi`
- [ ] All endpoint classes implement both `IApiProvider` and `IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>`
- [ ] Route starts with `webportalplus/`
- [ ] Entry point implements `IPlugInMethodSetProvider` → `IMethodSetProvider`
- [ ] `[assembly: Module("CCC")]` present in entry point file
- [ ] `AppId` set to a unique, meaningful string

### Completeness (bulk actions only)
- [ ] All 4 endpoints present: startaction, validate, action, endaction
- [ ] startaction returns `{ message, permission }`
- [ ] validate returns `object[]` per-row
- [ ] endaction returns `{ message, allImported }`

### Code quality
- [ ] No unused `using` statements
- [ ] `PostedID` / `PostedData` classes match the expected JSON contract
- [ ] No `Thread.Sleep` or blocking calls

## Output format

List findings as:
- ✅ Pass — if the checklist item is satisfied
- ⚠️ Warning — if it's a non-blocking issue
- ❌ Fail — if it's a blocking issue

End with a summary: **N issues found (X critical, Y warnings)** and recommend next steps.
