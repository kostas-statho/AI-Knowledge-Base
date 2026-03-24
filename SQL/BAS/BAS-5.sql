
--Find out how the system role and the service item are related together in SQL
SELECT e.Ident_ESet, acp.Ident_AccProduct
FROM ESet e
JOIN AccProduct acp
	ON e.UID_AccProduct = acp.UID_AccProduct

--Find out what assign the item to a shelf means in SQL
SELECT ap.Ident_AccProduct AS 'Product', ito.Ident_Org AS 'Shelf', apg.Ident_AccProductGroup AS 'Category', e.Ident_ESet AS 'System Role', ito.FullPath 
FROM ITShopOrgHasESet ite
JOIN ESet e 
	ON ite.UID_ESet = e.UID_ESet
JOIN ITShopOrg ito
	ON ite.UID_ITShopOrg = ito.UID_ITShopOrg
JOIN AccProduct ap
	ON e.UID_AccProduct = ap.UID_AccProduct -- only products from ESet
JOIN AccProductGroup apg
	ON ap.UID_AccProductGroup = apg.UID_AccProductGroup