Imports System.Threading
Imports Microsoft.Graph
Imports Microsoft.Graph.Models

Namespace M365
    Public Class TeamsHelper
        Private ReadOnly _client As GraphServiceClient

        Public Sub New(client As GraphServiceClient)
            _client = client
        End Sub

        Public Async Function SendMessageAsync(teamId As String, channelId As String,
                                                message As String, ct As CancellationToken) As Task
            Dim msg As New ChatMessage With {.Body = New ItemBody With {.Content = message}}
            Await _client.Teams(teamId).Channels(channelId).Messages.PostAsync(msg, cancellationToken:=ct)
        End Function

        Public Async Function CreateChannelAsync(teamId As String, displayName As String,
                                                  ct As CancellationToken) As Task(Of Channel)
            Dim ch As New Channel With {.DisplayName = displayName, .MembershipType = ChannelMembershipType.Standard}
            Return Await _client.Teams(teamId).Channels.PostAsync(ch, cancellationToken:=ct)
        End Function
    End Class
End Namespace
