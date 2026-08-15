USE real_estate_analytics;

DROP TABLE IF EXISTS fact_property_sales;
DROP TABLE IF EXISTS dim_property;
DROP TABLE IF EXISTS dim_location;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS stg_property_sales;

CREATE TABLE stg_property_sales (
    serial_number BIGINT,
    list_year SMALLINT,
    date_recorded DATE,
    town VARCHAR(150),
    address VARCHAR(255),
    assessed_value DECIMAL(18,2),
    sale_amount DECIMAL(18,2),
    sales_ratio DECIMAL(12,6),
    property_type VARCHAR(80),
    residential_type VARCHAR(100),
    non_use_code VARCHAR(100),
    assessor_remarks TEXT,
    opm_remarks TEXT,
    state VARCHAR(100)
);

CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year SMALLINT NOT NULL,
    quarter_num TINYINT NOT NULL,
    month_num TINYINT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    month_year VARCHAR(10) NOT NULL
);

CREATE TABLE dim_location (
    location_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    state VARCHAR(100) NOT NULL,
    town VARCHAR(150) NOT NULL,
    UNIQUE KEY uq_location (state, town)
);

CREATE TABLE dim_property (
    property_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    property_type VARCHAR(80),
    residential_type VARCHAR(100),
    UNIQUE KEY uq_property (property_type, residential_type)
);

CREATE TABLE fact_property_sales (
    sale_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    serial_number BIGINT NOT NULL,
    date_key INT,
    location_key BIGINT,
    property_key BIGINT,
    address VARCHAR(255),
    assessed_value DECIMAL(18,2),
    sale_amount DECIMAL(18,2),
    sales_ratio DECIMAL(12,6),
    load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_serial_number (serial_number),
    INDEX idx_date_key (date_key),
    INDEX idx_location_key (location_key),
    INDEX idx_property_key (property_key),
    INDEX idx_sale_amount (sale_amount),
    CONSTRAINT fk_fact_date FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    CONSTRAINT fk_fact_location FOREIGN KEY (location_key) REFERENCES dim_location(location_key),
    CONSTRAINT fk_fact_property FOREIGN KEY (property_key) REFERENCES dim_property(property_key)
);
