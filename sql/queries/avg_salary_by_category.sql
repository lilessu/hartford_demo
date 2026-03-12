SELECT
    c.category_name,
    COUNT(*) AS job_count,
    ROUND(AVG((f.min_salary + f.max_salary) / 2.0), 2) AS avg_est_salary
FROM fact_jobs f
JOIN dim_category c
    ON f.category_key = c.category_key
WHERE f.min_salary IS NOT NULL
  AND f.max_salary IS NOT NULL
GROUP BY c.category_name
ORDER BY avg_est_salary DESC;