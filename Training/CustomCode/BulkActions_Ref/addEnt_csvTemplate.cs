using System.Collections.Generic;
using System.Threading.Tasks;
using VI.Base;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Crud;
using System.Runtime.ConstrainedExecution;
using QER.CompositionApi.Portal;

namespace QBM.CompositionApi
{
    public class AddEntitlementCSVTemplate : IApiProviderFor<PortalApiProject>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/addentitlement/csvtemplate")
            .Handle("GET", async (qr, ct) =>
            {
                List<ColumnValuePair> csvTemplate = new List<ColumnValuePair>
                {
                    new ColumnValuePair { Column = "Personnel Number", Value = "PersonnelNumber" },
                    new ColumnValuePair { Column = "Entitlement", Value = "Ident_Org" },
                };

                return csvTemplate;
            }));
        }
        // Class representing a single column-value pair
        public class ColumnValuePair
        {
            public string Column { get; set; }
            public string Value { get; set; }
        }
    }
}