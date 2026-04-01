Imports System.IO
Imports System.Text.Json
Imports System.Threading
Imports OfficeProductivity.Excel

Namespace AgentTools
    Public Class ReadSheetTool
        Implements IOfficeAgentTool
        Private ReadOnly _helper As New ExcelFileHelper()

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "read_sheet"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Read data from an Excel worksheet range. Returns rows as a JSON array."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """workbook_path"":{""type"":""string""}," &
                       """sheet_name"":{""type"":""string""}," &
                       """range"":{""type"":""string"",""description"":""A1 notation (optional)""}" &
                       "},""required"":[""workbook_path"",""sheet_name""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim path = doc.RootElement.GetProperty("workbook_path").GetString()
            Dim sheet = doc.RootElement.GetProperty("sheet_name").GetString()
            Dim wb = _helper.OpenWorkbook(path)
            Dim ws = wb.Worksheet(sheet)
            Dim rngEl As JsonElement
            Dim rng = If(doc.RootElement.TryGetProperty("range", rngEl),
                         ws.Range(rngEl.GetString()),
                         ws.RangeUsed())
            If rng Is Nothing Then Return "[]"
            Dim rows As New List(Of List(Of String))
            For Each row In rng.Rows()
                rows.Add(row.Cells().Select(Function(c) c.GetString()).ToList())
            Next
            Return JsonSerializer.Serialize(rows)
        End Function
    End Class

    Public Class WriteSheetTool
        Implements IOfficeAgentTool
        Private ReadOnly _helper As New ExcelFileHelper()

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "write_sheet"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Write rows of data to an Excel worksheet. Creates the file if it does not exist."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """workbook_path"":{""type"":""string""}," &
                       """sheet_name"":{""type"":""string""}," &
                       """start_cell"":{""type"":""string""}," &
                       """rows"":{""type"":""array"",""items"":{""type"":""array""}}" &
                       "},""required"":[""workbook_path"",""sheet_name"",""start_cell"",""rows""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim path = doc.RootElement.GetProperty("workbook_path").GetString()
            Dim sheet = doc.RootElement.GetProperty("sheet_name").GetString()
            Dim startCell = doc.RootElement.GetProperty("start_cell").GetString()
            Dim wb = If(File.Exists(path), _helper.OpenWorkbook(path), _helper.CreateWorkbook())
            If Not wb.Worksheets.Any(Function(w) w.Name = sheet) Then wb.Worksheets.Add(sheet)
            Dim ws = wb.Worksheet(sheet)
            Dim baseCell = ws.Cell(startCell)
            Dim r = 0
            For Each rowEl In doc.RootElement.GetProperty("rows").EnumerateArray()
                Dim c = 0
                For Each cell In rowEl.EnumerateArray()
                    ws.Cell(baseCell.Address.RowNumber + r, baseCell.Address.ColumnNumber + c).Value = cell.GetString()
                    c += 1
                Next
                r += 1
            Next
            _helper.SaveAs(wb, path)
            Return $"{{""written"":{r}}}"
        End Function
    End Class

    Public Class ExportCsvTool
        Implements IOfficeAgentTool
        Private ReadOnly _helper As New ExcelFileHelper()

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "export_csv"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Export an Excel worksheet to a CSV file."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """workbook_path"":{""type"":""string""}," &
                       """sheet_name"":{""type"":""string""}," &
                       """output_path"":{""type"":""string""}},""required"":[""workbook_path"",""sheet_name"",""output_path""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim path = doc.RootElement.GetProperty("workbook_path").GetString()
            Dim sheet = doc.RootElement.GetProperty("sheet_name").GetString()
            Dim outPath = doc.RootElement.GetProperty("output_path").GetString()
            Dim wb = _helper.OpenWorkbook(path)
            Dim ws = wb.Worksheet(sheet)
            Dim rng = ws.RangeUsed()
            Using sw As New StreamWriter(outPath)
                For Each row In rng.Rows()
                    Await sw.WriteLineAsync(String.Join(",", row.Cells().Select(Function(c) $"""{c.GetString().Replace("""", """""")}""")))
                Next
            End Using
            Return $"{{""exported_to"":""{outPath.Replace("\", "\\")}""}}"
        End Function
    End Class
End Namespace
