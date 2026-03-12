SELECT l.location_name, COUNT(*) AS job_count
FROM fact_jobs f
JOIN dim_location l ON f.location_key = l.location_key
GROUP BY l.location_name
ORDER BY job_count DESC;