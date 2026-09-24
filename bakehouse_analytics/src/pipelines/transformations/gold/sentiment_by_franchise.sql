CREATE OR REFRESH MATERIALIZED VIEW gold.sentiment_by_franchise
COMMENT 'Review sentiment mix per franchise.'
AS

SELECT
    r.franchise_id,
    f.franchise_name,
    f.franchise_country,

    COUNT(DISTINCT r.review_id) AS review_count,

    SUM(CASE
        WHEN r.sentiment = 'positive' THEN 1
        ELSE 0
    END) AS positive_reviews,

    SUM(CASE
        WHEN r.sentiment = 'negative' THEN 1
        ELSE 0
    END) AS negative_reviews,

    SUM(CASE
        WHEN r.sentiment = 'neutral' THEN 1
        ELSE 0
    END) AS neutral_reviews,

    ROUND(
        100.0 * SUM(CASE
            WHEN r.sentiment = 'positive' THEN 1
            ELSE 0
        END) / COUNT(DISTINCT r.review_id),
        2
    ) AS positive_percentage,

    ROUND(
        100.0 * SUM(CASE
            WHEN r.sentiment = 'negative' THEN 1
            ELSE 0
        END) / COUNT(DISTINCT r.review_id),
        2
    ) AS negative_percentage,

    ROUND(
        100.0 * SUM(CASE
            WHEN r.sentiment = 'neutral' THEN 1
            ELSE 0
        END) / COUNT(DISTINCT r.review_id),
        2
    ) AS neutral_percentage

FROM silver.reviews_sentiment r

LEFT JOIN silver.franchises_enriched f
    ON r.franchise_id = f.franchise_id

GROUP BY
    r.franchise_id,
    f.franchise_name,
    f.franchise_country;