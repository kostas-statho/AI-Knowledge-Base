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
using System.Xml.Linq;
using System.Reflection.Metadata.Ecma335;

namespace QBM.CompositionApi
{
    public class InsertIdentitiesAction :
        IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/InsertIdentities/action")
            .Handle<PostedID>("POST", async (posted, qr, ct) =>
            {
                // Variables to hold column data
                string firstname = "";
                string lastname = "";
                string email = "";
                string remarks = "";
                string jobdescription = "";
                string department = "";
                string personnelnumber = "";
                string ImportSource = "IMPORT";

                var uidperson = qr.Session.User().Uid;

                // Loop through each column in the posted data
                foreach (var column in posted.columns)
                {
                    // Assigning values based on column names
                    if (column.column == "Remarks")
                    {
                        remarks = column.value;
                    }
                    if (column.column == "Job Description")
                    {
                        jobdescription = column.value;
                    }
                    if (column.column == "First Name")
                    {
                        firstname = column.value;
                    }
                    if (column.column == "Last Name")
                    {
                        lastname = column.value;
                    }
                    if (column.column == "E-mail")
                    {
                        email = column.value;
                    }
                    if (column.column == "Personnel Number")
                    {
                        personnelnumber = column.value;
                    }
                }

                var q1 = Query.From("Department")
                    .Select("UID_Department")
                    .Where(string.Format("UID_PersonHead = '{0}'", uidperson));

                var tryGetDepartment = await qr.Session.Source()
                    .TryGetAsync(q1, EntityLoadType.DelayedLogic)
                    .ConfigureAwait(false);

                if (tryGetDepartment.Success)
                {
                    department = tryGetDepartment.Result.GetValue<string>("UID_Department");
                }

                var newID = await qr.Session.Source().CreateNewAsync(
                    "Person",
                    new EntityParameters
                    {
                        CreationType = EntityCreationType.DelayedLogic
                    },
                    ct).ConfigureAwait(false);

                await newID.PutValueAsync("FirstName", firstname, ct).ConfigureAwait(false);
                await newID.PutValueAsync("LastName", lastname, ct).ConfigureAwait(false);
                await newID.PutValueAsync("UID_Department", department, ct).ConfigureAwait(false);
                await newID.PutValueAsync("Remarks", remarks, ct).ConfigureAwait(false);
                await newID.PutValueAsync("PersonalTitle", jobdescription, ct).ConfigureAwait(false);
                await newID.PutValueAsync("ContactEmail", email, ct).ConfigureAwait(false);
                await newID.PutValueAsync("PersonnelNumber", personnelnumber, ct).ConfigureAwait(false);
                await newID.PutValueAsync("ImportSource", ImportSource, ct).ConfigureAwait(false);

                using (var u = qr.Session.StartUnitOfWork())
                {
                    await u.PutAsync(newID, ct).ConfigureAwait(false);
                    await u.CommitAsync(ct).ConfigureAwait(false);
                }
            }));
        }

        public class PostedID
        {
            public string index { get; set; }
            public columnsarray[] columns { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }
    }
}
