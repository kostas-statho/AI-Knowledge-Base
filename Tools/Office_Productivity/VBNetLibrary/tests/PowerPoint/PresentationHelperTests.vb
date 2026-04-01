Imports System.IO
Imports OfficeProductivity.PowerPoint
Imports Xunit

Namespace PowerPoint
    Public Class PresentationHelperTests
        Private ReadOnly _helper As New PowerPointFileHelper()
        Private ReadOnly _tempPath As String = Path.Combine(Path.GetTempPath(), "OfficeProductivityTests")

        Public Sub New()
            Directory.CreateDirectory(_tempPath)
        End Sub

        <Fact>
        Public Sub CreateAndSavePresentation_CreatesFile()
            Dim filePath = Path.Combine(_tempPath, "test_create.pptx")
            If File.Exists(filePath) Then File.Delete(filePath)
            Dim prs = _helper.CreateNew()
            _helper.SaveAs(prs, filePath)
            Assert.True(File.Exists(filePath))
        End Sub

        <Fact>
        Public Sub SlideCount_ReturnsCorrectCount()
            Dim prs = _helper.CreateNew()
            Assert.Equal(1, _helper.SlideCount(prs))
        End Sub
    End Class
End Namespace
