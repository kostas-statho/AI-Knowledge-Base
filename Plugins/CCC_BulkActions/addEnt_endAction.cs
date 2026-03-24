using System;
using System.Collections.Generic;
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
    public class addEntitlementEndAction : IApiProviderFor<PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/addentitlement/endaction")
                .Handle<PostedData, Dictionary<string, object>>("POST", async (posted, qr, ct) =>
                {
                    return await Task.Run(() => ProcessPostedData(posted));
                }));
        }

        private Dictionary<string, object> ProcessPostedData(PostedData postedData)
        {
            var result = new Dictionary<string, object>
            {
                { "TotalRows", postedData.totalRows },
                { "SuccessfulRowsCount", postedData.SuccessfulRowsCount },
                { "ErrorRowsCount", postedData.ErrorRowsCount },
                { "SuccessfulRows", postedData.SuccessfulRows },
                { "ErrorRows", postedData.ErrorRows }
            };

            if (postedData.ErrorRowsCount == 0)
            {
                result.Add("message", $"You assigned {postedData.totalRows} entitlements!");
                result.Add("allAssigned", true);
            }
            else
            {
                result.Add("message", $"{postedData.ErrorRowsCount} errors occurred during entitlement assignment.");
                result.Add("allAssigned", false);
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