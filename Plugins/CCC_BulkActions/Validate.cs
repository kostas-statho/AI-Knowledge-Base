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
using QER.CompositionApi.Portal;

namespace QBM.CompositionApi
{
    public class InsertIdentitiesValidate :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>,
        IApiProvider
    {
        // When creating line breaks in your messages, please refrain from using the Format method.
        // The newline symbol returned by Format often appears as \\n instead of \n.
        // Use string interpolation ($"...") for correct formatting.

        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/InsertIdentities/validate")
                .Handle<PostedID, object[]>("POST", async (posted, qr, ct) =>
                {
                    var strUID_Person = qr.Session.User().Uid;

                    // List to store validation result objects
                    List<object> objects = new List<object>();

                    // Iterate through posted columns
                    foreach (var column in posted.columns)
                    {
                        // Validate First Name
                        if (string.IsNullOrEmpty(column.value) && column.column == "First Name")
                        {
                            objects.Add(new
                            {
                                column = column.column,
                                errorMsg = "First Name is a mandatory field."
                            });
                        }
                        // Validate Last Name
                        else if (string.IsNullOrEmpty(column.value) && column.column == "Last Name")
                        {
                            objects.Add(new
                            {
                                column = column.column,
                                errorMsg = "Last Name is a mandatory field."
                            });
                        }
                        // Validate Personnel Number
                        else if (column.column == "Personnel Number")
                        {
                            var q1 = Query.From("Person")
                                .Select("UID_Person")
                                .Where(string.Format(
                                    @"PersonnelNumber = '{0}' 
                                      AND UID_Department IN 
                                          (SELECT UID_Department 
                                           FROM Department 
                                           WHERE UID_PersonHead = '{1}')",
                                    column.value, strUID_Person));

                            var tryGetPersonnelNumber = await qr.Session.Source()
                                .TryGetAsync(q1, EntityLoadType.DelayedLogic)
                                .ConfigureAwait(false);

                            if (tryGetPersonnelNumber.Success)
                            {
                                objects.Add(new
                                {
                                    column = column.column,
                                    errorMsg = "Identity with the same Personnel Number already exists."
                                });
                            }
                            else
                            {
                                objects.Add(new { column = column.column });
                            }
                        }
                        // No validation required → include column
                        else
                        {
                            objects.Add(new { column = column.column });
                        }
                    }

                    return objects.ToArray();
                })
            );
        }

        // Represents the posted payload
        public class PostedID
        {
            public columnsarray[] columns { get; set; }
        }

        // Represents each column entry
        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }
    }
}
