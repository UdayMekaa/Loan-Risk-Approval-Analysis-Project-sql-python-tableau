-- how many rows?
SELECT COUNT(*)  FROM loans;

-- Target distribution (loanapproved) --
SELECT loanapproved AS label,
       COUNT(*) AS n,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM loans), 2) AS pct
FROM loans
GROUP BY loanapproved
ORDER BY n DESC;

-- Employment status
SELECT employmentstatus,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans
GROUP BY employmentstatus
ORDER BY n DESC;

-- Age bucket (if created)
SELECT age_bucket,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans
GROUP BY age_bucket
ORDER BY age_bucket;

-- Employment status
SELECT employmentstatus,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans
GROUP BY employmentstatus
ORDER BY n DESC;

-- Age bucket (if created)
SELECT age_bucket,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans
GROUP BY age_bucket
ORDER BY age_bucket;

-- Uses the helper table built for you in the DB
WITH loans_with_decile AS (
    SELECT *,
           NTILE(10) OVER (ORDER BY riskscore) AS risk_decile
    FROM loans
)
SELECT risk_decile,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans_with_decile
GROUP BY risk_decile
ORDER BY risk_decile;

-- Income-to-loan ratio and approval (if engineered)
SELECT ROUND(income_to_loan_ratio, 2) AS inc_loan_ratio_bin,
       AVG(CASE WHEN loanapproved IN ('1','yes','true',1) THEN 1.0 ELSE 0.0 END) AS approval_rate,
       COUNT(*) AS n
FROM loans
WHERE income_to_loan_ratio IS NOT NULL
GROUP BY ROUND(income_to_loan_ratio, 2)
ORDER BY inc_loan_ratio_bin
LIMIT 50;


