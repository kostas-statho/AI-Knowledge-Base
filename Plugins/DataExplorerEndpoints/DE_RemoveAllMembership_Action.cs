using VI.DB.Entities;
using QBM.CompositionApi.Definition;
using VI.DB.DataAccess;
using VI.DB.Sync;
using VI.DB;

namespace QBM.CompositionApi
{
    public class CCCRemoveAllMoverBRMembershipsAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/bulkremovebusinessroles/action")
                .Handle<PostedID>("POST", async (posted, qr, ct) =>
                {
                    string xkey = string.Empty;
                    string xsubkey = string.Empty;
                    var strUID_Person = qr.Session.User().Uid;
                    string xprimarykey = string.Empty;
                    string xprimarykey2 = string.Empty;
                    foreach (var column in posted.columns)
                    {
                        if (column.column == "xKey")
                        {
                            xkey = column.value;
                        }
                        if (column.column == "xSubKey")
                        {
                            xsubkey = column.value;
                        }
                        if (column.column == "xPrimaryKey")
                        {
                            xprimarykey = column.value;
                        }
                        if (column.column == "xPrimaryKey2")
                        {
                            xprimarykey2 = column.value;
                        }
                    }

                    string wc = String.Format("XObjectKey = '{0}' and UID_AttestationCase in (select UID_AttestationCase from ATT_VAttestationDecisionPerson where uid_personhead = '{1}')", xsubkey, strUID_Person);
                    bool ex = await qr.Session.Source().ExistsAsync("AttestationCase", wc, ct).ConfigureAwait(false);
                    if (!ex)
                    {
                        throw new InvalidOperationException("You are not the eligible approver for this attestation case.");
                    }
                    var assignmentkeys = new List<string>();
                    var runner = qr.Session.Resolve<IStatementRunner>();
                    using (var reader = await runner.SqlExecuteAsync("CCC_DE_MoverAttestationSubBusinessRole", new[]
                    { QueryParameter.Create("xprimarykey", xprimarykey) }, ct))
                    {
                        while (reader.Read())
                        {
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                var columnname = reader.GetName(i);
                                if (columnname == "XObjectKey")
                                {
                                    var fieldvalue = reader.IsDBNull(i) ? string.Empty : reader.GetValue(i).ToString();
                                    assignmentkeys.Add(fieldvalue);
                                }
                            }
                        }
                    }

                    foreach (var key in assignmentkeys)
                    {
                        var riskindex = string.Empty;
                        var q0 = Query.From("Org").Where(string.Format("UID_Org in (select UID_Org from PersonInOrg where XObjectKey = '{0}')", key)).SelectAll();
                        var tryGet0 = await qr.Session.Source().TryGetAsync(q0, EntityLoadType.DelayedLogic).ConfigureAwait(false);
                        var affectedright = tryGet0.Result.GetValue("Ident_Org");
                        
                        // Handle Direct Assigned
                        var q1 = Query.From("PersonInOrg").Where(string.Format("XObjectKey = '{0}' and ((XOrigin & 1) = 1)", key)).SelectAll();
                        var tryGet1 = await qr.Session.Source().TryGetAsync(q1, EntityLoadType.DelayedLogic).ConfigureAwait(false);
                        if (tryGet1.Success)
                        {
                            using (var u = qr.Session.StartUnitOfWork())
                            {
                                var objecttodelete = tryGet1.Result;
                                objecttodelete.MarkForDeletion();
                                await u.PutAsync(objecttodelete, ct).ConfigureAwait(false);
                                await u.CommitAsync(ct).ConfigureAwait(false);
                            }
                        }
                        // Handle Requested 
                        var q2 = Query.From("PersonInOrg").Where(string.Format("XObjectKey = '{0}' and ((XOrigin & 8) = 8)", key)).SelectAll();
                        var tryGet2 = await qr.Session.Source().TryGetAsync(q2, EntityLoadType.DelayedLogic).ConfigureAwait(false);
                        if (tryGet2.Success)
                        {
                            var q3 = Query.From("PersonWantsOrg").Where(string.Format("ObjectKeyAssignment = '{0}' and OrderState = 'Assigned'", key)).OrderBy("XDateInserted desc").SelectAll();
                            var tryget3 = await qr.Session.Source().TryGetAsync(q3, EntityLoadType.DelayedLogic, ct).ConfigureAwait(false);
                            if (tryget3.Success)
                            {
                                await tryget3.Result.CallMethodAsync("Unsubscribe", ct).ConfigureAwait(false);
                                await tryget3.Result.SaveAsync(qr.Session, ct).ConfigureAwait(continueOnCapturedContext: false);
                            }
                        }
                    }
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