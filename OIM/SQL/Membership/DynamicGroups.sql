-- Purpose : List all dynamic groups with their target table and WHERE clause
-- Tables  : DynamicGroup, DialogTable
-- Notes   : Safe read-only. WhereClause is the SQL condition used to compute
--           membership at runtime. In this environment all dynamic groups target Person.
--           13 dynamic groups in this environment.
-- Source  : live DB verified

SELECT
    dg.DisplayName,
    dt.TableName     AS TargetTable,
    dg.WhereClause,
    dg.IsRecalculationDeactivated,
    dg.XDateUpdated
FROM DynamicGroup dg
LEFT JOIN DialogTable dt ON dt.UID_DialogTable = dg.UID_DialogTableObjectClass
ORDER BY dg.DisplayName;
