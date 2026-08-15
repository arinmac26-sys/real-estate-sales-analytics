USE real_estate_analytics;

INSERT IGNORE INTO dim_date
(date_key, full_date, year, quarter_num, month_num, month_name, month_year)
SELECT DISTINCT
    DATE_FORMAT(date_recorded, '%Y%m%d') + 0,
    date_recorded, YEAR(date_recorded), QUARTER(date_recorded),
    MONTH(date_recorded), DATE_FORMAT(date_recorded, '%b'),
    DATE_FORMAT(date_recorded, '%b-%Y')
FROM stg_property_sales
WHERE date_recorded IS NOT NULL;

INSERT IGNORE INTO dim_location (state, town)
SELECT DISTINCT COALESCE(NULLIF(TRIM(state), ''), 'Unknown'),
                COALESCE(NULLIF(TRIM(town), ''), 'Unknown')
FROM stg_property_sales;

INSERT IGNORE INTO dim_property (property_type, residential_type)
SELECT DISTINCT COALESCE(NULLIF(TRIM(property_type), ''), 'Unknown'),
                COALESCE(NULLIF(TRIM(residential_type), ''), 'Unknown')
FROM stg_property_sales;

INSERT IGNORE INTO fact_property_sales
(serial_number, date_key, location_key, property_key, address,
 assessed_value, sale_amount, sales_ratio)
SELECT s.serial_number,
       DATE_FORMAT(s.date_recorded, '%Y%m%d') + 0,
       l.location_key, p.property_key, NULLIF(TRIM(s.address), ''),
       NULLIF(s.assessed_value, 0), NULLIF(s.sale_amount, 0),
       NULLIF(s.sales_ratio, 0)
FROM stg_property_sales s
JOIN dim_location l
  ON l.state = COALESCE(NULLIF(TRIM(s.state), ''), 'Unknown')
 AND l.town  = COALESCE(NULLIF(TRIM(s.town), ''), 'Unknown')
JOIN dim_property p
  ON p.property_type = COALESCE(NULLIF(TRIM(s.property_type), ''), 'Unknown')
 AND p.residential_type = COALESCE(NULLIF(TRIM(s.residential_type), ''), 'Unknown')
WHERE s.serial_number IS NOT NULL;
