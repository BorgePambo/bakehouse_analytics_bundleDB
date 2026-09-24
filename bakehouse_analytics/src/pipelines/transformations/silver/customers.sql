CREATE OR REFRESH MATERIALIZED VIEW silver.customers AS

SELECT DISTINCT
    TRIM(customerID) AS customer_id,
    CONCAT(TRIM(first_name), ' ', TRIM(last_name)) AS full_name,
    LOWER(TRIM(email_address)) AS email,
    TRIM(phone_number) AS phone_number,
    TRIM(city) AS city,
    TRIM(state) AS state,
    CASE
        WHEN UPPER(TRIM(country)) IN ('USA', 'US')
            THEN 'United States'
        ELSE TRIM(country)
    END AS country,

    TRIM(postal_zip_code) AS postal_zip_code,
   
    CASE
        WHEN UPPER(TRIM(gender)) = 'MALE' THEN 'M'
        WHEN UPPER(TRIM(gender)) = 'FEMALE' THEN 'F'
        ELSE NULL
    END AS gender

FROM bronze.customers

WHERE customerID IS NOT NULL;