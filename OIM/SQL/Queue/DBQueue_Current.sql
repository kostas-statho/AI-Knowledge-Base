-- Purpose : DBQueue processor status with slot-number diagnostics
-- Tables  : QBMDBQueueCurrent, QBMDBQueueTask
-- Notes   : Safe read-only. SlotNumber: -1=sync running, -2=locked by process, -3=pending job.
-- Source  : KB 4310886 (support.oneidentity.com/kb/4310886) + live DB verified

SELECT
    c.UID_DialogDBQueue,
    t.ProcedureName  AS TaskName,
    c.UID_Parameter, c.UID_SubParameter,
    c.SlotNumber, c.StartedAt,
    CASE c.SlotNumber
        WHEN -1 THEN 'Sync running on target system'
        WHEN -2 THEN 'Locked by another process'
        WHEN -3 THEN 'Pending job in QBMElementAffectedByJob'
        ELSE 'Normal slot'
    END AS SlotDiagnosis
FROM QBMDBQueueCurrent c
LEFT JOIN QBMDBQueueTask t ON t.UID_Task = c.UID_Task
ORDER BY c.StartedAt;

-- Only problematic slots (negative SlotNumber)
SELECT c.*, t.ProcedureName AS TaskName
FROM QBMDBQueueCurrent c
LEFT JOIN QBMDBQueueTask t ON t.UID_Task = c.UID_Task
WHERE c.SlotNumber < 0;
