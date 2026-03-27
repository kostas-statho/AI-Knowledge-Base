Imports System.Threading

Namespace AgentTools
    Public Interface IOfficeAgentTool
        ReadOnly Property Name As String
        ReadOnly Property Description As String
        ReadOnly Property InputSchema As String
        Function ExecuteAsync(inputJson As String, ct As CancellationToken) As Task(Of String)
    End Interface
End Namespace
