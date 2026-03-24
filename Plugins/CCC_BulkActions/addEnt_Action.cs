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
using QER.CompositionApi.Portal;

namespace QBM.CompositionApi
{
    public class addEntitlementAction : IApiProviderFor<PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/addentitlement/action")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    var product = "";
                    var personordered = "";
                    var loggedinuser = qr.Session.User().Uid;
                    var reason = "Entitlement added by Bulk Actions.";

                    var actionProperty2 = "Some value for action property2 from action";
                    var actionProperty3 = "Some value for action property3 from action";

                    var validationProperty1 = "New value for validation property1 from action";
                    var validationProperty2 = "New value for validation property2 from action";
                    var validationProperty3 = posted.ValidationAttributes.validationProperty3;

                    List<object> actionResponse = new List<object>();

                    foreach (var column in posted.columns)
                    {
                        if (column.column == "Personnel Number")
                        {
                            var q2 = Query.From("Person")
                                .Select("UID_Person")
                                .Where($"PersonnelNumber = '{column.value}' AND UID_Department IN (SELECT UID_Department FROM Department WHERE UID_PersonHead = '{loggedinuser}')");

                            var tryGetPersonOrdered = await qr.Session.Source().TryGetAsync(q2, EntityLoadType.DelayedLogic).ConfigureAwait(false);

                            if (tryGetPersonOrdered.Success)
                            {
                                personordered = tryGetPersonOrdered.Result.GetValueAsync<string>("UID_Person").Result;
                            }
                        }

                        if (column.column == "Entitlement")
                        {
                            var q2 = Query.From("ITShopOrg")
                                .Select("UID_ITShopOrg")
                                .Where($"Ident_Org = '{column.value}'");

                            var tryGetProduct = await qr.Session.Source().TryGetAsync(q2, EntityLoadType.DelayedLogic).ConfigureAwait(false);

                            if (tryGetProduct.Success)
                            {
                                product = tryGetProduct.Result.GetValueAsync<string>("UID_ITShopOrg").Result;
                            }
                        }
                    }

                    string shoppingCart = posted.ActionAttributes.shoppingCart;

                    var newID = await qr.Session.Source().CreateNewAsync(
                        "PersonWantsOrg",
                        new EntityParameters { CreationType = EntityCreationType.DelayedLogic }, ct).ConfigureAwait(false);

                    await newID.PutValueAsync("UID_Org", product, ct).ConfigureAwait(false);
                    await newID.PutValueAsync("UID_PersonOrdered", personordered, ct).ConfigureAwait(false);
                    await newID.PutValueAsync("UID_PersonInserted", loggedinuser, ct).ConfigureAwait(false);
                    await newID.PutValueAsync("OrderReason", reason, ct).ConfigureAwait(false);
                    await newID.PutValueAsync("UID_ShoppingCartOrder", shoppingCart, ct).ConfigureAwait(false);

                    using (var u = qr.Session.StartUnitOfWork())
                    {
                        await u.PutAsync(newID, ct).ConfigureAwait(false);
                        await u.CommitAsync(ct).ConfigureAwait(false);
                    }

                    var validationAttributes = new ValidationAttributes
                    {
                        validationProperty1 = validationProperty1,
                        validationProperty2 = validationProperty2,
                        validationProperty3 = validationProperty3
                    };

                    var actionAttributes = new ActionAttributes
                    {
                        shoppingCart = shoppingCart,
                        actionProperty2 = "New value for action property2 from action endpoint",
                        actionProperty3 = "New value for action property3 from action endpoint"
                    };

                    actionResponse.Add(new { ActionAttributes = actionAttributes });
                    actionResponse.Add(new { ValidationAttributes = validationAttributes });

                    return actionResponse.ToArray();
                }));
        }

        public class PostedID
        {
            public string index { get; set; }
            public columnsarray[] columns { get; set; }
            public ValidationAttributes ValidationAttributes { get; set; }
            public ActionAttributes ActionAttributes { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
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