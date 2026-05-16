/*
Purpose:
Create a reusable campaign segmentation view
for Tableau export and campaign portfolio analysis.

Objectives:
1. Identify high-scale campaigns
2. Identify high-value campaigns
3. Identify delayed-LTV campaigns
4. Separate stronger and weaker monetization structures

Output:
View name:
campaign_segmentation

Fields:
• campaign name
• payment volume
• total LTV
• average late LTV share
• monetization efficiency
• campaign tier
*/


-- Create campaign segmentation view for Tableau


CREATE OR REPLACE VIEW campaign_segmentation AS

WITH campaign_summary AS (

    SELECT

        campaign,

        SUM(payments_total)
            AS total_payments,

        ROUND(
            SUM(ltv_total),
            2
        ) AS total_ltv,

        ROUND(
            AVG(late_ltv_share),
            4
        ) AS avg_late_ltv_share,

        ROUND(
            SUM(ltv_total)
            /
            NULLIF(
                SUM(payments_total),
                0
            ),
            2
        ) AS monetization_efficiency

    FROM campaign_metrics

    GROUP BY campaign
)

SELECT

    campaign,
    total_payments,
    total_ltv,
    avg_late_ltv_share,
    monetization_efficiency,

    CASE

        WHEN total_ltv >= 2000
             AND monetization_efficiency >= 20
        THEN 'Scale'

        WHEN total_ltv >= 1000
             AND monetization_efficiency >= 12
        THEN 'Optimize'

        WHEN total_ltv >= 500
        THEN 'Hold'

        ELSE 'Cut'

    END AS campaign_tier

FROM campaign_summary

ORDER BY total_ltv DESC;