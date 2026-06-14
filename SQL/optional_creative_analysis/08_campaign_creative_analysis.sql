/*
Purpose:
Create a reusable campaign + creative analysis view
for Tableau export and creative performance analysis.

Questions:
1. Which campaign-creative combinations generate the most value?
2. Does creative performance differ across campaigns?
3. Which combinations show stronger monetization efficiency?
4. Which combinations rely heavily on delayed LTV?

Output:
View name:
campaign_creative_analysis

Fields:
• campaign
• creative
• payment volume
• total LTV
• average late LTV share
• monetization efficiency
*/


-- Create campaign + creative performance view


CREATE OR REPLACE VIEW campaign_creative_analysis AS


SELECT

    campaign,
    creative,

    SUM(payments_total)
        AS total_payments,

    ROUND(
        SUM(ltv_total),
        2
    ) AS total_ltv,

    ROUND(
        AVG(late_ltv_share),
        3
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

GROUP BY
    campaign,
    creative

ORDER BY total_ltv DESC;
