-- Pipeline Query: Public Health Exposure Decision Engine (3-Tier Model)
-- Repository: multicultural-cosmetic-safety-model/sql/t.case_study_1_logic.sql

```sql
WITH allergen_flags AS (
    SELECT
        product_id,
        brand,
        product_name,
        shade_profile,
        yuka_score,
        `Primary Stabilizer / Preservative System` AS ingredient_matrix,

        (IF(`Primary Stabilizer / Preservative System` LIKE '%Linalool%', 1, 0)
         + IF(`Primary Stabilizer / Preservative System` LIKE '%Limonene%', 1, 0)
         + IF(`Primary Stabilizer / Preservative System` LIKE '%Citronellol%', 1, 0)) AS allergen_count

    FROM `mcsi-data-infrastructure.cosmetic_audits.case_study_1_raw`
)

SELECT
    product_id,
    brand,
    product_name,
    shade_profile,
    yuka_score,
    ingredient_matrix,
    allergen_count,

    CASE
        WHEN ingredient_matrix LIKE '%BHT%' THEN 0
        WHEN ingredient_matrix LIKE '%Phenoxyethanol%' AND allergen_count > 0
            THEN GREATEST(0, 100 - (10 * allergen_count))
        ELSE 100
    END AS mcsi_score,

    CASE
        WHEN ingredient_matrix LIKE '%BHT%' THEN 'HIGH-RISK MISMATCH (FAIL)'
        WHEN ingredient_matrix LIKE '%Phenoxyethanol%' AND allergen_count > 0
            THEN 'CONDITIONAL WARNING'
        ELSE 'SAFE (PASS)'
    END AS mcsi_status

FROM allergen_flags
ORDER BY mcsi_score ASC;
```
