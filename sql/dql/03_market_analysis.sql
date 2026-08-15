USE real_estate_analytics;

SELECT l.state, l.town, COUNT(*) AS transactions,
       ROUND(SUM(f.sale_amount), 2) AS sales_value,
       ROUND(AVG(f.sale_amount), 2) AS avg_sale
FROM fact_property_sales f
JOIN dim_location l ON l.location_key = f.location_key
WHERE f.sale_amount IS NOT NULL
GROUP BY l.state, l.town
ORDER BY sales_value DESC
LIMIT 20;

SELECT p.property_type, p.residential_type,
       COUNT(*) AS transactions,
       ROUND(SUM(f.sale_amount), 2) AS sales_value,
       ROUND(100 * SUM(f.sale_amount) /
             NULLIF((SELECT SUM(sale_amount) FROM fact_property_sales),0), 2)
             AS sales_contribution_pct
FROM fact_property_sales f
JOIN dim_property p ON p.property_key = f.property_key
WHERE f.sale_amount IS NOT NULL
GROUP BY p.property_type, p.residential_type
ORDER BY sales_value DESC;
