using VI.DB;
using VI.DB.Entities;
using QBM.CompositionApi.Definition;

namespace QBM.CompositionApi
{
    public class CCCUpdateMainDataAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/updatemaindata/action")
                .Handle<PostedID>("POST", async (posted, qr, ct) =>
                {
                    var department = "";
                    var manager = "";
                    var remarks = "";
                    var entrydate = "";
                    var autolevel = "";
                    var description = "";
                    var objectkey = "";
                    var exitdate = "";
                    var external = "";

                    foreach (var column in posted.element)
                    {
                        if (column.column == "xKey")
                            objectkey = column.value.ToString();
                    }

                    var query1 = Query.From("Person").SelectAll().Where(String.Format("XObjectKey = '{0}'", objectkey));
                    var tryget = await qr.Session.Source().TryGetAsync(query1, EntityLoadType.DelayedLogic, ct).ConfigureAwait(false);

                    if (tryget.Success)
                    {
                        foreach (var column in posted.columns)
                        {
                            if (column.column == "Remarks")
                            {
                                remarks = column.value.ToString();
                                await tryget.Result.PutValueAsync("Remarks", remarks, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Automation Level")
                            {
                                autolevel = column.value.ToString();
                                await tryget.Result.PutValueAsync("CustomProperty02", autolevel, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Manager")
                            {
                                manager = column.value.ToString();
                                await tryget.Result.PutValueAsync("UID_PersonHead", manager, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Department")
                            {
                                department = column.value.ToString();
                                await tryget.Result.PutValueAsync("UID_Department", department, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Is external")
                            {
                                external = column.value.ToString();
                                await tryget.Result.PutValueAsync("IsExternal", external, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Exit Date")
                            {
                                exitdate = column.value.ToString();
                                await tryget.Result.PutValueAsync("ExitDate", exitdate, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Update entry date")
                            {
                                entrydate = column.value.ToString();
                                await tryget.Result.PutValueAsync("EntryDate", entrydate, ct).ConfigureAwait(false);
                            }
                            if (column.column == "Description")
                            {
                                description = column.value.ToString();
                                await tryget.Result.PutValueAsync("Description", description, ct).ConfigureAwait(false);
                            }
                        }

                        using (var u = qr.Session.StartUnitOfWork())
                        {
                            await u.PutAsync(tryget.Result, ct).ConfigureAwait(false);
                            await u.CommitAsync(ct).ConfigureAwait(false);
                        }
                    }
                }));
        }

        public class PostedID
        {
            public string index { get; set; }
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
