-- Purpose : SOD / compliance rule violations — which identities violate which rules
-- Tables  : QERPolicy, NonCompliance, PersonInNonCompliance, Person
-- Notes   : Safe read-only. Each compliance rule gets its own NonCompliance object.
--           PersonInNonCompliance maps Person → NonCompliance (violated rule).
--           QERPolicy defines the higher-level compliance policies.
-- Source  : OIM 9.1.1 Compliance Rules Administration Guide + web verified

-- All current rule violations with identity details
SELECT
    nc.DisplayName                   AS ViolatedRule,
    p.CentralAccount,
    p.FirstName + ' ' + p.LastName   AS FullName,
    pinc.XDateInserted               AS ViolationDate,
    pinc.XDateUpdated
FROM PersonInNonCompliance pinc
JOIN NonCompliance nc ON nc.UID_NonCompliance = pinc.UID_NonCompliance
JOIN Person        p  ON p.UID_Person         = pinc.UID_Person
ORDER BY nc.DisplayName, p.LastName;

-- Violation count per rule (top offenders)
SELECT nc.DisplayName AS Rule, COUNT(*) AS Violators
FROM PersonInNonCompliance pinc
JOIN NonCompliance nc ON nc.UID_NonCompliance = pinc.UID_NonCompliance
GROUP BY nc.DisplayName
ORDER BY Violators DESC;

-- All compliance policies
SELECT
    Ident_QERPolicy,
    Description,
    IsInActive,
    RiskIndex,
    XDateUpdated
FROM QERPolicy
ORDER BY Ident_QERPolicy;
