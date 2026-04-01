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

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class MultipleRoutes
    {
        public void Example()
        {
            // This example shows how to build a method with two GET handlers on different routes.
            // This is useful if the handlers share some logic (i.e. validation or parameterization).

            Method.Define("parentroute")
                // Define a GET handler for the /parentroute endpoint
                .HandleGet(request => "This is a request to /parentroute")
                // Add a subroute for the /parentroute/subroute endpoint
                .WithRoute("/subroute")
                // Add a query parameter to the subroute. This parameter exists on the subroute only!
                .WithParameter(new RequestParameter("parameter")
                {
                    Type = typeof(string),
                    IsInQuery = true
                })
                .HandleGet(request => "This is a request to /parentroute/childroute. The parameter value is: " +
                                      request.Parameters.Get<string>("parameter"));
        }
    }
}
