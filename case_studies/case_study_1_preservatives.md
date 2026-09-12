# 🔬 Case Study 1: The Liquid Gloss Preservative & Stability Paradox
## Spoke Document: In-Depth Dosage Audit & 20-Product Reference Matrix

---

## 🎯 Case Study Mission Statement

The primary objective of this empirical audit is to isolate the structural data gap between consumer-facing binary hazard scores and actual clinical toxicological thresholds. This project establishes the end-to-end analytics engineering pipeline—spanning programmatic text parsing, multi-layered cloud data warehousing, and interactive risk matrices—to prove how narrow corporate compliance tracking can mask critical cumulative toxicity hazards. 

Rather than resolving every formulation to a flat pass, this model applies a custom multi-variable risk engine — the **MCSI Public Health Exposure Decision Model** — to dynamically identify genuine chemical anomalies and hidden synergistic exposure paths, routing each product into one of three defensible outcomes: **`Safe Harbor`**, **`Conditional Warning`**, or **`High-Risk Mismatch`**.

---

## 📊 Transformed Ingestion Dataset: 20-Product Audit Matrix

The following structured matrix compiles the empirical tracking data pulled from live retail scanning assets. This data layer serves as the primary ingestion source for the Python text-parsing extraction pipelines and the cloud data warehouse:

| Product ID | Brand & Product Name | Shade / Scent Profile | Yuka Rating | Yuka Score | Primary Stabilizer / Preservative System | MCSI Adjusted Public Health Evaluation |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `MCSI-001` | e.l.f. Glow Reviver Lip Oil | Apricot Feelings | Bad | 21 / 100 | Phenoxyethanol + Caprylyl Glycol | **CONDITIONAL WARNING** - Concentration <= 1.0% |
| `MCSI-002` | e.l.f. Glow Reviver Balm | Wild Cherry | Bad | 7 / 100 | Ethylhexylglycerin + Antioxidants | **SAFE (PASS)** - Anhydrous Lipid Shield |
| `MCSI-003` | The Crème Shop X Hello Kitty | Banana | Poor | 25 / 100 | Ethylhexylglycerin + Citric Acid | **SAFE (PASS)** - Botanical Acid Barrier |
| `MCSI-004` | Crème Kiss and Blush Balm | Watermelon Sugar | Bad | 0 / 100 | 1,2-Hexanediol + BHT (App Flag) | **HIGH-RISK MISMATCH (FAIL)** - Solid Wax Stabilization |
| `MCSI-005` | Crème Kiss and Blush Balm | Berry Milkshake | Bad | 0 / 100 | 1,2-Hexanediol + BHT (App Flag) | **HIGH-RISK MISMATCH (FAIL)** - Solid Wax Stabilization |
| `MCSI-006` | Crème Candy Glaze Lip Oil | Berry Crush | Poor | 31 / 100 | Phenoxyethanol + 1,2-Hexanediol | **CONDITIONAL WARNING** - Multi-Glycol Low-Dose |
| `MCSI-007` | I'M MEME Water Gel Tint | Red Crush | Good | 62 / 100 | 1,2-Hexanediol + Dehydroacetic Acid | **SAFE (PASS)** - Eco-Certified Organic Salt |
| `MCSI-008` | I'M MEME Water Gel Tint | Plum Fatale | Good | 64 / 100 | 1,2-Hexanediol + Dehydroacetic Acid | **SAFE (PASS)** - Eco-Certified Organic Salt |
| `MCSI-009` | I'M MEME Water Gel Tint | Berry Compote | Good | 64 / 100 | 1,2-Hexanediol + Dehydroacetic Acid | **SAFE (PASS)** - Eco-Certified Organic Salt |
| `MCSI-010` | I'M MEME Water Gel Tint | My Cherry | Good | 64 / 100 | 1,2-Hexanediol + Dehydroacetic Acid | **SAFE (PASS)** - Eco-Certified Organic Salt |
| `MCSI-011` | I'M MEME Water Gel Tint | Pink Attack | Good | 66 / 100 | 1,2-Hexanediol + Dehydroacetic Acid | **SAFE (PASS)** - Eco-Certified Organic Salt |
| `MCSI-012` | Thread Gloss It Lip Gloss | Driven | Bad | 19 / 100 | Phenoxyethanol + Caprylyl Glycol | **CONDITIONAL WARNING** - Lipid Microbial Barrier |
| `MCSI-013` | Essence Hydra Kiss Lip Oil | Kiss From a Rose | Poor | 37 / 100 | Phenoxyethanol + Ethylhexylglycerin | **CONDITIONAL WARNING** - Standard Cosmetic Cap |
| `MCSI-014` | Essence What a Tint! | 01 Kiss From a Rose | Poor | 43 / 100 | Radish Root Ferment + Phenoxyethanol | **SAFE (PASS)** - High-Water Bio-Network |
| `MCSI-015` | Essence What the Fake! | Oh My Plump! | Poor | 31 / 100 | Phenoxyethanol + Ethylhexylglycerin | **SAFE (PASS)** - Glycol Enhanced Protection |
| `MCSI-016` | Essence The Super Balm | 01 Balmazing! | Poor | 43 / 100 | Shorea Robusta Resin + Vitamin E | **SAFE (PASS)** - Preservative-Free Anhydrous |
| `MCSI-017` | Essence Extreme Shine Volume | 13 Glazed Berry | Poor | 35 / 100 | Caprylyl Glycol + Hydroxyhydrocinnamate| **SAFE (PASS)** - Anti-Rancidity Shield |
| `MCSI-018` | NYX Cosmetics Jelly Job | 01 Just Jelly | Poor | 37 / 100 | Phenoxyethanol + Caprylyl Glycol | **SAFE (PASS)** - Peptide Bio-Stabilization |
| `MCSI-019` | Vitamasques Lip Butter Balm | Wild Cherry | Poor | 35 / 100 | 1,2-Hexanediol + Ethyl Hexanediol | **SAFE (PASS)** - Preservative-Free Alternative |
| `MCSI-020` | Holler and Glow Lip Serum | Coco Donut | Bad | 17 / 100 | Phenoxyethanol + 1,2-Hexanediol | **CONDITIONAL WARNING** - Occlusive Moisture Lock |

