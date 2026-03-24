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
    public class InsertIdentitiesStartValidate :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>,
        IApiProvider
    {
        // When creating line breaks in your messages, please refrain from using the Format method.
        // This is because the newline symbol (\n) returned by the Format method often includes \\n.
        // Use string interpolation for cleaner and correct line breaks.

        private string[] requiredHeaders =
        {
            "First Name",
            "Last Name",
            "E-mail",
            "Remarks",
            "Job Description",
            "Personnel Number"
        };

        private HeaderError HeaderErrorCheck(PostedID posted)
        {
            List<string> missingColumns = new List<string>();

            // Check each required header for its presence in the posted data.
            foreach (var header in requiredHeaders)
            {
                if (!posted.headerNames.Contains(header, StringComparer.OrdinalIgnoreCase))
                {
                    missingColumns.Add(header);
                }
            }

            // If missing headers exist, return error.
            if (missingColumns.Count > 0)
            {
                string missingColumnsMessage = string.Join(", ", missingColumns);

                return new HeaderError(
                    $"Invalid CSV format: Column(s) missing: {missingColumnsMessage}.|" +
                    "Mandatory columns: First Name, Last Name, E-mail, Remarks, Job Description, Personnel Number"
                );
            }

            return null;
        }

        // Method to set up the API method.
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/InsertIdentities/startvalidate")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    // Check for header errors.
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

                    // Retrieve maximum rows configuration parameter.
                    var myParam1 = await qr.Session.Config()
                        .GetConfigParmAsync(
                            "Custom\\WebPortalPlus\\BulkActions\\InsertIdentities\\MaxRows",
                            ct)
                        .ConfigureAwait(false);

                    var result = new ReturnedID();

                    // Check if MaxRows is configured.
                    if (!string.IsNullOrEmpty(myParam1))
                    {
                        int MaxRows = int.Parse(myParam1);

                        if (posted.totalRows > MaxRows)
                        {
                            result.message = $"You cannot import more than {myParam1} identities";
                            result.permission = false;
                        }
                        else
                        {
                            result.message = $"You are going to validate {posted.totalRows} identities.";
                            result.permission = true;
                        }
                    }
                    else
                    {
                        result.message = $"You are going to validate {posted.totalRows} identities.";
                        result.permission = true;
                    }

                    return result;
                })
            );
        }

        // Class representing the request body.
        public class PostedID
        {
            public int totalRows { get; set; }
            public string[] headerNames { get; set; }
        }

        // Class representing the response body.
        public class ReturnedID
        {
            public string message { get; set; }
            public bool permission { get; set; }
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
