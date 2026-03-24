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

using System.Linq;
using System.Threading.Tasks;
using QBM.CompositionApi.DataSources;
using QBM.CompositionApi.Definition;
using VI.Base;

namespace QBM.CompositionApi.Sdk01_Basics
{
    // This class shows an example of an API method that
    // returns entities which do not correspond to database entries.
    // The advantage is that you can use the existing methods
    // to describe the entity schema, and to handle entity values.
    internal class CustomEntities : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            var entityData = Enumerable.Range(0, 4)
                .Select(i =>
                {
                    var primaryKey = "pk" + i;
                    var display = i + "";
                    return new CustomEntityDescriptor(display, primaryKey);
                });

            builder.AddMethod(Method.Define("customentities")
                .AllowUnauthenticated()

                // Any call to this method will return 4 entities.
                .HandleGetCustomEntities((qr, ct) => Task.FromResult(entityData))

                // Any properties of these entities are defined as calculated properties.
                // Here is one simple property.
                .WithCalculatedProperties(new CalculatedProperty<string>("Message", cx =>
                        "This is number " + cx.Entity.Display + ", the primary key is " +
                        cx.Entity.GetValue("primarykey"))));
        }
    }
}
