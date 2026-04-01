#region Copyright 2023 One Identity LLC.
/*
 * ONE IDENTITY LLC. PROPRIETARY INFORMATION
 *
 * This software is confidential.  One Identity, LLC. or one of its affiliates or
 * subsidiaries, has supplied this software to you under terms of a
 * license agreement, nondisclosure agreement or both.
 *
 * You may not copy, disclose, or use this software except in accordance with
 * those terms.
 *
 *
 * Copyright 2023 One Identity LLC.
 * ALL RIGHTS RESERVED.
 *
 * ONE IDENTITY LLC. MAKES NO REPRESENTATIONS OR
 * WARRANTIES ABOUT THE SUITABILITY OF THE SOFTWARE,
 * EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE IMPLIED WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, OR
 * NON-INFRINGEMENT.  ONE IDENTITY LLC. SHALL NOT BE
 * LIABLE FOR ANY DAMAGES SUFFERED BY LICENSEE
 * AS A RESULT OF USING, MODIFYING OR DISTRIBUTING
 * THIS SOFTWARE OR ITS DERIVATIVES.
 *
 */
#endregion

using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.PlugIns;
using VI.Base;

// This attribute will automatically assign all methods defined by this DLL
// to the CCC module.
[assembly: Module("CCC")]

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class CustomApiProject : IMethodSetProvider
    {
        private readonly MethodSet _project;

        public CustomApiProject(IResolve resolver)
        {
            _project = new MethodSet
            {
                AppId = "customapi"
            };

            var svc = resolver.Resolve<IExtensibilityService>();

            // Configure all API providers that implement IApiProviderFor<CustomApiProject>
            var apiProvidersByAttribute = svc.FindAttributeBasedApiProviders<CustomApiProject>();
            _project.Configure(resolver, apiProvidersByAttribute);

            var authConfig = new Session.SessionAuthDbConfig
            {
                AuthenticationType = Config.AuthType.AllManualModules,
                Product = "WebDesigner",
                SsoAuthentifiers =
                {
                    // Add the names of any single-sign-on authentifiers here.
                    // Do not add any OAuth modules here, as OAuth requires a different
                    // authentication flow.
                },
                ExcludedAuthentifiers =
                {
                    // Add the names of any excluded authentifiers here
                }
            };

            // To explicitly set the list allowed authentication modules,
            // set the AuthenticationType to AuthType.Default and set
            // the list of ManualAuthentifiers.

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
            return new CustomApiProject(resolver);
        }
    }

    public class CustomApiHelloWorld : IApiProviderFor<CustomApiProject>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("helloworld")
                .AllowUnauthenticated()
                .HandleGet(qr => new DataObject { Message = "Hello world!" }));
        }
    }
}
