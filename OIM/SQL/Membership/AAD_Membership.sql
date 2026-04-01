-- Purpose : Azure AD group memberships for a user, with Person link
-- Tables  : AADUser, AADUserInGroup, AADGroup, Person
-- Notes   : Safe read-only. AADUser.UID_Person links back to OIM Person.
--           XOrigin: 1=direct, 2=inherited. HasReadOnlyMemberships on group = OIM-managed.
-- Source  : support.oneidentity.com/kb/4369746 + live DB verified

-- AAD group memberships for a user
SELECT
    au.UserPrincipalName,
    au.DisplayName     AS AADUserName,
    ag.DisplayName     AS AADGroupName,
    ag.IsSecurityEnabled, ag.IsMailEnabled,
    aig.XOrigin, aig.XDateInserted
FROM AADUserInGroup aig
JOIN AADUser  au ON au.UID_AADUser  = aig.UID_AADUser
JOIN AADGroup ag ON ag.UID_AADGroup = aig.UID_AADGroup
WHERE au.UserPrincipalName = '<upn>'
ORDER BY ag.DisplayName;

-- AAD user ↔ OIM Person link (by CentralAccount)
SELECT p.CentralAccount, p.FirstName + ' ' + p.LastName AS FullName,
       au.UserPrincipalName, au.AccountDisabled, au.OnPremisesSyncEnabled
FROM AADUser au
JOIN Person p ON p.UID_Person = au.UID_Person
WHERE p.CentralAccount = '<account>';
