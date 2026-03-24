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
    public class InsertIdentitiesStartAction :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/InsertIdentities/startaction")
            .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
            {
                // Fetching the configuration parameter to check that if we want to collect
                // the data which will be successfully imported or failed
                var myParam1 = await qr.Session.Config()
                    .GetConfigParmAsync(
                        "Custom\\WebPortalPlus\\BulkActions\\InsertIdentities\\CollectImportData",
                        ct).ConfigureAwait(false);

                bool collectImportData = false;

                // Setting a flag based on the configuration parameter
                if (!string.IsNullOrEmpty(myParam1))
                {
                    collectImportData = true;
                }

                // Creating a dictionary to hold the response data
                var start = new Dictionary<string, object>
                {
                    // When creating line breaks in your messages, please refrain from using
                    // the Format method. This is because the newline symbol (\n) returned by
                    // the Format method often includes an extra slash, resulting in \\n
                    // instead of the desired \n.
                    //
                    // To effectively create line breaks, it's recommended to use the $
                    // (string interpolation) method. This approach not only simplifies the
                    // syntax but also avoids the issue with the extra slash.
                    //
                    // Example using Format:
                    //   string.Format(@"Some text {0} extra text.", randomVariable)
                    //
                    // Example using '$':
                    //   $"Some text {randomVariable} extra text."
                    //
                    // Example using '$' to include a line break:
                    //   $"Some text {randomVariable} extra text.\nExtra text in new line"

                    { "message", string.Format(@"You are going to import {0} identities.", posted.totalRows) },
                    { "permission", true }
                };

                // Adding additional data to the response if the flag is set
                if (collectImportData)
                {
                    start.Add("collectImportData", collectImportData);
                }

                // Returning the constructed response
                return start;
            }));
        }

        // Class defining the structure of incoming POST data
        public class PostedID
        {
            public string[] headerNames { get; set; }
            public int totalRows { get; set; }
        }
    }
}
