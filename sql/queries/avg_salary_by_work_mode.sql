SELECT
    w.work_mode_name,
    COUNT(*) AS job_count,
    ROUND(AVG((f.min_salary + f.max_salary) / 2.0), 2) AS avg_est_salary
FROM fact_jobs f
JOIN dim_work_mode w
    ON f.work_mode_key = w.work_mode_key
WHERE f.min_salary IS NOT NULL
  AND f.max_salary IS NOT NULL
GROUP BY w.work_mode_name
ORDER BY avg_est_salary DESC;