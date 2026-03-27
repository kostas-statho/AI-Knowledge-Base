Attribute VB_Name = "stdRange"
' stdRange - Excel range read/write/format helpers

Option Explicit

Public Function ReadRangeToArray(ByVal ws As Worksheet, ByVal address As String) As Variant
    ReadRangeToArray = ws.Range(address).Value
End Function

Public Sub WriteArrayToRange(ByVal ws As Worksheet, ByVal address As String, ByRef data As Variant)
    Dim rng As Range
    Set rng = ws.Range(address)
    Dim r As Long: r = UBound(data, 1) - LBound(data, 1) + 1
    Dim c As Long: c = UBound(data, 2) - LBound(data, 2) + 1
    ws.Range(rng.Cells(1, 1), rng.Cells(r, c)).Value = data
End Sub

Public Sub FormatRange(ByVal ws As Worksheet, ByVal address As String, _
                       ByVal bold As Boolean, ByVal bgColor As Long)
    With ws.Range(address)
        .Font.Bold = bold
        If bgColor <> 0 Then .Interior.Color = bgColor Else .Interior.ColorIndex = xlNone
    End With
End Sub

Public Sub AutoFitColumns(ByVal ws As Worksheet)
    ws.UsedRange.Columns.AutoFit
End Sub
