// Template: Bulk Action — action (Step 3 of 4, called per row)
// Performs the actual DB write/update/delete for one row.
// No return value.
// Replace: MyFeatureAction, webportalplus/myfeature/action

using QBM.CompositionApi.Definition;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi
{
    public class MyFeatureAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/myfeature/action")
                .Handle<PostedID>("POST", async (posted, qr, ct) =>
                {
                    var uidPerson = qr.Session.User().Uid;
                    string targetUid = string.Empty;

                    foreach (var col in posted.columns)
                    {
                        if (col.column == "UID_Person")
                            targetUid = col.value;
                    }

                    // --- Example: update an existing entity ---
                    var q = Query.From("Person")
                        .SelectAll()
                        .Where($"UID_Person = '{targetUid}'");

                    var tryGet = await qr.Session.Source()
                        .TryGetAsync(q, EntityLoadType.DelayedLogic, ct)
                        .ConfigureAwait(false);

                    if (!tryGet.Success)
                        throw new InvalidOperationException($"Person '{targetUid}' not found.");

                    var entity = tryGet.Result;
                    await entity.PutValueAsync("SomeColumn", "NewValue", ct).ConfigureAwait(false);

                    using var u = qr.Session.StartUnitOfWork();
                    await u.PutAsync(entity, ct).ConfigureAwait(false);
                    await u.CommitAsync(ct).ConfigureAwait(false);
                }));
        }

        public class PostedID
        {
            public string index { get; set; } = string.Empty;
            public ColumnValue[] columns { get; set; } = Array.Empty<ColumnValue>();
        }

        public class ColumnValue
        {
            public string column { get; set; } = string.Empty;
            public string value { get; set; } = string.Empty;
        }
    }
}
