SELECT
    f.jobref,
    f.title,
    l.location_name,
    f.min_salary,
    f.max_salary,
    ROUND((f.min_salary + f.max_salary) / 2.0, 2) AS est_salary
FROM fact_jobs f
JOIN dim_location l
    ON f.location_key = l.location_key
WHERE f.min_salary IS NOT NULL
  AND f.max_salary IS NOT NULL
ORDER BY est_salary DESC;