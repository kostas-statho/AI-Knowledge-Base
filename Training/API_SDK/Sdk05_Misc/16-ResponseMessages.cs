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

using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class ResponseMessages
    {
        public void ModifyResponse()
        {
            // This example shows how to add a custom response builder to any endpoint.
            Method.Define("modifiedresponse")
                .HandleGet(request => "Hello world")
                .With(m =>
                {
                    // Get the GET handler
                    var routeVerb = m.Route.HttpMethods[m.Verb];

                    // The ResponseBuilderSelector is the object that selects a response builder.
                    // We register a custom ResponseBuilderSelector by wrapping the existing one
                    // and adding the required logic.
                    routeVerb.ResponseBuilderSelector =
                        new ModifiedResponseBuilderSelector(routeVerb.ResponseBuilderSelector);
                });
        }

        internal class ModifiedResponseBuilderSelector : IResponseBuilderSelector
        {
            private readonly IResponseBuilderSelector _inner;

            public ModifiedResponseBuilderSelector(IResponseBuilderSelector inner)
            {
                _inner = inner;
            }

            public IResponseBuilder Select(IRequest qr)
            {
                // Wrap the original response builder with new logic.
                return new ModifiedResponseBuilder(_inner.Select(qr));
            }

            private class ModifiedResponseBuilder : IResponseBuilder
            {
                private readonly IResponseBuilder _inner;

                public ModifiedResponseBuilder(IResponseBuilder inner)
                {
                    _inner = inner;
                }

                public string ContentType => _inner.ContentType;

                public async Task<HttpResponseMessage> WriteAsync(IRequest qr, CancellationToken ct = default)
                {
                    // This method is where the actual modification of the response happens.
                    // First, obtain the HttpResponseMessage from the original ResponseBuilder.
                    var message = await _inner.WriteAsync(qr, ct).ConfigureAwait(false);
                    // Then, apply any desired modifications.
                    message.ReasonPhrase = "This response was modified";
                    // Return the modified message.
                    return message;
                }
            }
        }
    }
}