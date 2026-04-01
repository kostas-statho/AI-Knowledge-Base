-- Purpose  : Search and browse OIM configuration parameters (DialogConfigParm)
-- Tables   : DialogConfigParm
-- Category : Sampling
-- Status   : Verified
-- OIM-Ver  : 9.3
-- Added    : 2026-03-30
-- Notes    : DialogConfigParm stores all OIM system configuration values.
--            FullPath uses backslash hierarchy e.g. 'QBM\General\MaxRetries'.
--            Value is nvarchar — cast if needed. IsCrypted=1 means value is encrypted.
--            IsEnabledResulting = effective state (includes parent enable/disable).

-- Search by path fragment
SELECT
    FullPath,
    DisplayName,
    Value,
    Enabled,
    IsEnabledResulting,
    IsCrypted,
    Description,
    XDateUpdated
FROM DialogConfigParm
WHERE FullPath LIKE '%<search_term>%'   -- ← e.g. '%Mail%', '%AAD%', '%Timeout%'
ORDER BY FullPath;

-- Browse top-level config categories
SELECT DISTINCT
    LEFT(FullPath, CHARINDEX('\', FullPath + '\') - 1) AS TopCategory,
    COUNT(*) AS ParameterCount
FROM DialogConfigParm
GROUP BY LEFT(FullPath, CHARINDEX('\', FullPath + '\') - 1)
ORDER BY TopCategory;

-- All enabled parameters with non-default (non-NULL) values
SELECT
    FullPath, Value, IsEnabledResulting, XDateUpdated
FROM DialogConfigParm
WHERE Value IS NOT NULL
  AND IsEnabledResulting = 1
ORDER BY XDateUpdated DESC;
