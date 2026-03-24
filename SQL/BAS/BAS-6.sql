--Find out how the business role and the service item are related together in SQL
SELECT ap.Ident_AccProduct AS 'Product', qa.Ident_QERAssign AS 'Assignment Resource', o.Ident_Org as 'Business Role' 
FROM QERAssign qa
JOIN Org o 
	ON qa.ObjectKeyAssignTarget = o.XObjectKey
JOIN AccProduct ap
	ON qa.UID_AccProduct = ap.UID_AccProduct

--Find out what assign the item to a shelf means in SQL
SELECT ap.Ident_AccProduct AS 'Product', ito.Ident_Org AS 'Shelf', apg.Ident_AccProductGroup AS 'Category', qa.Ident_QERAssign AS 'Assignment Resource', o.Ident_Org as 'Business Role'
FROM ITShopOrgHasQERAssign itq
JOIN QERAssign qa
	ON itq.UID_QERAssign = qa.UID_QERAssign
JOIN ITShopOrg ito
	ON itq.UID_ITShopOrg = ito.UID_ITShopOrg
JOIN Org o 
	ON qa.ObjectKeyAssignTarget = o.XObjectKey
JOIN AccProduct ap
	ON qa.UID_AccProduct = ap.UID_AccProduct
JOIN AccProductGroup apg
	ON ap.UID_AccProductGroup = apg.UID_AccProductGroup
	
