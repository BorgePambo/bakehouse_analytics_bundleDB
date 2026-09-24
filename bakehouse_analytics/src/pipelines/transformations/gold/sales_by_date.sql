CREATE OR REFRESH MATERIALIZED VIEW gold.sales_by_date AS

SELECT
    CAST(transaction_datetime AS DATE) AS sale_date,

    COUNT(DISTINCT transaction_id) AS total_transactions,

    SUM(quantity) AS total_quantity,

    SUM(total_price) AS total_revenue,

    ROUND(
        SUM(total_price) / COUNT(DISTINCT transaction_id),
        2
    ) AS average_ticket

FROM silver.transactions_enriched

GROUP BY
    CAST(transaction_datetime AS DATE);