# Office Productivity Library

Reusable, exportable toolkit for Excel, PowerPoint, Microsoft 365 Graph API, and Claude AI agent integration.

## Structure

| Path | Purpose |
|---|---|
| `VBA/Excel/` | Importable `.bas` modules for Excel automation |
| `VBA/PowerPoint/` | Importable `.bas` modules for PowerPoint automation |
| `VBA/Shared/` | Logger and error-handler shared by all VBA modules |
| `VBNetLibrary/src/` | .NET 8 class library (COM + OpenXML + M365 + Agent tools) |
| `VBNetLibrary/src/McpServer/` | MCP server exposing tools to Claude Code |
| `VBNetLibrary/tests/` | xUnit tests |

## VBA Quick Reference

| Module | Key Procedures |
|---|---|
| `stdWorkbook` | `OpenWorkbook`, `SaveWorkbookAs`, `CloseWorkbook`, `ProtectSheet` |
| `stdRange` | `ReadRangeToArray`, `WriteArrayToRange`, `FormatRange`, `AutoFitColumns` |
| `stdChart` | `CreateBarChart`, `UpdateChartSeries`, `ExportChartAsPng` |
| `stdExport` | `ExportSheetToCSV`, `ExportWorkbookToPDF`, `ExportRangeToNewWorkbook` |
| `stdPresentation` | `OpenPresentation`, `SavePresentationAs`, `ExportToPDF`, `ClosePresentation` |
| `stdSlide` | `AddSlide`, `CloneSlide`, `DeleteSlide`, `SetSlideTitle` |
| `stdShape` | `AddTextBox`, `InsertImage`, `AddTable`, `ApplyTheme` |
| `stdLogger` | `LogInfo`, `LogWarn`, `LogError` |
| `stdErrorHandler` | `HandleError` |

## .NET Quick Reference

| Class | Engine | Key Methods |
|---|---|---|
| `ExcelComHelper` | COM (Office required) | `OpenWorkbook`, `ReadRange`, `WriteRange`, `CreateChart`, `Close` |
| `ExcelFileHelper` | ClosedXML (no Office) | `OpenWorkbook`, `ReadRange`, `WriteRange`, `SaveAs` |
| `PowerPointComHelper` | COM (Office required) | `Open`, `AddSlide`, `ExportToPdf`, `Close` |
| `PowerPointFileHelper` | ShapeCrawler (no Office) | `Open`, `CreateNew`, `AddTextBox`, `SaveAs` |
| `GraphCredentialFactory` | Azure.Identity | `Build(AuthMode, tenantId, clientId, ...)` |
| `SharePointHelper` | Graph + PnP | `UploadFileAsync`, `DownloadFileAsync`, `ListFilesAsync` |
| `TeamsHelper` | Graph | `SendMessageAsync`, `CreateChannelAsync` |
| `ToolRegistry` | — | `ToClaudeToolsJson()`, `ToMcpManifestJson()` |

## Agent Tools (6 total)

**Excel:** `read_sheet`, `write_sheet`, `export_csv`
**PowerPoint:** `create_presentation`, `add_slide`, `export_pdf`

## Build & Deploy

```bash
cd VBNetLibrary
dotnet build OfficeProductivity.sln
dotnet test
```

**VBA Import:** VBA IDE → File → Import File → select any `.bas` file

## MCP Server

```bash
cd VBNetLibrary/src/McpServer
dotnet run
```

Exposes all agent tools via Model Context Protocol for use with Claude Code.
