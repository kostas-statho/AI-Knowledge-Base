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
using Microsoft.Owin;
using Owin;
using QBM.CompositionApi.PlugIns;
using VI.Base;

namespace TestMiddleware
{
    /// This plugin class registers a new server-level middleware that gets instantiated
    /// during the API Server initialization process.
    /// This middleware registers the /example URL and returns the HTTP status code 418
    /// with an empty response.
    
    public class Middleware : IPlugIn
    {
        public void Start(IAppBuilder app, IResolve resolve)
        {
            app.Map("/example", builder => builder.Use<ExampleMiddleware>());
        }

        public PipelineStage PipelineStage => PipelineStage.MapHandler;
        public int OrderNumber => 0;

        public class ExampleMiddleware : OwinMiddleware
        {
            public ExampleMiddleware(OwinMiddleware next) : base(next)
            {
            }

            public override async Task Invoke(IOwinContext context)
            {
                context.Response.StatusCode = 418;

                // to call the next middleware:
                // await Next.Invoke(context).ConfigureAwait(false);
            }
        }
    }
}