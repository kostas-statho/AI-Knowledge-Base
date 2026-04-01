// Template: Bulk Action — endaction (Step 4 of 4)
// Called once after all rows have been processed.
// Receives import stats, returns a summary message.
// Replace: MyFeatureEndAction, webportalplus/myfeature/endaction

using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class MyFeatureEndAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/myfeature/endaction")
                .Handle<PostedData, Dictionary<string, object>>("POST", async (posted, qr, ct) =>
                {
                    return await Task.Run(() =>
                    {
                        var result = new Dictionary<string, object>
                        {
                            { "TotalRows", posted.totalRows },
                            { "SuccessfulRowsCount", posted.SuccessfulRowsCount },
                            { "ErrorRowsCount", posted.ErrorRowsCount }
                        };

                        if (posted.ErrorRowsCount == 0)
                        {
                            result["message"] = $"Successfully processed {posted.totalRows} rows.";
                            result["allImported"] = true;
                        }
                        else
                        {
                            result["message"] = $"{posted.ErrorRowsCount} errors occurred during processing.";
                            result["allImported"] = false;
                        }

                        return result;
                    });
                }));
        }

        public class PostedData
        {
            public int totalRows { get; set; }
            public int SuccessfulRowsCount { get; set; }
            public int ErrorRowsCount { get; set; }
            public List<RowData> SuccessfulRows { get; set; } = new();
            public List<RowData> ErrorRows { get; set; } = new();
        }

        public class RowData
        {
            public string index { get; set; } = string.Empty;
            public List<ColumnValue> columns { get; set; } = new();
        }

        public class ColumnValue
        {
            public string column { get; set; } = string.Empty;
            public string value { get; set; } = string.Empty;
            public string? error { get; set; }
        }
    }
}
