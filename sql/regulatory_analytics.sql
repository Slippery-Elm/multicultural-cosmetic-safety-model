## DQL: Toxicity Ranking & Regulatory Disparity Analysis

This is the core analytical query. It calculates a composite risk score (hazard score × risk weight), flags cases where EU and FDA regulatory treatment diverge, and ranks each compound's risk within its own functional class — so a preservative is only compared against other preservatives, not against dyes or metals.

```sql
-- Advanced Analytical Query: Toxicological Ranking & Disparity Indexing
WITH ClassToxicityCalculations AS (
    SELECT 
        chemical_id,
        chemical_name,
        chemical_class,
        toxicity_score_ewg,
        regulatory_status_eu,
        regulatory_status_fda,
        risk_weight_multiplier,
        -- Calculate Composite Risk Index using your exact column titles
        ROUND(toxicity_score_ewg * risk_weight_multiplier, 2) AS composite_risk_score,

        -- Identify Regulatory Disparity Gap parameters
        CASE 
            WHEN regulatory_status_eu = 'BANNED' AND regulatory_status_fda = 'UNREGULATED' 
                THEN 'CRITICAL DISPARITY: EU Banned / FDA Allowed'
            WHEN regulatory_status_eu = 'RESTRICTED' AND regulatory_status_fda = 'UNREGULATED' 
                THEN 'MODERATE DISPARITY: EU Restricted / FDA Allowed'
            ELSE 'HARMONIZED REGULATION'
        END AS regulatory_gap_indicator
    FROM 
        cosmetic_safety.toxic_compound_master
)
SELECT 
    chemical_id,
    chemical_name,
    chemical_class,
    toxicity_score_ewg,
    composite_risk_score,
    regulatory_gap_indicator,
    
    -- Rank chemicals within their specific class using your calibrated metrics
    DENSE_RANK() OVER (
        PARTITION BY chemical_class 
        ORDER BY composite_risk_score DESC
    ) AS toxicity_rank_in_class
FROM 
    ClassToxicityCalculations
ORDER BY 
    chemical_class ASC,
    toxicity_rank_in_class ASC;
```

A **view** differs from a regular table in one key way: it doesn't store its own copy of the data. Every time something queries `regulatory_analytics`, BigQuery re-runs the underlying logic fresh against the current `toxic_compound_master` table. That means the view always reflects the latest data — new compounds, updated regulatory statuses — without you ever needing to remember to refresh anything manually.

