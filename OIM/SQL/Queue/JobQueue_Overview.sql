-- Purpose : Per-queue job count summary — first stop for health check
-- Tables  : QBMJobqueueOverview
-- Notes   : Safe read-only. CountTrue=pending, CountFalse=blocked, CountFrozen=frozen,
--           CountOverlimt=over retry, CountFinished=done.
-- Source  : One Identity Process Monitoring Guide + live DB verified

SELECT
    QueueName,
    CountTrue        AS Pending,
    CountProcessing  AS Processing,
    CountFalse       AS Blocked,
    CountFrozen      AS Frozen,
    CountOverlimt    AS OverLimit,
    CountFinished    AS Finished,
    IsInvalid,
    IsInitQueueRunning
FROM QBMJobqueueOverview
ORDER BY QueueName;
