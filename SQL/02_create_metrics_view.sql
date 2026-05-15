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
    Total observed payments across
    reporting windows

ltv_total
    Total observed customer value

share_of_late_payments
    Share of monetization occurring
    after day 0

ltv_per_payment
    Average value generated per payment


Notes:

Reporting windows in this dataset
behave as independent monetization
windows rather than cumulative values.

As a result:

payments_total =
0d + 3d + 7d

rather than using cumulative progression.
*/


CREATE VIEW campaign_metrics AS

SELECT

    *,

    -- total payment volume

    payments_0d +
    payments_3d +
    payments_7d

    AS payments_total,


    -- total customer value

    ltv_0d +
    ltv_3d +
    ltv_7d

    AS ltv_total,


    -- share of delayed monetization

    CASE

        WHEN payments_0d +
             payments_3d +
             payments_7d = 0

        THEN 0

        ELSE

        (payments_3d + payments_7d)::numeric

        /

        (payments_0d +
         payments_3d +
         payments_7d)

    END

    AS share_of_late_payments,


    -- customer value generated
    -- per observed payment

    CASE

        WHEN payments_0d +
             payments_3d +
             payments_7d = 0

        THEN 0

        ELSE

        (ltv_0d +
         ltv_3d +
         ltv_7d)

        /

        (payments_0d +
         payments_3d +
         payments_7d)

    END

    AS ltv_per_payment

FROM campaign_revenue;