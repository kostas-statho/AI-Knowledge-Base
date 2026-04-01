-- Purpose : Active and pending IT Shop requests for an identity
-- Tables  : PersonWantsOrg, Person
-- Notes   : Safe read-only. Live OrderState: Unsubscribed(156), Aborted(92),
--           Assigned(14), Dismissed(10), Waiting(2).
--           Doc also: New, OrderProduct, Granted, Canceled, OrderProlongate.
-- Source  : OIM 9.1.1 IT Shop Guide + live DB verified (274 rows)

-- Active assignments for a person
SELECT
    pwo.UID_PersonWantsOrg, pwo.DisplayOrg AS Product,
    pwo.OrderState, pwo.ValidFrom, pwo.ValidUntil, pwo.XDateInserted
FROM PersonWantsOrg pwo
JOIN Person p ON p.UID_Person = pwo.UID_PersonOrdered
WHERE p.CentralAccount = '<account>' AND pwo.OrderState = 'Assigned'
ORDER BY pwo.XDateInserted DESC;

-- All request states distribution
SELECT OrderState, COUNT(*) AS Cnt FROM PersonWantsOrg
GROUP BY OrderState ORDER BY Cnt DESC;

-- Requests stuck in Waiting
SELECT TOP 50
    pwo.DisplayPersonOrdered, pwo.DisplayOrg, pwo.OrderState, pwo.XDateInserted
FROM PersonWantsOrg pwo
WHERE pwo.OrderState = 'Waiting'
ORDER BY pwo.XDateInserted;
