-- Purpose : Synchronisation configurations (connected systems and direction)
-- Tables  : DPRProjectionConfig
-- Notes   : Safe read-only. ProjectionDirection: ToTheLeft=sync from target,
--           ToTheRight=provision to target, Inherite=inherited direction.
--           9 configs in this environment (includes custom CCC workflows).
-- Source  : live DB verified

SELECT
    DisplayName,
    Name,
    ProjectionDirection,
    ExceptionHandling,
    ConflictResolution,
    XDateUpdated
FROM DPRProjectionConfig
ORDER BY ProjectionDirection, DisplayName;