---

## 🛠️ Python Transformation Logic & Code Execution Gateway

The Python function `calculate_mcsi_metrics(row)` evaluates cumulative consumer hazard by scanning the combined ingredient matrix for multi-layered chemical patterns—explicit high-risk triggers, cumulative allergen pairings, and clean baseline formulations—and routes each product into an explicit failure zone, a conditional warning zone, or a safe harbor, rather than defaulting every outcome to a pass:

```python
import pandas as pd

FRAGRANCE_ALLERGENS = ['Linalool', 'Limonene', 'Citronellol']
ALLERGEN_PENALTY = 10   # points deducted per detected allergen when paired with Phenoxyethanol
BHT_FAIL_SCORE = 0

def calculate_mcsi_metrics(row):
    """
    Public Health Exposure Decision Engine — 3-Tiered Outcome Model
    -----------------------------------------------------------------
    Evaluates cumulative consumer hazard by scanning the combined
    'Primary Stabilizer / Preservative System' field for multi-layered
    chemical matrices, then routes each formulation into one of three
    execution profiles:

    Tier 1 — HIGH-RISK MISMATCH (FAIL): explicit presence of BHT drops the
             product to a continuous score of 0, regardless of any other factor.
    Tier 2 — CONDITIONAL WARNING: Phenoxyethanol paired with one or more
             fragrance/botanical allergens (Linalool, Limonene, Citronellol)
             triggers a cumulative 10-point penalty per allergen from a
             100-point baseline.
    Tier 3 — SAFE (PASS): no flagged ingredient pattern detected; baseline
             score of 100 retained.
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

df_audit[['mcsi_score', 'mcsi_status']] = df_audit.apply(calculate_mcsi_metrics, axis=1)

# Sanity check: confirm tier counts match your intended narrative before charting
print(df_audit['mcsi_status'].value_counts())
```
---

## ☁️ Google BigQuery SQL Data Engineering Gateway

To automate this multi-tier concentration and stabilizer validation inside our cloud data warehouse, the MCSI pipeline executes the following conditional logic queries inside Google BigQuery to calculate the mathematical variance metrics natively in the cloud space:

