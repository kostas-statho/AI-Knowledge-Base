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
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk03_Customization
{
    // This sample shows how to modify how a database property behaves
    // in an API project.
    public class GlobalModifier : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // The IModifierService manage the modifications that
            // will apply to all API methods in the project.
            var mod = builder.Resolver.Resolve<IModifierService>();

            // Obtain the modifiers for this column.
            mod.GetPropertyModifiers("Person", "UID_DialogState")
                .Add(new PropertyModifier
                {
                    // Add a modifier that limits the possible values for the UID_DialogState
                    // column, depending on the value for UID_DialogCountry.
                    FkWhereClauses =
                    {
                        new FkWhereClause(r => r.Request.Session.SqlFormatter().UidComparison("UID_DialogCountry",
                            r.Entity.GetValue("UID_DialogCountry")))
                    }
                });
        }
    }
}
