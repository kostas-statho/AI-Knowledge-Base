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
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Config;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Handling;
using QBM.CompositionApi.Session;
using QBM.CompositionApi.Translation;
using VI.Base;
using VI.DB.Entities;

namespace QBM.CompositionApi.Sdk07_Services
{
    /*
     * This class demonstrates the interfaces required to integrate an external
     * MFA service. The DemoMfaProvider class mocks an authentication provider
     * that supports the following operations:
     * - triggering a process to generate a one-time password and send it
     *   to a device associated with the user
     * - verifying a one-time-password 
     * - triggering a push notification and waiting for the user to approve
     *   using a device
     *
     * Note that this class does not perform any MFA, but it shows the usage
     * of the base interfaces.
     *
     * Integrating an MFA service consists of several parts:
     *
     * - An implementation of the ISecondaryAuthProvider interface (DemoMfaProvider
     *   in this example). The class must be public and loaded by the API compiler.
     * - The session state will include a SecondaryAuth object that notifies the
     *   client of the fact that additional MFA is expected:
     *   "SecondaryAuth": {
     *      "IsAuthenticated": false,
     *      "IsEnabled": true,
     *      "Name": "DemoMfa"
     *   }
     *   where "DemoMfa" is the identifier of the MFA provider.
     * - The client application must be aware of the type of MFA performed. See
     *   "Registering an Angular MFA provider".
     * - The DemoMfaApiMethod class defines three API endpoints to integrate
     *   the external service:
     *   1. POST demomfa/sendotp to send a OTP
     *   2. POST demomfa/verifyotp to verify a OTP
     *   3. POST demomfa/push to send a push notification
     *
     * Registering an Angular MFA provider
     *
     * - Import the TwoFactorAuthenticationService from the qbm package
     * - Build an Angular component to display the UI when the user is requested
     *   to perform a MFA
     * - Register the component with the TwoFactorAuthenticationService, as in this
     *   example:
     *   this.twoFactorAuthService.register('DemoMfa', DemoMfaComponent);
     *   Note that this code needs to run before the login process.
     *
     */
    public class DemoMfaProvider : ISecondaryAuthProvider
    {
        public ISessionAuthSecondary Build(ISessionAuthDb session, IMethodSet methodSet)
        {
            return new DemoSessionAuthSecondary(session);
        }

        public string Key => nameof(DemoMfaProvider);

        public ITranslatableString Display { get; }
            = new TranslatableString("Demo MFA provider");
    }

    internal class DemoSessionAuthSecondary : ISessionAuthSecondary
    {
        private readonly ISessionAuthDb _session;

        public DemoSessionAuthSecondary(ISessionAuthDb session)
        {
            _session = session;
        }

        // Require two-factor authentication
        public bool IsEnabled => true;

        public string Name => nameof(DemoMfaProvider);

        public bool IsAuthenticated { get; private set; }

        public string ErrorMessage => null;

        public async Task RequestOtpAsync(CancellationToken ct = default)
        {
            var session = await _session.GetSessionAsync(ct).ConfigureAwait(false);
            var uidPerson = session.User().Uid;

            // TODO: Using the UID_Person, trigger the process
            // to send a OTP to a device associated with the identity.
        }

        public async Task VerifyOtpAsync(string otp, CancellationToken ct = default)
        {
            var session = await _session.GetSessionAsync(ct).ConfigureAwait(false);
            var uidPerson = session.User().Uid;

            // TODO: Using the UID_Person, trigger the process to verify the code.
            // This demo uses "42" as the correct OTP.

            if (!Equals("42", otp))
                throw new ViException("The supplied one-time password was incorrect.", ExceptionRelevance.EndUser);

            IsAuthenticated = true;
        }

        public async Task SendPushNotificationAsync(CancellationToken ct = default)
        {
            var session = await _session.GetSessionAsync(ct).ConfigureAwait(false);
            var uidPerson = session.User().Uid;

            // TODO: Using the UID_Person, trigger the process for a push notification.
            // This method should handle timeouts as well as any errors, and throw
            // exceptions accordingly. The method should wait for the result of the
            // push notification and only return when push notification authentication
            // has been successful.

            // When successful, mark the session as authenticated:
            IsAuthenticated = true;
        }
    }


    public class DemoMfaApiMethodProvider : IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(new DemoMfaApiMethod("demomfa"));
        }
    }

    internal class DemoMfaApiMethod : BaseMethod
    {
        public DemoMfaApiMethod(string url) : base(url)
        {
            Settings.AllowUnauthenticated = true;
            RouteProviders.Add(new MethodRoute(Settings)
            {
                UrlSuffix = "/sendotp",
                HttpMethods =
                {
                    {
                        "POST", new MethodRouteVerb(new NoContentResponseBuilder(async (request, ct) =>
                        {
                            var auth = (await GetAsync(request, ct).ConfigureAwait(false)).Item2;

                            await auth.RequestOtpAsync(ct).ConfigureAwait(false);
                        }))
                        {
                            Description = "Triggers a one-time password and sends it to the user."
                        }
                    }
                }
            });

            RouteProviders.Add(new MethodRoute(Settings)
            {
                UrlSuffix = "/verifyotp",
                HttpMethods =
                {
                    {
                        "POST", new MethodRouteVerb(new JsonResponseBuilder(async (request, ct) =>
                        {
                            var otp = (string) request.Content;

                            return await VerifyOtpAsync(request, otp, ct).ConfigureAwait(false);
                        }))
                        {
                            Description = "Verifies the supplied one-time password.",
                            InputType = typeof(string),
                            DefaultResultType = typeof(SessionResponse)
                        }
                    }
                }
            });

            RouteProviders.Add(new MethodRoute(Settings)
            {
                UrlSuffix = "/push",
                HttpMethods =
                {
                    {
                        "POST", new MethodRouteVerb(new JsonResponseBuilder(async (request, ct)
                            => await PushAsync(request, ct).ConfigureAwait(false)))
                        {
                            Description = "Triggers a push notification to the connected devices.",
                            DefaultResultType = typeof(SessionResponse)
                        }
                    }
                }
            });
        }

        private static async Task<(ISessionGroup, DemoSessionAuthSecondary)> GetAsync(IRequest qr, CancellationToken ct = default)
        {
            var group = await qr.Resolver.Resolve<ISessionProvider>()
                .GetSessionGroupAsync(qr.Request.GetOwinContext(), ct).ConfigureAwait(false);
            return (group, group[qr.MethodSet.AppId].SecondaryAuth as DemoSessionAuthSecondary
                   ?? throw new InvalidOperationException("Demo MFA is not configured for this session."));

        }
        private async Task<SessionResponse> VerifyOtpAsync(IRequest request, string otp, CancellationToken ct)
        {
            var (group, auth) = await GetAsync(request, ct).ConfigureAwait(false);

            await auth.VerifyOtpAsync(otp, ct).ConfigureAwait(false);

            return await SessionResponse
                .BuildAsync(request, group, request.MethodSet.AppId, ct)
                .ConfigureAwait(false);
        }

        private async Task<SessionResponse> PushAsync(IRequest request, CancellationToken ct)
        {
            var (group, auth) = await GetAsync(request, ct).ConfigureAwait(false);

            await auth.SendPushNotificationAsync(ct).ConfigureAwait(false);

            return await SessionResponse
                .BuildAsync(request, group, request.MethodSet.AppId, ct)
                .ConfigureAwait(false);
        }
    }

}
