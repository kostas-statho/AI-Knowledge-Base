-- Purpose : Attestation cases updated within a date range
-- Tables  : AttestationCase
-- Notes   : Safe read-only. IsGranted: 1=approved, 0=denied, NULL=pending.
-- Source  : community.oneidentity.com/forum/6009 + live DB verified

DECLARE @FromDate DATETIME = '2025-01-01';
DECLARE @ToDate   DATETIME = GETDATE();

SELECT
    UID_AttestationCase, DisplayName,
    DisplayPersonHead AS Attestor, IsGranted, IsClosed,
    ToSolveTill, XDateUpdated, XDateInserted
FROM AttestationCase
WHERE XDateUpdated BETWEEN @FromDate AND @ToDate
ORDER BY XDateUpdated DESC;
