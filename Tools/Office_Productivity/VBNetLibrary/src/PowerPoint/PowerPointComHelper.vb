Imports Microsoft.Office.Interop.PowerPoint
Imports OfficeProductivity.Common

Namespace PowerPoint
    Public Class PowerPointComHelper
        Implements IDisposable

        Private _app As Application
        Private _disposed As Boolean

        Public Sub New()
            _app = ThreadingHelper.RunOnSta(Of Application)(Function() New Application())
        End Sub

        Public Function Open(path As String) As Presentation
            Return ThreadingHelper.RunOnSta(Of Presentation)(Function() _app.Presentations.Open(path))
        End Function

        Public Function CreateNew() As Presentation
            Return ThreadingHelper.RunOnSta(Of Presentation)(Function() _app.Presentations.Add())
        End Function

        Public Function AddSlide(prs As Presentation, layout As PpSlideLayout) As Slide
            Return ThreadingHelper.RunOnSta(Of Slide)(Function()
                Return prs.Slides.Add(prs.Slides.Count + 1, layout)
            End Function)
        End Function

        Public Sub ExportToPdf(prs As Presentation, outputPath As String)
            ThreadingHelper.RunOnSta(Sub() prs.ExportAsFixedFormat(outputPath, PpFixedFormatType.ppFixedFormatTypePDF))
        End Sub

        Public Sub SaveAs(prs As Presentation, path As String)
            ThreadingHelper.RunOnSta(Sub() prs.SaveAs(path, PpSaveAsFileType.ppSaveAsOpenXMLPresentation))
        End Sub

        Public Sub Close(prs As Presentation, Optional save As Boolean = False)
            ThreadingHelper.RunOnSta(Sub()
                If save Then prs.Save()
                prs.Close()
            End Sub)
            ComReleaser.Release(prs)
        End Sub

        Public Sub Dispose() Implements IDisposable.Dispose
            If Not _disposed Then
                ThreadingHelper.RunOnSta(Sub()
                    _app.Quit()
                    ComReleaser.Release(_app)
                End Sub)
                _disposed = True
            End If
        End Sub
    End Class
End Namespace
