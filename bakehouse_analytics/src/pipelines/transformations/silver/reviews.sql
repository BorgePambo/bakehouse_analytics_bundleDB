CREATE OR REFRESH MATERIALIZED VIEW silver.reviews_sentiment
(
    CONSTRAINT valid_review_id
        EXPECT (review_id IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT has_review_text
        EXPECT (review_text IS NOT NULL)
        ON VIOLATION DROP ROW,

    CONSTRAINT has_review_date
        EXPECT (review_date IS NOT NULL)
)
AS
SELECT DISTINCT
    TRIM(new_id) AS review_id,
    TRIM(franchiseID) AS franchise_id,
    CAST(review_date AS TIMESTAMP) AS review_date,
    TRIM(review) AS review_text,
    ai_analyze_sentiment(review) AS sentiment,
    _ingestion_timestamp
FROM bronze.reviews;