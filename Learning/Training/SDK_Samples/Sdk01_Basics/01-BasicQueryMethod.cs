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
using QBM.CompositionApi.Typed;

namespace QBM.CompositionApi.Sdk01_Basics
{
    // Every class that implements the IApiProvider interface will be
    // picked up by the API builder, who will call the Build method.
    public class BasicQueryMethod : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method shows how to build simple query methods that
            // work on top of the object layer.

            builder.AddMethod(Method
                
                // Set the method URL.
                .Define("person/allcolumns")

                // Set the database table
                .FromTable("Person")
                .EnableRead()

                // This will include all enabled columns in the result
                .WithAllColumns());

            builder.AddMethod(Method.Define("person/specificcolumns")
                .FromTable("Person")
                .EnableRead()
                // Only include specific columns in the result.
                .WithResultColumns("FirstName", "LastName"));

            // The new typed wrapper libraries contain classes for each table in a module.
            // Reference the correct <module>.TypedWrappers.dll for the module and use the type
            // directly to define an entity-based API method.
            builder.AddMethod(Method.Define("test")
                .From<QBM.TypedWrappers.QBMVSystemOverview>()
                .EnableRead()
                // Use the column names directly as LINQ expressions.
                .WithResultColumns(x => x.Element, x => x.QualityOfValue, x => x.RecommendedValue)
            );
        }
    }
}
