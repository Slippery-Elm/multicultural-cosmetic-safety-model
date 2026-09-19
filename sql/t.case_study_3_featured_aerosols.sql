```sql
WITH RawFormulationSanitizer AS (
    SELECT 
        -- Standardize original spreadsheet text strings
        LOWER(TRIM(episode_source)) AS clean_episode_source,
        LOWER(TRIM(timeline_marker)) AS production_timeline_marker,
        
        -- Ingest numeric toxicological baseline values
        CAST(formulation_concentration AS FLOAT64) AS concentration_pct,
        CAST(tissue_absorption_index AS FLOAT64) AS absorption_metric
    FROM 
        -- Fully synced with the exact, capitalized BigQuery table name!
        `birmingham-public-health-data.birmingham_health_core.Aerosol_Tracking`
    WHERE 
        formulation_concentration IS NOT NULL 
),
CalculatedRiskFunnel AS (
    SELECT 
        clean_episode_source,
        production_timeline_marker,
        concentration_pct,
        absorption_metric,
        
        -- Execute multi-factor risk logic 
        -- Applies 2.2 multiplier for high-vulnerability aerosol mists
        CASE 
            WHEN (production_timeline_marker LIKE '%elimi%' 
               OR production_timeline_marker LIKE '%prep%' 
               OR production_timeline_marker LIKE '%touch%') 
            THEN ROUND((concentration_pct * absorption_metric) * 2.2, 4)
            ELSE ROUND(concentration_pct * absorption_metric, 4)
        END AS dynamic_exposure_score
    FROM 
        RawFormulationSanitizer
)
SELECT 
    clean_episode_source,
    production_timeline_marker,
    concentration_pct,
    dynamic_exposure_score,
    
    -- Rank exposure risk velocity partitioned by episode stream sources
    RANK() OVER (
        PARTITION BY clean_episode_source 
        ORDER BY dynamic_exposure_score DESC
    ) AS regional_exposure_velocity_rank
FROM 
    CalculatedRiskFunnel
ORDER BY 
    dynamic_exposure_score DESC;
```
