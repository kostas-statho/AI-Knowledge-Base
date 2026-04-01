-- Purpose : Employees not linked to an ADSAccount — sync gap diagnostic
-- Tables  : Person, ADSAccount
-- Notes   : Safe read-only. Identifies persons OIM has not provisioned an AD account for.
-- Source  : KB 4322074 (support.oneidentity.com/identity-manager/kb/4322074)

SELECT FirstName, LastName, CentralAccount, XDateInserted
FROM Person
WHERE NOT EXISTS (
    SELECT 1 FROM ADSAccount WHERE ADSAccount.UID_Person = Person.UID_Person
)
ORDER BY LastName;
