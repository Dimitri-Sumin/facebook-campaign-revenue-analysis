/*
Purpose:
Export analytical views from PostgreSQL
to CSV files for Tableau dashboards.

Data flow:

Raw data
→ SQL transformations
→ analytical views
→ CSV export
→ Tableau visualization

Output folder:

Data/processed
*/


-- Export campaign Pareto dataset

COPY (

    SELECT *
    FROM campaign_pareto

)

TO 'D:/Stuff/Analytics/Subscription model analytical pet-project/Campaign Revenue and Monetization Dynamics Analysis/Data/processed/campaign_pareto.csv'

DELIMITER ','
CSV HEADER;


/*
Additional exports will be added as analytical
views are created:

campaign_ranking.csv
campaign_segmentation.csv
creative_stability.csv
campaign_creative_analysis.csv
*/

-- Export campaign ranking dataset

COPY (

    SELECT *
    FROM campaign_ranking

)

TO 'D:/Stuff/Analytics/Subscription model analytical pet-project/Campaign Revenue and Monetization Dynamics Analysis/Data/processed/campaign_ranking.csv'

DELIMITER ','
CSV HEADER;

-- Export campaign segmentation dataset

COPY (

    SELECT *
    FROM campaign_segmentation

)

TO 'D:/Stuff/Analytics/Subscription model analytical pet-project/Campaign Revenue and Monetization Dynamics Analysis/Data/processed/campaign_segmentation.csv'

DELIMITER ','
CSV HEADER;

-- Export campaign creative analysis dataset

COPY (

    SELECT *
    FROM campaign_creative_analysis

)

TO 'D:/Stuff/Analytics/Subscription model analytical pet-project/Campaign Revenue and Monetization Dynamics Analysis/Data/processed/campaign_creative_analysis.csv'

DELIMITER ','
CSV HEADER;

-- Export creative stability dataset

COPY (

    SELECT *
    FROM creative_stability

)

TO 'D:/Stuff/Analytics/Subscription model analytical pet-project/Campaign Revenue and Monetization Dynamics Analysis/Data/processed/creative_stability.csv'

DELIMITER ','
CSV HEADER;