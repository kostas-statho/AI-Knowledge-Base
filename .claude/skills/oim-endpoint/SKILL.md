---
name: oim-endpoint
description: Generate a new OIM CompositionAPI IApiProvider endpoint class. Use when adding a single new REST endpoint to an existing OIM plugin project.
argument-hint: "<ClassName> <route/path> [GET|POST|DELETE]"
user-invocable: true
allowed-tools: "Read, Write, Glob"
---

Generate a new OIM CompositionAPI endpoint class using the following rules:

## What to produce

A single `.cs` file in `namespace QBM.CompositionApi` implementing both `IApiProvider` and `IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>`.

## Template to follow

```csharp
using QBM.CompositionApi.Definition;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi
{
    public class {ClassName} : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>, IApiProvider
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("webportalplus/{route}")
                .Handle<PostedID, object>("{METHOD}", async (posted, qr, ct) =>
                {
                    var uidPerson = qr.Session.User().Uid;

                    // TODO: implement logic here
                    // DB read:  var q = Query.From("Table").Select("Col").Where($"...");
                    //           var result = await qr.Session.Source().TryGetAsync(q, EntityLoadType.DelayedLogic, ct).ConfigureAwait(false);
                    // DB write: using var u = qr.Session.StartUnitOfWork();
                    //           await u.PutAsync(entity, ct).ConfigureAwait(false);
                    //           await u.CommitAsync(ct).ConfigureAwait(false);
                    // Config:   var val = await qr.Session.Config().GetConfigParmAsync("Custom\\Path\\...", ct).ConfigureAwait(false);

                    return new { message = "OK" };
                }));
        }

        public class PostedID
        {
            // Define properties matching the JSON body the web portal sends
            public string uid { get; set; } = string.Empty;
        }
    }
}
```

## Rules

1. **ConfigureAwait(false)** on every await — no exceptions
2. **$"..."** interpolation for strings with `\n`, never `string.Format` for those
3. Namespace is always `QBM.CompositionApi`
4. Route always starts with `webportalplus/`
5. Use `string.Empty` not `null` for string defaults
6. For DELETE endpoints: `.Handle<PostedID>("{DELETE}", ...)` — no return type
7. For GET endpoints: no PostedID class needed, use `.Handle<object>()`
8. Only add using statements that are actually needed

## Output

Write the file to the appropriate plugin directory (ask if unsure which plugin it belongs to). Suggest adding it to the plugin's entry point via `svc.FindAttributeBasedApiProviders<PluginEntryClass>()` — no manual wiring needed.

State the full file path and confirm the endpoint URL: `POST webportalplus/{route}`.
