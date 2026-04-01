-- Purpose  : AD group memberships per person — shows which AD groups an identity belongs to
-- Tables   : Person, ADSAccount, ADSAccountInADSGroup, ADSGroup
-- Category : Membership
-- Status   : Verified
-- OIM-Ver  : 9.3
-- Added    : 2026-03-30

SELECT TOP 200
    p.FirstName    AS FirstName,
    p.LastName     AS LastName,
    a.cn           AS ADAccount,
    ag.cn          AS ADGroup,
    ag.DistinguishedName,
    aag.XOrigin,
    aag.XDateInserted
FROM ADSAccount a
JOIN Person              p   ON p.UID_Person    = a.UID_Person
JOIN ADSAccountInADSGroup aag ON aag.UID_ADSAccount = a.UID_ADSAccount
JOIN ADSGroup            ag  ON ag.UID_ADSGroup  = aag.UID_ADSGroup
ORDER BY p.LastName, ag.cn;