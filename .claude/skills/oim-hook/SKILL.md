---
name: oim-hook
description: Pre-commit validator for OIM C# plugin conventions — checks all modified .cs files for ConfigureAwait, IApiProviderFor, namespace, string.Format, and other critical conventions.
argument-hint: "[<file-path>]"
user-invocable: true
allowed-tools: "Bash, Read, Glob, Grep"
---

Validate OIM C# plugin files for convention compliance before committing.

## What to check

If `<file-path>` is provided, check only that file. Otherwise, check all `.cs` files staged for commit:

```bash
git diff --name-only --cached | grep "\.cs$"
```

## Convention checks (run all against each file)

### 1. ConfigureAwait(false) — CRITICAL

Every `await` call must be followed by `.ConfigureAwait(false)`.

```bash
# Find awaits missing ConfigureAwait(false)
grep -n "await " <file> | grep -v "ConfigureAwait(false)"
```

Flag: `FAIL: Line N — await missing .ConfigureAwait(false)`

### 2. IApiProviderFor interface — CRITICAL

Every endpoint class must implement `IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>`.

```bash
grep -n "class " <file> | grep -v "IApiProviderFor"
```

Only flag if the class also contains `Build(IApiBuilder builder)` — not all classes are endpoint classes.

### 3. Namespace — CRITICAL

Must be `QBM.CompositionApi` (no sub-namespaces).

```bash
grep -n "^namespace " <file>
```

Flag if namespace is anything other than `QBM.CompositionApi`.

### 4. string.Format with \n — HIGH

`string.Format` must not be used with strings containing `\n` (use `$"..."` interpolation instead).

```bash
grep -n "string\.Format" <file>
```

Check each hit: if the format string contains `\n`, flag it.  
Flag: `WARN: Line N — string.Format with potential \\n issue; use $"..." interpolation`

### 5. Unit of work pattern — HIGH

All DB writes must be inside `StartUnitOfWork()` … `CommitAsync()`.

Check: any `PutAsync(` call that is NOT inside a `using var u = ... StartUnitOfWork()` block.

### 6. TryGetAsync success check — MEDIUM

Any `TryGetAsync(` result must have `.Success` checked before using `.Result` or `.Value`.

```bash
grep -n "TryGetAsync" <file>
```

For each hit, check that the next 3 lines contain `.Success`.

### 7. Assembly attribute — MEDIUM (entry point files only)

If the file contains `IPlugInMethodSetProvider`, it must also have `[assembly: Module(...)]`.

```bash
grep -n "IPlugInMethodSetProvider\|assembly: Module" <file>
```

### 8. AssemblyName suffix — LOW (`.csproj` files)

```bash
grep -n "AssemblyName" <file.csproj>
```

Must end with `.CompositionApi.Server.Plugin`.

## Output format

```
## OIM Hook — Convention Check: <filename>

PASS  ConfigureAwait(false) on all awaits
FAIL  Line 47: await missing .ConfigureAwait(false)  ← IApiProviderFor: PASS  namespace QBM.CompositionApi: PASS
WARN  Line 83: string.Format — verify no \\n in format string
PASS  Unit of work pattern
PASS  TryGetAsync .Success checked

Summary: 1 FAIL, 1 WARN, 5 PASS
Action required: Fix FAIL before committing. Review WARN.
```

## Exit behavior

- Any **FAIL** = block commit (print message, suggest `/oim-review` for deeper analysis)
- Only **WARN** or better = allow commit (print summary and proceed)
- All **PASS** = print "All OIM conventions satisfied." and proceed
