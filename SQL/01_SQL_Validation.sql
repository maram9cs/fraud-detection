--IF DB_ID(N'FraudDetection') IS NULL
  --  CREATE DATABASE FraudDetection;

-- 5 Models
select * from dbo.ModelComparison ;

-- 433 Features/Columns 
select count(*) from dbo.FeatureImportance;

-- Five Thresholds 
Select * from dbo.ThresholdComparison;
--0.2 Threshold..
-- TP: 2038
-- FP: 1386
-- FN  2026
-- TN: 112,658

Select 
count(distinct transactionID)  TranCount,
count(*) ALL_rows,
sum(cast(PredictedFraud as INT)) Alert, -- TP + FP = 2038 + 1386
sum(CASE WHEN ActualFraud = 1 AND PredictedFraud = 1 THEN 1 ELSE 0 END) AS TP,
sum(CASE WHEN ActualFraud = 0 AND PredictedFraud = 1 THEN 1 ELSE 0 END) AS FP,
sum(CASE WHEN ActualFraud = 1 AND PredictedFraud = 0 THEN 1 ELSE 0 END) AS FN,
sum(CASE WHEN ActualFraud = 0 AND PredictedFraud = 0 THEN 1 ELSE 0 END) AS TN

from dbo.ScoredValidation;
