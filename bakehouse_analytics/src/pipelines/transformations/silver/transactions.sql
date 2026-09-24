CREATE OR REFRESH MATERIALIZED VIEW silver.transactions_enriched AS
(
    CONSTRAINT valid_transaction_id
        EXPECT (transaction_id IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_customer_id
        EXPECT (customer_id IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_franchise_id
        EXPECT (franchise_id IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_quantity
        EXPECT (quantity > 0)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_unit_price
        EXPECT (unit_price >= 0)
        ON VIOLATION DROP ROW,

    CONSTRAINT valid_total_price
        EXPECT (total_price >= 0)
        ON VIOLATION DROP ROW
)
SELECT DISTINCT
    TRIM(t.transactionID) AS transaction_id,
    CAST(t.dateTime AS TIMESTAMP) AS transaction_datetime,
    TRIM(t.product) AS product,
    CAST(t.quantity AS INT) AS quantity,
    CAST(t.unitPrice AS DECIMAL(10,2)) AS unit_price,
    CAST(t.totalPrice AS DECIMAL(10,2)) AS total_price,
    LOWER(TRIM(t.paymentMethod)) AS payment_method,

    TRIM(t.customerID) AS customer_id,
    c.full_name AS customer_full_name,
    c.email,
    c.city AS customer_city,
    c.country AS customer_country,

    TRIM(t.franchiseID) AS franchise_id,
    f.franchise_name,
    f.franchise_city,
    f.franchise_district,
    f.franchise_country,
    f.franchise_size,

    t._ingestion_timestamp

FROM bronze.transactions t

LEFT JOIN silver.customers c
    ON TRIM(t.customerID) = c.customer_id

LEFT JOIN silver.franchises_enriched f
    ON TRIM(t.franchiseID) = f.franchise_id;