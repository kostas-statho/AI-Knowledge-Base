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
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Dto;
using QBM.CompositionApi.Handling;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class Grouping
    // uncomment the next line to activate this API provider
    // : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("person")
                .FromTable("Person")
                .EnableRead()

                // Enables default grouping behavior for the UID_Department column,
                // and allows the client to call person/group?by=UID_Department
                .EnableGrouping("UID_Department")

                // Enables the person/datamodel endpoint to allow the client to
                // query data model information
                .With(m => m.EnableDataModelApi = true)

                // Add a custom group provider that defines a data group definition
                // "new hires" with two options: "this month" and "earlier".
                .With(m => m.GroupDefinitionProviders.Add(new CustomEntryDateGroupDefProvider()))
            );
        }

        private class CustomEntryDateGroupDefProvider : IGroupDefinitionProvider
        {
            public string Name { get; } = "newidentities";

            private readonly IGroupProvider _provider = new CustomEntryDateGroupProvider();

            public IGroupProvider GetGroupProvider(string value)
            {
                if (!string.Equals(value, "HireDate"))
                    throw new ArgumentException("Unexpected value " + value);
                return _provider;
            }

            public async Task<IReadOnlyList<GroupDefinition>> GetGroupDefinitionsAsync(IRequest qr,
                CancellationToken ct = default)
            {
                // Using the request object, you can dynamically calculate groups here.
                // In this example, we just return a static array.

                return new[]
                {
                    new GroupDefinition("Hire date", new GroupDefinitionOption("Hire date", "HireDate"))
                };
            }

            private class CustomEntryDateGroupProvider : IGroupProvider
            {
                public async Task<IReadOnlyList<Group>> GetGroupsAsync(string parentWhereClause, IRequest request, CancellationToken ct = default)
                {
                    var now = DateTime.UtcNow;

                    var startOfMonth = new DateTime(now.Year, now.Month, 1);
                    return new[]
                    {
                        new Group("This month", new FilterData
                        {
                            ColumnName = "EntryDate",
                            Type = FilterType.Compare,
                            CompareOp = CompareOperator.GreaterThan,
                            Value1 = startOfMonth
                        }),
                        new Group("Earlier", new FilterData
                        {
                            ColumnName = "EntryDate",
                            Type = FilterType.Compare,
                            CompareOp = CompareOperator.LowerThan,
                            Value1 = startOfMonth
                        })
                    };
                }
            }
        }
    }
}
