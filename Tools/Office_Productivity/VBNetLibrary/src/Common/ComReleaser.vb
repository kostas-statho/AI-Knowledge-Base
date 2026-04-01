Imports System.Runtime.InteropServices

Namespace Common
    Public NotInheritable Class ComReleaser
        Private Sub New()
        End Sub

        Public Shared Sub Release(ParamArray objects() As Object)
            For Each o In objects
                If o IsNot Nothing Then
                    Try
                        Marshal.ReleaseComObject(o)
                    Catch
                    End Try
                End If
            Next
        End Sub

        Public Shared Sub ReleaseAll(list As IEnumerable(Of Object))
            For Each o In list
                If o IsNot Nothing Then
                    Try
                        Marshal.ReleaseComObject(o)
                    Catch
                    End Try
                End If
            Next
        End Sub
    End Class
End Namespace
