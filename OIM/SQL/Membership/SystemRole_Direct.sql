-- Purpose : Direct system role (ESet) assignments per person — excludes inherited via Org/BaseTree
-- Tables  : PersonHasESet, ESet, Person
-- Notes   : Safe read-only. XOrigin: 1=direct, 2=inherited from Org/BaseTree, 4=dynamic.
--           PersonInBaseTree holds assignments inherited through hierarchical roles.
--           Filter XOrigin=1 to see only directly assigned system roles.
-- Source  : OIM 9.1 System Roles Administration Guide + live DB verified

-- System roles for a specific person (all origins)
SELECT
    p.CentralAccount,
    e.Ident_ESet       AS SystemRole,
    e.DisplayName      AS SystemRoleDisplay,
    phe.XOrigin,
    phe.XDateInserted
FROM PersonHasESet phe
JOIN Person p ON p.UID_Person = phe.UID_Person
JOIN ESet   e ON e.UID_ESet   = phe.UID_ESet
WHERE p.CentralAccount = '<account>'
ORDER BY e.Ident_ESet;

-- Top persons by count of direct (XOrigin=1) ESet assignments
SELECT
    p.CentralAccount,
    p.FirstName + ' ' + p.LastName AS FullName,
    COUNT(*) AS DirectESetCount
FROM PersonHasESet phe
JOIN Person p ON p.UID_Person = phe.UID_Person
WHERE phe.XOrigin = 1
GROUP BY p.UID_Person, p.CentralAccount, p.FirstName, p.LastName
ORDER BY DirectESetCount DESC;

-- All persons holding a specific system role
SELECT
    p.CentralAccount,
    p.FirstName + ' ' + p.LastName AS FullName,
    phe.XOrigin, phe.XDateInserted
FROM PersonHasESet phe
JOIN Person p ON p.UID_Person = phe.UID_Person
JOIN ESet   e ON e.UID_ESet   = phe.UID_ESet
WHERE e.Ident_ESet = '<eset_name>'
ORDER BY p.LastName;
