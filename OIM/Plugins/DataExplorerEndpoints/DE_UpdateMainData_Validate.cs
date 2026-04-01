using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class CCCUpdateMainDataValidate : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/updatemaindata/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    List<object> objects = new List<object>();

                    foreach (var column in posted.columns)
                    {
                        if ((column.value.ToString()) == "No Remarks" && column.column == "Remarks")
                        {
                            objects.Add(new { column = column.column, errorMsg = $"This is not an accepted value. Add more details" });
                        }
                        else if ((column.value.ToString()) == "2" && column.column == "Automation Level")
                        {
                            objects.Add(new { column = column.column, errorMsg = "Level 2 is locked" });
                        }
                        else
                        {
                            objects.Add(new { column = column.column });
                        }
                    }

                    return objects.ToArray();
                }));
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
