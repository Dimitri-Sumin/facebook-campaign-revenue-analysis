/*
Purpose:
Create reusable creative contribution layer.

Measures contribution of each creative
inside campaign revenue structure.

Used later for campaign concentration
analysis and dashboard visualizations.
*/

CREATE VIEW creative_contribution AS

WITH creative_share AS (

    SELECT

        campaign,
        creative,

        SUM(ltv_total) AS creative_ltv,

        SUM(
            SUM(ltv_total)
        ) OVER (
            PARTITION BY campaign
        ) AS campaign_ltv

    FROM campaign_metrics

    GROUP BY
        campaign,
        creative
)

SELECT

    campaign,
    creative,

    ROUND(
        creative_ltv,
        2
    ) AS creative_ltv,

    ROUND(
        creative_ltv/
        NULLIF(campaign_ltv,0)*100,
        2
    ) AS contribution_pct

FROM creative_share;