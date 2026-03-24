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

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class ClientSuffix
    {
        // When using two methods with the same route, the server needs an additional identifier
        // to create unique method identifiers. This is the ClientSuffix property.

        public void DefineClientSuffix()
        {
            // Example of a simple method.
            // The API client method for this API method will be named app_simplemethod_get.
            Method.Define("simplemethod")
                .WithDescription("Returns information about available statistics.")
                .HandleGet(request => "Method M");

            // Define a single-object method.
            // The API client method for this API method will be named app_simplemethod_byid_get,
            // and the ClientSuffix is required to avoid a name conflict with app_simplemethod_get.
            Method.Define("simplemethod/{id}")
                // Assign a ClientSuffix to distinguish this method's routes.
                .With(m => m.Settings.ClientSuffix = "_byid")
                .HandleGet(request => "Method M/{id}"); ;

        }
    }
}
