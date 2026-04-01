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
using QBM.CompositionApi.Chart;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk01_Basics
{
    internal class Statistics : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("statistics")
                .HandleGet(async (qr, ct) =>
                {
                    // These are the identifiers of some system statistics. Data for these
                    // statistics will be exposed to the client.
                    var statistics = new[] {"DialogTableTOP10CountRows", "DialogJournal", "DialogTableTOP10SizeMB"};

                    // Load all data using the ChartDataProvider
                    var data = await Task
                        .WhenAll(statistics.Select(s => new ChartDataProvider(s).TryGetDataAsync(qr.Session, ct)))
                        .ConfigureAwait(false);

                    // Some charts might not be available or enabled -> check Success flag
                    return data
                        .Where(d => d.Success)
                        .Select(d => d.Result)
                        .ToArray();
                }));
        }
    }
}
