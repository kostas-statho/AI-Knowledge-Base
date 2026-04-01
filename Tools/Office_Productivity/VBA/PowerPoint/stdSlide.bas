Attribute VB_Name = "stdSlide"
' stdSlide - PowerPoint slide management helpers

Option Explicit

Public Function AddSlide(ByVal prs As Presentation, ByVal layout As Integer, _
                          ByVal pos As Integer) As Slide
    Set AddSlide = prs.Slides.Add(pos, layout)
End Function

Public Function CloneSlide(ByVal prs As Presentation, ByVal sourceIndex As Integer) As Slide
    prs.Slides(sourceIndex).Copy
    prs.Slides.Paste prs.Slides.Count + 1
    Set CloneSlide = prs.Slides(prs.Slides.Count)
End Function

Public Sub DeleteSlide(ByVal prs As Presentation, ByVal slideIndex As Integer)
    prs.Slides(slideIndex).Delete
End Sub

Public Sub SetSlideTitle(ByVal slide As Slide, ByVal title As String)
    On Error Resume Next
    slide.Shapes.Title.TextFrame.TextRange.Text = title
    On Error GoTo 0
End Sub
