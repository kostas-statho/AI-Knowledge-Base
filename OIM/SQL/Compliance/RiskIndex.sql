-- Purpose : Risk index rule definitions used in identity compliance scoring
-- Tables  : QERRiskIndex
-- Notes   : Safe read-only. TypeOfCalculation: MX1=max(134), DEC=decrease(132),
--           INC=increase(44), RED=reduce(4). Weight = contribution to risk score.
--           314 rows in this environment (live DB 2026-03-30).
-- Source  : live DB verified

-- All active risk index rules with weight and description
SELECT
    DisplayValue,
    Description,
    TypeOfCalculation,
    Weight,
    IsInActive,
    XDateUpdated
FROM QERRiskIndex
WHERE IsInActive = 0
ORDER BY Weight DESC, TypeOfCalculation;

-- Risk index distribution by calculation type
SELECT TypeOfCalculation, COUNT(*) AS RuleCount, AVG(Weight) AS AvgWeight
FROM QERRiskIndex
WHERE IsInActive = 0
GROUP BY TypeOfCalculation
ORDER BY RuleCount DESC;
