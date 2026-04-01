-- Purpose : Row counts across all key OIM tables
-- Tables  : sys.tables, sys.partitions
-- Notes   : Safe read-only. Edit the IN list as needed.
-- Source  : Standard sys.partitions pattern

SELECT t.name AS TableName, SUM(p.rows) AS TotalRows
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)
  AND t.name IN (
    'Person','ADSAccount','ADSGroup','ADSGroupInADSGroup',
    'PersonInOrg','PersonInAERole','PersonHasESet','PersonInBaseTree',
    'JobQueue','JobHistory','QBMJobqueueOverview',
    'AttestationCase','AttestationRun','AttestationHistory','AttestationPolicy',
    'ESet','AccProduct','PersonWantsOrg','PWODecisionHistory',
    'Org','AERole','BaseTree','BaseTreeHasESet',
    'AADUser','AADGroup','AADUserInGroup',
    'DynamicGroup','DPRProjectionConfig','DPRJournal','QERRiskIndex',
    'NonCompliance','PersonInNonCompliance','QERPolicy'
  )
GROUP BY t.name
ORDER BY TotalRows DESC;
