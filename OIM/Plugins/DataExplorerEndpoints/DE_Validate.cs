using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class CCCApproveAttestationValidate :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/approveattestation/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    List<object> results = new List<object>();

                    foreach (var column in posted.columns)
                    {
                        // Validate the popup Reason parameter
                        if (column.column == "Reason for approval" && column.value?.ToString() == "No Reason")
                        {
                            results.Add(new
                            {
                                column = column.column,
                                errorMsg = "No reason to be granted"
                            });
                        }
                        else
                        {
                            results.Add(new { column = column.column });
                        }
                    }

                    return results.ToArray();
                })
            );
        }

        public class PostedID
        {
            public columnsarray[] element { get; set; }
            public columnsarray[] columns { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public object value { get; set; }
        }
    }
}
