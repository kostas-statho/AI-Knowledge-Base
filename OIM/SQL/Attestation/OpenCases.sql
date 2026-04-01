-- Purpose : Active (open, undecided) attestation cases still within deadline
-- Tables  : AttestationCase
-- Notes   : Safe read-only. IsClosed=0 + future ToSolveTill = active.
--           IsGranted: NULL=pending, 1=approved, 0=denied.
-- Source  : OIM 9.1 Attestation Administration Guide + live DB verified

SELECT TOP 100
    UID_AttestationCase, DisplayName,
    DisplayPersonHead AS Attestor, IsGranted, ToSolveTill, XDateInserted
FROM AttestationCase
WHERE IsClosed = 0 AND ToSolveTill > GETDATE()
ORDER BY ToSolveTill;
