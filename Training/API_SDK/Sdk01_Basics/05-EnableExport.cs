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
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk01_Basics
{
	internal class EnableExport : IApiProvider
	{
		public void Build(IApiBuilder builder)
		{
			// This statement takes a method
			builder.AddMethod(Method.Define("person/exportdata")
				.FromTable("Person")
                .EnableRead()
				.WithResultColumns("InternalName", "UID_PersonHead", "UID_Department")

				// Enable exporting to various formats depending on the "Accept" HTTP header.
				// The API server currently supports:
				// * text/csv
				// * application/pdf (if the RPS module is installed)
				.AllowExport());
		}
	}
}
