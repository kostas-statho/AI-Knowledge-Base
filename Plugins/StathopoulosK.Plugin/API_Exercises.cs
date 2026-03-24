using Microsoft.Extensions.Logging;
using NLog;
using QBM.CompositionApi;
using QBM.CompositionApi.ApiManager;
using QBM.CompositionApi.Crud;
using QBM.CompositionApi.Definition;
using QBM.CompositionApi.Dto;
using QBM.CompositionApi.Handling;
using QBM.CompositionApi.PlugIns;
using System;
using System.Linq;
using System.Security.Cryptography;
using System.Threading;
using System.Threading.Tasks;
using System.Xml.Linq;
using VI.Base;
using VI.Base.Logging;
using VI.DB;
using VI.DB.Entities;
using VI.DB.Sync;

namespace QBM.CompositionApi
{
    // =====================================================================
    // EXERCISE 1: Basic connectivity test
    // =====================================================================
    public class ApiExercise1 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("ApiExercise1")
                .AllowUnauthenticated()
                .HandleGet(qr => new
                {
                    Message = "Hello world! API connection working successfully.",
                    Timestamp = DateTime.UtcNow
                }));
        }
    }

    // =====================================================================
    // EXERCISE 2: Basic POST echo test
    // =====================================================================
    public class ApiExercise2 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(Method.Define("ApiExercise2")
                .AllowUnauthenticated()
                .Handle<PostedMessage2, object>("POST", (posted, qr) =>
                {
                    if (posted == null || string.IsNullOrWhiteSpace(posted.Input))
                        return new { Message = "Hello world! (no input provided)" };

                    return new { Message = $"Hello world! You said: {posted.Input}" };
                }));
        }

        public class PostedMessage2
        {
            public string Input { get; set; }
        }
    }

    // =====================================================================
    // EXERCISE 3: Secure / logical test POST
    // =====================================================================
    public class ApiExercise3 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            var logger = LogManager.GetCurrentClassLogger();

            builder.AddMethod(Method.Define("ApiExercise3")
                .Handle<PostedMessage3, object>("POST", async (posted, qr, ct) =>
                {
                    try
                    {
                        if (posted == null || string.IsNullOrWhiteSpace(posted.Input))
                            throw new Exception("Input is required.");

                        // Basic logic simulation (for example, validation)
                        if (posted.Input.Contains("admin", StringComparison.OrdinalIgnoreCase))
                            throw new Exception("Access denied: input contains restricted keyword.");

                        //await Task.Delay(100, ct); // simulate async operation

                        return new
                        {
                            Message = $"Secure Hello world! Authorized input received: {posted.Input}",
                            ServerTime = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss")
                        };
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[ApiExercise3] Exception occurred");
                        return new { Status = "Error", Message = ex.Message };
                    }
                }));
        }

        public class PostedMessage3
        {
            public string Input { get; set; }
        }
    }

    // =====================================================================
    // EXERCISE 4: AADGroup CRUD Operations
    // =====================================================================
    public class ApiExercise4 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            var logger = LogManager.GetCurrentClassLogger();
            // ---------- Get By UID ------
            builder.AddMethod(Method.Define("ApiExercise4")
                .FromTable("AADGroup")
                .EnableRead()
                .WithWhereClause(qr =>
                {
                    var uid = qr.Parameters.Get<string>("UID_AADGroup");
                    return qr.Session.SqlFormatter().UidComparison("UID_AADGroup", uid);
                })
                .WithResultColumns("UID_AADGroup", "DisplayName", "MailNickName", "XDateInserted", "XUserInserted")
            );

            // ---------- INSERT ----------
            builder.AddMethod(Method.Define("ApiExercise4/InsertAADGroup")
                .Handle<PostedInsertAAD, object>("POST", async (posted, qr, ct) =>
                {
                    try
                    {
                        var UID_AADOrganization = "f8307421-7e4e-4a04-bd84-38eda866bb5a";

                        //Get displayNamea and validate isNot empty
                        if (string.IsNullOrWhiteSpace(posted.DisplayName))
                            throw new Exception("DisplayName is required.");
                        else if (!posted.DisplayName.StartsWith("AAD", StringComparison.OrdinalIgnoreCase))
                            throw new Exception("Invalid DisplayName. Must start with 'AAD'.");
                        var displayName = posted.DisplayName;
                        
                        //If AADGroup already exists skip
                        var queryAADGroup = Query.From("AADGroup")
                                .Select("DisplayName")
                                .Where($"DisplayName = '{displayName}'");
                        var resultAADGroup = await qr.Session.Source()
                                .TryGetAsync(queryAADGroup, EntityLoadType.DelayedLogic, ct)
                                .ConfigureAwait(false);
                        if (resultAADGroup.Result != null)
                            throw new Exception($"AADGroup '{displayName}' ALREADY EXISTS.");

                        //Get MailNickName and validate isNot empty
                        if (string.IsNullOrWhiteSpace(posted.MailNickName))
                            throw new Exception("MailNickName is required.");
                        var MailNickName = posted.MailNickName;

                        using (var u = qr.Session.StartUnitOfWork())
                            {
                                var entity = await qr.Session.Source().CreateNewAsync("AADGroup");
                                await entity.PutValueAsync("UID_AADOrganization", UID_AADOrganization);
                                await entity.PutValueAsync("DisplayName", displayName);
                                await entity.PutValueAsync("MailNickName", MailNickName);
                                await u.PutAsync(entity);
                                await u.CommitAsync();
                            }

                        return new
                        {
                            Status = "Success",
                            Message = $"AADGroup '{displayName}' created successfully."
                        };
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[InsertAADGroup] Exception occurred");
                        return new { Status = "Error", Message = ex.Message };
                    }
                }));

            // ---------- UPDATE ----------
            builder.AddMethod(Method.Define("ApiExercise4/UpdateAADGroup")
                .Handle<PostedUpdateID, object>("POST", async (posted, qr, ct) =>
                {
                    try
                    {
                        var UpdatedFields = "";
                        // Validate UID_AADGroup is provided
                        if (string.IsNullOrWhiteSpace(posted.UID_AADGroup))
                            throw new Exception("UID_AADGroup must be provided.");
                        var uid = posted.UID_AADGroup;

                        // Validate UID_AADGroup matches AADGroup
                        var query = Query.From("AADGroup").Select("*").Where($"UID_AADGroup = '{uid}'");
                        var tryget = await qr.Session.Source().TryGetAsync(query, EntityLoadType.Default);
                        if (!tryget.Success || tryget.Result == null)
                            throw new Exception($"No AADGroup found with UID_AADGroup = {uid}");
                        var entity = tryget.Result;

                        // Get & Validate DisplayName 
                        string displayName = posted.DisplayName;
                        if (!string.IsNullOrWhiteSpace(displayName))
                        {
                            if (!displayName.StartsWith("AAD", StringComparison.OrdinalIgnoreCase))
                                throw new Exception("Invalid DisplayName. Must start with 'AAD'.");
                            await entity.PutValueAsync("DisplayName", displayName);
                            UpdatedFields += "DisplayName, ";
                        }

                        // Get & Validate MailNickName 
                        string mailNickName = posted.MailNickName;
                        if (!string.IsNullOrWhiteSpace(mailNickName))
                        {
                            await entity.PutValueAsync("MailNickName", mailNickName);
                            UpdatedFields += "MailNickName";
                        }

                        // Update 
                        using (var u = qr.Session.StartUnitOfWork())
                        {
                            await u.PutAsync(entity);
                            await u.CommitAsync();
                        }

                        return new
                        {
                            Status = "Success",
                            Message = $"AADGroup {uid} updated successfully.",
                            Updated_Fields = UpdatedFields
                        };
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[UpdateAADGroup] Exception occurred");
                        return new { Status = "Error", Message = ex.Message };
                    }
                }));

            // ---------- DELETE ----------
            builder.AddMethod(Method.Define("ApiExercise4/DeleteAADGroup")
                .Handle<PostedDeleteID, object>("POST", async (posted, qr, ct) =>
                {
                    string xObjectKey = null;
                    string uid = null;
                    try
                    {
                        // Validate UID_AADGroup is provided
                        if (string.IsNullOrWhiteSpace(posted.UID_AADGroup))
                            throw new Exception("UID_AADGroup must be provided.");
                        uid = posted.UID_AADGroup;

                        // Validate UID_AADGroup matches AADGroup
                        var query = Query.From("AADGroup").Select("*").Where($"UID_AADGroup = '{uid}'");
                        var tryget = await qr.Session.Source().TryGetAsync(query, EntityLoadType.Default);
                        if (!tryget.Success || tryget.Result == null)
                            throw new Exception($"No AADGroup found with UID_AADGroup = {uid}");
                        var entity = tryget.Result;

                        // Delete
                        using (var u = qr.Session.StartUnitOfWork())
                        {
                            entity.MarkForDeletion();
                            await u.PutAsync(entity);
                            await u.CommitAsync();
                        }

                        return new { UID_AADGroup = uid, Result = "Successful" };
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[DeleteAADGroup] Exception occurred");
                        //Reutn UID_AADGroup or N/A if it doesnt exist
                        return new { UID_AADGroup = uid ?? "N/A", Result = $"Failed with error: {ex.Message}" };
                    }
                }));
        }
        public class PostedUpdateID
        {
            public string UID_AADGroup { get; set; }
            public string DisplayName { get; set; }
            public string MailNickName { get; set; }
        }
        public class PostedInsertAAD
        {
            public string DisplayName { get; set; }
            public string MailNickName { get; set; }
        }
        public class PostedDeleteID
        {
            public string UID_AADGroup { get; set; }
        }
    }

    // =====================================================================
    // EXERCISE 5: GET (Filtered list of AADGroups & Membership Insert)
    // =====================================================================
    public class ApiExercise5 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            var logger = NLog.LogManager.GetCurrentClassLogger();
            // ---------- Get By Filters ------
            builder.AddMethod(Method.Define("ApiExercise5")
                .FromTable("AADGroup")
                .WithDescription("Returns a filtered list of Azure Active Directory groups.")
                .EnableRead()
                .With(m =>
                {
                    // Enable the datamodel API for client-visible filters
                    m.EnableDataModelApi = true;

                    // Register our static filters
                    m.OptionalClauseProviders.Add(new AADGroupFilter());
                })
                // Return useful columns only
                .WithResultColumns("UID_AADGroup", "DisplayName", "Description", "MailNickName", "XDateInserted")
            );
            // ---------- Create AAD Membership ------
            builder.AddMethod(Method.Define("ApiExercise5/CreatePWO")
                .Handle<PostedID, object>("POST", async (posted, qr, ct) =>
                {
                    try
                    {
                        string username = "";
                        string UIDOrg = "";

                        // Logged-in user UID (the one creating the request)
                        var loggedinuser = qr.Session.User().Uid;

                        // Parse JSON columns
                        foreach (var column in posted.columns)
                        {
                            if (column.column == "username")
                            {
                                username = column.value;
                                logger.Info("username parsed");
                            }

                            if (column.column == "UID_Org")
                            {
                                UIDOrg = column.value;
                                logger.Info("UID_Org parsed");
                            }
                        }

                        // Basic validation
                        if (string.IsNullOrEmpty(username))
                            throw new ArgumentException("username is required.");

                        if (string.IsNullOrEmpty(UIDOrg))
                            throw new ArgumentException("UID_Org is required.");

                        // Retrieve UID_Person for given AAD user
                        var queryAADUser = Query.From("AADUser")
                                .Select("UID_Person")
                                .Where($"UserPrincipalName = '{username}'");

                        var resultAADUser = await qr.Session.Source()
                                .TryGetAsync(queryAADUser, EntityLoadType.DelayedLogic, ct)
                                .ConfigureAwait(false);

                        if (!resultAADUser.Success || resultAADUser.Result == null)
                            throw new Exception($"No AADUser found with username '{username}'.");

                        var UIDPersonOrdered = await resultAADUser.Result
                                .GetValueAsync<string>("UID_Person")
                                .ConfigureAwait(false);

                        // Retrieve UID_ITShopOrg for given AAD group
                        var ProductUID = "";

                        var queryProduct = Query.From("ITShopOrg")
                                .Select("UID_ITShopOrg")
                                .Where($"Ident_Org = '{UIDOrg}'");

                        var resultProduct = await qr.Session.Source()
                                .TryGetAsync(queryProduct, EntityLoadType.DelayedLogic, ct)
                                .ConfigureAwait(false);

                        if (!resultProduct.Success || resultProduct.Result == null)
                            throw new Exception($"No Product found for AADGroup '{UIDOrg}'.");
                        else
                        {
                            ProductUID = await resultProduct.Result.GetValueAsync<string>("UID_ITShopOrg").ConfigureAwait(false);
                        }

                        // Create new PersonWantsOrg (ITShop Request)
                        var newRequest = await qr.Session.Source().CreateNewAsync("PersonWantsOrg",
                                new EntityParameters
                                {
                                    CreationType = EntityCreationType.DelayedLogic
                                }, ct).ConfigureAwait(false);

                        //await newRequest.PutValueAsync("UID_Org", UIDOrg, ct).ConfigureAwait(false);
                        await newRequest.PutValueAsync("UID_Org", ProductUID, ct).ConfigureAwait(false);
                        await newRequest.PutValueAsync("UID_PersonOrdered", UIDPersonOrdered, ct).ConfigureAwait(false);
                        await newRequest.PutValueAsync("UID_PersonInserted", loggedinuser, ct).ConfigureAwait(false);

                        // Commit within Unit of Work
                        using (var u = qr.Session.StartUnitOfWork())
                        {
                            await u.PutAsync(newRequest, ct).ConfigureAwait(false);
                            await u.CommitAsync(ct).ConfigureAwait(false);
                        }

                        var UID_PersonWantsOrg = await newRequest
                                .GetValueAsync<string>("UID_PersonWantsOrg", ct)
                                .ConfigureAwait(false);

                        return new
                        {
                            Status = "Success",
                            Message = "ITShop request (PersonWantsOrg) created successfully for AADUser " + username + " on AADGroup " + UIDOrg,
                            UID_PersonWantsOrg = UID_PersonWantsOrg,
                            UID_PersonInserted = loggedinuser,
                            UID_PersonOrdered = UIDPersonOrdered,
                            UID_Org = ProductUID

                        };
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "Insert Membership Exception occurred");
                        return new { Result = $"Failed with error: {ex.Message}" };
                    }
                }));
            
        }
        public class AADGroupFilter : IPredefinedFilter
        {
            public string UrlParameterName => "aadfilter";
            public string Description => "Filters AADGroups by UID, Description, or DisplayName pattern.";

            // This label is shown in the datamodel metadata (UI, swagger, etc.)
            public MultiLanguageStringData Title { get; } =
                MultiLanguageStringData.FromWebTranslations("Filter type");

            // Define available filter options and their corresponding SQL clauses
            public IDictionary<string, IPredefinedFilterOption> Options { get; } =
                new Dictionary<string, IPredefinedFilterOption>
                {
            {
                "UID_AADGroup", new PredefinedFilterOption
                {
                    DisplayName = MultiLanguageStringData.FromWebTranslations("By UID_AADGroup"),
                    ClauseProvider = new ClauseProvider("UID_AADGroup = '11b60f05-e992-4338-b417-c77fca6bcedc'")
                }
            },
            {
                "Description", new PredefinedFilterOption
                {
                    DisplayName = MultiLanguageStringData.FromWebTranslations("By Description = 'Filtered'"),
                    ClauseProvider = new ClauseProvider("Description = 'Filtered'")
                }
            },
            {
                "XDateInserted", new PredefinedFilterOption
                {
                    DisplayName = MultiLanguageStringData.FromWebTranslations("By XDateInserted older than 1 day"),
                    ClauseProvider = new ClauseProvider("XDateInserted < DATEADD(DAY, -1, GETDATE())")
                }
            }
                };
        }
        public class PostedITShopRequest
        {
            public string UID_Person { get; set; }
            public string UID_Org { get; set; }
            public string Reason { get; set; }
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

    // =====================================================================
    // EXERCISE 6: GET Membership's Request State
    // =====================================================================
    public class ApiExercise6 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            var logger = NLog.LogManager.GetCurrentClassLogger();
            // ---------- Get Membership Order Status ------
            builder.AddMethod(Method.Define("ApiExercise6")
                .HandleGet(async (qr, ct) =>
                {
                    try
                    {
                        string AADGroupName = qr.Parameters.Get<string>("AADGroupName");

                        // ---- Find AADGroup by DisplayName ----
                        var queryGroup = Query.From("AADGroup")
                            .Select("xObjectKey")
                            .Where($"DisplayName = '{AADGroupName}'");

                        var groupResult = await qr.Session.Source()
                            .TryGetAsync(queryGroup, EntityLoadType.DelayedLogic, ct)
                            .ConfigureAwait(false);

                        if (!groupResult.Success || groupResult.Result == null)
                            throw new Exception($"No Group found with DisplayName '{AADGroupName}'");

                        var ObjectKey = await groupResult.Result
                            .GetValueAsync<string>("xObjectKey")
                            .ConfigureAwait(false);

                        // ---- Get PersonWantsOrg collection ----
                        var queryPwo = Query.From("PersonWantsOrg")
                            .Select(
                                "UID_PersonWantsOrg",
                                "DisplayOrg",
                                "DisplayPersonInserted",
                                "DisplayPersonOrdered",
                                "OrderState",
                                "XDateInserted",
                                "DateActivated",
                                "DateDeactivated"
                            )
                            .Where($"ObjectKeyOrdered = '{ObjectKey}'");

                        // Use GetCollectionAsync to get all PWO rows
                        var pwoCollection = await qr.Session.Source()
                            .GetCollectionAsync(queryPwo, EntityCollectionLoadType.Default, ct)
                            .ConfigureAwait(false);

                        if (pwoCollection == null || !pwoCollection.Any())
                            throw new Exception($"No PersonWantsOrg records found for group '{AADGroupName}'");

                        var records = new List<object>();
                        foreach (var entity in pwoCollection)
                        {
                            var pwo = new
                            {
                                UID_PersonWantsOrg = await entity.GetValueAsync<string>("UID_PersonWantsOrg").ConfigureAwait(false),
                                AADGroup = await entity.GetValueAsync<string>("DisplayOrg").ConfigureAwait(false),
                                UserRequested = await entity.GetValueAsync<string>("DisplayPersonInserted").ConfigureAwait(false),
                                UserGranted = await entity.GetValueAsync<string>("DisplayPersonOrdered").ConfigureAwait(false),
                                OrderState = await entity.GetValueAsync<string>("OrderState").ConfigureAwait(false),
                                DateRequested = (await entity.GetValueAsync<object>("XDateInserted")) as DateTime?,
                                DateActivated = (await entity.GetValueAsync<object>("DateActivated")) as DateTime?,
                                DateDeactivated = (await entity.GetValueAsync<object>("DateDeactivated")) as DateTime?
                            };

                            records.Add(pwo);
                        }

                        // Return all results
                        return await Task.FromResult<object>(new
                        {
                            Status = "Success",
                            AADGroupName,
                            Count = records.Count,
                            Requests = records
                        });
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[ApiExercise5/OrderState] Exception occurred");
                        return await Task.FromResult<object>(new
                        {
                            Status = "Error",
                            Message = $"Failed with error: {ex.Message}"
                        });
                    }
                }
            ));
        }

    }
    // =====================================================================
    // EXERCISE 7: GET ALL FIELDS FOR AADGroup 
    // =====================================================================
    public class ApiExercise7 : IApiProviderFor<CCC_StathopoulosK>
    {
        public void Build(IApiBuilder builder)
        {
            var logger = NLog.LogManager.GetCurrentClassLogger();
            builder.AddMethod(Method.Define("ApiExercise7")
                .HandleGet(async (qr, ct) =>
                {
                    try
                    {
                        string UID_AADGroup = qr.Parameters.Get<string>("UID_AADGroup");
                        if (string.IsNullOrWhiteSpace(UID_AADGroup))
                            throw new Exception("Parameter UID_AADGroup is required.");

                        // ---- Query AADGroup ----
                        var queryAADGroup = Query.From("AADGroup")
                            .Select("*")
                            .Where($"UID_AADGroup = '{UID_AADGroup}'");

                        var result = await qr.Session.Source()
                            .TryGetAsync(queryAADGroup, EntityLoadType.DelayedLogic, ct)
                            .ConfigureAwait(false);

                        if (!result.Success || result.Result == null)
                            throw new Exception($"No AADGroup found with UID_AADGroup = {UID_AADGroup}");

                        var entity = result.Result;
                        var output = new Dictionary<string, object>();

                        // ---- Enumerate each column ----
                        foreach (var column in entity.Columns)
                        {
                            try
                            {
                                // Only return readable fields
                                if (column.CanSee)
                                {
                                    string columnName = column.Columnname; // ✅ correct property
                                    var value = await entity.GetValueAsync<object>(columnName, ct)
                                        .ConfigureAwait(false);
                                    output[columnName] = value;
                                }
                            }
                            catch (Exception innerEx)
                            {
                                logger.Warn(innerEx, $"Failed to read column {column.Columnname}");
                                output[$"Error_{column.Columnname}"] = innerEx.Message;
                            }
                        }

                        // Return a proper object
                        return await Task.FromResult<object>(new
                        {
                            Status = "Success",
                            Result = output
                        });
                    }
                    catch (Exception ex)
                    {
                        logger.Error(ex, "[ApiExercise7] Exception occurred");
                        return await Task.FromResult<object>(new
                        {
                            Status = "Error",
                            Message = $"Failed with error: {ex.Message}"
                        });
                    }
                }));

        }

    }
}
