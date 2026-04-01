# Office Productivity Library

A ready-to-use toolkit for automating Excel, PowerPoint, and Microsoft 365 from VBA macros or .NET code. Pick the layer that fits your situation — no need to use all of it.

---

## Which part do I need?

| I want to... | Use this |
|---|---|
| Write a quick Excel/PowerPoint macro | **VBA modules** (`VBA/`) |
| Automate Office from a C# or VB.NET app, Office is installed | **VBNetLibrary — COM helpers** |
| Generate `.xlsx` / `.pptx` files on a server (no Office installed) | **VBNetLibrary — File helpers** (ClosedXML / ShapeCrawler) |
| Upload files to SharePoint or send Teams messages | **VBNetLibrary — M365 helpers** |
| Let Claude AI read/write your spreadsheets | **VBNetLibrary — Agent Tools** |

---

## Folder layout

```
Office_Productivity/
├── README.md           ← you are here
├── HOW_TO_USE.md       ← step-by-step examples for beginners
├── Resources.md        ← links to libraries and docs used
│
├── VBA/                ← copy-paste macros, works in any Excel/PowerPoint
│   ├── Excel/          ← stdWorkbook, stdRange, stdChart, stdExport
│   ├── PowerPoint/     ← stdPresentation, stdSlide, stdShape
│   └── Shared/         ← stdLogger, stdErrorHandler (used by all modules)
│
└── VBNetLibrary/       ← .NET 8 class library
    ├── src/
    │   ├── Common/     ← helper utilities (COM cleanup, STA threading, config)
    │   ├── Excel/      ← ExcelComHelper (live COM), ExcelFileHelper (ClosedXML)
    │   ├── PowerPoint/ ← PowerPointComHelper (live COM), PowerPointFileHelper (ShapeCrawler)
    │   ├── M365/       ← Graph API: SharePoint upload/download, Teams messages
    │   ├── AgentTools/ ← 6 tools Claude can call (read sheet, write sheet, export, ...)
    │   └── McpServer/  ← runs the MCP server so Claude Code can use the tools
    └── tests/          ← automated tests (xUnit)
```

---

## VBA Modules

### What each module does

**Excel**

| Module | What it does |
|---|---|
| `stdWorkbook` | Open, save, close, and password-protect workbooks |
| `stdRange` | Read a range into a variable, write data back, bold/colour cells, auto-fit columns |
| `stdChart` | Create a bar chart from a data range, update its data, save it as a PNG |
| `stdExport` | Save a sheet as CSV, export the whole workbook to PDF, copy a range to a new file |

**PowerPoint**

| Module | What it does |
|---|---|
| `stdPresentation` | Open, save-as, export to PDF, close presentations |
| `stdSlide` | Add a new slide, duplicate a slide, delete a slide, set its title |
| `stdShape` | Add a text box, insert an image, add a table, apply a theme file |

**Shared (use in any module)**

| Module | What it does |
|---|---|
| `stdLogger` | Write log messages to the Immediate window and optionally a "Log" sheet |
| `stdErrorHandler` | Standard error-catch wrapper — shows a message box and logs the error |

### How to import a module

1. Open Excel or PowerPoint
2. Press **Alt + F11** to open the VBA editor
3. In the menu: **File → Import File...**
4. Browse to `VBA/Excel/` (or `VBA/PowerPoint/`, `VBA/Shared/`)
5. Select the `.bas` file and click **Open**
6. The module appears in the left-hand **Project** panel — done

> Always import `stdLogger.bas` and `stdErrorHandler.bas` from `VBA/Shared/` first — the other modules use them.

---

## VBNetLibrary (.NET 8)

### Build it

```bash
cd VBNetLibrary
dotnet build OfficeProductivity.sln
```

Requires: Windows + .NET 8 SDK. Office only needed for the COM helpers (the File helpers work without it).

### Run the tests

```bash
dotnet test
```

### Two modes for Excel and PowerPoint

Every Excel/PowerPoint operation comes in two flavours:

| Class | When to use |
|---|---|
| `ExcelComHelper` | Office is installed; you need charts, macros, or need to work with a file already open in Excel |
| `ExcelFileHelper` | No Office; generating reports on a server; faster for large file creation |
| `PowerPointComHelper` | Office installed; export to PDF; use PPT animations/themes |
| `PowerPointFileHelper` | No Office; quickly create or read `.pptx` files |

Both classes have the same method names — you can swap one for the other without changing your calling code.

### M365 / Graph API helpers

Three helpers for Microsoft 365:

| Class | What it does |
|---|---|
| `GraphCredentialFactory` | Creates the authenticated Graph client (choose: service principal, interactive login, or managed identity) |
| `SharePointHelper` | Upload a file, download a file, list files in a folder |
| `TeamsHelper` | Post a message to a Teams channel, create a channel |

### Agent Tools (Claude integration)

Six tools that Claude AI can call directly:

| Tool name | What it does |
|---|---|
| `read_sheet` | Reads rows from an Excel sheet, returns them as JSON |
| `write_sheet` | Writes JSON rows into an Excel sheet |
| `export_csv` | Exports a sheet to a CSV file |
| `create_presentation` | Creates a new `.pptx` from a JSON slide spec |
| `add_slide` | Adds a slide with a title and content to an existing presentation |
| `export_pdf` | Exports a presentation to PDF |

Get the tool definitions for the Claude API:

```vb
Dim registry As New ToolRegistry()
Dim json As String = registry.ToClaudeToolsJson()
' paste json into the "tools" parameter of your Claude API call
```

### MCP Server

Starts a local server so Claude Code can discover and call the tools automatically:

```bash
cd VBNetLibrary/src/McpServer
dotnet run
```

---

## See also

- **[HOW_TO_USE.md](HOW_TO_USE.md)** — beginner walkthroughs with copy-paste examples
- **[Resources.md](Resources.md)** — links to all external libraries and docs
