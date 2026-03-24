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
using QBM.CompositionApi.DataSources;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk02_Properties
{
    public class EnumPropertySample : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // The EnumProperty class is a special type of calculated property
            // based on an enumeration type. This is useful if you have
            // a property that supports only a limited set of values.
            Method.Define("enumproperty")
                .FromTable("Person")
                .EnableRead()
                .WithCalculatedProperties(
                    new EnumProperty<SampleEnum>("Color", cx =>
                    {
                        var entity = cx.Entity;

                        // Calculate the SampleEnum value based on the entity's data
                        return SampleEnum.Blue;
                    })
                );
        }

        public enum SampleEnum
        {
            Red,
            Green,
            Blue
        }
    }
}
