Imports System.Threading

Namespace Common
    Public NotInheritable Class ThreadingHelper
        Private Sub New()
        End Sub

        Public Shared Function RunOnSta(Of T)(action As Func(Of T)) As T
            Dim result As T = Nothing
            Dim ex As Exception = Nothing
            Dim thread As New Thread(Sub()
                                         Try
                                             result = action()
                                         Catch e As Exception
                                             ex = e
                                         End Try
                                     End Sub)
            thread.SetApartmentState(ApartmentState.STA)
            thread.Start()
            thread.Join()
            If ex IsNot Nothing Then Throw ex
            Return result
        End Function

        Public Shared Sub RunOnSta(action As Action)
            RunOnSta(Of Object)(Function()
                                    action()
                                    Return Nothing
                                End Function)
        End Sub
    End Class
End Namespace
