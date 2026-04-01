-- Purpose : Pending and stuck individual jobs in the OIM job queue
-- Tables  : JobQueue
-- Notes   : Safe read-only. PK=UID_Job. Ready2EXE: TRUE/FALSE/OVERLIMIT/FINISHED.
--           WARNING: Do NOT directly UPDATE JobQueue — blocked by QBM_TUJobQueue trigger.
--           To reassign jobs use QBM_PTriggerDisable / QBM_PTriggerEnable (dev/test only).
-- Source  : One Identity Process Monitoring Guide + live DB verified

-- All non-finished jobs
SELECT TOP 100
    UID_Job, TaskName, JobChainName, Queue, Ready2EXE,
    WasError, ErrorMessages, Retries, XDateInserted
FROM JobQueue
WHERE Ready2EXE <> 'FINISHED'
ORDER BY XDateInserted;

-- Job count by status
SELECT Ready2EXE AS Status, COUNT(*) AS JobCount
FROM JobQueue
GROUP BY Ready2EXE
ORDER BY JobCount DESC;
