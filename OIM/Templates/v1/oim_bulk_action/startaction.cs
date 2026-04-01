// Template: Bulk Action — startaction (Step 1 of 4)
// Called once before any rows are processed.
// Returns: { message, permission, collectImportData? }
// Replace: MyFeatureStartAction, webportalplus/myfeature/startaction

using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class MyFeatureStartAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/myfeature/startaction")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    // Optional: read a config param to enable data collection
                    var collectParam = await qr.Session.Config()
                        .GetConfigParmAsync("Custom\\WebPortalPlus\\MyFeature\\CollectImportData", ct)
                        .ConfigureAwait(false);

                    bool collectImportData = !string.IsNullOrEmpty(collectParam);

                    // Use $"..." for messages containing \n (not string.Format)
                    var response = new Dictionary<string, object>
                    {
                        { "message", $"You are about to process {posted.totalRows} rows." },
                        { "permission", true }
                    };

                    if (collectImportData)
                        response.Add("collectImportData", true);

                    return response;
                }));
        }

        public class PostedID
        {
            public string[] headerNames { get; set; } = Array.Empty<string>();
            public int totalRows { get; set; }
        }
    }
}
