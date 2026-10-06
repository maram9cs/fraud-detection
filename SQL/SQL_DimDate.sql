
CREATE TABLE dbo.DimDate (
    DateKey      INT PRIMARY KEY,
    [DATE]      DATE NOT NULL UNIQUE,
    [Year]       INT,
    [Quarter]    INT,
    [Month]      INT,
    MonthName    NVARCHAR(20),
    [Day]        INT,
    DayOfWeek    INT,
    DayName      NVARCHAR(20),
    IsWeekend    BIT,
    IsWeekendSA  BIT

);

DECLARE @StartDate DATE = '20170101';
DECLARE @EndDate   DATE = '20301231';

-- Monday = 1, Friday = 5, Saturday = 6
SET DATEFIRST 1;
SET LANGUAGE us_english;
SET DATEFIRST 1;

;WITH Calendar AS (
    SELECT @StartDate AS  [DATE] 

    UNION ALL

    SELECT DATEADD(DAY, 1,  [DATE] )
    FROM Calendar
    WHERE  [DATE]  < @EndDate
)
INSERT INTO dbo.DimDate (
    DateKey,
     [DATE] ,
    [Year],
    [Quarter],
    [Month],
    MonthName,
    [Day],
    DayOfWeek,
    DayName,
    IsWeekend,
    IsWeekendSA

)
SELECT
    CONVERT(INT, CONVERT(CHAR(8),  [DATE] , 112)),
     [DATE] ,
    YEAR( [DATE] ),
    DATEPART(QUARTER,  [DATE] ),
    MONTH( [DATE] ),
    DATENAME(MONTH,  [DATE] ),
    DAY( [DATE] ),
    DATEPART(WEEKDAY,  [DATE] ),
    DATENAME(WEEKDAY,  [DATE] ),
     -- Saturday and Saunday 
    CASE
        WHEN DATEPART(WEEKDAY,  [DATE] ) IN (6, 7) THEN 1
        ELSE 0
    END ,
    -- Friday and Saturday 
    CASE
        WHEN DATEPART(WEEKDAY,  [DATE] ) IN (5, 6) THEN 1
        ELSE 0
    END 
FROM Calendar
OPTION (MAXRECURSION 0);

-- -- -- -- -- --
SELECT  *
FROM dbo.DimDate
ORDER BY  [DATE];