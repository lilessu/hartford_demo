SELECT
    ROUND(AVG((min_salary + max_salary) / 2.0), 2) AS avg_estimated_salary
FROM fact_jobs
WHERE min_salary IS NOT NULL
  AND max_salary IS NOT NULL;