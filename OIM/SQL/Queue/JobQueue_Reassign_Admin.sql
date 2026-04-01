-- Purpose  : Reassign pending JobQueue tasks to a specific queue (admin/dev use only)
-- Tables   : JobQueue
-- Category : Queue
-- Status   : Verified
-- OIM-Ver  : 9.3
-- Added    : 2026-03-30
-- WARNING  : DESTRUCTIVE — wraps in QBM_PTriggerDisable to bypass trigger guard.
--            Use ONLY on dev/test. Never run on production without change freeze.
--            Max 300 tasks moved per execution to avoid lock contention.

-- Step 1 — Disable the JobQueue update trigger
EXEC QBM_PTriggerDisable 'JobQueue', 'QBM_TUJobqueue';

-- Step 2 — Reassign top 300 pending tasks to target queue
-- Uncomment/adjust the WHERE filters as needed
UPDATE JobQueue
SET    Queue = '\StathopoulosK'          -- ← target queue name
WHERE  UID_Job IN (
    SELECT TOP 300 UID_Job
    FROM   JobQueue WITH (NOLOCK)
    WHERE  Queue <> '\StathopoulosK'      -- ← exclude already-correct rows
    --AND  JobChainName = 'CCC_EventMgr_Schedule_TriggerDueEvents'
    --AND  Ready2EXE   = 'TRUE'
);

-- Step 3 — Re-enable the trigger
EXEC QBM_PTriggerEnable 'JobQueue', 'QBM_TUJobqueue';
