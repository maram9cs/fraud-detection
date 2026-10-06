CREATE OR ALTER VIEW dbo.vw_ScoredValidation
AS
SELECT
    *,
    -- Relative day from the dataset time origin
    DATEADD(SECOND, TransactionDT, CAST('2017-11-30' AS DATETIME)) TranDateTime,
    -- Classify the prediction against the actual outcome
    CASE
        WHEN ActualFraud = 1 AND PredictedFraud = 1 THEN 'True Positive'
        WHEN ActualFraud = 0 AND PredictedFraud = 1 THEN 'False Positive'
        WHEN ActualFraud = 1 AND PredictedFraud = 0 THEN 'False Negative'
        WHEN ActualFraud = 0 AND PredictedFraud = 0 THEN 'True Negative'
    END AS AlertType,
    CASE
        WHEN TransactionAmt < 50 THEN '1. Under 50'
        WHEN TransactionAmt < 100 THEN '2. 50 to under 100'
        WHEN TransactionAmt < 200 THEN '3. 100 to under 200'
        WHEN TransactionAmt < 500 THEN '4. 200 to under 500'
        WHEN TransactionAmt < 1000 THEN '5. 500 to under 1000'
        ELSE '6. 1000 and above'
    END AS AmountBand,
    CASE
        WHEN HasIdentity = 1 THEN 'Avail'
        ELSE 'Not Avail'
    END AS IdentityStatus
   
FROM dbo.ScoredValidation ;
GO

-- Verify the reporting view
SELECT TOP (10)
    *
FROM dbo.vw_ScoredValidation
ORDER BY TransactionID;