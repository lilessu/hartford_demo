CREATE TABLE IF NOT EXISTS staging (
    jobref TEXT PRIMARY KEY,
    title TEXT,
    location TEXT,
    category TEXT,
    employment_type TEXT,
    work_mode TEXT,
    description TEXT,
    min_sal INTEGER,
    max_sal INTEGER,
    url TEXT,
    date_retrieved TIMESTAMP
);