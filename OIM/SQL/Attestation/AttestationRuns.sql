-- Purpose : Recent attestation runs (one per policy execution)
-- Tables  : AttestationRun, AttestationPolicy
-- Notes   : Safe read-only. PolicyProcessed = when the run was triggered.
--           In this env, runs happen daily at ~01:00.
-- Source  : OIM 9.2 Attestation Administration Guide + live DB verified

SELECT TOP 50
    ar.UID_AttestationRun,
    ap.Ident_AttestationPolicy,
    ar.PolicyProcessed,
    ar.XDateInserted,
    ar.CountChunksUnderConstruction
FROM AttestationRun ar
LEFT JOIN AttestationPolicy ap ON ap.UID_AttestationPolicy = ar.UID_AttestationPolicy
ORDER BY ar.PolicyProcessed DESC;
