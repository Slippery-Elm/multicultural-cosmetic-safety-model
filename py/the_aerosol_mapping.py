import pandas as pd
import numpy as np

def calculate_aerosol_exposure_risk(row):
    """
    Calculates cumulative toxicological risk scores for media-audited cosmetic formulations.
    Applies a strict 2.2 Risk Multiplier if aerosol delivery triggers tissue occlusion bounds.
    """
    try:
        # Standardize and isolate updated product and delivery columns
        product_name = str(row.get('product_name', '')).strip().lower()
        delivery_mechanism = str(row.get('delivery_mechanism', '')).strip().lower()
        
        # Extract numeric formulation concentration bounds
        base_concentration = float(row.get('formulation_concentration', 0.0))
        absorption_index = float(row.get('tissue_absorption_index', 1.0))
        
        # Null-guard and bounds validation to insulate database corruption
        if pd.isna(base_concentration) or base_concentration <= 0.0:
            return 0.0
            
        # Target compound logic loop (Scanning real product matrices for silicone vectors)
        # Identifies setting sprays, freeze sprays, sunscreens, and body oils
        if any(keyword in product_name for keyword in ['setting', 'spray', 'freeze', 'sunscreen', 'sunblock', 'oil']):
            if 'aerosol' in delivery_mechanism:
                # Apply high-vulnerability multi-factor risk multiplier for pressurized delivery
                calculated_score = (base_concentration * absorption_index) * 2.2
                return round(calculated_score, 4)
            
        # Default safety baseline calculation for standard mechanical pump sprays
        return round(base_concentration * absorption_index, 4)
        
    except (ValueError, TypeError) as system_error:
        # Prevent silent database corruption by routing exceptions to error logging channels
        print(f"[PIPELINE RUNTIME EXCEPTION] Ingestion failure on record row: {system_error}")
        return -1.0


# EXECUTION COMPONENT: LOADING DATASET & POPULATING RISK SCORES

# 1. Load downloaded CSV data file into a Pandas DataFrame
df = pd.read_csv('aerosol_tracking.csv')

# 2. Run the risk calculation function row-by-row across the table
df['dynamic_exposure_score'] = df.apply(calculate_aerosol_exposure_risk, axis=1)

# 3. Sort dataset from highest risk to lowest risk
df_sorted = df.sort_values(by='dynamic_exposure_score', ascending=False)

# 4. Display fully populated table on screen
df_sorted
