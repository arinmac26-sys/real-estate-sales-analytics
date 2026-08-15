USE real_estate_analytics;

WITH town_sales AS (
    SELECT l.state, l.town, SUM(f.sale_amount) AS sales_value
    FROM fact_property_sales f
    JOIN dim_location l ON l.location_key = f.location_key
    WHERE f.sale_amount IS NOT NULL
    GROUP BY l.state, l.town
)
SELECT state, town, ROUND(sales_value,2) AS sales_value,
       DENSE_RANK() OVER (PARTITION BY state ORDER BY sales_value DESC) AS state_rank,
       ROUND(100 * sales_value /
             NULLIF(SUM(sales_value) OVER (PARTITION BY state),0),2)
             AS state_contribution_pct
FROM town_sales
ORDER BY state, state_rank;
