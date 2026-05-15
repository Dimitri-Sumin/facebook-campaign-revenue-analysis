/*
Project:
Campaign Revenue Analytics

Purpose:
Run initial validation checks after
CSV import into PostgreSQL.

Validation goals:

1. Confirm successful row import
2. Verify dataset structure
3. Inspect sample observations
4. Validate acquisition date coverage
5. Validate campaign and creative diversity

Expected results:

• 3155 rows
• acquisition date:
    2026-04-10
• approximately:
    591 campaigns
    1363 creatives

These checks confirm that the cleaned
dataset was imported correctly before
starting analytical transformations.
*/


-- Total row count validation

SELECT
    COUNT(*) AS total_rows
FROM campaign_revenue;



-- Sample data inspection

SELECT *
FROM campaign_revenue
LIMIT 10;



-- Dataset structure validation

SELECT

    MIN(acquisition_date)
        AS earliest_acquisition_date,

    MAX(acquisition_date)
        AS latest_acquisition_date,

    COUNT(DISTINCT campaign)
        AS unique_campaigns,

    COUNT(DISTINCT creative)
        AS unique_creatives

FROM campaign_revenue;