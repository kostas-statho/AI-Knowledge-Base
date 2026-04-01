-- Purpose : Business role (Org) → System role (ESet) mappings
-- Tables  : BaseTreeHasESet, BaseTree, ESet, AccProduct
-- Notes   : Safe read-only. Shows which business roles grant which system roles
--           and their linked service items. 55 mappings in this environment.
--           ESet.UID_AccProduct is a direct FK — no AccProductInESet junction exists.
-- Source  : live DB verified

SELECT
    bt.Ident_Org        AS BusinessRole,
    e.Ident_ESet        AS SystemRole,
    e.DisplayName       AS SystemRoleDisplay,
    ap.Ident_AccProduct AS ServiceItem,
    bhe.XOrigin,
    bhe.XDateInserted
FROM BaseTreeHasESet bhe
JOIN BaseTree    bt ON bt.UID_Org      = bhe.UID_Org
JOIN ESet        e  ON e.UID_ESet      = bhe.UID_ESet
LEFT JOIN AccProduct ap ON ap.UID_AccProduct = e.UID_AccProduct
ORDER BY bt.Ident_Org, e.Ident_ESet;
