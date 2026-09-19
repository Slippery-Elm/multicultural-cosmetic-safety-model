import pandas as pd
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

# Your exact verified Google Sheet ID
SHEET_ID = "1S-MaUYM54ztOBw-rZkmKxSzH0LAPaFjJe4Der5Rl4jc"
# Your exact tab name
SHEET_NAME = "fact_viral_marketing_trends"

# This URL forces Google Sheets to stream your live data tab as an automatic CSV stream
url = f"https://docs.google.com/spreadsheets/d/{SHEET_ID}/gviz/tq?tqx=out:csv&sheet={SHEET_NAME}"

# Stream the table straight into your active pandas DataFrame
df = pd.read_csv(url)

# 1. Clean the staging dataframe structure natively
df = df[['trend_id', 'brand_partner', 'campaign_type', 'placement_driver', 'raw_consumer_text']].dropna(subset=['raw_consumer_text'])

# 2. Instantiate and permanently patch the analyzer BEFORE the execution loop
analyzer = SentimentIntensityAnalyzer()

slang_lexicon_patch = {
    'flex': 3.5, 'magic': 3.0, 'melanin': 2.0, 'ate': 3.5, 'crumbs': -1.0,
    'baddie': 2.5, 'it-girl': 3.5, 'meta-humor': 2.5, 'skepticism': -0.5, 'awe': 3.5
}
analyzer.lexicon.update(slang_lexicon_patch)

# 3. Define the metrics logic referencing the pre-patched cache
def get_vader_metrics(text):
    text_str = str(text)
    polarity = analyzer.polarity_scores(text_str)
    return pd.Series([polarity['pos'], polarity['neu'], polarity['compound']])

# 4. Simultaneously score all 16 multi-season rows
df[['positive_score', 'neutral_score', 'compound_score']] = df['raw_consumer_text'].apply(get_vader_metrics)

print("🎯 Pipeline complete: All 16 records scored with permanent slang logic constraints!")
df.head(16)
