-- Cross-campaign creative analysis
-- Goal:
-- Identify creatives reused across multiple campaigns
-- and evaluate whether some creatives behave as independent
-- performance drivers across campaign contexts


WITH creative_performance AS (

    SELECT
        creative,
        campaign,

        SUM(payments_total) AS total_payments,
        ROUND(SUM(ltv_total),2) AS total_ltv,

        ROUND(
            SUM(ltv_total)/
            NULLIF(SUM(payments_total),0),
        2) AS monetization_efficiency

    FROM campaign_metrics

    GROUP BY
        creative,
        campaign

),

creative_summary AS (

    SELECT

        creative,

        COUNT(DISTINCT campaign)
            AS campaign_count,

        ROUND(
            SUM(total_ltv),
        2) AS creative_total_ltv,

        ROUND(
            AVG(monetization_efficiency),
        2) AS avg_efficiency

    FROM creative_performance

    GROUP BY creative

)

SELECT *

FROM creative_summary

WHERE campaign_count > 1

ORDER BY

campaign_count DESC,
creative_total_ltv DESC;
