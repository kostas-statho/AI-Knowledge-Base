-- Purpose : Accounts not linked to an OIM Person — orphan / leaver diagnostic
-- Tables  : ADSAccount, AADUser
-- Notes   : Safe read-only. UID_Person IS NULL = account has no OIM identity owner.
--           IsDisabled / AccountDisabled shows current enablement state.
-- Source  : OIM best practice + live DB verified

-- Orphaned AD accounts (no linked Person)
SELECT
    SAMAccountName, DisplayName, IsDisabled,
    XDateInserted, XDateUpdated
FROM ADSAccount
WHERE UID_Person IS NULL
ORDER BY XDateUpdated DESC;

-- Orphaned Azure AD accounts (no linked Person)
SELECT
    UserPrincipalName, DisplayName, AccountDisabled,
    XDateInserted, XDateUpdated
FROM AADUser
WHERE UID_Person IS NULL
ORDER BY XDateUpdated DESC;

-- Summary: orphaned vs linked count per account type
SELECT
    'ADSAccount' AS AccountType,
    SUM(CASE WHEN UID_Person IS NULL     THEN 1 ELSE 0 END) AS Orphaned,
    SUM(CASE WHEN UID_Person IS NOT NULL THEN 1 ELSE 0 END) AS Linked
FROM ADSAccount
UNION ALL
SELECT 'AADUser',
    SUM(CASE WHEN UID_Person IS NULL     THEN 1 ELSE 0 END),
    SUM(CASE WHEN UID_Person IS NOT NULL THEN 1 ELSE 0 END)
FROM AADUser;
