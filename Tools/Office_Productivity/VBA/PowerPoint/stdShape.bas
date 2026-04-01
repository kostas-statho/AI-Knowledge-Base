Attribute VB_Name = "stdShape"
' stdShape - PowerPoint shape helpers

Option Explicit

Public Function AddTextBox(ByVal slide As Slide, ByVal text As String, _
                            ByVal left As Single, ByVal top As Single, _
                            ByVal width As Single, ByVal height As Single) As Shape
    Set AddTextBox = slide.Shapes.AddTextbox(msoTextOrientationHorizontal, left, top, width, height)
    AddTextBox.TextFrame.TextRange.Text = text
End Function

Public Function InsertImage(ByVal slide As Slide, ByVal imgPath As String, _
                              ByVal left As Single, ByVal top As Single, _
                              ByVal width As Single, ByVal height As Single) As Shape
    Set InsertImage = slide.Shapes.AddPicture(imgPath, msoFalse, msoTrue, left, top, width, height)
End Function

Public Function AddTable(ByVal slide As Slide, ByVal rows As Integer, _
                          ByVal cols As Integer) As Shape
    Set AddTable = slide.Shapes.AddTable(rows, cols, 50, 100, 600, 200)
End Function

Public Sub ApplyTheme(ByVal prs As Presentation, ByVal themePath As String)
    prs.ApplyTheme themePath
End Sub
