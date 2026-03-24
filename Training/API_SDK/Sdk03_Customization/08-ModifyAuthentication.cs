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

using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk03_Customization
{
    internal class ModifyAuthentication
    {
        // This class shows how to change authentication configuration for an existing API project.
        public void Build(IApiBuilder builder)
        {
            // The IApiBuilder registers a helper method which only serves as a vehicle to
            // set the authentication settings. It does not change the API surface.
            builder.AddMethod(new HelperMethod());
        }

        private class HelperMethod : BaseMethod, IRouteProvider
        {
            public HelperMethod() : base("placeholder")
            {
                RouteProviders.Add(this);
            }

            public async Task CreateRoutesAsync(IMethodValidationContext context, CancellationToken ct = new CancellationToken())
            {
                context.MethodSet.SessionConfig.ExcludedAuthentifiers.Add("OAuthRoleBased");
            }
        }
    }
}
