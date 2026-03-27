Attribute VB_Name = "stdPresentation"
' stdPresentation - PowerPoint presentation lifecycle helpers

Option Explicit

Public Function OpenPresentation(ByVal path As String) As Presentation
    On Error GoTo Fail
    Set OpenPresentation = Presentations.Open(path)
    Exit Function
Fail:
    Set OpenPresentation = Nothing
End Function

Public Sub SavePresentationAs(ByVal prs As Presentation, ByVal path As String)
    prs.SaveAs path, ppSaveAsOpenXMLPresentation
End Sub

Public Sub ExportToPDF(ByVal prs As Presentation, ByVal path As String)
    prs.ExportAsFixedFormat path, ppFixedFormatTypePDF
End Sub

Public Sub ClosePresentation(ByVal prs As Presentation, ByVal save As Boolean)
    If save Then prs.Save
    prs.Close
End Sub
