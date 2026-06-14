/*
Project:
Campaign Revenue Analytics

Purpose:
Create a reusable campaign-level ranking view
for Tableau export and performance comparison.

This view aggregates the analytical KPI layer
from campaign_metrics to the campaign level.

It is used to compare campaigns by:

• total payment volume
• total observed LTV
• delayed LTV dependency
• monetization efficiency
• scale and quality combination

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
• campaign-level late LTV share
• monetization efficiency

Notes:

campaign_late_ltv_share is calculated at the
campaign level as:

late LTV across the campaign
/
total LTV across the campaign

This avoids averaging row-level ratios and gives
a cleaner campaign-level delayed revenue indicator.
*/


-- Create campaign-level ranking view for Tableau


CREATE OR REPLACE VIEW campaign_ranking AS

WITH campaign_summary AS (

    SELECT

        campaign,

        -- total payment volume by campaign

        SUM(payments_total)
            AS total_payments,


        -- total observed revenue / LTV by campaign

        ROUND(
            SUM(ltv_total),
            2
        ) AS total_ltv,


        -- campaign-level share of LTV generated after Day 0

        ROUND(
            SUM(ltv_3d + ltv_7d)
            /
            NULLIF(
                SUM(ltv_total),
                0
            ),
            4
        ) AS campaign_late_ltv_share,


        -- average observed LTV generated per payment event

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
