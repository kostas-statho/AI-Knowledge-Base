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
using QBM.CompositionApi.Definition;
using VI.DB;
using VI.DB.Entities;
using VI.DB.Sync;

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class _13_CustomizerMethod : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("customizermethod")
                .HandleGet(async qr =>
                {
                    // Load the Person entity for the authenticated user.
                    // Note that methods can only be called in interactive entities.
                    var person = await qr.Session.Source().GetAsync(new DbObjectKey("Person", qr.Session.User().Uid),
                            EntityLoadType.Interactive)
                        .ConfigureAwait(false);

                    // Load the GetCulture method. This one does not take any parameters.
                    var method = person.GetMethod(qr.Session, "GetCulture", Array.Empty<object>());

                    // Call the method and return the result (in this case, it's a string).
                    var result = await method.CallAsync(qr.Session, person).ConfigureAwait(false);
                    return result;
                }));
        }
    }
}
