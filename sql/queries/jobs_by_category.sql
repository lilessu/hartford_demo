SELECT
    c.category_name,
    COUNT(*) AS job_count
FROM fact_jobs f
JOIN dim_category c
    ON f.category_key = c.category_key
GROUP BY c.category_name
ORDER BY job_count DESC;