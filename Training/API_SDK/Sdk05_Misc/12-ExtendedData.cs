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
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.ExtendedData;
using QBM.CompositionApi.Handling;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class ExtendedDataSample
        // uncomment the next line to activate this API provider
        // : IApiProvider
    {
        /*
         * ExtendedData providers define customized data flow that integrate with the API
         * endpoints designed to read and write database entities.
         *
         * ExtendedData providers can be read-only, write-only or read-write.
         *
         * ExtendedData providers can read and write objects of any serializable type.
         * The data types for read and write operations can be different.
         *
         * The ExtendedData objects are always read and written for a fixed list
         * of entities.
         *
         * Typical use cases include:
         *
         *   - Reading/writing DialogParameter objects for entities. There is a pre-defined
         *     ExtendedData provider for this use case; include it by calling the
         *     WithParameterExtendedData extension method.
         *   - Unwrapping objects that are serialized within a string property of an entity.
         *
         */

        public void Build(IApiBuilder builder)
        {
            // Example for DialogParameter integration
            builder.AddMethod(Method.Define("request_with_dialogparameter")
                .FromTable("PersonWantsOrg")
                .EnableRead()

                // include DialogParameters as read-only
                .WithParameterExtendedData(true /* isReadOnly */)
            );


            // Example with a custom ExtendedData provider
            builder.AddMethod(Method.Define("request_with_extendeddata")
                .FromTable("Person")
                .EnableRead()

                // include custom object
                .WithExtendedData(new ExampleExtendedDataProvider())
            );
        }

        private class ExampleExtendedDataProvider : IReadOnlyExtendedDataProvider<ExampleExtendedData>
        {
            public async Task<ExampleExtendedData> GetExtendedDataAsync(IReadOnlyList<IEntity> entities,
                IRequest request, CancellationToken ct = default)
            {
                return new ExampleExtendedData();
            }

            public async Task ValidateAsync(IMethodValidationContext con, CancellationToken ct = default)
            {
                // include any code that runs at API compilation time.
            }
        }

        public class ExampleExtendedData
        {

        }

    }
}
