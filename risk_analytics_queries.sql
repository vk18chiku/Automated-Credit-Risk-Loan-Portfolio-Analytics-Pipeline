USE credit_risk_db;

SELECT 
    COUNT(id) AS Total_Loans_Processed,
    CONCAT('$', FORMAT(SUM(loan_amnt) / 1000000, 2), 'M') AS Total_Funded_Amount,
    CONCAT('$', FORMAT(SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN loan_amnt ELSE 0 END) / 1000000, 2), 'M') AS Value_At_Risk_TVaR,
    ROUND((SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) / COUNT(id)) * 100, 2) AS Default_Rate_Pct
FROM loan_portfolio;

-- Risk Segmentation
WITH Risk_Metrics AS (
    SELECT 
        purpose,
        Risk_Category,
        COUNT(id) AS Total_Loans,
        SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) AS Defaulted_Loans
    FROM loan_portfolio
    GROUP BY purpose, Risk_Category
    HAVING Total_Loans > 1000 -- Ignoring categories with very few loans
)
SELECT 
    purpose,
    Risk_Category,
    Total_Loans,
    ROUND((Defaulted_Loans / Total_Loans) * 100, 2) AS Default_Rate_Pct,
    DENSE_RANK() OVER(PARTITION BY Risk_Category ORDER BY (Defaulted_Loans / Total_Loans) DESC) AS Risk_Rank
FROM Risk_Metrics
ORDER BY Risk_Category, Risk_Rank;

-- Default Rates by Loan Grade and Term
SELECT 
    grade AS Credit_Grade,
    term AS Loan_Term,
    COUNT(id) AS Total_Issued,
    SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) AS Default_Count,
    ROUND((SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) / COUNT(id)) * 100, 2) AS Default_Rate_Percentage
FROM loan_portfolio
GROUP BY grade, term
ORDER BY grade, term;

-- Month-over-Month Risk Trend (Moving Average)
WITH Monthly_Stats AS (
    SELECT 
        STR_TO_DATE(CONCAT('01-', issue_d), '%d-%b-%Y') AS Issue_Month,
        COUNT(id) AS Total_Loans,
        SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) AS Defaulted_Loans
    FROM loan_portfolio
    WHERE issue_d IS NOT NULL
    GROUP BY Issue_Month
)
SELECT 
    DATE_FORMAT(Issue_Month, '%b-%Y') AS Month_Year,
    Total_Loans,
    ROUND((Defaulted_Loans / Total_Loans) * 100, 2) AS Default_Rate,
    ROUND(AVG((Defaulted_Loans / Total_Loans) * 100) OVER (
        ORDER BY Issue_Month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS 3_Month_Moving_Avg_Risk
FROM Monthly_Stats
ORDER BY Issue_Month;

-- Employment Length vs. Loan Size
SELECT 
    emp_length AS Employment_Duration,
    COUNT(id) AS Total_Borrowers,
    CONCAT('$', FORMAT(AVG(loan_amnt), 2)) AS Avg_Loan_Amount,
    (SELECT CONCAT('$', FORMAT(AVG(loan_amnt), 2)) FROM loan_portfolio) AS Portfolio_Avg_Loan,
    ROUND((AVG(loan_amnt) - (SELECT AVG(loan_amnt) FROM loan_portfolio)), 2) AS Difference_From_Portfolio_Avg
FROM loan_portfolio
GROUP BY emp_length
ORDER BY 
    CASE 
        WHEN emp_length = '< 1 year' THEN 1
        WHEN emp_length = '1 year' THEN 2
        WHEN emp_length = '10+ years' THEN 11
        WHEN emp_length = 'Unknown' THEN 12
        ELSE CAST(SUBSTRING_INDEX(emp_length, ' ', 1) AS UNSIGNED) + 1
    END;
    
-- Risk Profiling: The Debt-to-Income (DTI) Danger Zone
SELECT 
    CASE 
        WHEN dti < 10 THEN '0-10% (Excellent)'
        WHEN dti BETWEEN 10 AND 20 THEN '10-20% (Good)'
        WHEN dti BETWEEN 20 AND 30 THEN '20-30% (Risky)'
        WHEN dti > 30 THEN '30%+ (Danger)'
        ELSE 'Unknown'
    END AS DTI_Bucket,
    COUNT(id) AS Total_Loans,
    CONCAT('$', FORMAT(AVG(annual_inc), 2)) AS Avg_Annual_Income,
    ROUND((SUM(CASE WHEN loan_status IN ('Charged Off', 'Default') THEN 1 ELSE 0 END) / COUNT(id)) * 100, 2) AS Default_Rate_Percentage
FROM loan_portfolio
GROUP BY DTI_Bucket
ORDER BY Default_Rate_Percentage ASC;

--    