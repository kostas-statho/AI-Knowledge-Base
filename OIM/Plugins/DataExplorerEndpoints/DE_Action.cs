using QBM.CompositionApi.Definition;
using QER.CompositionApi.QueueQuery;
using VI.DB;
using VI.DB.Entities;

namespace QBM.CompositionApi
{
    public class CCCApproveAttestationAction : IApiProviderFor<QER.CompositionApi.Portal.PortalApiProject>
    {
        public void Build(IApiBuilder builder)
        {
            builder.AddMethod(
                Method.Define("webportalplus/approveattestation/action")
                .Handle<PostedID>("POST", async (posted, qr, ct) =>
                {
                    string uidPerson = qr.Session.User().Uid;
                    string xkey = null;
                    string xsubkey = null;
                    string decisionType = null;
                    string delegatedFrom = null;
                    string reason = null;

                    // -----------------------------------------
                    // Extract popup parameter (columns[])
                    // -----------------------------------------
                    foreach (var col in posted.columns)
                    {
                        if (col.column == "Reason for approval")
                            reason = col.value?.ToString();
                    }

                    // --------------------------
                    // EXTRACT Elements (xKey, xSubKey, custom keys)
                    // --------------------------
                    foreach (var column in posted.element)
                    {
                        if (column.column == "xKey")
                            xkey = column.value;

                        if (column.column == "xSubKey")
                            xsubkey = column.value;

                        if (column.column == "xPersonKey")
                            xkey = column.value;

                        if (column.column == "xCaseKey")
                            xsubkey = column.value;

                        if (column.column == "#LDS#Decision Type")
                            decisionType = column.value;

                        if (column.column == "#LDS#Delegated from")
                            delegatedFrom = column.value;
                    }

                    // --------------------------
                    // ensure user is eligible approver
                    // --------------------------
                    string wc = string.Format(
                        "XObjectKey = '{0}' AND UID_AttestationCase IN (" +
                        "SELECT UID_AttestationCase FROM ATT_VAttestationDecisionPerson " +
                        "WHERE UID_PersonHead = '{1}')",
                        xsubkey,
                        uidPerson
                    );

                    bool isEligible = await qr.Session
                        .Source()
                        .ExistsAsync("AttestationCase", wc, ct)
                        .ConfigureAwait(false);

                    if (!isEligible)
                        throw new InvalidOperationException("You are not the eligible approver for this attestation case.");


                    // --------------------------
                    // LOAD ATTESTATION CASE
                    // --------------------------
                    var query = Query
                        .From("AttestationCase")
                        .SelectAll()
                        .Where($"XObjectKey = '{xsubkey}'");

                    var tryget = await qr.Session
                        .Source()
                        .TryGetAsync(query, EntityLoadType.DelayedLogic, ct)
                        .ConfigureAwait(false);

                    IEntity attestationCase = tryget.Result;


                    // --------------------------
                    // EXECUTE MakeDecision
                    // --------------------------
                    await attestationCase.CallMethodAsync("MakeDecision", new object[]
                    {
                        uidPerson,   // approver UID
                        true,        // Decision = approve
                        reason,      // Reason from pop-up
                        null,        // UidJustification
                        -1           // SubLevel
                    }, ct).ConfigureAwait(false);

                    // --------------------------
                    // SAVE CHANGES
                    // --------------------------
                    await attestationCase.SaveAsync(qr.Session, ct).ConfigureAwait(false);

                    // --------------------------
                    // ATTESTATION HISTORY
                    // Determine policy type and generate history record
                    // --------------------------
                    string type = string.Empty;
                    string policyUid = attestationCase.GetValue("UID_AttestationPolicy");
                    var yearlyUid = await qr.Session.Config().GetConfigParmAsync("Custom\\DataExplorerAttestations\\Yearly", ct).ConfigureAwait(false);
                    var moverUid = await qr.Session.Config().GetConfigParmAsync("Custom\\DataExplorerAttestations\\Mover", ct).ConfigureAwait(false);
                    var externalUid = await qr.Session.Config().GetConfigParmAsync("Custom\\DataExplorerAttestations\\External", ct).ConfigureAwait(false);
                    var guestUid = await qr.Session.Config().GetConfigParmAsync("Custom\\DataExplorerAttestations\\Guest", ct).ConfigureAwait(false);

                    if (string.Equals(policyUid, yearlyUid) || string.Equals(policyUid, moverUid))
                        type = "approveAll";
                    if (string.Equals(policyUid, externalUid) || string.Equals(policyUid, guestUid))
                        type = "approveExternalOrGuest";

                    var htParameter = new Dictionary<string, object>
                    {
                        { "approverUid", uidPerson },
                        { "type", type },
                        { "decisionType", decisionType },
                        { "delegatedFrom", delegatedFrom }
                    };

                    using (var u = qr.Session.StartUnitOfWork())
                    {
                        await u.GenerateAsync(attestationCase, "CCC_AttestationHistoryDE", htParameter, ct).ConfigureAwait(false);
                        await u.CommitAsync(ct).ConfigureAwait(false);
                    }
                })
            );
        }


        // --------------------------
        // Helpers
        // --------------------------
        public class PostedID
        {
            public columnsarray[] element { get; set; }
            public columnsarray[] columns { get; set; }
        }

        public class columnsarray
        {
            public string column { get; set; }
            public string value { get; set; }
        }
    }
}
