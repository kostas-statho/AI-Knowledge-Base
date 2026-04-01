Imports System.Text.Json
Imports System.Threading
Imports OfficeProductivity.PowerPoint
Imports ShapeCrawler

Namespace AgentTools
    Public Class CreatePresentationTool
        Implements IOfficeAgentTool
        Private ReadOnly _helper As New PowerPointFileHelper()

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "create_presentation"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Create a new PowerPoint presentation with a title slide."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """output_path"":{""type"":""string""}," &
                       """title"":{""type"":""string""}},""required"":[""output_path"",""title""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim outPath = doc.RootElement.GetProperty("output_path").GetString()
            Dim title = doc.RootElement.GetProperty("title").GetString()
            Dim prs = _helper.CreateNew()
            Dim firstSlide = prs.Slides.First()
            _helper.AddTextBox(firstSlide, title, 500000, 500000, 8000000, 1500000)
            _helper.SaveAs(prs, outPath)
            Return $"{{""created"":""{outPath.Replace("\", "\\")}""}}"
        End Function
    End Class

    Public Class AddSlideTool
        Implements IOfficeAgentTool
        Private ReadOnly _helper As New PowerPointFileHelper()

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "add_slide"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Add a slide with title and optional body text to an existing PowerPoint presentation."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """presentation_path"":{""type"":""string""}," &
                       """title"":{""type"":""string""}," &
                       """content"":{""type"":""string""}},""required"":[""presentation_path"",""title""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim prsPath = doc.RootElement.GetProperty("presentation_path").GetString()
            Dim title = doc.RootElement.GetProperty("title").GetString()
            Dim prs = _helper.Open(prsPath)
            prs.Slides.Add(prs.Slides.Count() + 1)
            Dim slide = prs.Slides.Last()
            _helper.AddTextBox(slide, title, 500000, 300000, 8000000, 1200000)
            Dim contentEl As JsonElement
            If doc.RootElement.TryGetProperty("content", contentEl) AndAlso contentEl.GetString() <> "" Then
                _helper.AddTextBox(slide, contentEl.GetString(), 500000, 1800000, 8000000, 3000000)
            End If
            _helper.SaveAs(prs, prsPath)
            Return $"{{""slide_count"":{_helper.SlideCount(prs)}}}"
        End Function
    End Class

    Public Class ExportPdfTool
        Implements IOfficeAgentTool

        Public ReadOnly Property Name As String Implements IOfficeAgentTool.Name
            Get
                Return "export_pdf"
            End Get
        End Property

        Public ReadOnly Property Description As String Implements IOfficeAgentTool.Description
            Get
                Return "Export a PowerPoint presentation to PDF. Requires Microsoft PowerPoint installed."
            End Get
        End Property

        Public ReadOnly Property InputSchema As String Implements IOfficeAgentTool.InputSchema
            Get
                Return "{""type"":""object"",""properties"":{" &
                       """presentation_path"":{""type"":""string""}," &
                       """output_path"":{""type"":""string""}},""required"":[""presentation_path"",""output_path""]}"
            End Get
        End Property

        Public Async Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String) Implements IOfficeAgentTool.ExecuteAsync
            Dim doc = JsonDocument.Parse(inputJson)
            Dim prsPath = doc.RootElement.GetProperty("presentation_path").GetString()
            Dim outPath = doc.RootElement.GetProperty("output_path").GetString()
            Using helper As New PowerPointComHelper()
                Dim prs = helper.Open(prsPath)
                Try
                    helper.ExportToPdf(prs, outPath)
                Finally
                    helper.Close(prs)
                End Try
            End Using
            Return $"{{""exported_to"":""{outPath.Replace("\", "\\")}""}}"
        End Function
    End Class
End Namespace
