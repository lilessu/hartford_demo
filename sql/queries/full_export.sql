SELECT
    f.jobref,
    f.title,
    l.location_name,
    c.category_name,
    e.employment_type_name,
    w.work_mode_name,
    f.min_salary,
    f.max_salary,
    ROUND((f.min_salary + f.max_salary) / 2.0, 2) AS est_salary,
    f.url,
    f.description,
    f.date_retrieved
FROM fact_jobs f
LEFT JOIN dim_location l
    ON f.location_key = l.location_key
LEFT JOIN dim_category c
    ON f.category_key = c.category_key
LEFT JOIN dim_employment_type e
    ON f.employment_type_key = e.employment_type_key
LEFT JOIN dim_work_mode w
    ON f.work_mode_key = w.work_mode_key
ORDER BY f.title;