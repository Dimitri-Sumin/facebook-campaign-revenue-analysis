/*
Purpose:
Create a reusable campaign-level Pareto view
for Tableau export and revenue concentration analysis.

Questions:
1. Which campaigns contribute the largest share of total LTV?
2. How quickly does cumulative revenue accumulate?
3. Does campaign performance follow a Pareto-like structure?
4. Which campaigns fall inside the top cumulative revenue segment?

Output:
View name:
campaign_pareto

Fields:
• campaign rank
• campaign name
• payment volume
• total LTV
• revenue share
• cumulative revenue contribution
*/


-- Create campaign-level Pareto view for Tableau


CREATE OR REPLACE VIEW campaign_pareto AS

WITH campaign_totals AS (

    SELECT
        campaign,
        SUM(payments_total) AS total_payments,
        SUM(ltv_total) AS total_ltv

    FROM campaign_metrics

    GROUP BY campaign
),

ranked_campaigns AS (

    SELECT
        campaign,
        total_payments,
        total_ltv,

        -- campaign share of total revenue

        total_ltv /
        NULLIF(SUM(total_ltv) OVER (), 0)
        AS revenue_share,

        -- cumulative revenue accumulation

        SUM(total_ltv) OVER (
            ORDER BY total_ltv DESC
        )
        /
        NULLIF(SUM(total_ltv) OVER (), 0)
        AS cumulative_revenue_share,

        ROW_NUMBER() OVER (
            ORDER BY total_ltv DESC
        ) AS campaign_rank

    FROM campaign_totals
)

SELECT
    campaign_rank,
    campaign,
    total_payments,
    ROUND(total_ltv, 2) AS total_ltv,
    ROUND(revenue_share * 100, 2) AS revenue_share_pct,
    ROUND(cumulative_revenue_share * 100, 2)
        AS cumulative_revenue_share_pct,

    CASE
        WHEN cumulative_revenue_share <= 0.80
            THEN 'Top revenue concentration'
        ELSE 'Long tail'
    END AS pareto_segment

FROM ranked_campaigns

ORDER BY campaign_rank;