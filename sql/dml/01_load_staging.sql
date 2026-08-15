USE real_estate_analytics;

LOAD DATA LOCAL INFILE 'data/processed/real_estate_sales_sample_50k.csv'
INTO TABLE stg_property_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(serial_number, list_year, date_recorded, town, address,
 assessed_value, sale_amount, sales_ratio, property_type,
 residential_type, non_use_code, assessor_remarks, opm_remarks, state);
