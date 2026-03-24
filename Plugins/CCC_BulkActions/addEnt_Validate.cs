using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VI.Base;
using VI.DB;
using VI.DB.Entities;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Crud;
using QER.CompositionApi.Portal;
using QER.CompositionApi.QueueQuery;

namespace QBM.CompositionApi
{
    public class AddEntitlementValidate : IApiProviderFor<PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            BuildValidate(builder);
        }

        // =============================================================
        // VALIDATE (POST) with Extended Attributes
        // =============================================================
        private void BuildValidate(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/addentitlement/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    string personnelNumber = "";
                    string entitlement = "";
                    string loggedinuser = qr.Session.User().Uid;
                    string uidPersonOrdered = "";

                    List<object> objects = new List<object>();

                    // Extract values from CSV row
                    foreach (var column in posted.columns)
                    {
                        if (column.column == "Personnel Number")
                            personnelNumber = column.value;

                        if (column.column == "Entitlement")
                            entitlement = column.value;
                    }

                    // ----------------------------------------------------------
                    // STEP 1: Validate PERSON exists in manager scope
                    // ----------------------------------------------------------
                    var q01 = Query
                        .From("Person")
                        .Select("*")
                        .Where(string.Format(
                            "PersonnelNumber = '{0}' AND UID_Department IN (" +
                            "SELECT UID_Department FROM Department WHERE UID_PersonHead = '{1}')",
                            personnelNumber, loggedinuser));

                    var tryGet01 = await qr.Session.Source()
                        .TryGetAsync(q01, EntityLoadType.DelayedLogic)
                        .ConfigureAwait(false);

                    if (tryGet01.Success)
                    {
                        uidPersonOrdered = await tryGet01.Result
                            .GetValueAsync<string>("UID_Person")
                            .ConfigureAwait(false);
                    }

                    // ----------------------------------------------------------
                    // STEP 2: Validate entitlement exists and is permitted
                    // ----------------------------------------------------------
                    var queryS = Query
                        .From("ITShopOrg")
                        .Select("Ident_Org")
                        .Where(string.Format(@"
                            Ident_Org = '{0}' 
                            AND UID_ITShopOrg IN (
                                SELECT i.UID_ITShopOrg 
                                FROM AccProduct a
                                JOIN ITShopOrg i ON a.UID_AccProduct = i.UID_AccProduct
                                JOIN ITShopOrg t ON t.UID_ITShopOrg = i.UID_ParentITShopOrg
                                JOIN ITShopOrg s ON s.UID_ITShopOrg = t.UID_ParentITShopOrg
                                WHERE s.UID_ITShopOrg IN (
                                    SELECT i.UID_ITShopOrg FROM ITShopOrg i
                                    JOIN ITShopOrg t ON i.UID_ITShopOrg = t.UID_ParentITShopOrg
                                    JOIN PersonInITShopOrg pii ON pii.UID_ITShopOrg = t.UID_ITShopOrg
                                    WHERE pii.UID_Person = '{1}'
                                )
                            )", entitlement, uidPersonOrdered));

                    var tryGetS = await qr.Session.Source()
                        .TryGetAsync(queryS, EntityLoadType.DelayedLogic)
                        .ConfigureAwait(false);

                    // ----------------------------------------------------------
                    // STEP 3: PER-COLUMN VALIDATION
                    // ----------------------------------------------------------
                    foreach (var column in posted.columns)
                    {
                        if (column.column == "Personnel Number")
                        {
                            if (string.IsNullOrEmpty(personnelNumber))
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Personnel Number is a mandatory field."
                                });
                            }
                            else if (!tryGet01.Success)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Identity does not exist in the Department."
                                });
                            }
                            else
                            {
                                var q1 = Query.From("PersonWantsOrg")
                                    .Select("*")
                                    .Where(string.Format(
                                        "DisplayOrg = '{0}' AND " +
                                        "UID_PersonOrdered IN (" +
                                        "SELECT UID_Person FROM Person WHERE PersonnelNumber = '{1}' AND UID_Department IN (" +
                                        "SELECT UID_Department FROM Department WHERE UID_PersonHead = '{2}')) " +
                                        "AND OrderState = 'Assigned'",
                                        entitlement, personnelNumber, loggedinuser));

                                var tryGet1 = await qr.Session.Source()
                                    .TryGetAsync(q1, EntityLoadType.DelayedLogic)
                                    .ConfigureAwait(false);

                                if (tryGet1.Success)
                                {
                                    objects.Add(new
                                    {
                                        column = column.column,
                                        errorMsg = "Assignment already exists."
                                    });
                                }
                                else
                                {
                                    objects.Add(new { column = column.column });
                                }
                            }
                        }

                        else if (column.column == "Entitlement")
                        {
                            if (string.IsNullOrEmpty(entitlement))
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Entitlement is a mandatory field."
                                });
                            }
                            else if (!tryGetS.Success)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Entitlement does not exist or the assignment is not permitted."
                                });
                            }
                            else
                            {
                                var q1 = Query.From("PersonWantsOrg")
                                    .Select("*")
                                    .Where(string.Format(
                                        "DisplayOrg = '{0}' AND " +
                                        "UID_PersonOrdered IN (" +
                                        "SELECT UID_Person FROM Person WHERE PersonnelNumber = '{1}' AND UID_Department IN (" +
                                        "SELECT UID_Department FROM Department WHERE UID_PersonHead = '{2}')) " +
                                        "AND OrderState = 'Assigned'",
                                        entitlement, personnelNumber, loggedinuser));

                                var tryGet1 = await qr.Session.Source()
                                    .TryGetAsync(q1, EntityLoadType.DelayedLogic)
                                    .ConfigureAwait(false);

                                if (tryGet1.Success)
                                {
                                    objects.Add(new
                                    {
                                        column = column.column,
                                        errorMsg = "Assignment already exists."
                                    });
                                }
                                else
                                {
                                    objects.Add(new { column = column.column });
                                }
                            }
                        }
                        else
                        {
                            objects.Add(new { column = column.column });
                        }
                    }

                    // ----------------------------------------------------------
                    // STEP 4: Extended Attributes (Line 10 logic)
                    // ----------------------------------------------------------
                    if (posted.index == "10")
                    {
                        var validationAttributes = new ValidationAttributes
                        {
                            validationProperty1 = "New value for validation property1 from validate endpoint from line 10",
                            validationProperty2 = "New value for validation property2 from validate endpoint from line 10",
                            validationProperty3 = "New value for validation property3 from validate endpoint from line 10"
                        };

                        objects.Add(new { ValidationAttributes = validationAttributes });
                    }

                    return objects.ToArray();
                })
            );
        }

        // =============================================================
        //  Supporting Classes
        // =============================================================

        public class PostedID
        {
            public string index { get; set; }
            public columnsarray[] columns { get; set; }
            public ValidationAttributes ValidationAttributes { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }

        public class ValidationAttributes
        {
            public string validationProperty1 { get; set; }
            public string validationProperty2 { get; set; }
            public string validationProperty3 { get; set; }
        }
    }
}