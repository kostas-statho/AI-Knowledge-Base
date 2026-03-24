using Microsoft.Extensions.Logging;
using NLog;
using QBM.CompositionApi;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Dto;
using QBM.CompositionApi.Handling;
using QBM.CompositionApi.PlugIns;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Xml.Linq;
using VI.Base;
using VI.Base.Logging;
using VI.DB;
using VI.DB.Entities;
using VI.DB.Sync;

[assembly: Module("CCC")]

namespace QBM.CompositionApi
{
    public class CCC_StathopoulosK : IMethodSetProvider
    {
        private readonly MethodSet _project;

        public CCC_StathopoulosK(IResolve resolver)
        {
            _project = new MethodSet
            {
                AppId = "StathopoulosK"
            };

            var svc = resolver.Resolve<IExtensibilityService>();
            var apiProvidersByAttribute = svc.FindAttributeBasedApiProviders<CCC_StathopoulosK>();
            _project.Configure(resolver, apiProvidersByAttribute);

            var authConfig = new Session.SessionAuthDbConfig
            {
                AuthenticationType = Config.AuthType.AllManualModules,
                Product = null
            };

            _project.SessionConfig = authConfig;
        }

        public Task<IEnumerable<IMethodSet>> GetMethodSetsAsync(CancellationToken ct = new CancellationToken())
        {
            return Task.FromResult<IEnumerable<IMethodSet>>(new[] { _project });
        }
    }
    public class CustomApiPlugin : IPlugInMethodSetProvider
    {
        public IMethodSetProvider Build(IResolve resolver)
        {
            return new CCC_StathopoulosK(resolver);
        }
    }
}
