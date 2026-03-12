SELECT
    c.category_name,
    COUNT(*) FILTER (WHERE w.work_mode_name = 'remote') AS remote_jobs,
    COUNT(*) FILTER (WHERE w.work_mode_name = 'hybrid') AS hybrid_jobs,
    COUNT(*) FILTER (WHERE w.work_mode_name = 'in office') AS in_office_jobs
FROM fact_jobs f
JOIN dim_category c
    ON f.category_key = c.category_key
JOIN dim_work_mode w
    ON f.work_mode_key = w.work_mode_key
GROUP BY c.category_name
ORDER BY c.category_name;