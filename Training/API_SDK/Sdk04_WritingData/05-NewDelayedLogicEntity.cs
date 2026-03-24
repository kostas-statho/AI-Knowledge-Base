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

namespace QBM.CompositionApi.Sdk04_WritingData
{
    internal class NewDelayedLogicEntity : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method shows how to build an API method for the creation of a new entity.
            builder.AddMethod(Method
                .Define("person/createnew")
                // The parameter specifies the type of object.
                .FromTable("Person")

                .EnableCreate()

                // Subscribe to the entity creation event.
                .Subscribe(c =>
                {
                    // insert code here that runs when a new entity is created
                })

                // Specify writable columns
                .WithWritableColumns("FirstName", "LastName", "UID_PersonHead"));
        }
    }
}
