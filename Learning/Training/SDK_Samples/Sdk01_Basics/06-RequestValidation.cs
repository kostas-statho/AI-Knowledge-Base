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

using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk01_Basics
{
	public class RequestValidation : IApiProvider
	{
		public void Build(IApiBuilder builder)
		{
			builder.AddMethod(Method.Define("testvalidation")
			    .AllowUnauthenticated()
                .WithParameter("p", description: "Parameter must be 'a' or 'b'")
				.WithValidator("Parameter validation", qr =>
				{
					var value = qr.Parameters.Get<string>("p");
					if (value != "a" && value != "b")
						return new ValidationError("Invalid value for parameter");
					return null;
				})
				.HandleGet(qr => new DataObject { Message = "Hello world!" }));
		}
	}
}
