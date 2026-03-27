Namespace AgentTools
    Public Class ToolRegistry
        Private ReadOnly _tools As IReadOnlyList(Of IOfficeAgentTool)

        Public Sub New(tools As IEnumerable(Of IOfficeAgentTool))
            _tools = tools.ToList().AsReadOnly()
        End Sub

        Public Function GetAll() As IReadOnlyList(Of IOfficeAgentTool)
            Return _tools
        End Function

        Public Function ToClaudeToolsJson() As String
            Dim sb As New System.Text.StringBuilder("[")
            For i = 0 To _tools.Count - 1
                Dim t = _tools(i)
                If i > 0 Then sb.Append(",")
                Dim escapedDesc = t.Description.Replace("""", "\""")
                sb.Append("{")
                sb.Append("""name"":""" & t.Name & """,")
                sb.Append("""description"":""" & escapedDesc & """,")
                sb.Append("""input_schema"":" & t.InputSchema)
                sb.Append("}")
            Next
            sb.Append("]")
            Return sb.ToString()
        End Function

        Public Function ToMcpManifestJson() As String
            Dim sb As New System.Text.StringBuilder("{""tools"":[")
            For i = 0 To _tools.Count - 1
                Dim t = _tools(i)
                If i > 0 Then sb.Append(",")
                Dim escapedDesc = t.Description.Replace("""", "\""")
                sb.Append("{")
                sb.Append("""name"":""" & t.Name & """,")
                sb.Append("""description"":""" & escapedDesc & """,")
                sb.Append("""inputSchema"":" & t.InputSchema)
                sb.Append("}")
            Next
            sb.Append("]}")
            Return sb.ToString()
        End Function
    End Class
End Namespace
