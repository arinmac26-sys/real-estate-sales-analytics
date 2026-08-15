USE real_estate_analytics;

SELECT COUNT(*) AS transactions,
       ROUND(SUM(sale_amount), 2) AS total_sales,
       ROUND(AVG(sale_amount), 2) AS avg_sale,
       ROUND(MIN(sale_amount), 2) AS min_sale,
       ROUND(MAX(sale_amount), 2) AS max_sale,
       ROUND(AVG(sales_ratio), 4) AS avg_sales_ratio
FROM fact_property_sales
WHERE sale_amount IS NOT NULL;
