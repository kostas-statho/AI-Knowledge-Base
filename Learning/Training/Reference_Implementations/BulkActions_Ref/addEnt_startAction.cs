using System;
using System.IO;
using System.Web;
using System.Net;
using System.Threading;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Linq;
using System.Text;
using VI.Base;
using VI.DB;
using VI.DB.Entities;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Crud;

namespace QBM.CompositionApi
{
    public class addEntitlementStartAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/addentitlement/startaction")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    var myParam1 = await qr.Session.Config().GetConfigParmAsync(
                        "Custom\\WebPortalPlus\\BulkActions\\addentitlement\\CollectImportData", ct)
                        .ConfigureAwait(false);

                    bool collectImportData = false;
                    var loggedinuser = qr.Session.User().Uid;

                    var shoppingCart = "";
                    var actionProperty2 = "Some value for action property2 from start action";
                    var actionProperty3 = "Some value for action property3 from start action";

                    var validationProperty1 = "New value for validation property1 from start action";
                    var validationProperty2 = "New value for validation property2 from start action";
                    var validationProperty3 = posted.ValidationAttributes.validationProperty3;

                    if (!string.IsNullOrEmpty(myParam1))
                    {
                        collectImportData = true;
                    }

                    var start = new Dictionary<string, object>
                    {
                        { "message", $"You are going to assign {posted.totalRows} entitlements." },
                        { "permission", true }
                    };

                    if (collectImportData)
                    {
                        start.Add("collectImportData", collectImportData);
                    }

                    var newID = await qr.Session.Source().CreateNewAsync(
                        "ShoppingCartOrder",
                        new EntityParameters { CreationType = EntityCreationType.DelayedLogic }, ct)
                        .ConfigureAwait(false);

                    await newID.PutValueAsync("UID_Person", loggedinuser, ct).ConfigureAwait(false);
                    await newID.PutValueAsync("CheckStatus", 2, ct).ConfigureAwait(false);

                    shoppingCart = await newID.GetValueAsync<string>("UID_ShoppingCartOrder").ConfigureAwait(false);

                    using (var u = qr.Session.StartUnitOfWork())
                    {
                        await u.PutAsync(newID, ct).ConfigureAwait(false);
                        await u.CommitAsync(ct).ConfigureAwait(false);
                    }

                    var actionAttributes = new ActionAttributes
                    {
                        shoppingCart = shoppingCart,
                        actionProperty2 = actionProperty2,
                        actionProperty3 = actionProperty3
                    };

                    var validationAttributes = new ValidationAttributes
                    {
                        validationProperty1 = validationProperty1,
                        validationProperty2 = validationProperty2,
                        validationProperty3 = validationProperty3
                    };

                    start.Add("ActionAttributes", actionAttributes);
                    start.Add("ValidationAttributes", validationAttributes);

                    return start;
                }));
        }

        public class PostedID
        {
            public string[] headerNames { get; set; }
            public int totalRows { get; set; }
            public ValidationAttributes ValidationAttributes { get; set; }
        }

        public class ActionAttributes
        {
            public string shoppingCart { get; set; }
            public string actionProperty2 { get; set; }
            public string actionProperty3 { get; set; }
        }

        public class ValidationAttributes
        {
            public string validationProperty1 { get; set; }
            public string validationProperty2 { get; set; }
            public string validationProperty3 { get; set; }
        }
    }
}
