/*
Project:
Campaign Revenue Analytics

Purpose:
Create base table for cleaned Facebook Ads
campaign performance data.

Dataset characteristics:

• source: Facebook Ads
• level: campaign + creative + acquisition date
• rows: 3155 validated observations
• duplicate rows removed: 9
• analysis window:
    0d
    3d
    7d

Notes:

payments and LTV metrics represent
independent reporting windows rather
than cumulative values.

This table serves as the base layer
for downstream KPI calculation,
campaign ranking and Tableau analysis.
*/


CREATE TABLE campaign_revenue (

    acquisition_date DATE,

    timestamp TIMESTAMP,

    source TEXT,

    campaign TEXT,

    creative TEXT,

    payments_0d INTEGER,
    payments_3d INTEGER,
    payments_7d INTEGER,

    ltv_0d NUMERIC,
    ltv_3d NUMERIC,
    ltv_7d NUMERIC

);