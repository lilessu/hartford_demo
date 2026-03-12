SELECT
    l.location_name,

    COUNT(*) FILTER (WHERE c.category_name = 'data science and analytics') AS data_science_and_analytics,
    COUNT(*) FILTER (WHERE c.category_name = 'underwriting') AS underwriting,
    COUNT(*) FILTER (WHERE c.category_name = 'product management') AS product_management,
    COUNT(*) FILTER (WHERE c.category_name = 'training') AS training,
    COUNT(*) FILTER (WHERE c.category_name = 'sales support') AS sales_support,
    COUNT(*) FILTER (WHERE c.category_name = 'quality') AS quality,
    COUNT(*) FILTER (WHERE c.category_name = 'business development') AS business_development,
    COUNT(*) FILTER (WHERE c.category_name = 'finance') AS finance,
    COUNT(*) FILTER (WHERE c.category_name = 'risk management') AS risk_management,
    COUNT(*) FILTER (WHERE c.category_name = 'human resources') AS human_resources,
    COUNT(*) FILTER (WHERE c.category_name = 'data & analytics') AS data_analytics,
    COUNT(*) FILTER (WHERE c.category_name = 'legal') AS legal,
    COUNT(*) FILTER (WHERE c.category_name = 'agile') AS agile,
    COUNT(*) FILTER (WHERE c.category_name = 'actuarial') AS actuarial,
    COUNT(*) FILTER (WHERE c.category_name = 'marketing') AS marketing,
    COUNT(*) FILTER (WHERE c.category_name = 'data engineering') AS data_engineering,
    COUNT(*) FILTER (WHERE c.category_name = 'service operations') AS service_operations,
    COUNT(*) FILTER (WHERE c.category_name = 'sales') AS sales,
    COUNT(*) FILTER (WHERE c.category_name = 'claim') AS claim,
    COUNT(*) FILTER (WHERE c.category_name = 'information technology') AS information_technology

FROM fact_jobs f
JOIN dim_location l
    ON f.location_key = l.location_key
JOIN dim_category c
    ON f.category_key = c.category_key

GROUP BY l.location_name
ORDER BY l.location_name;