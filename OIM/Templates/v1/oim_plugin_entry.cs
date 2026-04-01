// Template: OIM CompositionAPI Plugin Entry Point
// Replace: MyCCCPlugin, CustomApiPlugin, MyPlugin with your plugin name.
// File naming convention: CCC_<PluginName>.cs
// Assembly naming convention: <PluginName>.CompositionApi.Server.Plugin.dll (set in .csproj)

using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.PlugIns;

[assembly: Module("CCC")]

namespace QBM.CompositionApi
{
    /// <summary>
    /// Plugin entry point — discovered by the OIM API Server at startup.
    /// IPlugInMethodSetProvider is the interface the API Server looks for.
    /// </summary>
    public class CustomApiPlugin : IPlugInMethodSetProvider
    {
        public IMethodSetProvider Build(IResolve resolver)
        {
            return new MyCCCPlugin(resolver);
        }
    }

    /// <summary>
    /// Registers all endpoint classes for this plugin.
    /// FindAttributeBasedApiProviders discovers all IApiProvider classes
    /// in this assembly automatically — no manual wiring needed.
    /// </summary>
    public class MyCCCPlugin : IMethodSetProvider
    {
        private readonly MethodSet _project;

        public MyCCCPlugin(IResolve resolver)
        {
            _project = new MethodSet
            {
                AppId = "MyPlugin"  // Unique ID — appears in API Server logs
            };

            var svc = resolver.Resolve<IExtensibilityService>();
            _project.Configure(resolver, svc.FindAttributeBasedApiProviders<MyCCCPlugin>());

            _project.SessionConfig = new Session.SessionAuthDbConfig
            {
                AuthenticationType = Config.AuthType.AllManualModules,
                Product = null
            };
        }

        public Task<IEnumerable<IMethodSet>> GetMethodSetsAsync(CancellationToken ct = default)
            => Task.FromResult<IEnumerable<IMethodSet>>(new[] { _project });
    }
}
