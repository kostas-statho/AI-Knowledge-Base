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
    // When creating line breaks in your messages, please refrain from using the Format method. 
    // This is because the newline symbol (\n) returned by the Format method often includes an extra slash,
    // resulting in \\n instead of the desired \n.
    // To effectively create line breaks, it's recommended to use the $ (string interpolation) method.
    // This approach not only simplifies the syntax but also avoids the issue with the extra slash.
    // Example using Format: string.Format(@"Some text {0} extra text.", randomVariable)
    // Example using '$': $"Some text {randomVariable} extra text."
    // Example using '$' to include a line break:
    //   $"Some text {randomVariable} extra text.\nExtra text in new line"

    public class InsertIdentitiesEndAction :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/InsertIdentities/endaction")
            .Handle<PostedData, Dictionary<string, object>>("POST", async (posted, qr, ct) =>
            {
                // Processes the posted data asynchronously
                return await Task.Run(() => ProcessPostedData(posted));
            }));
        }

        // Processes the posted data and returns the result as a dictionary
        private Dictionary<string, object> ProcessPostedData(PostedData postedData)
        {
            // Initializes a dictionary to store the results
            var result = new Dictionary<string, object>
            {
                { "TotalRows", postedData.totalRows },
                { "SuccessfulRowsCount", postedData.SuccessfulRowsCount },
                { "ErrorRowsCount", postedData.ErrorRowsCount },
                { "SuccessfulRows", postedData.SuccessfulRows },
                { "ErrorRows", postedData.ErrorRows }
            };

            // Check if there are no errors and add appropriate messages
            if (postedData.ErrorRowsCount == 0)
            {
                result.Add("message",
                    string.Format(@"You imported {0} identities!", postedData.totalRows));
                result.Add("allImported", true);
            }
            else
            {
                result.Add("message",
                    string.Format(@"{0} errors occurred during import.",
                        postedData.ErrorRowsCount));
                result.Add("allImported", false);
            }

            return result;
        }

        // Class representing the structure of posted data
        public class PostedData
        {
            public int totalRows { get; set; }
            public int SuccessfulRowsCount { get; set; }
            public int ErrorRowsCount { get; set; }
            public List<SuccessfulRowData> SuccessfulRows { get; set; }
            public List<ErrorRowData> ErrorRows { get; set; }

            public PostedData()
            {
                SuccessfulRows = new List<SuccessfulRowData>();
                ErrorRows = new List<ErrorRowData>();
            }
        }

        // Represents the structure of a successful row
        public class SuccessfulRowData
        {
            public string index { get; set; }
            public List<SuccessfulColumnData> columns { get; set; }

            public SuccessfulRowData()
            {
                columns = new List<SuccessfulColumnData>();
            }
        }

        // Represents the structure of a successful column
        public class SuccessfulColumnData
        {
            public string column { get; set; }
            public string value { get; set; }
        }

        // Represents the structure of an error row
        public class ErrorRowData
        {
            public string index { get; set; }
            public List<ErrorColumnData> columns { get; set; }

            public ErrorRowData()
            {
                columns = new List<ErrorColumnData>();
            }
        }

        // Represents the structure of an error column
        public class ErrorColumnData
        {
            public string column { get; set; }
            public string value { get; set; }
            public string error { get; set; }
        }
    }
}
