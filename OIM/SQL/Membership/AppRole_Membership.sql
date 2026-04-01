-- Purpose : Application role (AERole) memberships for an identity
-- Tables  : PersonInAERole, AERole, Person
-- Notes   : Safe read-only. XOrigin: 1=direct, 2=inherited, 4=dynamic.
-- Source  : community.oneidentity.com/forum/30985 + live DB verified

-- All app role memberships for a person
SELECT
    p.CentralAccount,
    ae.Ident_AERole  AS AppRoleName,
    ae.UID_AERole,
    iar.XOrigin, iar.XDateInserted
FROM PersonInAERole iar
JOIN Person p  ON p.UID_Person  = iar.UID_Person
JOIN AERole ae ON ae.UID_AERole = iar.UID_AERole
WHERE p.CentralAccount = '<account>'
ORDER BY ae.Ident_AERole;

-- Check if a person is a member of a specific AERole (1=yes, 0=no)
SELECT CASE WHEN EXISTS (
    SELECT 1 FROM PersonInAERole
    WHERE UID_Person = '<uid_person>' AND UID_AERole = '<uid_aerole>'
) THEN 1 ELSE 0 END AS IsMember;
