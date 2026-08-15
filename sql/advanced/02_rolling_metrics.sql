USE real_estate_analytics;

WITH monthly AS (
    SELECT d.year, d.month_num, d.month_year, SUM(f.sale_amount) AS sales_value
    FROM fact_property_sales f
    JOIN dim_date d ON d.date_key = f.date_key
    WHERE f.sale_amount IS NOT NULL
    GROUP BY d.year, d.month_num, d.month_year
)
SELECT year, month_num, month_year, sales_value,
       ROUND(AVG(sales_value) OVER (
           ORDER BY year, month_num ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ),2) AS rolling_3_month_avg,
       ROUND(100 * (sales_value / NULLIF(
           LAG(sales_value) OVER (ORDER BY year, month_num),0) - 1),2)
           AS mom_growth_pct
FROM monthly
ORDER BY year, month_num;
