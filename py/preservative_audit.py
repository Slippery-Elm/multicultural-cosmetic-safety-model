import pandas as pd

# 1. Read local file into the exact variable your functions are expecting
# Replace this filename if the actual file name has different spaces/dashes!
df_audit = pd.read_csv('synthetic preservative audit matrix.csv')

# 2. Define established Public Health Exposure parameters
FRAGRANCE_ALLERGENS = ['Linalool', 'Limonene', 'Citronellol']
ALLERGEN_PENALTY = 10   # points deducted per detected allergen when paired with Phenoxyethanol
BHT_FAIL_SCORE = 0

def calculate_mcsi_metrics(row):
    """
    Public Health Exposure Decision Engine — 3-Tiered Outcome Model
    """
    ingredients = str(row['Primary Stabilizer / Preservative System'])

    # Tier 1: explicit, non-negotiable fail
    if 'BHT' in ingredients:
        return pd.Series({'mcsi_score': BHT_FAIL_SCORE, 'mcsi_status': 'HIGH-RISK MISMATCH (FAIL)'})

    # Tier 2: cumulative allergen penalty
    allergens_detected = [a for a in FRAGRANCE_ALLERGENS if a in ingredients]
    if 'Phenoxyethanol' in ingredients and allergens_detected:
        score = max(0, 100 - (ALLERGEN_PENALTY * len(allergens_detected)))
        return pd.Series({'mcsi_score': score, 'mcsi_status': 'CONDITIONAL WARNING'})

    # Tier 3: clean pass
    return pd.Series({'mcsi_score': 100, 'mcsi_status': 'SAFE (PASS)'})

# 3. Simultaneously map the calculation across the uploaded matrix rows
df_audit[['mcsi_score', 'mcsi_status']] = df_audit.apply(calculate_mcsi_metrics, axis=1)

# 4. Display the confirmed metrics summary!
print("📋 Case Study 1 Tier Validation Counts:")
print(df_audit['mcsi_status'].value_counts())
print("\n")
df_audit[['brand', 'product_name', 'mcsi_score', 'mcsi_status']].head(16)
