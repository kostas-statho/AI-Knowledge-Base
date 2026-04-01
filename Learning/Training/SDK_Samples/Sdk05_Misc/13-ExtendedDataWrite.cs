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
using VI.Base;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class ExtendedDataWriteApiProvider
        // uncomment the next line to activate this API provider
        // : IApiProvider
    {
        /*
         * This is an example of a write-only ExtendedData provider.
         * There are two phases to writing data:
         *    1. The Apply phase, where the client may update the data object.
         *       The ApplyAsync method is called on the ExtendedData object for every update.
         *       In case of an interactive entity API endpoint, there may be more than one ApplyAsync call.
         *    2. The Commit phase, where the client commits the change.
         *       The CommitAsync method is called on the ExtendedData object.
         *       If the client rejects the entity, or if an exception happens,
         *       the CommitAsync method may never be called.
         */

        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("test_with_writecheck")
                .FromTable("Person")
                .EnableRead()
                .EnableUpdate()
                .WithExtendedData(new ExampleExtendedDataWriteProvider())
            );
        }
    }

    public class ExampleExtendedDataWriteProvider : IWriteOnlyExtendedDataProvider<ExampleDataObject>
    {
        public Task<IWriteExtendedData<ExampleDataObject>> GetExtendedDataAsync(IReadOnlyList<IEntity> entities,
            IRequest request, CancellationToken ct = default)
        {
            return Task.FromResult<IWriteExtendedData<ExampleDataObject>>(new ExampleExtendedWriteData());
        }

        Task IValidatingMethod.ValidateAsync(IMethodValidationContext con, CancellationToken ct)
        {
            return NullTask.Instance;
        }

        private class ExampleExtendedWriteData : IWriteExtendedData<ExampleDataObject>
        {
            private ExampleDataObject CurrentValue { get; set; }

            public async Task ApplyAsync(IRequest qr, ExampleDataObject val, CancellationToken ct = default)
            {
                // The client has submitted a new value. In case of an interactive entity,
                // there is one call to ApplyAsync for each incremental change
                // before the final CommitAsync.
                CurrentValue = val;
            }

            public Task CommitAsync(IUnitOfWork unitOfWork, CancellationToken ct = default)
            {
                // The client wants to commit the change -> log the value
                unitOfWork.Session.GetLogSession().Debug("CommitAsync called with value: " + CurrentValue.Content);
                return NullTask.Instance;
            }
        }
    }

    public class ExampleDataObject
    {
        /// <summary>
        /// Represents the content supplied by the client.
        /// </summary>
        public string Content { get; set; }
    }
}
