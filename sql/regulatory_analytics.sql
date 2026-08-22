## DQL: Toxicity Ranking & Regulatory Disparity Analysis

This is the core analytical query. It calculates a composite risk score (hazard score × risk weight), flags cases where EU and FDA regulatory treatment diverge, and ranks each compound's risk within its own functional class — so a preservative is only compared against other preservatives, not against dyes or metals.

```sql
WITH ClassToxicityCalculations AS (
    SELECT
        chemical_name,
        chemical_class,
        ewg_hazard_score,
        melanin_interaction,
        chronic_skin_trigger,
        regulatory_status_eu,
        regulatory_status_fda,
        primary_health_concern,
        risk_weight_multiplier,

        -- Composite Risk Index: raw hazard score adjusted by the compound's risk weight
        ROUND(ewg_hazard_score * risk_weight_multiplier, 2) AS composite_risk_score,

        -- Flag divergence between EU and FDA regulatory treatment
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
    chemical_name,
    chemical_class,
    ewg_hazard_score,
    melanin_interaction,
    chronic_skin_trigger,
    primary_health_concern,
    composite_risk_score,
    regulatory_gap_indicator,

    -- Rank each compound's risk within its own functional class
    DENSE_RANK() OVER (
        PARTITION BY chemical_class
        ORDER BY composite_risk_score DESC
    ) AS toxicity_rank_in_class

FROM
    ClassToxicityCalculations
WHERE
    ewg_hazard_score >= 5

ORDER BY
    chemical_class ASC,
    toxicity_rank_in_class ASC;
```

**On that `WHERE ewg_hazard_score >= 5` filter:** this keeps the final report focused on compounds with genuinely notable hazard scores, rather than including low-concern entries that would dilute the ranking. Adjust or remove the threshold depending on whether you want the full dataset or just the higher-risk subset in a given report.

---

## Saving the Query as a Reusable View

Rather than re-running the full DQL query every time a report or visualization needs this data, it's saved as a **view** — a stored query that behaves like a virtual table. Any tool (Python, Tableau, another SQL query) can select from `cosmetic_safety.regulatory_analytics` directly, without needing to know or repeat the underlying `WITH` / window-function logic.

```sql
CREATE OR REPLACE VIEW cosmetic_safety.regulatory_analytics AS
WITH ClassToxicityCalculations AS (
    SELECT
        chemical_name,
        chemical_class,
        ewg_hazard_score,
        melanin_interaction,
        chronic_skin_trigger,
        regulatory_status_eu,
        regulatory_status_fda,
        primary_health_concern,
        risk_weight_multiplier,
        ROUND(ewg_hazard_score * risk_weight_multiplier, 2) AS composite_risk_score,
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
    chemical_name,
    chemical_class,
    ewg_hazard_score,
    melanin_interaction,
    chronic_skin_trigger,
    primary_health_concern,
    composite_risk_score,
    regulatory_gap_indicator,
    DENSE_RANK() OVER (
        PARTITION BY chemical_class
        ORDER BY composite_risk_score DESC
    ) AS toxicity_rank_in_class
FROM
    ClassToxicityCalculations
WHERE
    ewg_hazard_score >= 5;
```

A **view** differs from a regular table in one key way: it doesn't store its own copy of the data. Every time something queries `regulatory_analytics`, BigQuery re-runs the underlying logic fresh against the current `toxic_compound_master` table. That means the view always reflects the latest data — new compounds, updated regulatory statuses — without you ever needing to remember to refresh anything manually.

