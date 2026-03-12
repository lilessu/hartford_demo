CREATE TABLE dim_location (
    location_key SERIAL PRIMARY KEY,
    location_name TEXT UNIQUE
);

CREATE TABLE dim_category (
    category_key SERIAL PRIMARY KEY,
    category_name TEXT UNIQUE
);

CREATE TABLE dim_employment_type (
    employment_type_key SERIAL PRIMARY KEY,
    employment_type_name TEXT UNIQUE
);

CREATE TABLE dim_work_mode (
    work_mode_key SERIAL PRIMARY KEY,
    work_mode_name TEXT UNIQUE
);