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
    public class CustomMethod : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            // This is how a method can return objects of any type,
            // provided that the type can be serialized.
            builder.AddMethod(Method.Define("helloworld")
                .AllowUnauthenticated()
                .HandleGet(qr => new DataObject {Message = "Hello world!"}));

            // This is how posted data of any type can be processed.
            builder.AddMethod(Method.Define("helloworld/post")
                .AllowUnauthenticated()
                .Handle<PostedMessage, DataObject>("POST",
                    (posted, qr) => new DataObject
                    {
                        Message = "You posted the following message: " + posted.Input
                    }));

            // This is an example of a method that generates plain text (not JSON formatted).
            // You can use this to generate content of any type.
            builder.AddMethod(Method.Define("helloworld/text")
                .AllowUnauthenticated()
                .HandleGet(new ContentTypeSelector
                {
                    // Specifiy the MIME type of the response.
                    new ResponseBuilder("text/plain", async (qr, ct) =>
                    {
                        return new System.Net.Http.HttpResponseMessage
                        {
                            Content = new System.Net.Http.StringContent("Hello world!")
                        };
                    })
                }, typeof(string)));
        }
    }


    // This class defines the type of data object that will be sent to the client.
    public class DataObject
    {
        public string Message { get; set; }
    }

    // This class defines the type of data object that will be sent from the client to the server.
    public class PostedMessage
    {
        public string Input { get; set; }
    }
}
