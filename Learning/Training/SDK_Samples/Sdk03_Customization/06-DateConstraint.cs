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
using QBM.CompositionApi.Handling;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk03_Customization
{
    public class DateConstraint
        // uncomment the next line to activate this API provider
        // : IApiProvider
    {
        // This sample shows how to add a date constraint to the Person.EntryDate property.
        public void Build(IApiBuilder builder)
        {
            // The constraint applies only to this method because it is added at the method level.
            // The GlobalModifier sample shows how to add a modifier globally to all methods
            // that process a property.
            builder.AddMethod(Method.Define("person/dateconstraint")
                .FromTable("Person")
                .EnableCreate()
                .WithWritableAllColumns()
                .Modify("EntryDate", mod => mod.DynamicModifiers.Add(new DateNotInPastModifier())));

        }

        private class DateNotInPastModifier : IEntityColumnModifier
        {
            public EntityColumnModifierResult Get(IEntity entity)
            {
                // return a modifier with a constraint that defines that MinDate
                // should not be in the past
                return new EntityColumnModifierResult
                {
                    ValueConstraint = new ValueConstraint
                    {
                        MinValue = DateTime.UtcNow
                    }
                };
            }
        }
    }
}
