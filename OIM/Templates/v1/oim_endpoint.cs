// Template: OIM CompositionAPI Single Endpoint
// Replace: MyFeatureAction, webportalplus/myfeature/action
// Rules:
//   - ConfigureAwait(false) on every await
//   - $"..." for strings with \n, not string.Format
//   - IApiProviderFor<PortalApiProject> + IApiProvider on every endpoint class

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
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    var uidPerson = qr.Session.User().Uid;

                    // --- DB READ ---
                    // var q = Query.From("TableName")
                    //     .Select("Column1", "Column2")
                    //     .Where($"SomeColumn = '{posted.uid}'");
                    // var tryGet = await qr.Session.Source()
                    //     .TryGetAsync(q, EntityLoadType.DelayedLogic, ct)
                    //     .ConfigureAwait(false);
                    // if (!tryGet.Success) throw new InvalidOperationException("Not found.");
                    // var entity = tryGet.Result;

                    // --- CONFIG READ ---
                    // var configVal = await qr.Session.Config()
                    //     .GetConfigParmAsync("Custom\\MyPlugin\\Setting", ct)
                    //     .ConfigureAwait(false);

                    // --- DB WRITE ---
                    // using var u = qr.Session.StartUnitOfWork();
                    // await u.PutAsync(entity, ct).ConfigureAwait(false);
                    // await u.CommitAsync(ct).ConfigureAwait(false);

                    // --- DB CREATE ---
                    // var newEntity = await qr.Session.Source().CreateNewAsync(
                    //     "TableName",
                    //     new EntityParameters { CreationType = EntityCreationType.DelayedLogic },
                    //     ct).ConfigureAwait(false);
                    // await newEntity.PutValueAsync("Column", value, ct).ConfigureAwait(false);
                    // using var u = qr.Session.StartUnitOfWork();
                    // await u.PutAsync(newEntity, ct).ConfigureAwait(false);
                    // await u.CommitAsync(ct).ConfigureAwait(false);

                    return new { message = "OK" };
                }));
        }

        public class PostedID
        {
            public string uid { get; set; } = string.Empty;
            // Add properties matching the JSON the web portal POSTs
        }
    }
}
