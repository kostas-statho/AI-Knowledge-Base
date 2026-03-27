Imports System.IO
Imports System.Threading
Imports Microsoft.Graph
Imports Microsoft.Graph.Models

Namespace M365
    Public Class SharePointHelper
        Private ReadOnly _client As GraphServiceClient

        Public Sub New(client As GraphServiceClient)
            _client = client
        End Sub

        Public Async Function UploadFileAsync(driveId As String,
                                               remotePath As String, localPath As String,
                                               ct As CancellationToken) As Task(Of DriveItem)
            Using stream = File.OpenRead(localPath)
                Return Await _client.Drives(driveId).Root.ItemWithPath(remotePath).Content.PutAsync(stream, cancellationToken:=ct)
            End Using
        End Function

        Public Async Function DownloadFileAsync(driveId As String, itemId As String,
                                                 localPath As String, ct As CancellationToken) As Task
            Dim stream = Await _client.Drives(driveId).Items(itemId).Content.GetAsync(cancellationToken:=ct)
            Using fs = File.Create(localPath)
                Await stream.CopyToAsync(fs, ct)
            End Using
        End Function

        Public Async Function ListFilesAsync(driveId As String,
                                              folderPath As String, ct As CancellationToken) As Task(Of IEnumerable(Of DriveItem))
            Dim result = Await _client.Drives(driveId).Root.ItemWithPath(folderPath).Children.GetAsync(cancellationToken:=ct)
            Return If(result?.Value, Enumerable.Empty(Of DriveItem)())
        End Function
    End Class
End Namespace
