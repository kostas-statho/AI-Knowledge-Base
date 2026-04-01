---
name: oim-plugin
description: Scaffold a complete new OIM CompositionAPI plugin project — entry point, first endpoint, .csproj, and .sln. Use when starting a brand new plugin from scratch.
argument-hint: "<PluginName> [\"first endpoint description\"]"
user-invocable: true
allowed-tools: "Read, Write, Glob, Bash"
---

Scaffold a new OIM CompositionAPI plugin project. Read `Knowledge_Base/templates/` first, then produce the files below.

## Files to create

Given `<PluginName>` (e.g. "MyFeature"), create:

```
Plugins/<PluginName>/
├── <PluginName>.CompositionApi.Server.Plugin.csproj   ← from templates/oim_plugin.csproj
├── <PluginName>.sln
├── CCC_<PluginName>.cs                                ← entry point (from templates/oim_plugin_entry.cs)
└── <PluginName>Action.cs                              ← first endpoint (from templates/oim_endpoint.cs)
```

## .csproj template

Use `templates/oim_plugin.csproj` verbatim — it already has all OIM HintPath DLL references and correct `<TargetFramework>net8.0</TargetFramework>`, `<Nullable>enable</Nullable>`.

## Entry point (CCC_<PluginName>.cs)

Use `templates/oim_plugin_entry.cs` as the base. Replace:
- `MyCCCPlugin` → `CCC_<PluginName>`
- `CustomApiPlugin` → `<PluginName>ApiPlugin`
- `AppId = "MyPlugin"` → `AppId = "<PluginName>"`
- `[assembly: Module("CCC")]` — keep as-is

## First endpoint

Use the `/project:oim-endpoint` skill pattern or `templates/oim_endpoint.cs`. Name it `<PluginName>Action`.

## .sln

Generate a minimal `.sln` referencing the `.csproj`. Follow the format of existing `.sln` files in `Plugins/`.

## After creating files

State:
1. All file paths created
2. Build command: `dotnet build Plugins/<PluginName>/<PluginName>.sln`
3. Deploy: copy `<PluginName>.CompositionApi.Server.Plugin.dll` to OIM API Server plugin directory
4. The first endpoint URL: `POST webportalplus/<pluginname>/action`
