/*
Purpose:
Create a reusable campaign-level ranking view
for Tableau export and performance comparison.

Questions:
1. Which campaigns generate the highest total value?
2. Which campaigns demonstrate strongest monetization efficiency?
3. Which campaigns rely heavily on delayed LTV?
4. Which campaigns combine scale and quality?

Output:
View name:
campaign_ranking

Fields:
• campaign name
• payment volume
• total LTV
• average late LTV share
• monetization efficiency
*/


-- Create campaign-level ranking view for Tableau


CREATE OR REPLACE VIEW campaign_ranking AS

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

SELECT *

FROM campaign_summary

ORDER BY total_ltv DESC;