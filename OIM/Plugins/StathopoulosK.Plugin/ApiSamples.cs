using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Config;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Session;
using VI.Base;

namespace QBM.CompositionApi.Debugging
{
    public class PluginMethodSetProvider : IPlugInMethodSetProvider
    {
        public IMethodSetProvider Build(IResolve resolver)
        {
            return new ApiSamples(resolver);
        }
    }
    internal class ApiSamples : IMethodSetProvider
    {
        private readonly IResolve _resolver;
        public ApiSamples(IResolve resolver)
        {
            _resolver = resolver;
        }
        public Task<IEnumerable<IMethodSet>> GetMethodSetsAsync(CancellationToken ct = new CancellationToken())
        {
            var methodSet = new MethodSet
            {
                AppId = "apisamples",
                SessionConfig = new SessionAuthDbConfig { AuthenticationType = AuthType.AllManualModules }
            };
            // Include all classes in this assembly that implement IApiProvider
            methodSet.Configure(_resolver, Assembly.GetExecutingAssembly().GetTypes()
                .Where(t => typeof(IApiProvider).IsAssignableFrom(t))
                .OrderBy(t => t.FullName)
                .Select(t => (IApiProvider)t.GetConstructor(new Type[0]).Invoke(new object[0])));

            return Task.FromResult<IEnumerable<IMethodSet>>(new[]
            {
                methodSet
            });
        }
    }
}
