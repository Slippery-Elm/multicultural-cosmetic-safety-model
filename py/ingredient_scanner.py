# =========================================================================
# ⚙️ MULTICULTURAL COSMETICS SAFETY INDEX (MCSI) - INGREDIENT SCANNER UTILITY
# =========================================================================
import pandas as pd

# 1. DATA INTAKE: Stream your master 30-compound dataset directly over the web
GITHUB_RAW_URL = "https://raw.githubusercontent.com/Slippery-Elm/multicultural-cosmetic-safety-model/refs/heads/main/data/toxic_compounds_master.csv"
master_df = pd.read_csv(GITHUB_RAW_URL)

# Normalize the data frame columns instantly to strip hidden spaces
master_df.columns = master_df.columns.str.strip().str.lower()

# Compute the engineered risk scores automatically in memory
master_df['composite_risk_score'] = master_df['toxicity_score_ewg'] * master_df['risk_weight_multiplier']

# 2. RUNTIME ENGINE: Core execution logic to ingest and parse consumer labels
def run_ingredient_scanner():
    print("\n=========================================================")
    print("=== 🌍 MCSI MULTICULTURAL INGREDIENT SCANNER INTERFACE ===")
    print("=========================================================")
    
    # Ingest raw label text copied straight off a consumer bottle
    raw_user_input = input("Paste product ingredients list here: ")
    
    if not raw_user_input.strip():
        print("❌ Error: Ingredient input cannot be empty.")
        return
        
    # Clean the input text string and split it into an uppercase searchable array
    cleaned_ingredients = [ing.strip().lower() for ing in raw_user_input.split(",")]
    
    print("\n🕵🏾‍♀️ CROSS-REFERENCING MASTER INDEX DATA LINES...")
    found_any = False
    
    for ingredient in cleaned_ingredients:
        # Check if the user's ingredient matches any chemical_name in our memory DataFrame
        match = master_df[master_df['chemical_name'].str.lower() == ingredient]
        
        if not match.empty:
            found_any = True
            # Extract raw metrics directly using clear array indexing
            chem_id = match['chemical_id'].values[0]
            chem_name = match['chemical_name'].values[0]
            composite_score = match['composite_risk_score'].values[0]
            interaction = match['melanin_interaction'].values[0]
            trigger = match['chronic_skin_trigger'].values[0]
            framework = match['behavioral_intervention_framework'].values[0]
            
            # Print out the customized multicultural safety report card text block
            print(f"\n🚨 WARNING ALERT: High-Risk Compound Detected [{chem_id}]")
            print(f"• Compound Name: {chem_name}")
            print(f"• Composite Risk Index Score: {composite_score:.2f}")
            print(f"• Melanin Interaction Mode: {interaction}")
            print(f"• Chronic Skin Trigger Profile: {trigger}")
            print(f"• Behavioral Intervention Strategy: {framework}")
            print("---------------------------------------------------------")
            
    if not found_any:
        print("\n✅ SCAN COMPLETE: Zero MCSI-listed toxic compounds or heavy metals detected in this ingredient deck.")

# This execution block allows the script to run seamlessly from your command line terminal
if __name__ == "__main__":
    run_ingredient_scanner()

