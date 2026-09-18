# 📺 Case Study 2: Love Island Influencer Syndication & VADER Sentiment Pipeline

## 🎯 Case Study Mission Statement
Automate the evaluation of unstructured digital audience response data for reality television multi-season brand partnerships. This end-to-end pipeline extracts live campaign data via programmatic cloud connections, overrides context-blind academic sentiment models with custom internet-culture slang libraries, and partitions warehouse metrics into competitive market leaderboards.

---

### 🛠️ Technical Stack & Environmental Constraints
*   **Core Execution Stack:** Python 3.10+ (`pandas`, `vaderSentiment`), SQL (Google BigQuery Standard SQL Dialect).
*   **Data Architecture & Pipelines:** `gspread` Cloud API authorization, automated DataFrame list transformations, and local CSV ingestion.
*   **Analytical Windows:** Partitioned non-correlated Common Table Expressions (CTEs) leveraging `RANK() OVER()` parameters.
*   **Business Intelligence Visual Anchor:** Tableau Desktop (Pane-Isolated Horizontal Leaderboards & Volume Scatter Matrices).
*   **Data Ingestion Constraints:** Google Colab temporary local cache storage. Schema tracking requires precise row list conversions (`df.values.tolist()`) to maintain matrix formatting when executing sheet-overwrites via cloud tokens.

---

## ⚙️ Python NLP Slang Lexicon Overrides
Standard academic NLP libraries suffer from severe context-blindness when auditing social commerce text. Expressions like *"flex"*, *"baddie"*, or *"ate"* register as negative or neutral stress flags. This pipeline patches the internal **VADER** lexicon dictionary to ensure human-in-the-loop accuracy:
*   `'flex'`: `+3.5` (Expression of supreme achievement/pride)
*   `'magic'`: `+3.0` (High-vibrational community validation value)
*   `'ate'`: `+3.5` (Vernacular for absolute performance excellence)
*   `'meta-humor'`: `+2.5` (Self-referential campaign engagement boost)

---

## 🐍 Local Python NLP Inference Engine (`py/vader_sentiment_engine.py`)
This standalone script showcases how the pipeline hooks your custom internet-culture slang configurations into the active VADER processing memory cache before mapping vectorized token lookups across your live text dataframe rows:

```python
import pandas as pd
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# 1. Initialize your local NLP engine
analyzer = SentimentIntensityAnalyzer()

# 2. Update the lexicon cache with your custom reality TV internet slang weights
slang_lexicon_patch = {
    'flex': 3.5,
    'magic': 3.0,
    'melanin': 2.0,
    'ate': 3.5,
    'crumbs': -1.0,
    'baddie': 2.5,
    'it-girl': 3.5,
    'meta-humor': 2.5,
    'skepticism': -0.5,
    'awe': 3.5
}
analyzer.lexicon.update(slang_lexicon_patch)

# 3. Define your vectorized mapping function to extract isolated sentiment scores
def extract_vader_scores(row):
    text = str(row['raw_consumer_text'])
    scores = analyzer.polarity_scores(text)
    return pd.Series({
        'positive_score': scores['pos'],
        'neutral_score': scores['neu'],
        'compound_score': scores['compound']
    })

# 4. Simultaneously compute and drop metrics across all 16 multi-season rows
df[['positive_score', 'neutral_score', 'compound_score']] = df.apply(extract_vader_scores, axis=1)
```
--

## 🏛️ Cloud Warehouse Integration: Google BigQuery Window Functions
Following live programmatic scoring, the cleaned campaign dataset is migrated into the `birmingham_health_core` dataset environment. A non-correlated CTE deploys a `RANK() OVER()` window partition to dynamically compute localized competitor standings by vertical:

```sql
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
```

## 🎯 Key Analytical Warehouse Insights
*   🥇 **Shark Beauty (#1 Hair Tools):** Captured an undisputed peak compound sentiment ranking of **`0.8860`** driven by extensive community support for natural hair charisma.
*   🥈 **NYX Professional Makeup (#2 Cosmetics):** Correctly calculated a slight negative compound lean of **`-0.1280`** alongside a high neutral density of **`0.8890`**. This reflects accurate machine tracking of intense Reddit skepticism regarding reality TV relationship PR campaigns.

## 📊 Business Intelligence Performance Dashboards (Tableau Desktop)

### 📈 1. Consumer Sentiment Volume Matrix (Scatter Analysis)
This multi-dimensional cross-plot charts positive audience distribution metrics against neutral evaluation clusters, mapping independent color spectral arrays to distinct industry marketing verticals. High-impact engagement anomalies (such as Shark Beauty's extreme positivity mapping and NYX Professional Makeup's dense neutrality clustering) are instantly isolated.

![Consumer Sentiment Volume Matrix](case_studies/consumer_sentiment_volume_matrix.png)

### 📋 2. Categorical Sentiment Leaderboard (Dynamic Ranks)
This pane-isolated operational view visually details the results of the backend BigQuery non-correlated partition functions. Campaigns are dynamically segmented and sorted by compound weight scales to provide real-time competitor tracking models across cosmetics, hair care, and beverage categories.

![Categorical Sentiment Leaderboard](case_studies/categorical_sentiment_leaderboard.png)

