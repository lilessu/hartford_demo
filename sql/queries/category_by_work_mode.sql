SELECT
    c.category_name,
    w.work_mode_name,
    COUNT(*) AS job_count
FROM fact_jobs f
JOIN dim_category c
    ON f.category_key = c.category_key
JOIN dim_work_mode w
    ON f.work_mode_key = w.work_mode_key
GROUP BY c.category_name, w.work_mode_name
ORDER BY c.category_name, job_count DESC;