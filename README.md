# Multicultural Cosmetic Safety Index (MCSI) & Risk Transformation Model💄

## 📖 Project Overview
This repository contains a full-stack data project that evaluates, transforms, and analyzes the public health impacts of toxic cosmetic compounds and textile chemicals on sensitive and multicultural skin types. Grounded in public health behavior frameworks (MPH), this project bridges environmental toxicology and modern data infrastructure to dynamically score product safety metrics.

## 🛠️ Technical Stack
* **Data Engineering / Storage:** Google BigQuery, SQL (ETL processing, data modeling, schema design)
* **Data Analytics / Logic:** Python (Pandas, NumPy for data manipulation, algorithmic risk scoring)
* **Business Intelligence / Visualization:** Tableau (Executive dashboard creation, risk segmentation mapping)

## 🚀 Core Analytical Features
*   **Cross-Border Regulatory Analytics (SQL):** Utilized advanced SQL Window Functions (`PARTITION BY`, `DENSE_RANK`) inside Google BigQuery to segment and rank chemical hazards across international regulatory frameworks (FDA vs. EU vs. AfCFTA).
*   **Advanced Predictive Risk Weighting (Python):** Developed a multi-factor risk matrix using Pandas and NumPy to dynamically calculate safety scores based on chemical toxicity, exposure types, and skin-barrier vulnerabilities.
*   **Product Ingredient Scanner (Python):** Built an algorithmic text-parsing tool that accepts unstructured ingredient lists, cross-references them with the transformed database, and outputs a personalized Multicultural Safety Report.

## ⚙️ Data Architecture & ETL Pipeline
* **Ingestion:** Extracted raw chemical hazard datasets, global regulatory statuses (FDA vs. EU), and chronic skin condition triggers into a unified master database.
* **Transformation (SQL):** Developed complex SQL queries inside **Google BigQuery** using Common Table Expressions (CTEs) and conditional logic (CASE WHEN) to clean records, handle missing toxicity inputs, and segment high-risk compound anomalies.
* **Algorithmic Calculation (Python):** Processed the data frame through **Pandas** to calculate a multi-factor risk matrix. The algorithm multiplies base toxicity weights against application types (leave-on vs. rinse-off) and skin-barrier vulnerabilities to generate an output safety score from 1 to 100.

## 📊 Business Questions Answered
* Which cosmetic chemical classes pose the highest physiological risk to populations managing chronic atopic dermatitis or lichen planus?
* What are the primary regulatory discrepancies where toxic compounds are restricted globally but remain unregulated locally?
