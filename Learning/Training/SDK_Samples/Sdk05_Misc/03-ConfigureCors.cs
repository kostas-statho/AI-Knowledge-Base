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

using System.Threading.Tasks;
using System.Web.Cors;
using Microsoft.Owin.Cors;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk05_Misc
{
	public class ConfigureCors : IApiProvider
	{
		public void Build(IApiBuilder builder)
		{
			// Get the CORS options object
			var corsOptions = builder.Resolver.Resolve<CorsOptions>();

			// Configure the CORS policy for the API
			corsOptions.PolicyProvider = new CorsPolicyProvider
			{
				PolicyResolver = context => Task.FromResult(new CorsPolicy
				{
					// This is an example policy to allow every request
					AllowAnyHeader = true,
					AllowAnyMethod = true,
					AllowAnyOrigin = true,
					SupportsCredentials = true
				})
			};
		}
	}
}
