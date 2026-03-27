# How to Use — Office Productivity Library

Step-by-step walkthroughs. Jump to the section you need.

---

## Table of contents

1. [VBA — Import the modules into Excel](#1-vba--import-the-modules-into-excel)
2. [VBA — Open a workbook, read data, write data](#2-vba--open-a-workbook-read-data-write-data)
3. [VBA — Export a sheet to CSV or PDF](#3-vba--export-a-sheet-to-csv-or-pdf)
4. [VBA — Create a bar chart from a range](#4-vba--create-a-bar-chart-from-a-range)
5. [VBA — Automate a PowerPoint presentation](#5-vba--automate-a-powerpoint-presentation)
6. [VBA — Log messages and handle errors](#6-vba--log-messages-and-handle-errors)
7. [.NET — Create an Excel file without Office installed](#7-net--create-an-excel-file-without-office-installed)
8. [.NET — Automate a live Excel session (COM)](#8-net--automate-a-live-excel-session-com)
9. [.NET — Upload a file to SharePoint](#9-net--upload-a-file-to-sharepoint)
10. [.NET — Send a Teams message](#10-net--send-a-teams-message)
11. [.NET — Let Claude read and write your spreadsheet](#11-net--let-claude-read-and-write-your-spreadsheet)

---

## 1. VBA — Import the modules into Excel

Do this once per workbook (or once into your Personal Macro Workbook to have them everywhere).

**Step 1** — Open Excel, press **Alt + F11**.
The Visual Basic Editor opens.

**Step 2** — In the menu bar click **File → Import File...**

**Step 3** — Navigate to `VBA/Shared/` and import these two files first (other modules depend on them):
- `stdLogger.bas`
- `stdErrorHandler.bas`

**Step 4** — Then import whichever Excel modules you need from `VBA/Excel/`:
- `stdWorkbook.bas`
- `stdRange.bas`
- `stdChart.bas`
- `stdExport.bas`

**Step 5** — Close the editor (**Alt + F11** again). The procedures are now available in any macro you write in this workbook.

> **Tip:** To make modules available in every workbook automatically, open your Personal Macro Workbook first (run any macro with "Store macro in: Personal Macro Workbook"), then import into `VBAProject (PERSONAL.XLSB)` instead.

---

## 2. VBA — Open a workbook, read data, write data

```vb
Sub Demo_ReadWrite()
    ' --- open a workbook ---
    Dim wb As Workbook
    Set wb = OpenWorkbook("C:\Reports\Sales.xlsx")
    If wb Is Nothing Then
        MsgBox "Could not open file."
        Exit Sub
    End If

    Dim ws As Worksheet
    Set ws = wb.Sheets("Sheet1")

    ' --- read a range into a 2D array ---
    Dim data As Variant
    data = ReadRangeToArray(ws, "A1:C10")   ' rows 1-10, columns A-C

    ' data(1,1) = cell A1, data(1,2) = cell B1, etc.
    MsgBox "First cell value: " & data(1, 1)

    ' --- write data back (same size array) ---
    data(1, 1) = "Updated"
    WriteArrayToRange ws, "A1", data

    ' --- make it look nice ---
    FormatRange ws, "A1:C1", True, RGB(173, 216, 230)   ' header row: bold + light blue
    AutoFitColumns ws

    ' --- save and close ---
    SaveWorkbookAs wb, "C:\Reports\Sales_Updated.xlsx"
    CloseWorkbook wb, False   ' False = don't save again (we already saved)
End Sub
```

---

## 3. VBA — Export a sheet to CSV or PDF

```vb
Sub Demo_Export()
    Dim wb As Workbook
    Set wb = ThisWorkbook   ' the workbook that contains this macro

    Dim ws As Worksheet
    Set ws = wb.Sheets("Data")

    ' Export just this sheet as CSV
    ExportSheetToCSV ws, "C:\Exports\data.csv"

    ' Export the whole workbook as PDF
    ExportWorkbookToPDF wb, "C:\Exports\report.pdf"

    ' Copy a specific range to a brand-new workbook file
    ExportRangeToNewWorkbook ws, "A1:F50", "C:\Exports\subset.xlsx"

    MsgBox "Done!"
End Sub
```

---

## 4. VBA — Create a bar chart from a range

```vb
Sub Demo_Chart()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Sheet1")

    ' Assume A1:B5 has two columns: labels in A, values in B

    Dim ch As Chart
    Set ch = CreateBarChart(ws, "A1:B5", "Monthly Sales")

    ' Later — if the data changes, update the chart
    UpdateChartSeries ch, "A1:B8"   ' now covers 8 rows

    ' Save the chart as a PNG image
    ExportChartAsPng ch, "C:\Charts\monthly_sales.png"
End Sub
```

> **Layout note:** The chart is placed at pixel position Left=200, Top=30 on the sheet by default. Move it by dragging in Excel after creation, or edit the `Left`/`Top` values in `stdChart.bas`.

---

## 5. VBA — Automate a PowerPoint presentation

**Import first:** `VBA/Shared/stdLogger.bas`, `VBA/Shared/stdErrorHandler.bas`, then `VBA/PowerPoint/stdPresentation.bas`, `stdSlide.bas`, `stdShape.bas`.

```vb
Sub Demo_PowerPoint()
    ' Open an existing presentation
    Dim prs As Presentation
    Set prs = OpenPresentation("C:\Decks\Template.pptx")
    If prs Is Nothing Then
        MsgBox "Could not open presentation."
        Exit Sub
    End If

    ' Add a new slide at position 2 using layout 1 (Title Slide)
    ' Common layout numbers: 1=Title, 2=Title+Content, 11=Blank
    Dim sld As Slide
    Set sld = AddSlide(prs, 2, 2)
    SetSlideTitle sld, "Q1 Results"

    ' Add a text box (position in points: left=50, top=150, width=600, height=100)
    AddTextBox sld, "Revenue grew 12% vs last quarter.", 50, 150, 600, 100

    ' Insert an image
    InsertImage sld, "C:\Images\logo.png", 600, 450, 100, 50

    ' Duplicate slide 1 to the end (e.g. a "thank you" template)
    CloneSlide prs, 1

    ' Export the whole deck to PDF
    ExportToPDF prs, "C:\Decks\Q1_Results.pdf"

    ' Save and close
    SavePresentationAs prs, "C:\Decks\Q1_Results.pptx"
    ClosePresentation prs, False
End Sub
```

---

## 6. VBA — Log messages and handle errors

Use `stdLogger` to record what your macro is doing. Logs appear in the **Immediate window** (View → Immediate Window) and optionally on a "Log" sheet.

```vb
Sub Demo_WithLogging()
    On Error GoTo Catch

    LogInfo "Starting report generation"

    Dim wb As Workbook
    Set wb = OpenWorkbook("C:\data.xlsx")
    If wb Is Nothing Then
        LogWarn "File not found, using ActiveWorkbook instead"
        Set wb = ActiveWorkbook
    End If

    ' ... do work ...

    LogInfo "Report complete"
    Exit Sub

Catch:
    ' HandleError logs the error and shows a message box
    HandleError "Demo_WithLogging", Err
End Sub
```

**Immediate window output:**
```
[INFO] Starting report generation
[WARN] File not found, using ActiveWorkbook instead
[INFO] Report complete
```

---

## 7. .NET — Create an Excel file without Office installed

Use `ExcelFileHelper` (powered by ClosedXML). Office does **not** need to be installed.

```vb
Imports OfficeProductivity.Excel

Sub CreateReport()
    Using helper As New ExcelFileHelper()
        ' Create a brand-new workbook
        Dim wb = helper.CreateWorkbook()
        Dim ws = wb.Worksheets.First()
        ws.Name = "Report"

        ' Write a 3x3 block of data starting at A1
        Dim data(2, 2) As String
        data(0, 0) = "Name"  : data(0, 1) = "Score" : data(0, 2) = "Grade"
        data(1, 0) = "Alice" : data(1, 1) = "92"    : data(1, 2) = "A"
        data(2, 0) = "Bob"   : data(2, 1) = "78"    : data(2, 2) = "B"
        helper.WriteRange(ws, "A1", data)

        ' Save to disk
        helper.SaveAs(wb, "C:\Reports\output.xlsx")
    End Using
    Console.WriteLine("Done — no Excel needed.")
End Sub
```

---

## 8. .NET — Automate a live Excel session (COM)

Use `ExcelComHelper` when Excel is (or will be) open and you want to interact with a real Excel session — for example to trigger calculations, work with charts, or run macros.

> **Important:** COM requires a Windows STA thread. `ExcelComHelper` handles this automatically via `ThreadingHelper.RunOnSta()`. Do not call COM methods from an ASP.NET thread pool thread.

```vb
Imports OfficeProductivity.Excel

Sub AutomateExcel()
    Using excel As New ExcelComHelper()
        ' Opens Excel in the background (hidden)
        Dim wb = excel.OpenWorkbook("C:\data.xlsx")
        Dim ws = wb.Sheets("Sheet1")

        ' Read values
        Dim values = excel.ReadRange(ws, "A1:C5")
        Console.WriteLine($"Cell A1 = {values(0, 0)}")

        ' Write values
        Dim newData(1, 1) As String
        newData(0, 0) = "Updated" : newData(0, 1) = "2026-03-27"
        newData(1, 0) = "Done"    : newData(1, 1) = "Yes"
        excel.WriteRange(ws, "A1", newData)

        excel.SaveAs(wb, "C:\data_updated.xlsx", XlFileFormat.xlOpenXMLWorkbook)
        excel.Close(wb, save:=False)
    End Using   ' Excel quits and all COM objects are released
End Sub
```

---

## 9. .NET — Upload a file to SharePoint

You need an Azure AD app registration with `Files.ReadWrite.All` permission (or delegated permission for interactive login).

```vb
Imports OfficeProductivity.M365
Imports OfficeProductivity.Common

Async Function UploadReport() As Task
    ' Build an authenticated Graph client using a service principal
    Dim factory As New GraphCredentialFactory()
    Dim client = factory.Build(
        AuthMode.ServicePrincipal,
        tenantId    := "your-tenant-id",
        clientId    := "your-app-client-id",
        clientSecret:= "your-app-secret"
    )

    Dim sp As New SharePointHelper(client)

    ' siteId and driveId: find them via Graph Explorer
    ' https://developer.microsoft.com/en-us/graph/graph-explorer
    Await sp.UploadFileAsync(
        siteId     := "your-site-id",
        driveId    := "your-drive-id",
        remotePath := "/Reports/Q1_Results.xlsx",   ' path inside the document library
        localPath  := "C:\Reports\Q1_Results.xlsx"
    )

    Console.WriteLine("Uploaded.")
End Function
```

**How to find siteId and driveId:**
1. Go to https://developer.microsoft.com/en-us/graph/graph-explorer
2. Sign in with your M365 account
3. `GET https://graph.microsoft.com/v1.0/sites?search=YourSiteName` → copy `id`
4. `GET https://graph.microsoft.com/v1.0/sites/{siteId}/drives` → copy the `id` of your document library

---

## 10. .NET — Send a Teams message

```vb
Imports OfficeProductivity.M365
Imports OfficeProductivity.Common

Async Function NotifyTeam() As Task
    Dim factory As New GraphCredentialFactory()
    Dim client = factory.Build(
        AuthMode.ServicePrincipal,
        tenantId    := "your-tenant-id",
        clientId    := "your-app-client-id",
        clientSecret:= "your-app-secret"
    )

    Dim teams As New TeamsHelper(client)

    ' teamId and channelId: right-click channel in Teams → Get link to channel
    ' The link contains the IDs encoded in the URL
    Await teams.SendMessageAsync(
        teamId    := "your-team-id",
        channelId := "your-channel-id",
        message   := "Q1 report has been uploaded to SharePoint."
    )
End Function
```

---

## 11. .NET — Let Claude read and write your spreadsheet

### Option A — Paste tool definitions into a Claude API call

```vb
Imports OfficeProductivity.AgentTools

' Get the JSON tool definitions
Dim registry As New ToolRegistry()
Dim toolsJson As String = registry.ToClaudeToolsJson()

' toolsJson is a JSON array ready to drop into the Claude API "tools" parameter.
' Example: POST https://api.anthropic.com/v1/messages
' {
'   "model": "claude-opus-4-6",
'   "tools": <toolsJson here>,
'   "messages": [{"role": "user", "content": "Read the Sales sheet from C:\\data.xlsx"}]
' }
```

When Claude decides to call `read_sheet`, your code receives a `tool_use` block. Pass the `input` JSON to the matching tool:

```vb
' Claude returned tool_use: { "name": "read_sheet", "input": "{...}" }
Dim tool = registry.GetAll().First(Function(t) t.Name = "read_sheet")
Dim result As String = Await tool.ExecuteAsync(inputJson, CancellationToken.None)
' result is a JSON array of rows — send it back to Claude as a tool_result message
```

### Option B — Use the MCP server (Claude Code)

The MCP server lets Claude Code discover and call the tools automatically — no manual wiring needed.

**Start the server:**
```bash
cd VBNetLibrary/src/McpServer
dotnet run
```

**Add it to Claude Code** (`.claude/settings.json` or via `/mcp` command):
```json
{
  "mcpServers": {
    "office": {
      "command": "dotnet",
      "args": ["run", "--project", "C:\\path\\to\\VBNetLibrary\\src\\McpServer"]
    }
  }
}
```

After restarting Claude Code, you can say things like:
- *"Read the data from C:\Sales.xlsx, Sheet1, range A1:D20"*
- *"Create a presentation with 3 slides about Q1 results and save it to C:\deck.pptx"*
- *"Export the Budget sheet from C:\Finance.xlsx to C:\budget.csv"*

---

## Common mistakes

| Mistake | Fix |
|---|---|
| Imported a module but procedures aren't visible | Make sure `Option Explicit` is at the top of your module — then re-import |
| `stdRange` / `stdChart` errors | Did you import `stdLogger` and `stdErrorHandler` from `Shared/` first? |
| `ExcelComHelper` hangs or crashes on a server | Use `ExcelFileHelper` (ClosedXML) instead — COM requires a desktop session |
| Graph API returns 403 Forbidden | Check your Azure AD app has the right API permissions granted by an admin |
| `dotnet build` fails on non-Windows | The project targets `net8.0-windows` — it must be built on Windows |
| COM object not released, Excel stays open | Always wrap `ExcelComHelper` / `PowerPointComHelper` in a `Using` block |
