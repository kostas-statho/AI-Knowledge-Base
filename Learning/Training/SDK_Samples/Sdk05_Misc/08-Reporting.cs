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
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class Reporting : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method shows how to define an API for a report.
            // The report will automatically be made available in different formats, such as PDF.
            // The client can set the HTTP Accept header to define the requested format.

            builder.AddMethod(Method.Define("report")
                .HandleReport(req =>
                {
                    var parameters = new System.Collections.Generic.Dictionary<string, object>
                    {
                        ["ObjectKeyBase"] = new DbObjectKey("Person", req.Session.User().Uid).ToXmlString(),
                        ["IncludeSubIdentities"] = false
                    };

                    // In this example, we show the personal data report for the authenticated
                    // user. Additional parameters could be defined here.
                    return new ReportGeneration
                    {
                        ReportName = "VI_Attestation_Person_overview",
                        Parameters = parameters
                    };
                }));
        }
    }
}
