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
    public class AddEntitlementStartValidate :
        IApiProviderFor<PortalApiProject>, IApiProvider
    {
        private string[] requiredHeaders = { "Personnel Number", "Entitlement" };

        private HeaderError HeaderErrorCheck(PostedID posted)
        {
            List<string> missingColumns = new List<string>();

            // Check each required header
            foreach (var header in requiredHeaders)
            {
                if (!posted.headerNames.Contains(header, StringComparer.OrdinalIgnoreCase))
                {
                    missingColumns.Add(header);
                }
            }

            if (missingColumns.Count > 0)
            {
                string missingColumnsMessage = string.Join(", ", missingColumns);
                return new HeaderError(
                    $"Invalid CSV format: Column(s) missing: {missingColumnsMessage}.|" +
                    $"Mandatory columns: Personnel Number, Entitlement"
                );
            }

            return null;
        }

        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/addentitlement/startvalidate")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    var loggedinuser = qr.Session.User().Uid;

                    // Extended attribute values (example usage)
                    var validationProperty1 = "Some value for validation property1 from start validate";
                    var validationProperty2 = "Some value for validation property2 from start validate";
                    var validationProperty3 = "Some value for validation property3 from start validate";

                    // Header error check
                    HeaderError error = HeaderErrorCheck(posted);
                    if (error != null)
                    {
                        string[] errorMessages = error.error.Split('|');
                        string formattedErrorMessage = string.Join("\n", errorMessages);

                        return new ReturnedID
                        {
                            message = formattedErrorMessage,
                            permission = false
                        };
                    }

                    // Read MaxRows parameter
                    var maxRowsParam = await qr.Session.Config()
                        .GetConfigParmAsync("Custom\\WebPortalPlus\\BulkActions\\AddEntitlement\\MaxRows", ct)
                        .ConfigureAwait(false);

                    var result = new ReturnedID();

                    if (!string.IsNullOrEmpty(maxRowsParam))
                    {
                        int maxRows = int.Parse(maxRowsParam);

                        if (posted.totalRows > maxRows)
                        {
                            result.message =
                                $"You cannot assign more than {maxRowsParam} entitlement(s).";
                            result.permission = false;
                        }
                        else
                        {
                            result.message =
                                $"You are going to validate {posted.totalRows} assignments.";
                            result.permission = true;
                        }
                    }
                    else
                    {
                        result.message =
                            $"You are going to validate {posted.totalRows} assignments.";
                        result.permission = true;
                    }

                    // Attach extended attributes
                    result.ValidationAttributes = new ValidationAttributes
                    {
                        validationProperty1 = validationProperty1,
                        validationProperty2 = validationProperty2,
                        validationProperty3 = validationProperty3
                    };

                    return result;
                })
            );
        }

        // ==============================
        // Supporting Classes
        // ==============================

        public class PostedID
        {
            public int totalRows { get; set; }
            public string[] headerNames { get; set; }
        }

        public class ReturnedID
        {
            public string message { get; set; }
            public bool permission { get; set; }
            public ValidationAttributes ValidationAttributes { get; set; }
        }

        public class ValidationAttributes
        {
            public string validationProperty1 { get; set; }
            public string validationProperty2 { get; set; }
            public string validationProperty3 { get; set; }
        }

        public class HeaderError
        {
            public string error { get; set; }

            public HeaderError(string message)
            {
                error = message;
            }
        }
    }
}
