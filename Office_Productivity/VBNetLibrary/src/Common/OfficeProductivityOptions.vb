Imports System.IO

Namespace Common
    Public Class OfficeProductivityOptions
        Public Property TempPath As String = Path.GetTempPath()
        Public Property LogLevel As Integer = 2
        Public Property MakeOfficeVisible As Boolean = False
    End Class

    Public Enum AuthMode
        ServicePrincipal = 0
        Interactive = 1
        ManagedIdentity = 2
    End Enum
End Namespace
