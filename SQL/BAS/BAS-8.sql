SELECT p.InternalName, p.IsInActive, p.IsTemporaryDeactivated, aa.CanonicalName  FROM Person p
JOIN ADSAccount aa
	ON aa.UID_Person = p.UID_Person	
WHERE p.IsInActive LIKE '0' AND p.IsTemporaryDeactivated LIKE '0'


    
SELECT DISTINCT
	hho.UID_PersonHead as uid_person, dbo.QER_FGIPWORulerOrigin(hho.XObjectkey) as UID_PWORulerOrigin, pe.InternalName, pe.IsInActive, pe.IsTemporaryDeactivated
FROM personwantsorg pwo
	JOIN person pe 
		on pwo.uid_personordered = pe.uid_person
	JOIN ADSAccount aa
		ON aa.UID_Person = pe.UID_Person
	JOIN helperHeadperson hho 
		on hho.uid_person = pe.uid_Person and hho.XOrigin > 0	
--where pwo.uid_personwantsorg = @uid_personwantsorg


    
select distinct
	hho.UID_PersonHead as uid_person, dbo.QER_FGIPWORulerOrigin(hho.XObjectkey) as UID_PWORulerOrigin

from personwantsorg pwo 
			join person pe 
				on pwo.uid_personordered = pe.uid_person
			join helperHeadperson hho 
				on hho.uid_person = pe.uid_Person
					and hho.XOrigin > 0
			join ADSAccount aa 
				on aa.UID_Person = hho.UID_PersonHead
where pwo.uid_personwantsorg = @uid_personwantsorg