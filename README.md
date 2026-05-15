# Facebook Campaign Revenue Analytics

A campaign-level analytics case built from real Facebook Ads data, evaluating how paid acquisition translates into revenue and customer value across multiple monetization windows. The project identifies not only which campaigns generate conversions, but which acquisition sources produce stronger monetization quality, delayed revenue generation, and more sustainable customer value.

## Key Results

- 3,155 validated records analyzed
- 591 campaign entities
- 20–30% campaigns generated ~80% of value
- Only 4 campaigns classified as Scale candidates
- High-value campaigns showed 90–100% delayed monetization

\---

## Live Dashboard

Interactive Tableau visualization:

[**➜ View Interactive Dashboard**](https://public.tableau.com/app/profile/d.s6530/viz/campaign_revenue_dashboard/Dashboard)

\---

## Business Problem

Paid acquisition campaigns differ not just in volume — but in the *quality* of monetization they produce. Raw payment counts can mask weak value generation, while lower-volume campaigns may deliver disproportionate long-term LTV.

This project addresses the need to move beyond surface-level performance metrics and build an analytical framework that answers: **which campaigns are worth scaling, optimizing, holding, or cutting — and why?**

\---

## Dataset Overview

|Attribute|Detail|
|-|-|
|**Source**|Facebook Ads (single advertising account)|
|**Initial rows**|3,164|
|**Duplicates removed**|9|
|**Final analytical records**|3,155|
|**Monetization windows**|Day 0 / Day 3 / Day 7|
|**Spend data**|Not available|

> \*\*Note:\*\* Validation confirmed that Day 0, Day 3, and Day 7 windows function as \*\*independent monetization windows\*\*, not cumulative values. This reframes monetization timing as a core analytical dimension — same-day metrics alone can significantly underestimate campaign quality.

\---

## Analytical Goals

* Evaluate monetization timing across three independent reporting windows
* Identify revenue concentration patterns across the campaign portfolio
* Classify campaigns by monetization efficiency and customer value quality
* Detect campaigns with strong delayed monetization that would be misclassified by Day 0 metrics alone
* Build a strategic segmentation framework for portfolio-level decision making

\---

## Tech Stack

|Tool|Purpose|
|-|-|
|**PostgreSQL**|Data import, KPI layer, campaign ranking, Pareto analysis, segmentation|
|**Excel**|Data validation, duplicate removal, exploratory pivot analysis|
|**Tableau Public**|Interactive dashboard and visualization layer|
|**SQL**|Analytical queries, derived metrics, segmentation logic|

\---

## KPI Framework

### Monetization Metrics

|Metric|Description|
|-|-|
|`payments\_0d`|Payments recorded on Day 0|
|`payments\_3d`|Payments recorded on Day 3|
|`payments\_7d`|Payments recorded on Day 7|
|`ltv\_0d`|Revenue generated on Day 0|
|`ltv\_3d`|Revenue generated on Day 3|
|`ltv\_7d`|Revenue generated on Day 7|

### Derived Metrics

|Metric|Formula|Interpretation|
|-|-|-|
|`payments\_total`|`payments\_0d + payments\_3d + payments\_7d`|Total payment events per campaign|
|`ltv\_total`|`ltv\_0d + ltv\_3d + ltv\_7d`|Total revenue generated per campaign|
|`share\_of\_late\_payments`|`(payments\_3d + payments\_7d) / payments\_total`|Proportion of delayed monetization|
|`ltv\_per\_payment`|`ltv\_total / payments\_total`|Average revenue per payment event|
|`monetization\_efficiency`|`ltv\_total / payments\_total`|Customer value quality per payment|

> Higher `monetization\_efficiency` indicates stronger value generated per payment event. High payment volume with low efficiency signals monetization quality risk.

\---

## Project Workflow

**1. Data Validation and Normalization**
Standardized naming conventions, removed 9 duplicate records, validated reporting window structure, and performed exploratory pivot analysis in Excel.

**2. SQL Analytical Layer**
Built PostgreSQL import workflow, KPI calculation layer, campaign ranking logic, Pareto analysis, and campaign segmentation model.

**3. Revenue Concentration Analysis**
Ranked campaigns by total LTV contribution, calculated cumulative revenue share, and evaluated Pareto-like concentration behavior across the portfolio.

**4. Delayed Monetization Analysis**
Identified campaigns driven by delayed payment behavior, compared immediate vs. delayed value generation, and evaluated long-term sustainability patterns.

**5. Dashboard Development**
Combined all analytical views into a single Tableau dashboard covering revenue concentration, efficiency matrix, strategic segmentation, and delayed monetization behavior.

\---

## Dashboard Overview

![Tableau Dashboard](Images/tableau\_dashboard.png)

The Tableau Public dashboard integrates four analytical views into a single business decision layer: revenue concentration, monetization efficiency, delayed monetization behavior, and campaign strategic segmentation. Designed for portfolio-level review and prioritization.

\---

## Visualization Analysis

### Campaign Revenue Concentration Analysis

!\[Campaign Revenue Concentration](Images/pareto\_campaign\_revenue.png)

Campaigns were ranked by total LTV contribution and cumulative revenue share was plotted to reveal concentration structure. The curve shows a classic Pareto-like distribution: **approximately 20–30% of campaigns generate around 80% of total observed LTV.** Revenue generation is structurally concentrated, not evenly distributed across the portfolio. This implies that scaling efforts should focus on identifying and replicating a small number of high-performing structures rather than optimizing the portfolio uniformly.

\---

### Campaign Efficiency vs Value Matrix

!\[Campaign Efficiency vs Value Matrix](Images/campaign\_tier\_matrix.png)

Each campaign is plotted on two dimensions simultaneously — Monetization Efficiency (X axis) and Campaign LTV (Y axis) — creating a four-quadrant strategic classification:

|Quadrant|Criteria|Action|
|-|-|-|
|**Scale**|High efficiency + high LTV|Prioritize and expand budget|
|**Optimize**|Lower efficiency but strong value opportunity|Improve monetization quality|
|**Hold**|Stable moderate performance|Monitor, no immediate action|
|**Cut**|Low value + weak efficiency|Deprioritize or remove|

Most campaigns cluster in low-value zones. A smaller subset enters the Scale and Optimize quadrants, confirming that raw payment volume alone is insufficient for prioritization decisions.

\---

### Campaign Portfolio Distribution by Strategic Tier

!\[Campaign Portfolio Distribution](Images/campaign\_segment\_distribution.png)

|Tier|Campaign Count|
|-|-|
|🔴 Cut|465|
|⚪ Hold|87|
|🔵 Optimize|35|
|🟢 Scale|4|

**465 campaigns** fall into the Cut tier — the largest segment by count, representing operational noise in the portfolio. Only **4 campaigns** reach Scale-level classification. This distribution is consistent with the concentration behavior identified in the Pareto analysis: a structurally small subset drives the meaningful share of business value.

\---

### Delayed Monetization vs Value

!\[Delayed Monetization vs Value](Images/delayed\_monetization\_vs\_value.png)

This chart plots Delayed Monetization Share (X axis) against Campaign LTV (Y axis), with bubble size representing total payment volume. The observed pattern suggests: **most high-value campaigns cluster at delayed monetization shares of 90–100%.**

Top campaigns exhibiting this pattern:

|Campaign|Observation|
|-|-|
|`campaign\_151`|Highest LTV in dataset; near-total delayed monetization|
|`campaign\_432`|Second highest LTV; similarly delayed structure|
|`campaign\_149`|Strong LTV; high delayed monetization share|
|`campaign\_38`|Notable LTV with delayed monetization dependency|

Evaluating campaigns on Day 0 metrics alone would likely misclassify these as weak performers. **Monetization timing is not a secondary signal — it is a core analytical dimension.**

\---

## Key Findings

* **Revenue is structurally concentrated.** \~20–30% of campaigns generate \~80% of total LTV. The portfolio contains substantial large long-tail campaign population.
* **Delayed monetization dominates high-value behavior.** Top campaigns are heavily dependent on Day 3 and Day 7 monetization. Day 0 metrics systematically underestimate their value.
* **Volume and value do not align.** High payment volume does not reliably predict high LTV. Monetization efficiency is the more meaningful signal.
* **Reporting window structure matters.** Confirming that windows are independent (not cumulative) changed the interpretation of timing-based metrics.
* **Only 4 campaigns qualify as Scale candidates** out of 591 total — reflecting the concentration of genuine acquisition quality in a small subset of the portfolio. Campaign-level records were aggregated into 591 unique campaign entities.
* **Certain campaigns function as reusable acquisition assets.** Creative reuse alone does not guarantee stable performance; structural quality must be verified independently.

\---

## Business Recommendations

**Scale** — Campaigns with high monetization efficiency, strong delayed monetization share, and sustainable value generation. Replicate creative and targeting structures. Prioritize budget allocation.

**Optimize** — Campaigns with strong payment volume but weaker monetization sustainability. Investigate monetization bottlenecks and test structural improvements before scaling.

**Hold** — Campaigns with stable moderate performance. Maintain current spend levels; monitor for deterioration or improvement signals before reclassifying.

**Cut** — Campaigns with weak value generation and low efficiency. Deprioritize or remove. Reallocate budget toward Scale and Optimize tiers.

\---

## Limitations

* No spend data available — ROAS and CAC metrics cannot be calculated
* No user-level behavioral data — analysis operates at campaign aggregation level only
* Reporting windows limited to Day 0, Day 3, and Day 7
* Single advertising account — findings may not generalize across accounts or industries
* No CAC data — true acquisition economics cannot be fully evaluated

\---

## Deliverables

* ✅ Cleaned and validated dataset
* ✅ PostgreSQL import workflow
* ✅ SQL analytical queries (KPIs, ranking, Pareto, segmentation)
* ✅ Tableau interactive dashboard
* ✅ Tableau Public visualization (publicly accessible)
* ✅ Business recommendation framework
* ✅ KPI definitions and derived metric documentation

\---

## Repository Structure

```
campaign-revenue-analytics/
│
├── data/
│   ├── raw/                  # Original Facebook Ads export
│   └── processed/            # Cleaned, deduplicated analytical dataset
│
├── sql/                      # PostgreSQL queries: KPIs, Pareto, segmentation
│
├── tableau/                  # Tableau workbook file
│    └── campaign\_revenue\_dashboard.twb
│
├── images/                   # Visualization exports used in README
│
└── README.md
```

\---

*Built as a portfolio analytics project demonstrating end-to-end workflow: data validation → SQL analytical layer → revenue concentration analysis → strategic segmentation → Tableau dashboard.*

