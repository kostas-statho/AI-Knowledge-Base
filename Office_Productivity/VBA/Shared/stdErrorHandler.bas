Attribute VB_Name = "stdErrorHandler"
' stdErrorHandler - Standard On Error GoTo wrapper
' Usage:
'   Sub MySub()
'       On Error GoTo ErrHandler
'       ' ... code ...
'       Exit Sub
'   ErrHandler:
'       HandleError "MySub", Err
'   End Sub

Option Explicit

Public Sub HandleError(ByVal src As String, ByVal err As ErrObject, _
                        Optional ByVal showMsgBox As Boolean = False)
    Dim msg As String
    msg = "Error " & err.Number & " in " & src & ": " & err.Description
    stdLogger.LogError msg, src
    If showMsgBox Then MsgBox msg, vbExclamation, "Error"
End Sub
