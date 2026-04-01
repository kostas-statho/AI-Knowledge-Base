-- Purpose : Business role (Org) memberships for an identity, with linked AD group
-- Tables  : PersonInOrg, Org, OrgHasADSGroup, ADSGroup, Person
-- Notes   : Safe read-only. OrgHasADSGroup has 0 rows in this env — LEFT JOIN is safe.
--           XOrigin: 1=direct, 2=inherited, 4=dynamic.
-- Source  : community.oneidentity.com/forum/30985 + live DB verified

SELECT
    p.CentralAccount,
    p.FirstName + ' ' + p.LastName  AS FullName,
    o.Ident_Org                     AS BusinessRoleName,
    ag.cn                           AS LinkedADGroup,
    pio.XOrigin, pio.XDateInserted
FROM PersonInOrg pio
JOIN  Person          p   ON p.UID_Person        = pio.UID_Person
JOIN  Org             o   ON o.UID_Org           = pio.UID_Org
LEFT JOIN OrgHasADSGroup  oha ON oha.UID_Org     = o.UID_Org
LEFT JOIN ADSGroup        ag  ON ag.UID_ADSGroup = oha.UID_ADSGroup
WHERE p.CentralAccount = '<account>'
ORDER BY o.Ident_Org;
