/*
Purpose:
Measure creative-level contribution inside each campaign.

This query identifies whether campaign performance
is distributed across many creatives or concentrated
in a small number of creatives.

Important:
Some campaigns may have zero total LTV.
NULLIF is used to prevent division by zero.
*/


WITH creative_share AS (

    SELECT

        campaign,
        creative,

        SUM(ltv_total) AS creative_ltv,

        SUM(SUM(ltv_total)) OVER (
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
        creative_ltv /
        NULLIF(campaign_ltv, 0) * 100,
        2
    ) AS contribution_pct

FROM creative_share

ORDER BY
    campaign,
    contribution_pct DESC;
