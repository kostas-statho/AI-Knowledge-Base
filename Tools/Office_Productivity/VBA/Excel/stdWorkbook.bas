Attribute VB_Name = "stdWorkbook"
' stdWorkbook - Excel workbook lifecycle helpers
' Import: VBA IDE > File > Import File

Option Explicit

Public Function OpenWorkbook(ByVal path As String) As Workbook
    On Error GoTo Fail
    Set OpenWorkbook = Workbooks.Open(path)
    Exit Function
Fail:
    Set OpenWorkbook = Nothing
End Function

Public Sub SaveWorkbookAs(ByVal wb As Workbook, ByVal path As String)
    wb.SaveAs Filename:=path, FileFormat:=xlOpenXMLWorkbook
End Sub

Public Sub CloseWorkbook(ByVal wb As Workbook, ByVal save As Boolean)
    wb.Close SaveChanges:=save
End Sub

Public Sub ProtectSheet(ByVal ws As Worksheet, ByVal pwd As String)
    ws.Protect Password:=pwd, DrawingObjects:=True, Contents:=True, Scenarios:=True
End Sub

Public Sub UnprotectSheet(ByVal ws As Worksheet, ByVal pwd As String)
    ws.Unprotect Password:=pwd
End Sub
