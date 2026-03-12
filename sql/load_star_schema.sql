INSERT INTO dim_location (location_name)
SELECT DISTINCT location
FROM staging
WHERE location IS NOT NULL
ON CONFLICT (location_name) DO NOTHING;

INSERT INTO dim_category (category_name)
SELECT DISTINCT category
FROM staging
WHERE category IS NOT NULL
ON CONFLICT (category_name) DO NOTHING;

INSERT INTO dim_employment_type (employment_type_name)
SELECT DISTINCT employment_type
FROM staging
WHERE employment_type IS NOT NULL
ON CONFLICT (employment_type_name) DO NOTHING;

INSERT INTO dim_work_mode (work_mode_name)
SELECT DISTINCT work_mode
FROM staging
WHERE work_mode IS NOT NULL
ON CONFLICT (work_mode_name) DO NOTHING;

INSERT INTO fact_jobs (
    jobref,
    title,
    location_key,
    category_key,
    employment_type_key,
    work_mode_key,
    min_salary,
    max_salary,
    url,
    description,
    date_retrieved
)
SELECT
    s.jobref,
    s.title,
    l.location_key,
    c.category_key,
    e.employment_type_key,
    w.work_mode_key,
    s.min_sal,
    s.max_sal,
    s.url,
    s.description,
    s.date_retrieved
FROM staging s
LEFT JOIN dim_location l
    ON s.location = l.location_name
LEFT JOIN dim_category c
    ON s.category = c.category_name
LEFT JOIN dim_employment_type e
    ON s.employment_type = e.employment_type_name
LEFT JOIN dim_work_mode w
    ON s.work_mode = w.work_mode_name
ON CONFLICT (jobref) DO NOTHING;