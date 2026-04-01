-- Purpose : Filter pending/stuck JobQueue entries by queue name
-- Tables  : JobQueue
-- Notes   : Safe read-only. Replace <QueueName> (e.g. \StathopoulosK).
--           WARNING: Do NOT directly UPDATE JobQueue — blocked by QBM_TUJobQueue trigger.
-- Source  : community.oneidentity.com/forum/30594 + live DB verified

SELECT TOP 200
    UID_Job, TaskName, JobChainName, Queue, Ready2EXE,
    WasError, ErrorMessages, Retries, XDateInserted
FROM JobQueue
WHERE Queue      LIKE '%<QueueName>%'
  AND Ready2EXE <> 'FINISHED'
ORDER BY XDateInserted DESC;
