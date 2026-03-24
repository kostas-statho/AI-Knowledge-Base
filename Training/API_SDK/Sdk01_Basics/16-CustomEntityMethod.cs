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

using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class CustomEntityMethod
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("person/test")
                .FromTable("Person")
                .EnableRead()
                .As(EntityType.Interactive)

                // Register a custom API endpoint person/test/extended
                // to define logic using the entity.
                .AddGet("extended", async (entity, request, ct) =>
                {
                    // The specified entity is the current interactive entity, which
                    // may have been modified previously.
                    return entity.GetValue("UID_Person").String;
                })
            );
        }
    }
}
