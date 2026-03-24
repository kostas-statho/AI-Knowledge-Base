select p.FirstName as firstname, p.LastName as lastname ,a.cn as ADacc, aag.XDateInserted  
from ADSAccount a
join Person p on a.UID_Person = p.UID_Person
join ADSAccountInADSGroup aag on a.UID_ADSAccount = aag.UID_ADSAccount
join ADSGroup ag on aag.UID_ADSGroup = ag.UID_ADSGroup