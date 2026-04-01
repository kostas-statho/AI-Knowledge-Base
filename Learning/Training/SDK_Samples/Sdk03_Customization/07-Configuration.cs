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


using QBM.CompositionApi.Config;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi.Sdk03_Customization
{
    // This class shows an example of exposing configuration settings
    // of your API. The API configuration service manages configuration objects,
    // and you can add your own configuration objects.
    public class Configuration : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            var configService = builder.Resolver.Resolve<IConfigService>();
            var configurableObject = new ConfigurableObject();

            // This call registers the object instance with the configuration
            // service. This has the following effects:
            // 1. The object's configurable properties will be exposed to
            // the external configurator.
            // 2. Changes made through external configuration will be directly
            // applied to the configurable object.
            configService.RegisterConfigurableObject(configurableObject);
        }

        public class ConfigurableObject
        {
            public string StringProperty { get; set; }

            public int IntegerSetting { get; set; }
        }
    }
}
