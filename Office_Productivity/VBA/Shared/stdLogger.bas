Attribute VB_Name = "stdLogger"
' stdLogger - Lightweight logger (Debug.Print + optional log sheet)

Option Explicit

Private Const LOG_SHEET_NAME As String = "Log"
Private Const USE_LOG_SHEET  As Boolean = False

Public Sub LogInfo(ByVal msg As String)
    WriteLog "INFO", msg, ""
End Sub

Public Sub LogWarn(ByVal msg As String)
    WriteLog "WARN", msg, ""
End Sub

Public Sub LogError(ByVal msg As String, Optional ByVal src As String = "")
    WriteLog "ERROR", msg, src
End Sub

Private Sub WriteLog(ByVal level As String, ByVal msg As String, ByVal src As String)
    Dim line As String
    line = Format(Now, "yyyy-mm-dd hh:nn:ss") & " [" & level & "] " & msg
    If src <> "" Then line = line & " (" & src & ")"
    Debug.Print line
    If USE_LOG_SHEET Then WriteToSheet line
End Sub

Private Sub WriteToSheet(ByVal line As String)
    On Error Resume Next
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets(LOG_SHEET_NAME)
    If ws Is Nothing Then
        Set ws = ThisWorkbook.Sheets.Add
        ws.Name = LOG_SHEET_NAME
    End If
    ws.Cells(ws.UsedRange.Rows.Count + 1, 1).Value = line
    On Error GoTo 0
End Sub
