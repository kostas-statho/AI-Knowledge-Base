-- Purpose : IT Shop request approval/rejection history
-- Tables  : PWODecisionHistory, PersonWantsOrg, Person
-- Notes   : Safe read-only. Live DecisionType: Grant(373), Order(274), Unsubscribe(82),
--           Cancel(52), Dismiss(44), Abort(41), Escalate(1).
-- Source  : live DB verified (867 rows)

-- Approval history for a specific request
SELECT
    pdh.DecisionType, pdh.DisplayPersonHead AS Approver,
    pdh.ReasonHead, pdh.DateHead, pdh.OrderState,
    pdh.IsDecisionBySystem, pdh.XDateInserted
FROM PWODecisionHistory pdh
WHERE pdh.UID_PersonWantsOrg = '<uid_personwantsorg>'
ORDER BY pdh.DateHead;

-- Recent decisions for a person's requests
SELECT TOP 100
    pwo.DisplayOrg AS Product, pdh.DecisionType,
    pdh.DisplayPersonHead AS Approver, pdh.ReasonHead, pdh.DateHead
FROM PWODecisionHistory pdh
JOIN PersonWantsOrg pwo ON pwo.UID_PersonWantsOrg = pdh.UID_PersonWantsOrg
JOIN Person p           ON p.UID_Person = pwo.UID_PersonOrdered
WHERE p.CentralAccount  = '<account>'
  AND pdh.DecisionType IN ('Grant', 'Dismiss', 'Abort')
ORDER BY pdh.DateHead DESC;
