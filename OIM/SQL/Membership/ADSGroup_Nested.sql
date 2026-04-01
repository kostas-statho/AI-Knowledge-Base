-- Purpose : Nested AD group hierarchy (parent group contains child groups)
-- Tables  : ADSGroupInADSGroup, ADSGroup
-- Notes   : Safe read-only. Replace <group_cn> with the parent group name.
--           Recursive CTE limited to 10 levels to prevent infinite loops.
--           11 nesting relationships in this environment.
-- Source  : live DB verified

-- Direct children of a group
SELECT
    gp.cn  AS ParentGroup,
    gc.cn  AS ChildGroup,
    agg.XDateInserted
FROM ADSGroupInADSGroup agg
JOIN ADSGroup gp ON gp.UID_ADSGroup = agg.UID_ADSGroupParent
JOIN ADSGroup gc ON gc.UID_ADSGroup = agg.UID_ADSGroupChild
WHERE gp.cn = '<group_cn>'
ORDER BY gc.cn;

-- Full nested hierarchy (recursive) for a parent group
WITH GroupTree AS (
    SELECT gp.UID_ADSGroup AS ParentUID, gp.cn AS ParentCN,
           gc.UID_ADSGroup AS ChildUID,  gc.cn AS ChildCN, 1 AS Level
    FROM ADSGroupInADSGroup agg
    JOIN ADSGroup gp ON gp.UID_ADSGroup = agg.UID_ADSGroupParent
    JOIN ADSGroup gc ON gc.UID_ADSGroup = agg.UID_ADSGroupChild
    WHERE gp.cn = '<group_cn>'
    UNION ALL
    SELECT gt.ParentUID, gt.ParentCN,
           gc2.UID_ADSGroup, gc2.cn, gt.Level + 1
    FROM GroupTree gt
    JOIN ADSGroupInADSGroup agg2 ON agg2.UID_ADSGroupParent = gt.ChildUID
    JOIN ADSGroup gc2 ON gc2.UID_ADSGroup = agg2.UID_ADSGroupChild
    WHERE gt.Level < 10
)
SELECT * FROM GroupTree ORDER BY Level, ChildCN;
