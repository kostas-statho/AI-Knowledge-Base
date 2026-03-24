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

using QBM.CompositionApi.DataSources;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Dto;
using VI.Base;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk03_Customization
{
    public class AddPropertyToSqlMethod : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // Call the ModifyStatementMethod method to modify a statement method.
            builder.ModifyStatementMethod(

                // This is the URL of the method to be modified.
                "sql/changecount",
                method =>
                {
                    // Simply include one more property in the result.
                    method.WithCalculatedProperties(new CalculatedProperty("TableDisplay", ValType.String,

                        // Statement to calculate the property value
                        async (context, ct) =>
                        {
                            // Get the (technical) table name
                            var tablename = context.Entity.GetValue("TableName").String;

                            // Obtain the table definition
                            var metaTable = await context.Session.MetaData()
                                .GetTableAsync(tablename, ct).ConfigureAwait(false);

                            // Return the translated table display name
                            return new EntityColumnData(metaTable.Display.Translated);
                        }));
                });
        }
    }
}
