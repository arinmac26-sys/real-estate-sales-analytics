USE real_estate_analytics;

SELECT d.year, d.month_num, d.month_name,
       COUNT(*) AS transactions,
       ROUND(SUM(f.sale_amount), 2) AS sales_value,
       ROUND(AVG(f.sale_amount), 2) AS avg_sale
FROM fact_property_sales f
JOIN dim_date d ON d.date_key = f.date_key
WHERE f.sale_amount IS NOT NULL
GROUP BY d.year, d.month_num, d.month_name
ORDER BY d.year, d.month_num;
