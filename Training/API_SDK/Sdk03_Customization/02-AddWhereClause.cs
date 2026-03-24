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

namespace QBM.CompositionApi.Sdk03_Customization
{
    public class AddWhereClause : IApiProvider
    {
        // This class shows how to add a WHERE clause condition to an already existing method.
        public void Build(IApiBuilder builder)
        {
            // Call the ModifyQueryMethod method to modify or extend a query method.
            builder.ModifyQueryMethod(

                // This is the URL of the method to be extended.
                "person/allcolumns",
                method =>
                {
                    method.WhereClauseProviders.Add(new WhereClauseProvider((qr, whereClause) =>

                        // add another condition using "AND" operator
                        qr.Session.SqlFormatter().AndRelation(whereClause, "IsTemporaryDeactivated=0")));
                });

        }
    }
}
