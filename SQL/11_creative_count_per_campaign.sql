/*
Purpose:
Measure creative diversity inside campaigns.

The objective is to understand whether
campaign revenue concentration is caused by:

• a small number of available creatives
• dependence on a single dominant creative
• diversified creative contribution

This analysis supports interpretation of
campaign concentration patterns.
*/


SELECT

    campaign,

    COUNT(
        DISTINCT creative
    ) AS creative_count,

    ROUND(
        SUM(ltv_total),
        2
    ) AS total_ltv,

    ROUND(
        AVG(share_of_late_payments),
        3
    ) AS avg_late_payment_share

FROM campaign_metrics

GROUP BY campaign

ORDER BY

creative_count ASC,
total_ltv DESC;