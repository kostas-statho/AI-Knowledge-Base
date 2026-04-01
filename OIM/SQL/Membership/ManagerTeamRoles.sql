-- Purpose  : All roles assigned to a manager's direct reports — App, System, and Business roles
-- Tables   : PersonInAERole, AERole, PersonHasESet, ESet, PersonInOrg, Org, HelperHeadPerson, Person
-- Category : Membership
-- Status   : Verified
-- OIM-Ver  : 9.3
-- Added    : 2026-03-30
-- Notes    : Replace @manager with the UID_Person of the manager.
--            XOrigin: 1=Direct, 2=Indirect, 3=Both(Direct+Indirect), 4=Dynamic.
--            Results filtered to CCC-prefixed roles (IsAutoAssignToPerson filter removed).
--            Useful for access reviews, manager attestation prep, or audit reports.

DECLARE @manager VARCHAR(50) = '<uid_manager>';  -- ← replace with actual UID_Person

-- Application roles under this manager's team
SELECT
    pe.InternalName                                                    AS Employee,
    ph.InternalName                                                    AS Manager,
    STRING_AGG(ae.Ident_AERole, ', ')                                 AS RoleName,
    'Application Role'                                                 AS RoleType,
    CASE pae.XOrigin
        WHEN 1 THEN 'Direct'
        WHEN 2 THEN 'Indirect'
        WHEN 3 THEN 'Direct+Indirect'
        WHEN 4 THEN 'Dynamic'
    END                                                                AS AssignmentType
FROM PersonInAERole pae
JOIN AERole  ae ON ae.UID_AERole  = pae.UID_AERole
JOIN Person  pe ON pe.UID_Person  = pae.UID_Person
JOIN Person  ph ON ph.UID_Person  = pe.UID_PersonHead
WHERE pae.UID_Person IN (
    SELECT UID_Person FROM HelperHeadPerson WHERE UID_PersonHead = @manager
)
GROUP BY pe.InternalName, ph.InternalName, pae.XOrigin

UNION ALL

-- System roles under this manager's team
SELECT
    pe.InternalName,
    ph.InternalName,
    STRING_AGG(e.Ident_ESet, ', '),
    'System Role',
    CASE phe.XOrigin
        WHEN 1 THEN 'Direct'
        WHEN 2 THEN 'Indirect'
        WHEN 3 THEN 'Direct+Indirect'
        WHEN 4 THEN 'Dynamic'
    END
FROM PersonHasESet phe
JOIN ESet   e  ON e.UID_ESet    = phe.UID_ESet
JOIN Person pe ON pe.UID_Person = phe.UID_Person
JOIN Person ph ON ph.UID_Person = pe.UID_PersonHead
WHERE phe.UID_Person IN (
    SELECT UID_Person FROM HelperHeadPerson WHERE UID_PersonHead = @manager
)
GROUP BY pe.InternalName, ph.InternalName, phe.XOrigin

UNION ALL

-- Business roles under this manager's team
SELECT
    pe.InternalName,
    ph.InternalName,
    STRING_AGG(o.Ident_Org, ', '),
    'Business Role',
    CASE pio.XOrigin
        WHEN 1 THEN 'Direct'
        WHEN 2 THEN 'Indirect'
        WHEN 3 THEN 'Direct+Indirect'
        WHEN 4 THEN 'Dynamic'
    END
FROM PersonInOrg pio
JOIN Org    o  ON o.UID_Org     = pio.UID_Org
JOIN Person pe ON pe.UID_Person = pio.UID_Person
JOIN Person ph ON ph.UID_Person = pe.UID_PersonHead
WHERE pio.UID_Person IN (
    SELECT UID_Person FROM HelperHeadPerson WHERE UID_PersonHead = @manager
)
GROUP BY pe.InternalName, ph.InternalName, pio.XOrigin

ORDER BY Employee, RoleType;
