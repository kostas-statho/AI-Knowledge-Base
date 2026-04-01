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
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk04_WritingData
{
	internal class WriteDelayedLogicEntity : IApiProvider
	{
		public void Build(IApiBuilder builder)
		{
			// This method shows how to build a writable API method, and how to
            // assign different descriptions to read and write operations.

            builder.AddMethod(Method
                .Define("person/masterdata")
                .FromTable("Person")
                .EnableRead()

                // Assign a description to the method.
                .WithDescription("Returns identity main data.")

                .WithWhereClause(
                    // filter to the UID_Person of the authenticated user
                    qr => qr.Session.SqlFormatter().UidComparison("UID_Person", qr.Session.User().Uid))
                .WithAllColumns()

                // This call will enable writing to all columns, with a delayed-logic entity.
                // Note that object permission constraints still apply and cannot be overridden.
                .EnableUpdate()
                .WithWritableAllColumns()

                // This description is used to document the PUT method associated with
                // updating an identity.
                .With(update => update.Description = "Updates the main data of an identity.")

            );
        }
	}
}
