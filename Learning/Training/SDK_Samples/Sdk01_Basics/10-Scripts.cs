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
using VI.DB.Entities;
using VI.DB.Scripting;

namespace QBM.CompositionApi.Sdk01_Basics
{
    // This class shows how to expose a script call through the API.
    public class Scripts : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method takes two string parameters and returns a string.
            // For demonstration purposes, the method simply calls the script
            // VI_BuildInitials.

            builder.AddMethod(Method.Define("getinitials/{firstname}/{lastname}")
                .WithParameter("firstname", typeof(string), isInQuery: false)
                .WithParameter("lastname", typeof(string), isInQuery: false)
                .HandleGet(qr =>
                {
                    // Setup the script runner
                    var scriptClass = qr.Session.Scripts().GetScriptClass(ScriptContext.Scripts);
                    var runner = new ScriptRunner(scriptClass, qr.Session);

                    // Add any script input parameters to this array.
                    // In this example, the script parameters are defined as
                    // URL parameters, and their values must be supplied
                    // by the client. This does not have to be the case.
                    var parameters = new object[]
                    {
                        qr.Parameters.Get<string>("firstname"),
                        qr.Parameters.Get<string>("lastname")
                    };

                    // This assumes that the script returns a string.
                    return runner.Eval("VI_BuildInitials", parameters) as string;
                }));
        }
    }
}
