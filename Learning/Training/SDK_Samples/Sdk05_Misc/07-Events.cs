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

using QBM.CompositionApi.Definition;
using QBM.CompositionApi.ApiManager;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class Events : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method shows how to register an event which is called for every request of this method.
            builder.AddMethod(Method.Define("event")
                .AllowUnauthenticated()
                .HandleGet(qr => "Hello world!")
                .Configure(m =>
                {
                    m.Settings.ProcessingRequest.Subscribe(async request =>
                    {
                        // handle request here
                    });
                    return m;
                })
            );
        }
    }
}
