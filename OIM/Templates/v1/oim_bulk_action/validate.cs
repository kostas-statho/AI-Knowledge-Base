// Template: Bulk Action — validate (Step 2 of 4, called per row)
// Returns object[] — each element is either:
//   { column }              → row is valid for that column
//   { column, errorMsg }   → validation failed
// Replace: MyFeatureValidate, webportalplus/myfeature/validate

using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class MyFeatureValidate : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/myfeature/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    var results = new List<object>();

                    foreach (var col in posted.columns)
                    {
                        if (col.column == "UID_Person")
                        {
                            if (string.IsNullOrWhiteSpace(col.value))
                            {
                                results.Add(new { column = col.column, errorMsg = "UID_Person is required." });
                            }
                            else
                            {
                                bool exists = await qr.Session.Source()
                                    .ExistsAsync("Person", $"UID_Person = '{col.value}'", ct)
                                    .ConfigureAwait(false);
                                results.Add(exists
                                    ? new { column = col.column }
                                    : new { column = col.column, errorMsg = "Person not found." });
                            }
                        }
                        else
                        {
                            // Pass-through for columns not requiring validation
                            results.Add(new { column = col.column });
                        }
                    }

                    return results.ToArray();
                }));
        }

        public class PostedID
        {
            public string index { get; set; } = string.Empty;
            public ColumnValue[] columns { get; set; } = Array.Empty<ColumnValue>();
        }

        public class ColumnValue
        {
            public string column { get; set; } = string.Empty;
            public string value { get; set; } = string.Empty;
        }
    }
}
