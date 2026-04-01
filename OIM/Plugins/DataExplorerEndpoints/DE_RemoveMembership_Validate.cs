using QBM.CompositionApi.Definition;
using System.Xml.Linq;
using VI.DB.Entities;

namespace QBM.CompositionApi
{
    public class CCCRemoveMembershipValidate : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/removebusinessrole/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    List<object> objects = new List<object>();
                    string objectkey = string.Empty;
                    string group = string.Empty;
                    string xkey = string.Empty;
                    foreach (var column in posted.columns)
                    {
                        if (column.column == "XObjectKey")
                        {
                            objectkey = column.value;
                        }
                        if (column.column == "xDisplay")
                        {
                            group = column.value;
                        }
                    }
                    object[] array = objects.ToArray();
                    return array;
                }));
        }
        public class PostedID
        {
            public columnsarray[] columns { get; set; }
        }
        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }
    }
}