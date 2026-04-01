using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Debugging;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Typed;

namespace QBM.CompositionApi.Sdk01_Basics
{
    // Every class that implements the IApiProvider interface will be
    // picked up by the API builder, who will call the Build method.
    public class BasicQueryMethod : IApiProviderFor<ApiSamples>
    {
        public void Build(IApiBuilder builder)
        {
            // The new typed wrapper libraries contain classes for each table in a module.
            // Reference the correct <module>.TypedWrappers.dll for the module and use the type
            // directly to define an entity-based API method.
            builder.AddMethod(Method.Define("test")
                .From<AAD.TypedWrappers.AADGroup>()
                .EnableRead()
                // Use the column names directly as LINQ expressions.
                .WithResultColumns(x => x.DisplayName, x => x.MailNickName, x => x.UNSDisplay, x => x.Description)
            );
        }
    }
}
