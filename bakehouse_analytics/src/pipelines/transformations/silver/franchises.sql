CREATE OR REFRESH MATERIALIZED VIEW silver.franchises_enriched
(
    CONSTRAINT valid_franchise_id
        EXPECT (franchise_id IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_supplier_id
        EXPECT (supplier_id IS NOT NULL)
        ON VIOLATION DROP ROW
)
AS
SELECT DISTINCT
    TRIM(f.franchiseID) AS franchise_id,
    TRIM(f.name) AS franchise_name,
    TRIM(f.city) AS franchise_city,
    TRIM(f.district) AS franchise_district,
    TRIM(f.zipcode) AS zipcode,
    TRIM(f.country) AS franchise_country,
    TRIM(f.size) AS franchise_size,
    CAST(f.longitude AS DOUBLE) AS franchise_longitude,
    CAST(f.latitude AS DOUBLE) AS franchise_latitude,

    TRIM(s.supplierID) AS supplier_id,
    TRIM(s.name) AS supplier_name,
    TRIM(s.ingredient) AS ingredient,
    TRIM(s.continent) AS supplier_continent,
    TRIM(s.city) AS supplier_city,
    UPPER(TRIM(s.approved)) AS supplier_approved,

    f._ingestion_timestamp

FROM bronze.franchises f

LEFT JOIN bronze.suppliers s
    ON f.supplierID = s.supplierID;