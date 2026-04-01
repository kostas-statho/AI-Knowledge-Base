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

using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk03_Customization
{
    public class MethodModifier : IApiProvider
    {
        // This sample shows how to modify how a database property behaves
        // when used in one specific API method.
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("modified")
                .FromTable("Person")
                .EnableCreate()
                .WithWritableColumns("UID_DialogCountry", "UID_DialogState")

                // Add a modifier that limits the possible values for the UID_DialogState
                // column, depending on the value for UID_DialogCountry.
                .Modify("UID_DialogState", mo => mo.FkWhereClauses.Add(
                    new FkWhereClause(r => r.Request.Session
                        .SqlFormatter().UidComparison("UID_DialogCountry",
                            r.Entity.GetValue("UID_DialogCountry")))))

                // This is an example for a custom display value provider;
                // converting an e-mail address to lower-case.
                .Modify("DefaultEMailAddress",
                    modifier => modifier.DynamicModifiers.Add(
                        new EMailAsLowerCaseModifier(new EMailAsLowerCaseProvider())))
            );


            // Add modifiers to the API method definition
            builder.AddMethod(Method.Define("person")
                .FromTable("Person")
                .EnableCreate()
                .WithResultColumns("UID_FirmPartner")
                .Modify("UID_FirmPartner", mod => mod.DynamicModifiers.Add(new MandatoryCompanyModifier())));

        }

        // sample modifier object
        internal class MandatoryCompanyModifier : IEntityColumnModifier
        {
            public EntityColumnModifierResult Get(IEntity entity)
            {
                // is it an external user? If so, then UID_FirmPartner becomes
                // a mandatory field
                if (entity.GetValue("IsExternal").Bool)
                    return new EntityColumnModifierResult
                    {
                        MinLen = 1
                    };

                // if not -> no modification
                return null;
            }
        }

        private class EMailAsLowerCaseProvider : IDisplayValueProvider
        {
            public async Task<string> GetDisplayValueAsync(IDisplayValueContext context, CancellationToken ct = default)
            {
                // get actual data value
                var value = await context.InnerColumn.GetValueAsync(ct).ConfigureAwait(false);

                // convert to lower-case
                return value?.ToString().ToLowerInvariant();
            }
        }

        private class EMailAsLowerCaseModifier : IEntityColumnModifier
        {
            private readonly EntityColumnModifierResult _modifier;

            public EMailAsLowerCaseModifier(IDisplayValueProvider provider)
            {
                _modifier = new EntityColumnModifierResult
                {
                    DisplayValueProvider = provider
                };
            }

            public EntityColumnModifierResult Get(IEntity entity)
            {
                return _modifier;
            }
        }
    }
}
