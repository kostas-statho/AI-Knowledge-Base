-- Purpose : Attestation decision history — who approved/denied/aborted each case
-- Tables  : AttestationHistory, AttestationCase
-- Notes   : Safe read-only. DecisionType values: Create, Grant, Dismiss, Abort, Escalate.
--           Live counts: Create(1038), Abort(637), Dismiss(205), Grant(117), Escalate(1).
-- Source  : live DB verified (1,998 rows)

-- All decisions for a specific case
SELECT
    ah.DecisionType, ah.DisplayPersonHead AS Decider,
    ah.ReasonHead, ah.DateHead, ah.IsDecisionBySystem, ah.XDateInserted
FROM AttestationHistory ah
WHERE ah.UID_AttestationCase = '<uid_attestationcase>'
ORDER BY ah.DateHead;

-- Recent Grant and Dismiss decisions across all cases
SELECT TOP 100
    ac.DisplayName, ah.DecisionType,
    ah.DisplayPersonHead AS Decider, ah.ReasonHead, ah.DateHead
FROM AttestationHistory ah
JOIN AttestationCase ac ON ac.UID_AttestationCase = ah.UID_AttestationCase
WHERE ah.DecisionType IN ('Grant', 'Dismiss')
ORDER BY ah.DateHead DESC;