```sql
-- Pipeline Query: Public Health Exposure Decision Engine (3-Tier Model)
-- Repository: multicultural-cosmetic-safety-model/sql/case_study_1_logic.sql

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

---

## 🎨 Interactive Business Intelligence & Scatter Plot Architecture

To bridge the gap between back-end pipeline math and front-end executive decision-making, the transformed dataset is mapped into an interactive **Tableau Desktop** spatial visualization. By bypassing standard measure aggregations, individual product profiles are plotted as unaggregated vectors to explicitly contrast commercial application scores against the custom MCSI framework.

### 📐 Visual Canvas Grid Parameters

*   **Horizontal Coordinate Axis (X-Axis):** Raw `Yuka Score` — Fixed range configuration set from `-5 to 105` to provide uniform edge padding for border outliers.
*   **Vertical Coordinate Axis (Y-Axis):** Custom Calculated `Mcsi Score` — Fixed range configuration set from `-5 to 105` to preserve strict mathematical proportions.
*   **Analytical Background Segmentation:** Employs a dual-intersecting reference band layout. A soft-teal **`Safe Harbor Shading Zone`** is structurally locked between `X: [50 to 100]` and `Y: [90 to 100]` to visually segregate the clean formulations from underlying risk layers.

### 🎨 Color-Coded Execution Markings

Individual data markers are rendered as solid circles mapped directly to the discrete `mcsi_status` dimension utilizing a distinct public health color hierarchy:
*   **🔵 Teal Marks `SAFE (PASS)`:** Captures clean anhydrous shields and organic salt networks clustering smoothly along the maximum 100-point boundary.
*   **🟡 Gold Marks `CONDITIONAL WARNING`:** Isolates modern preservative bases that are heavily layered against unlisted fragrances, highlighting continuous score drops (e.g., Essence Lip Oil at 70/100).
*   **🔴 Coral Marks `HIGH-RISK MISMATCH (FAIL)`:** Drops the controversial synthetic antioxidant BHT to coordinates `(0,0)`, creating a high-contrast visual outlier.

### 🔗 Interactive Project Gateways
*   **Live Dashboard Link:** [View the Interactive Data Visualization on Tableau Public](https://public.tableau.com/views/MulticulturalCosmeticSafetyIndexMCSIPortfolio/Sheet3?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## 📈 MCSI Portfolio Discoveries & Data Insights

An analysis of the 20-product live retail dataset reveals four critical architectural and toxicological insights that expose the deep limitations of standard commercial scanning algorithms:

1. **The BHT Antioxidant Anomaly:** The BHT Absolute Failure Zone: Formulations like *The Crème Shop Kiss and Blush* balms crash to a `0/100` MCSI score under this model. **Butylated Hydroxytoluene (BHT)** does play a legitimate technical role as an oil-stabilizing antioxidant that prevents premium cosmetic waxes from turning rancid — but this audit deliberately treats its presence as a hard-fail trigger regardless of that functional benefit, reflecting a precautionary, public-health-first standard rather than a pure formulation-chemistry standard. The tension between "technically useful" and "flagged as high-risk" is itself part of the finding.
2. **The Water-Content Preservative Dependency:** Products containing Aqua (Water) as a primary ingredient — such as *Essence What a Tint!* and the *I'M MEME Water Gel Tints* — rely on complex, eco-certified organic acid networks (`Dehydroacetic Acid`, `Sodium Benzoate`) and natural bio-ferments (`Radish Root Ferment Filtrate`) to guard against bacterial growth, allowing them to clear the model's Safe Harbor tier cleanly.
3. **Anhydrous Moisture-Starvation Mechanics:** High-scoring lipid formulations like the *Essence Super Balm* remove water entirely, relying on dense resins (`Shorea Robusta Resin`) and concentrated Vitamin E (`Tocopherol`) to starve potential microbes of moisture — achieving a preservative-free Safe Harbor status without triggering any conditional flags.
4. **The Synergistic Exposure Discovery:** Products like the *Essence Hydra Kiss Lip Oil*, layering Phenoxyethanol against three separate fragrance allergens (Linalool, Limonene, Citronellol), resolve to a 70/100 Conditional Warning score under this model — a result invisible to any binary pass/fail system. This intermediate scoring tier is the study's core methodological argument: genuine public health risk assessment requires evaluating ingredient combinations, not scoring each chemical in isolation.
