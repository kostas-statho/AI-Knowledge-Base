select * from AccProduct

select * from FirmPartner

select UID_FirmPartner, EntryDate, ExitDate,DefaultEmailAddress, CentralAccount,* from Person
where UID_Person = '87c0c840-1566-4138-aba4-919c5aec0dc4'

select XDateInserted, DisplayOrg,* from PersonWantsOrg
where DisplayOrg = 'Create_Employee_SCN1'
