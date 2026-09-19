WITH prepared_marketing_metrics AS (
    SELECT 
        trend_id, brand_partner, campaign_type, placement_driver,
        positive_score, neutral_score, compound_score
    FROM `birmingham-public-health-data.birmingham_health_core.fact_viral_marketing_trends`
)
SELECT 
    trend_id, brand_partner, campaign_type, placement_driver,
    positive_score, neutral_score, compound_score,
    RANK() OVER (
        PARTITION BY campaign_type 
        ORDER BY compound_score DESC
    ) AS rank_by_sentiment
FROM prepared_marketing_metrics
ORDER BY campaign_type, rank_by_sentiment;
