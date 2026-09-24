CREATE OR REFRESH MATERIALIZED VIEW gold.sales_by_franchise
COMMENT 'Sales performance by franchise.'
AS

SELECT
    franchise_id,
    franchise_name,
    franchise_city,
    franchise_country,
    franchise_size,

    COUNT(DISTINCT transaction_id) AS total_transactions,

    SUM(quantity) AS total_quantity,

    SUM(total_price) AS total_revenue,

    ROUND(
        SUM(total_price) / COUNT(DISTINCT transaction_id),
        2
    ) AS average_ticket

FROM silver.transactions_enriched

GROUP BY
    franchise_id,
    franchise_name,
    franchise_city,
    franchise_country,
    franchise_size;