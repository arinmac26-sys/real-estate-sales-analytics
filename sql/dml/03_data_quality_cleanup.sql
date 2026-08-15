USE real_estate_analytics;

UPDATE stg_property_sales
SET town = NULLIF(TRIM(town), ''),
    state = NULLIF(TRIM(state), ''),
    property_type = NULLIF(TRIM(property_type), ''),
    residential_type = NULLIF(TRIM(residential_type), ''),
    address = NULLIF(TRIM(address), '');

DELETE FROM stg_property_sales
WHERE assessed_value < 0 OR sale_amount < 0;

DELETE f1
FROM fact_property_sales f1
JOIN fact_property_sales f2
  ON f1.serial_number = f2.serial_number
 AND f1.sale_key > f2.sale_key;
