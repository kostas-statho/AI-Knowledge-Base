declare @manager varchar(50) = 'a8f8fbf6-d039-4067-abf1-69b178b795b5'

Select pe.InternalName as 'Employee', ph.InternalName as 'Manager',STRING_AGG(ae.Ident_AERole, ',') as 'Role Name','Application Role' as 'Type of Role', 
	CASE when pae.xorigin = 1 then 'Direct' when pae.xorigin = 2 then 'InDirect' when pae.xorigin = 3 then 'Both' when pae.xorigin = 4 then 'Dynamic' end as 'Assignment Type'
From PersonInAERole pae
Join AERole ae on ae.UID_AERole = pae.UID_AERole 
join Person pe on pae.UID_Person = pe.UID_Person
join Person ph on pe.UID_PersonHead = ph.UID_Person
Where pae.UID_Person in (
	Select UID_Person
	From HelperHeadPerson
	Where UID_PersonHead = @manager

) and ae.XUserInserted like 'viadmin'
Group by pe.InternalName, ph.InternalName, pae.xorigin
--AND (
--    (@type = 'direct' AND pae.XOrigin = 1) OR
--    (@type = 'indirect' AND pae.XOrigin IN (2, 3, 4))
--)

union all

Select pe.InternalName as 'Employee', ph.InternalName as 'Manager', STRING_AGG(e.Ident_ESet, ',') as 'Role Name', 'System Role' as 'Type of Role', CASE when phe.xorigin = 1 then 'Direct' when phe.xorigin = 2 then 'InDirect' when phe.xorigin = 3 then 'Both' when phe.xorigin = 4 then 'Dynamic' end as 'Assignment Type'
From PersonHasESet phe
Join ESet e on e.UID_ESet = phe.UID_ESet 
join Person pe on phe.UID_Person = pe.UID_Person
join Person ph on pe.UID_PersonHead = ph.UID_Person
Where phe.UID_Person in (
	Select UID_Person
	From HelperHeadPerson
	Where UID_PersonHead = @manager
)
Group by pe.InternalName, ph.InternalName, phe.xorigin

union all

Select pe.InternalName as 'Employee', ph.InternalName as 'Manager', STRING_AGG(o.Ident_Org, ',') as 'Role Name', 'Business Role' as 'Type of Role', CASE when pio.xorigin = 1 then 'Direct' when pio.xorigin = 2 then 'InDirect' when pio.xorigin = 3 then 'Both' when pio.xorigin = 4 then 'Dynamic' end as 'Assignment Type'
From PersonInOrg pio
Join Org o on o.UID_Org = pio.UID_Org 
join Person pe on pio.UID_Person = pe.UID_Person
join Person ph on pe.UID_PersonHead = ph.UID_Person
Where pio.UID_Person in (
	Select UID_Person
	From HelperHeadPerson
	Where UID_PersonHead = @manager
)
Group by pe.InternalName, ph.InternalName, pio.xorigin 