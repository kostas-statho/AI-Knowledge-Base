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

using System.Drawing;
using QBM.CompositionApi.Config;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Data;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class ImageConstraintSample : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // To enforce a size constraint on image data, create an instance of the
            // ImagePropertyProcessor class and register it with the API method.

            var config = new ProjectConfig(builder.Resolver.Resolve<ICandidateConfigService>(), builder.Resolver.Resolve<ProjectLevelConfig>());
            var constraint = new ImageConstraint
            {
                MaxSize = new Size(300, 400),
                MaxSizeBytes = 5000000
            };
            Method.Define("personprofilepicture")
                .FromTable("Person")
                .EnableUpdate()
                .WithWritableColumns("JPegPhoto")
                .Subscribe(new ImagePropertyProcessor("JPegPhoto", config, constraint));

        }
    }
}
