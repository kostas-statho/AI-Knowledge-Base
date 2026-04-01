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
using System.Net;
using System.Net.Http;
using System.Web.Http;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;
using VI.Base;

namespace QBM.CompositionApi.Sdk05_Misc
{
    public class Exceptions : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // Use the IExceptionService to configure which exceptions are
            // exposed to the client.
            var exceptionService = builder.Resolver.Resolve<IExceptionService>();

            var currentFilter = exceptionService.Filter;
            
            // Example: do not expose any exceptions to the client that contain the given text
            exceptionService.Filter = exc => currentFilter(exc) && !exc.Message.Contains("xyz");

            // When generating exceptions, use the ViException type and set the ExceptionRelevance
            // if the exception message should be visible to the client.
            throw new ViException("An error occurred.", ExceptionRelevance.EndUser);

        }
    }

    public class ExceptionMessageBuilder : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // If you need to emit exceptions from the API in a specific format, you can define
            // a MessageBuilder that serializes exceptions. This message builder is
            // defined on the API project level, so it takes effect for all API endpoints
            // in the API project.

            builder.Resolver.Resolve<IExceptionTransformService>()
                .MessageBuilder = new MessageBuilder(builder.Resolver.Resolve<IExceptionService>());
        }

        private class MessageBuilder : IExceptionMessageBuilder
        {
            private readonly IExceptionService _svc;

            public MessageBuilder(IExceptionService svc)
            {
                _svc = svc;
            }

            public Type ExceptionDataType => typeof(SimpleExceptionString);

            public HttpResponseMessage BuildMessage(IRequest request, Exception exc)
            {
                return new HttpResponseMessage
                {
                    StatusCode = HttpStatusCode.InternalServerError,
                    Content = new ObjectContent<SimpleExceptionString>(new SimpleExceptionString
                    {
                        // obtain all relevant exceptions in the chain, and
                        // combine the messages into one string.

                        TheMessage = string.Join(" ", _svc.GetExceptions(exc).Select(e => e.Message))
                    }, JsonResponseBuilder.Formatter)
                };
            }

            // The API will return an object of this type when the API call results in an exception.
            private class SimpleExceptionString
            {
                public string TheMessage { get; set; }
            }

        }
    }

    public class HttpResponseExceptionDemo
    {
        public void MethodWithExceptionResponse()
        {
            // If you need to throw an exception with a certain response message
            // to the client, you can do so by throwing a HttpResponseException.
            // The message will not be modified by the API Server's usual exception
            // handling and transformation.
            throw new HttpResponseException(new HttpResponseMessage(HttpStatusCode.BadRequest)
            {
                Content = new StringContent("Demo Content")
            });
        }
    }
}
