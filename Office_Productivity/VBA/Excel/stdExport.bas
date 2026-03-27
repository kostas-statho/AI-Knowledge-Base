Attribute VB_Name = "stdExport"
' stdExport - Excel export helpers

Option Explicit

Public Sub ExportSheetToCSV(ByVal ws As Worksheet, ByVal path As String)
    Dim tmpWb As Workbook
    ws.Copy
    Set tmpWb = ActiveWorkbook
    tmpWb.SaveAs Filename:=path, FileFormat:=xlCSV
    tmpWb.Close SaveChanges:=False
End Sub

Public Sub ExportWorkbookToPDF(ByVal wb As Workbook, ByVal path As String)
    wb.ExportAsFixedFormat Type:=xlTypePDF, Filename:=path
End Sub

Public Sub ExportRangeToNewWorkbook(ByVal ws As Worksheet, ByVal address As String, _
                                     ByVal path As String)
    Dim newWb As Workbook
    Set newWb = Workbooks.Add
    ws.Range(address).Copy newWb.Sheets(1).Range("A1")
    newWb.SaveAs Filename:=path, FileFormat:=xlOpenXMLWorkbook
    newWb.Close SaveChanges:=False
End Sub
