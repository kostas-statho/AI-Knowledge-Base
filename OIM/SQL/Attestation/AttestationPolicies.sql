-- Purpose : Overview of all attestation policies with schedule and risk
-- Tables  : AttestationPolicy
-- Notes   : Safe read-only. SolutionDays = deadline per run. 63 policies in this env.
-- Source  : live DB verified

SELECT
    UID_AttestationPolicy,
    Ident_AttestationPolicy,
    SolutionDays,
    IsAutoCloseOldCases,
    RiskIndex,
    XDateUpdated
FROM AttestationPolicy
ORDER BY Ident_AttestationPolicy;
