/*
Purpose:
Create a reusable creative stability view
for Tableau export and cross-campaign analysis.

Goal:

Identify whether reused creatives perform
consistently across campaign contexts.

Questions:

1. Which creatives appear across many campaigns?
2. Which creatives demonstrate stable performance?
3. Which creatives are highly context dependent?
4. Which creatives may function as reusable assets?

Output:

View name:
creative_stability

Fields:

• creative
• campaign count
• average efficiency
• minimum efficiency
• maximum efficiency
• efficiency variation
*/


-- Create reusable creative stability view


CREATE OR REPLACE VIEW creative_stability AS


WITH creative_campaign_perf AS (

    SELECT

        creative,
        campaign,

        SUM(payments_total)
            AS total_payments,

        ROUND(
            SUM(ltv_total),
        2) AS total_ltv,

        ROUND(
            SUM(ltv_total)
            /
            NULLIF(
                SUM(payments_total),
                0
            ),
        2) AS monetization_efficiency

    FROM campaign_metrics

    GROUP BY
        creative,
        campaign

),

creative_stats AS (

    SELECT

        creative,

        COUNT(DISTINCT campaign)
            AS campaign_count,

        ROUND(
            AVG(monetization_efficiency),
        2) AS avg_efficiency,

        ROUND(
            MIN(monetization_efficiency),
        2) AS min_efficiency,

        ROUND(
            MAX(monetization_efficiency),
        2) AS max_efficiency,

        ROUND(
            STDDEV(monetization_efficiency),
        2) AS efficiency_variation

    FROM creative_campaign_perf

    GROUP BY creative

)

SELECT *

FROM creative_stats

WHERE campaign_count > 3

ORDER BY

campaign_count DESC,
efficiency_variation ASC;
