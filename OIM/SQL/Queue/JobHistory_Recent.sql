-- Purpose : Recent job execution history — error diagnostics
-- Tables  : JobHistory
-- Notes   : Safe read-only. 38,185 total rows; 113 with WasError=True (live DB 2026-03-30).
--           BasisObjectKey links to the OIM object that triggered the job.
-- Source  : live DB verified + support.oneidentity.com/kb/4376713

-- Recent failed jobs
SELECT TOP 50
    TaskName, JobChainName, Queue, WasError, ErrorMessages,
    StartAt, EndedAt, BasisObjectKey
FROM JobHistory
WHERE WasError = 1
ORDER BY StartAt DESC;

-- All history for a specific object (replace <ObjectKey>)
SELECT TOP 100
    TaskName, JobChainName, Queue, WasError, ErrorMessages, StartAt, EndedAt
FROM JobHistory
WHERE BasisObjectKey = '<ObjectKey>'
ORDER BY StartAt DESC;
