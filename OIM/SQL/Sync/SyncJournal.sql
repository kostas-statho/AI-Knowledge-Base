-- Purpose : Synchronisation run journal — tracks recent sync executions
-- Tables  : DPRJournal
-- Notes   : Safe read-only. ProjectionState values observed: Running.
--           CausingEntityDisplay = object that triggered the sync.
--           CompletionTime IS NULL = sync still running.
--           Journal may be regularly purged (only 3 rows in this env on 2026-03-30).
-- Source  : live DB verified

SELECT TOP 50
    j.ProjectionConfigDisplay  AS SyncConfig,
    j.ProjectionState,
    j.CreationTime,
    j.CompletionTime,
    j.CausingEntityDisplay,
    j.SystemVariableSetDisplay
FROM DPRJournal j
ORDER BY j.CreationTime DESC;

-- Currently running syncs
SELECT * FROM DPRJournal
WHERE CompletionTime IS NULL
ORDER BY CreationTime;
