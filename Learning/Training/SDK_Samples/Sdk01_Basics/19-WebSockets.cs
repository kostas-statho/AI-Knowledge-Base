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
using System.Net.WebSockets;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Socket;

namespace QBM.CompositionApi.Sdk01_Basics
{
    public class WebSockets : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("socketdemo")

                // Configure this method to use a web socket. The client can make a request
                // to this method using a ws:// or wss:// URL. The server will perform the
                // usual authentication and parameter validation on the request, and then
                // transfer control of the request to the SocketAdapter provided here.
                .HandleSocket(request => new SocketAdapter(request)));
        }

        private class SocketAdapter : ISocketAdapter
        {
            // This is the object that provides access to:
            // - Socket: the underlying socket, which you can use to send data to the client
            // - Request: the API request including access to the Identity Manager session
            private readonly ISocketRequest _request;

            public SocketAdapter(ISocketRequest request)
            {
                _request = request;
            }

            public async Task OnMessageReceivedAsync(ArraySegment<byte> data, WebSocketMessageType type,
                CancellationToken ct = new CancellationToken())
            {
                // TODO: handle the message received from the client
                
            }

            public void OnReceiveError(Exception exc)
            {
                // TODO: an error has occurred.
            }

            public async Task OnCloseAsync(WebSocketCloseStatus? status, string description)
            {
                // TODO: handle the closing of the socket.
            }
        }
    }
}
