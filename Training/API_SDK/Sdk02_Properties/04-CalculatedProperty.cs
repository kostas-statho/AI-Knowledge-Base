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

using System.Collections.Generic;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.DataSources;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk02_Properties
{
    public class CalculatedPropertyDemo : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("calculatedproperty")
                .FromTable("Person")
                .EnableRead()
                .WithResultColumns("InternalName")

                // Define a new property "InternalNameUpper":
                .WithCalculatedProperties(new CalculatedProperty<string>("InternalNameUpper",

                    // Define how the property value is calculated:
                    context =>

                        // Obtain the data value through the entity of the context. In this example,
                        // convert the "InternalName" property to upper-case:
                        context.Entity.GetValue("InternalName").String.ToUpperInvariant()))
            );

            // You can also define calculated properties that evaluate values in bulk mode.
            // This is recommended if you need to run any expensive operations (such as
            // accessing the database) for value calculation. This is an example of how
            // to define a bulk-mode calculated property:

            new CalculatedPropertyBulk<string>("SomeProperty", GetValuesForEntities);
        }

        private static IReadOnlyList<string> GetValuesForEntities(IBulkPropertyValueContext cx)
        {
            // These are the entities for which the property value needs to be calculated.
            var entities = cx.Entities;
            // The result array must be of the same length as the input array.
            var result = new string[entities.Count];
            for (var idx = 0; idx < result.Length; idx++)
                result[idx] = "some value";
            return result;

        }
    }
}
