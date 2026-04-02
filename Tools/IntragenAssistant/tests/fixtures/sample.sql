-- Sample OIM query: list persons in IT-related organisations
-- Used by: Person Assistant automated backend tests
SELECT p.XObjectKey, p.FirstName, p.LastName,
       o.UID_Org, o.OrgName
FROM   Person p
INNER JOIN PersonInOrg pio ON pio.UID_Person = p.UID_Person
INNER JOIN Org         o   ON o.UID_Org      = pio.UID_Org
WHERE  p.IsExternal = 0
  AND  o.OrgName LIKE '%IT%'
ORDER  BY p.LastName
