# Multicultural Cosmetic Safety Index (MCSI) & Risk Transformation Model💄

## 📖 Project Overview
This repository contains a full-stack data project that evaluates, transforms, and analyzes the public health impacts of toxic cosmetic compounds and textile chemicals on sensitive and multicultural skin types. Grounded in public health behavior frameworks (MPH), this project bridges environmental toxicology and modern data infrastructure to score product safety metrics dynamically.

## 🛠️ Technical Stack
* **Data Engineering / Storage:** Google BigQuery, SQL (ETL processing, production schema layout, data modeling, multi-dataset integration)
* **Data Analytics / Logic:** Python 3.10+ (Pandas, NumPy for vectorized array processing, automated try-except exception handling, Natural Language Processing (NLP) text-parsing engines)
* **Business Intelligence / Visualization:** Tableau Desktop / Tableau Public Server (Executive dashboard design, dynamic parameter filter controls, risk segmentation mapping)

## 🚀 Core Analytical Features
*   **Cross-Border Regulatory Analytics (SQL):** Utilized advanced SQL Window Functions (`PARTITION BY`, `DENSE_RANK`) inside Google BigQuery to segment and rank chemical hazards across international regulatory frameworks (FDA vs. EU).
*   **Advanced Predictive Risk Weighting (Python):** Developed a multi-factor risk matrix using Pandas and NumPy to dynamically calculate safety scores based on chemical toxicity, exposure types, and skin-barrier vulnerabilities.
*   **Product Ingredient Scanner (Python):** Built an algorithmic text-parsing tool that accepts unstructured ingredient lists, cross-references them with the transformed database, and outputs a personalized Multicultural Safety Report.
* **Product Ingredient Scanner (Python):** Built an algorithmic text-parsing tool that accepts unstructured ingredient lists, cross-references them with the transformed database, and outputs a personalized Multicultural Safety Report.
*   **🎮 Interactive Simulation Engine & Visual Dashboard:** Access the complete, live execution environment straight through our scrollable Jupyter Notebook to run the custom [NumPy Toxicological Exposure Game Engine & Seaborn Correlation Heatmap](./notebooks/mcsi_model_calculation.ipynb).
  
---

## 📂 Portfolio Case Study Index

### 🔹 Case Study 1: The Liquid Gloss Preservative & Stability Paradox — 20-Product Audit
*   **Core Infrastructure:** Google BigQuery (SQL Window Functions, `DENSE_RANK`, `PARTITION BY`, multi-dataset schema mapping).
*   **Domain Focus:** Cross-Border Regulatory Analytics executing a comprehensive toxicological audit of 20 commercial lip gloss formulations. Segments and ranks chemical preservative discrepancies, stability paradoxes, and hazardous compound concentrations across international regulatory frameworks (FDA vs. European Union).

### 🔹 Case Study 2: Love Island Influencer Syndication & VADER Sentiment Pipeline
*   **Core Infrastructure:** Python (Pandas data orchestration, VADER Sentiment Intensity Analyzer, social text tokenization processing).
*   **Domain Focus:** Public Health Communication and Media Informatics monitoring fan reception, engagement health indicators, and audience sentiment trends surrounding strategic brand deals driven by five key breakout stars (Olandria, Chelley, JaNa, etc.).

### 🔹 Case Study 3: Leave-On Aerosol Silicone Exposure Pipeline & Media-Audited Toxicological Risk Cascade
*   **Core Infrastructure:** Python Ingestion, Google BigQuery Data Warehouse, Tableau Public Parameterized Matrix.
*   **Domain Focus:** Public Health Informatics and Cosmetovigilance tracking proprietary leave-on silicone resins (*Trimethylsiloxysilicate*) via a chronological media audit model of **Seasons 6 & 7 of Love Island USA**. Maps regulatory safety ceilings with a calibrated **2.2 aerosol multiplier** to monitor skin occlusion risks.

---

## ⚙️ Data Architecture & Core ETL Pipeline
* **Ingestion:** Extracted raw chemical hazard datasets, global regulatory statuses (FDA vs. EU), and unstructured social media interaction streams surrounding key digital creators into a unified data ecosystem.
* **Transformation (SQL):** Developed complex SQL queries inside **Google BigQuery** using Common Table Expressions (CTEs) and conditional logic (`CASE WHEN`) to clean records, handle missing inputs, and isolate data corruption across localized dataset clusters.
* **Algorithmic Calculation & NLP Processing (Python):** Processed text blocks through **VADER Sentiment layers** to quantify positive, neutral, and negative compound scores from raw digital responses. The algorithm handles exception traps natively to protect downstream dashboards from string-parsing execution failures.

---

## 📊 Business Questions Answered
* What are the primary regulatory discrepancies where toxic cosmetic compounds are restricted globally but remain unregulated locally?
* How do community sentiment, public safety reception, and audience brand velocity respond when high-profile commercial influencers announce beauty-sector syndication partnerships?
* How can public health informaticists model real-world exposure limits when commercial manufacturers treat chemical formulation concentrations as proprietary trade secrets?
