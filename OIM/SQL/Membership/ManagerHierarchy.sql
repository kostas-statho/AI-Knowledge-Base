-- Purpose : Direct reports under a manager / manager chain upward for an identity
-- Tables  : HelperHeadPerson, Person
-- Notes   : Safe read-only. XOrigin > 0 = delegated/inherited. Safety cap: 10 levels.
-- Source  : community.oneidentity.com/forum/32588 + live DB verified

-- Direct reports under a manager (replace <uid_manager> with UID_Person of manager)
SELECT p.CentralAccount, p.FirstName + ' ' + p.LastName AS FullName,
       p.IsExternal, hhp.XOrigin
FROM HelperHeadPerson hhp
JOIN Person p ON p.UID_Person = hhp.UID_Person
WHERE hhp.UID_PersonHead = '<uid_manager>' AND hhp.XOrigin > 0
ORDER BY p.LastName;

-- Full manager chain upward from a given account
WITH MgrChain AS (
    SELECT p.UID_Person, p.CentralAccount,
           p.FirstName + ' ' + p.LastName AS FullName,
           p.IsExternal, p.UID_PersonHead, 0 AS Level
    FROM Person p WHERE p.CentralAccount = '<account>'
    UNION ALL
    SELECT mgr.UID_Person, mgr.CentralAccount,
           mgr.FirstName + ' ' + mgr.LastName,
           mgr.IsExternal, mgr.UID_PersonHead, mc.Level + 1
    FROM Person mgr JOIN MgrChain mc ON mc.UID_PersonHead = mgr.UID_Person
    WHERE mc.Level < 10
)
SELECT * FROM MgrChain ORDER BY Level;
