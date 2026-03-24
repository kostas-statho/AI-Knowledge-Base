// RemoveEntitlements.cs
// Bulk Actions – Remove Entitlements using PersonWantsOrg.Unsubscribe

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

namespace QBM.CompositionApi
{
    public class RemoveEntitlements : IApiProviderFor<PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            BuildCsvTemplate(builder);
            BuildStartValidate(builder);
            BuildValidate(builder);
            BuildStartAction(builder);
            BuildAction(builder);
            BuildEndAction(builder);
        }

        // =============================================================
        //  CSV TEMPLATE (GET)
        // =============================================================
        private void BuildCsvTemplate(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/removeentitlements/csvtemplate")
                .Handle("GET", async (qr, ct) =>
                {
                    var csvTemplate = new List<ColumnValuePair>
                    {
                        new ColumnValuePair { Column = "Personnel Number", Value = "PersonnelNumber" },
                        new ColumnValuePair { Column = "Entitlement",      Value = "Ident_Org" }
                    };

                    return csvTemplate;
                })
            );
        }

        public class ColumnValuePair
        {
            public string Column { get; set; }
            public string Value { get; set; }
        }

        // =============================================================
        //  START VALIDATE (POST)
        // =============================================================
        private void BuildStartValidate(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/removeentitlements/startvalidate")
                .Handle<PostedStartValidate, object>("POST", async (posted, qr, ct) =>
                {
                    string[] requiredHeaders = { "Personnel Number", "Entitlement" };
                    var missing = new List<string>();

                    foreach (var header in requiredHeaders)
                    {
                        if (posted.headerNames == null ||
                            !posted.headerNames.Contains(header, StringComparer.OrdinalIgnoreCase))
                        {
                            missing.Add(header);
                        }
                    }

                    if (missing.Count > 0)
                    {
                        string msg =
                            $"Invalid CSV format: Column(s) missing: {string.Join(", ", missing)}.|" +
                            "Mandatory columns: Personnel Number, Entitlement";

                        return new StartValidateResponse
                        {
                            message = msg,
                            permission = false
                        };
                    }

                    var maxRowsCfg = await qr.Session.Config()
                        .GetConfigParmAsync("Custom\\WebPortalPlus\\BulkActions\\removeentitlements\\MaxRows", ct)
                        .ConfigureAwait(false);

                    var result = new StartValidateResponse();

                    if (!string.IsNullOrEmpty(maxRowsCfg) && int.TryParse(maxRowsCfg, out int maxRows))
                    {
                        if (posted.totalRows > maxRows)
                        {
                            result.message = $"You cannot process more than {maxRows} rows.";
                            result.permission = false;
                        }
                        else
                        {
                            result.message = $"You are going to validate {posted.totalRows} removals.";
                            result.permission = true;
                        }
                    }
                    else
                    {
                        result.message = $"You are going to validate {posted.totalRows} removals.";
                        result.permission = true;
                    }

                    return result;
                })
            );
        }

        public class PostedStartValidate
        {
            public int totalRows { get; set; }
            public string[] headerNames { get; set; }
        }

        public class StartValidateResponse
        {
            public string message { get; set; }
            public bool permission { get; set; }
        }

        // =============================================================
        //  VALIDATE (POST)
        //  - Person exists in manager scope
        //  - Entitlement exists (ITShopOrg)
        //  - Entitlement assigned (PersonHasESet with ESet of that ITShopOrg)
        // =============================================================
        private void BuildValidate(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/removeentitlements/validate")
                .Handle<PostedValidateRow, object[]>("POST", async (posted, qr, ct) =>
                {
                    string personnelNumber = "";
                    string entitlement = "";
                    string loggedinuser = qr.Session.User().Uid;

                    foreach (var column in posted.columns ?? Array.Empty<ValidateColumn>())
                    {
                        if (column.column == "Personnel Number")
                            personnelNumber = column.value;

                        if (column.column == "Entitlement")
                            entitlement = column.value;
                    }

                    var objects = new List<object>();

                    // STEP 1: Person in manager scope
                    var qPerson = Query
                        .From("Person")
                        .Select("*")
                        .Where(
                            $"PersonnelNumber = '{personnelNumber}' AND " +
                            $"UID_Department IN (SELECT UID_Department FROM Department WHERE UID_PersonHead = '{loggedinuser}')"
                        );

                    var tryGetPerson = await qr.Session.Source()
                        .TryGetAsync(qPerson, EntityLoadType.DelayedLogic)
                        .ConfigureAwait(false);

                    bool hasPerson = tryGetPerson.Success;
                    string uidPerson = null;

                    if (hasPerson)
                    {
                        uidPerson = await tryGetPerson.Result
                            .GetValueAsync<string>("UID_Person")
                            .ConfigureAwait(false);
                    }

                    // STEP 2: Entitlement exists (ITShopOrg)
                    var qIT = Query
                        .From("ITShopOrg")
                        .Select("*")
                        .Where($"Ident_Org = '{entitlement}'");

                    var tryGetIT = await qr.Session.Source()
                        .TryGetAsync(qIT, EntityLoadType.DelayedLogic)
                        .ConfigureAwait(false);

                    bool hasEnt = tryGetIT.Success;
                    string uidITShopOrg = null;

                    if (hasEnt)
                    {
                        uidITShopOrg = await tryGetIT.Result
                            .GetValueAsync<string>("UID_ITShopOrg")
                            .ConfigureAwait(false);
                    }

                    // STEP 3: Entitlement assigned (PersonHasESet with ESet of that ITShopOrg)
                    bool hasAssigned = false;

                    if (hasPerson && hasEnt)
                    {
                        var qAssigned = Query
                            .From("PersonHasESet")
                            .Select("*")
                            .Where(
                                $"UID_Person = '{uidPerson}' AND UID_ESet IN (" +
                                $"SELECT UID_ESet FROM ITShopOrgHasESet WHERE UID_ITShopOrg = '{uidITShopOrg}')"
                            );

                        var tryGetAssigned = await qr.Session.Source()
                            .TryGetAsync(qAssigned, EntityLoadType.DelayedLogic)
                            .ConfigureAwait(false);

                        hasAssigned = tryGetAssigned.Success;
                    }

                    // STEP 4: Per-column validation
                    foreach (var column in posted.columns ?? Array.Empty<ValidateColumn>())
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
                            else if (!hasPerson)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Identity does not exist in the Department."
                                });
                            }
                            else if (hasEnt && !hasAssigned)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Entitlement is not assigned to this identity."
                                });
                            }
                            else
                            {
                                objects.Add(new { column = column.column });
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
                            else if (!hasEnt)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Entitlement does not exist."
                                });
                            }
                            else if (hasPerson && !hasAssigned)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Entitlement is not assigned to this identity."
                                });
                            }
                            else
                            {
                                objects.Add(new { column = column.column });
                            }
                        }
                        else
                        {
                            objects.Add(new { column = column.column });
                        }
                    }

                    // Optional: line 10 extended attributes
                    if (posted.index == "10")
                    {
                        var validationAttributes = new ValidationAttributes
                        {
                            validationProperty1 = "New value for validation property1 (remove) line 10",
                            validationProperty2 = "New value for validation property2 (remove) line 10",
                            validationProperty3 = "New value for validation property3 (remove) line 10"
                        };

                        objects.Add(new { ValidationAttributes = validationAttributes });
                    }

                    return objects.ToArray();
                })
            );
        }

        public class PostedValidateRow
        {
            public string index { get; set; }
            public ValidateColumn[] columns { get; set; }
            public ValidationAttributes ValidationAttributes { get; set; }
        }

        public class ValidateColumn
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

        // =============================================================
        //  START ACTION (POST)
        // =============================================================
        private void BuildStartAction(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/removeentitlements/startaction")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    var myParam1 = await qr.Session.Config()
                        .GetConfigParmAsync("Custom\\WebPortalPlus\\BulkActions\\removeentitlements\\CollectImportData", ct)
                        .ConfigureAwait(false);

                    bool collectImportData = !string.IsNullOrEmpty(myParam1);

                    var actionProperty2 = "Some value for action property2 from start action (remove)";
                    var actionProperty3 = "Some value for action property3 from start action (remove)";

                    var validationProperty1 = "New value for validation property1 from start action (remove)";
                    var validationProperty2 = "New value for validation property2 from start action (remove)";
                    var validationProperty3 = posted.ValidationAttributes?.validationProperty3 ?? string.Empty;

                    var start = new Dictionary<string, object>
                    {
                        { "message",   $"You are going to remove {posted.totalRows} entitlements." },
                        { "permission", true }
                    };

                    if (collectImportData)
                    {
                        start.Add("collectImportData", collectImportData);
                    }

                    var actionAttributes = new ActionAttributes
                    {
                        shoppingCart = string.Empty,
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
                })
            );
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

        // =============================================================
        //  ACTION (POST) – Unsubscribe + CustomProperty01 = "FoundByBA"
        // =============================================================
        public void BuildAction(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/removeentitlements/action")
                .Handle<PostedIDAction>("POST", async (posted, qr, ct) =>
                {
                    string product = "";
                    string personnelnumber = "";
                    var loggedinuser = qr.Session.User().Uid;

                    foreach (var column in posted.columns)
                    {
                        if (column.column == "Personnel Number")
                        {
                            personnelnumber = column.value;
                        }
                        if (column.column == "Entitlement")
                        {
                            product = column.value;
                        }
                    }

                    var query1 = Query.From("PersonWantsOrg")
                                      .Select("*")
                                      .Where(string.Format(
                                          "DisplayOrg = '{0}' and UID_PersonOrdered in (select UID_Person from Person where PersonnelNumber = '{1}' and UID_Department in (select UID_Department from Department where UID_PersonHead = '{2}')) and OrderState = 'Assigned'",
                                          product, personnelnumber, loggedinuser)
                                      );

                    var tryget = await qr.Session.Source().TryGetAsync(query1, EntityLoadType.DelayedLogic, ct).ConfigureAwait(false);

                    if (tryget.Success)
                    {
                        await tryget.Result.CallMethodAsync("Unsubscribe", ct).ConfigureAwait(false);
                        await tryget.Result.SaveAsync(qr.Session, ct).ConfigureAwait(continueOnCapturedContext: false);
                    }

                }));
        }


        public class PostedIDAction
        {
            public columnsarray[] columns { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }

        // =============================================================
        //  END ACTION (POST) – Based on addEntitlementEndAction
        // =============================================================
        private void BuildEndAction(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/removeentitlements/endaction")
                .Handle<PostedData, Dictionary<string, object>>("POST", async (posted, qr, ct) =>
                {
                    return await Task.Run(() => ProcessPostedData(posted));
                })
            );
        }

        private Dictionary<string, object> ProcessPostedData(PostedData postedData)
        {
            var result = new Dictionary<string, object>
            {
                { "TotalRows",           postedData.totalRows },
                { "SuccessfulRowsCount", postedData.SuccessfulRowsCount },
                { "ErrorRowsCount",      postedData.ErrorRowsCount },
                { "SuccessfulRows",      postedData.SuccessfulRows },
                { "ErrorRows",           postedData.ErrorRows }
            };

            if (postedData.ErrorRowsCount == 0)
            {
                result.Add("message", $"You removed entitlements for {postedData.totalRows} rows!");
                result.Add("allProcessed", true);
            }
            else
            {
                result.Add("message", $"{postedData.ErrorRowsCount} errors occurred during entitlement removal.");
                result.Add("allProcessed", false);
            }

            return result;
        }

        public class PostedData
        {
            public int totalRows { get; set; }
            public int SuccessfulRowsCount { get; set; }
            public int ErrorRowsCount { get; set; }
            public List<SuccessfulRowData> SuccessfulRows { get; set; } = new();
            public List<ErrorRowData> ErrorRows { get; set; } = new();
        }

        public class SuccessfulRowData
        {
            public string index { get; set; }
            public List<SuccessfulColumnData> columns { get; set; } = new();
        }

        public class SuccessfulColumnData
        {
            public string column { get; set; }
            public string value { get; set; }
        }

        public class ErrorRowData
        {
            public string index { get; set; }
            public List<ErrorColumnData> columns { get; set; } = new();
        }

        public class ErrorColumnData
        {
            public string column { get; set; }
            public string value { get; set; }
            public string error { get; set; }
        }
    }
}
