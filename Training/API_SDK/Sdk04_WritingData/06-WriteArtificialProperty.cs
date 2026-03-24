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
using QBM.CompositionApi.Handling;
using VI.Base;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk04_WritingData
{
    internal class WriteArtificialProperty : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This method shows how to build a writable API method
            // with an artificial property that does not exist in the database.

            builder.AddMethod(Method
                .Define("person/artificialproperty")
                .FromTable("Person")
                .EnableRead()
                .WithWhereClause(
                    // filter to the UID_Person of the authenticated user
                    qr => qr.Session.SqlFormatter().UidComparison("UID_Person", qr.Session.User().Uid))
                .WithAllColumns()

                // This call will enable update operations for this method.
                .EnableUpdate()

                // Now we define an artificial, writable property.
                .WithCalculatedProperties(new CalculatedProperty(new PropertyMetaData("ArtificialProperty", false)))

                // Now we subscribe to the BeforeSave event so that we can change the entity
                // using the value of the artificial property.
                .Subscribe(e =>
                {
                    if (e.Type == EntityProcessingType.BeforeSave)
                    {
                        var value = e.Entity.GetValue("ArtificialProperty");
                        // now we can handle the value, and take action - for
                        // example, change the entity.
                    }
                }));
        }
    }
}
