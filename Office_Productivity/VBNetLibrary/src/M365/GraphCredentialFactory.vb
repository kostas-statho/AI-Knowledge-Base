Imports Azure.Identity
Imports Microsoft.Graph
Imports OfficeProductivity.Common

Namespace M365
    Public Class GraphCredentialFactory
        Private ReadOnly _tenantId As String
        Private ReadOnly _clientId As String
        Private ReadOnly _clientSecret As String

        Public Sub New(tenantId As String, clientId As String, Optional clientSecret As String = Nothing)
            _tenantId = tenantId
            _clientId = clientId
            _clientSecret = clientSecret
        End Sub

        Public Function Build(mode As AuthMode) As GraphServiceClient
            Dim scopes = New String() {"https://graph.microsoft.com/.default"}
            Select Case mode
                Case AuthMode.ServicePrincipal
                    If String.IsNullOrEmpty(_clientSecret) Then
                        Throw New ArgumentException("clientSecret required for ServicePrincipal mode")
                    End If
                    Return New GraphServiceClient(New ClientSecretCredential(_tenantId, _clientId, _clientSecret), scopes)
                Case AuthMode.Interactive
                    Return New GraphServiceClient(
                        New InteractiveBrowserCredential(New InteractiveBrowserCredentialOptions() With {
                            .TenantId = _tenantId, .ClientId = _clientId
                        }), scopes)
                Case AuthMode.ManagedIdentity
                    Return New GraphServiceClient(New ManagedIdentityCredential(_clientId), scopes)
                Case Else
                    Throw New ArgumentOutOfRangeException(NameOf(mode))
            End Select
        End Function
    End Class
End Namespace
