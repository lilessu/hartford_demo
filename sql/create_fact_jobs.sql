CREATE TABLE fact_jobs (
    job_key SERIAL PRIMARY KEY,
    jobref TEXT UNIQUE,
    title TEXT,
    location_key INTEGER REFERENCES dim_location(location_key),
    category_key INTEGER REFERENCES dim_category(category_key),
    employment_type_key INTEGER REFERENCES dim_employment_type(employment_type_key),
    work_mode_key INTEGER REFERENCES dim_work_mode(work_mode_key),
    min_salary INTEGER,
    max_salary INTEGER,
    url TEXT,
    description TEXT,
    date_retrieved TIMESTAMP
);