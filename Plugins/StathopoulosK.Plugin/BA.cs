using System.Collections.Generic;
using System.Threading.Tasks;
using VI.Base;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Crud;
using System.Runtime.ConstrainedExecution;
namespace QBM.CompositionApi
{
    public class InsertIdentitiesCSVTemplate :
    IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/InsertIdentities/csvtemplate")
            .Handle("GET", async (qr, ct) =>
            {
                List<ColumnValuePair> csvTemplate = new List<ColumnValuePair>
                {
                    new ColumnValuePair { Column = "First Name", Value = "Sarah" },
                    new ColumnValuePair { Column = "Last Name", Value = "Johnson" },
                    new ColumnValuePair { Column = "E-mail", Value = "sarah.johnson@examplebank.com" },
                    new ColumnValuePair { Column = "Remarks", Value = "productize visionary applications" },
                    new ColumnValuePair { Column = "Job Description", Value = "Credit Analyst" },
                    new ColumnValuePair { Column = "Personnel Number", Value = "547678" },
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