Imports System.Threading
Imports ShapeCrawler

Namespace PowerPoint
    Public Class PowerPointFileHelper
        Public Function Open(path As String) As IPresentation
            Return New Presentation(path)
        End Function

        Public Function CreateNew() As IPresentation
            Return New Presentation()
        End Function

        Public Function SlideCount(prs As IPresentation) As Integer
            Return prs.Slides.Count()
        End Function

        Public Sub AddTextBox(slide As IUserSlide, text As String, x As Integer, y As Integer,
                               width As Integer, height As Integer)
            slide.Shapes.AddTextBox(x, y, width, height, text)
        End Sub

        Public Sub SaveAs(prs As IPresentation, path As String)
            prs.Save(path)
        End Sub
    End Class
End Namespace
