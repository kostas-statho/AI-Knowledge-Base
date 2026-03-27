Imports System.IO
Imports OfficeProductivity.Excel
Imports Xunit

Namespace Excel
    Public Class ExcelHelperTests
        Private ReadOnly _helper As New ExcelFileHelper()
        Private ReadOnly _tempPath As String = Path.Combine(Path.GetTempPath(), "OfficeProductivityTests")

        Public Sub New()
            Directory.CreateDirectory(_tempPath)
        End Sub

        <Fact>
        Public Sub CreateAndSaveWorkbook_CreatesFile()
            Dim filePath = Path.Combine(_tempPath, "test_create.xlsx")
            If File.Exists(filePath) Then File.Delete(filePath)
            Dim wb = _helper.CreateWorkbook()
            wb.Worksheets.Add("Sheet1")
            _helper.SaveAs(wb, filePath)
            Assert.True(File.Exists(filePath))
        End Sub

        <Fact>
        Public Sub WriteAndReadRange_RoundTrips()
            Dim filePath = Path.Combine(_tempPath, "test_rw.xlsx")
            Dim wb = _helper.CreateWorkbook()
            wb.Worksheets.Add("Data")
            Dim data As String(,) = {{"A1", "B1"}, {"A2", "B2"}}
            _helper.WriteRange(wb, "Data", "A1", data)
            _helper.SaveAs(wb, filePath)
            Dim wb2 = _helper.OpenWorkbook(filePath)
            Dim result = _helper.ReadRange(wb2, "Data", "A1:B2")
            Assert.Equal("A1", result(0, 0))
            Assert.Equal("B2", result(1, 1))
        End Sub
    End Class
End Namespace
