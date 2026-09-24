CREATE OR REFRESH MATERIALIZED VIEW gold.sales_by_product

COMMENT 'Revenue, units sold, orders, and average ticket per product.'

AS

SELECT
    product,

    SUM(total_price) AS revenue,

    SUM(quantity) AS units_sold,

    COUNT(DISTINCT transaction_id) AS orders,

    ROUND(
        SUM(total_price) / COUNT(DISTINCT transaction_id),
        2
    ) AS avg_ticket

FROM silver.transactions_enriched

GROUP BY product;