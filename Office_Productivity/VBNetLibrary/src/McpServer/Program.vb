Imports Microsoft.Extensions.DependencyInjection
Imports Microsoft.Extensions.Hosting
Imports OfficeProductivity.AgentTools

Module Program
    Sub Main(args As String())
        Dim appBuilder As New Microsoft.Extensions.Hosting.HostApplicationBuilder(args)
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, ReadSheetTool)()
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, WriteSheetTool)()
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, ExportCsvTool)()
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, CreatePresentationTool)()
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, AddSlideTool)()
        appBuilder.Services.AddSingleton(Of IOfficeAgentTool, ExportPdfTool)()
        appBuilder.Services.AddSingleton(Of ToolRegistry)(Function(sp)
            Return New ToolRegistry(sp.GetServices(Of IOfficeAgentTool)())
        End Function)
        Dim appHost As IHost = appBuilder.Build()
        Dim registry = appHost.Services.GetRequiredService(Of ToolRegistry)()
        Console.WriteLine(registry.ToMcpManifestJson())
        appHost.Run()
    End Sub
End Module
