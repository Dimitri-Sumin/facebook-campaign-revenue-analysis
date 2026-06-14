/*
Purpose:
Measure campaign revenue concentration structure.

Identify whether campaign performance
depends on a small number of creatives
or is distributed across many creatives.

Campaigns with no observed revenue
are classified separately.
*/


WITH contribution AS (

    SELECT

        campaign,

        MAX(contribution_pct)
            AS top_creative_share

    FROM creative_contribution

    GROUP BY campaign

)

SELECT

    campaign,

    ROUND(
        top_creative_share,
        2
    ) AS top_creative_share,

    CASE

        WHEN top_creative_share IS NULL
        THEN 'No revenue'

        WHEN top_creative_share >=50
        THEN 'Highly concentrated'

        WHEN top_creative_share >=30
        THEN 'Moderately concentrated'

        ELSE 'Distributed'

    END AS campaign_structure

FROM contribution

ORDER BY
    top_creative_share DESC NULLS LAST;
