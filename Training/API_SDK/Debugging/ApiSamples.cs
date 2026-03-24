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
			    SessionConfig = new SessionAuthDbConfig {AuthenticationType = AuthType.AllManualModules}
		    };

		    // Include all classes in this assembly that implement IApiProvider
            methodSet.Configure(_resolver, Assembly.GetExecutingAssembly().GetTypes()
                .Where(t => typeof(IApiProvider).IsAssignableFrom(t))
                .OrderBy(t => t.FullName)
                .Select(t => (IApiProvider) t.GetConstructor(new Type[0]).Invoke(new object[0])));

		    return Task.FromResult<IEnumerable<IMethodSet>>(new[]
		    {
			    methodSet
		    });
	    }
    }
}
