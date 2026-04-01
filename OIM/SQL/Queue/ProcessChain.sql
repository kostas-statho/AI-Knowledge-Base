-- Purpose  : OIM process chain monitoring — track active jobs and execution history by chain name
-- Tables   : JobQueue, JobHistory, JobChain
-- Category : Queue
-- Status   : Verified
-- OIM-Ver  : 9.3
-- Added    : 2026-03-30
-- Notes    : JobChainName in JobQueue/JobHistory links to JobChain.Name.
--            'Created by QBMDBQueueProcess' = system-internal DB queue tasks (not custom chains).
--            Common custom chains: CCC_*, Create_Employee, Publish_BR_to_ITShop, Process_6.
--            Ready2EXE: TRUE=pending, FINISHED=done, OVERLIMIT=retry exceeded.

-- Active (pending) jobs for a specific process chain
SELECT TOP 50
    UID_Job, TaskName, JobChainName,
    Queue, Ready2EXE, WasError,
    ErrorMessages, Retries, XDateInserted
FROM JobQueue
WHERE JobChainName = '<chain_name>'   -- ← e.g. 'Create_Employee'
  AND Ready2EXE  <> 'FINISHED'
ORDER BY XDateInserted;

-- Recent execution history for a process chain (last 200 runs)
SELECT TOP 200
    TaskName, JobChainName, Queue,
    WasError, ErrorMessages,
    StartAt, EndedAt, BasisObjectKey
FROM JobHistory
WHERE JobChainName = '<chain_name>'
ORDER BY StartAt DESC;

-- All process chains with execution counts (last 30 days)
SELECT
    JobChainName,
    COUNT(*)                                          AS TotalRuns,
    SUM(CASE WHEN WasError = 1 THEN 1 ELSE 0 END)    AS ErrorRuns,
    MAX(StartAt)                                      AS LastRun
FROM JobHistory
WHERE StartAt > DATEADD(DAY, -30, GETDATE())
  AND JobChainName NOT LIKE 'Created by%'            -- exclude internal DB queue tasks
GROUP BY JobChainName
ORDER BY TotalRuns DESC;

-- All registered process chains (Designer-defined)
SELECT
    Name              AS ChainName,
    ProcessDisplay,
    LimitationCount,
    XDateUpdated
FROM JobChain
ORDER BY XDateUpdated DESC;
