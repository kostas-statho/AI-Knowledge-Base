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
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk01_Basics
{
    internal class DeletionMethod : IApiProvider
    {
        /// <summary>
        /// This class shows how to delete an entity.
        /// </summary>
        public void Build(IApiBuilder builder)
        {
            /*
             * Define the table and a base WHERE clause to define which set of objects can be deleted
             * using this method. To avoid accidental deletions, this method restricts deletion to
             * tags named "DELETION TEST".
             */
            builder.AddMethod(Method.Define("deletiontest")
                .FromTable("DialogTag")
                .EnableRead()
                .WithWhereClause("Ident_DialogTag = 'DELETION TEST'")
                .EnableDelete());
        }
    }
}
