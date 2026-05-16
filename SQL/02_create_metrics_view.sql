/*
Project:
Campaign Revenue Analytics

Purpose:
Create analytical KPI layer from cleaned
campaign-level acquisition data.

This view transforms raw metrics into
derived business indicators used for:

• campaign ranking
• monetization analysis
• delayed conversion analysis
• efficiency comparison
• Tableau visualization
• performance tier classification

Derived KPIs:

payments_total
    Total observed payment events across
    reporting windows

ltv_total
    Total observed revenue / LTV across
    reporting windows

late_payment_share
    Share of payment events occurring
    after Day 0

late_ltv_share
    Share of revenue / LTV generated
    after Day 0

monetization_efficiency
    Average observed LTV generated
    per payment event


Notes:

Reporting windows in this dataset
behave as independent monetization
windows rather than cumulative values.

As a result:

payments_total =
payments_0d + payments_3d + payments_7d

ltv_total =
ltv_0d + ltv_3d + ltv_7d

rather than using cumulative progression.
*/


CREATE OR REPLACE VIEW campaign_metrics AS

SELECT

    *,

    -- total payment volume

    payments_0d +
    payments_3d +
    payments_7d

    AS payments_total,


    -- total observed revenue / LTV

    ltv_0d +
    ltv_3d +
    ltv_7d

    AS ltv_total,


    -- share of payment events occurring after Day 0

    CASE

        WHEN payments_0d +
             payments_3d +
             payments_7d = 0

        THEN 0

        ELSE

        (payments_3d + payments_7d)::numeric

        /

        NULLIF(
            payments_0d +
            payments_3d +
            payments_7d,
            0
        )

    END

    AS late_payment_share,


    -- share of observed revenue / LTV generated after Day 0

    CASE

        WHEN ltv_0d +
             ltv_3d +
             ltv_7d = 0

        THEN 0

        ELSE

        (ltv_3d + ltv_7d)::numeric

        /

        NULLIF(
            ltv_0d +
            ltv_3d +
            ltv_7d,
            0
        )

    END

    AS late_ltv_share,


    -- average observed LTV generated per payment event

    CASE

        WHEN payments_0d +
             payments_3d +
             payments_7d = 0

        THEN 0

        ELSE

        (ltv_0d +
         ltv_3d +
         ltv_7d)::numeric

        /

        NULLIF(
            payments_0d +
            payments_3d +
            payments_7d,
            0
        )

    END

    AS monetization_efficiency

FROM campaign_revenue;
