---
name: oim-deploy
description: Generate a deployment checklist and release notes for an OIM plugin. Use before deploying a plugin to a test or production OIM API Server.
argument-hint: "<plugin-project-name> [version]"
user-invocable: true
allowed-tools: "Read, Glob, Bash"
---

Read the specified plugin directory and generate:
1. A pre-deployment checklist
2. A release notes summary

## Step 1 — Read the plugin

Glob `Plugins/<plugin-project-name>/**/*.cs` and read:
- The entry point file (contains `IPlugInMethodSetProvider`)
- All endpoint files

## Step 2 — Pre-deployment checklist

```
## Pre-deployment Checklist — <PluginName> v<version>
Date: <today>

### Build
- [ ] dotnet build <plugin>.sln — zero errors, zero warnings
- [ ] Output DLL: Plugins/<plugin>/bin/Debug/net8.0/<plugin>.CompositionApi.Server.Plugin.dll

### OIM Environment
- [ ] OIM API Server version confirmed: 9.3
- [ ] Plugin DLL copied to: C:\Program Files\One Identity\One Identity Manager\<ApiServerPluginsDir>\
- [ ] Old DLL version backed up before overwrite
- [ ] API Server service restarted after DLL copy

### Endpoints to test
<list each endpoint with: METHOD webportalplus/<route> — what it does>

### Smoke tests
<list 2-3 quick manual tests for the main happy path>

### Rollback plan
- [ ] Previous DLL backup available at: <backup path>
- [ ] Restore: stop API Server → copy backup → restart API Server
```

## Step 3 — Release notes

```
## Release Notes — <PluginName> v<version>
Date: <today>

### What's new
<bullet list of endpoints added or changed>

### Endpoints
| Method | Route | Description |
|---|---|---|
<one row per endpoint>

### Dependencies
- OIM 9.3 API Server
- DLLs from: C:\Program Files\One Identity\One Identity Manager\

### Notes
<any migration steps, config params to add, or known limitations>
```

Output both sections as markdown. Do not create any files — display the output for the user to copy.
