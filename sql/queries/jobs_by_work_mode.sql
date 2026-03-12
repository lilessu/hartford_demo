SELECT w.work_mode_name, COUNT(*) AS job_count
FROM fact_jobs f
JOIN dim_work_mode w ON f.work_mode_key = w.work_mode_key
GROUP BY w.work_mode_name
ORDER BY job_count DESC;