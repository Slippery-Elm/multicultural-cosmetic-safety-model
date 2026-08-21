# Multicultural Cosmetic Safety Index (MCSI) - Execution Board 👩🏾‍💻

## Phase 1: Data Curation & Toxicological Ontology 🧪
- [ ] Research and extract 30 target compounds across 5 ingredient classes
- [ ] Map EU vs. FDA regulatory status codes (EC No 1223/2009 vs. FD&C Act)
- [ ] Export sanitized dataset as `toxic_compound_master.csv`

## Phase 2: Cloud Warehousing (BigQuery DDL/DML) ☁️
- [ ] Execute `sql/database_setup.sql` DDL schema script
- [ ] Ingest `toxic_compound_master.csv` into `cosmetic_safety` dataset
- [ ] Run DML standardization audit for casing and NULL handling

## Phase 3: Analytical Window Functions & Gap Analytics (DQL) 🪟
- [ ] Draft DQL script into a new tab on Google BigQuery
- [ ] Run the script using your CTEs, CASE WHEN, and PARTITION BY
- [ ] Save the resulting clean query table into `regulatory_analytics.sql`

## Phase 4: Python Integration and Risk Visualization ⚠️
- [ ] Connect Google Colab to BigQuery using the `google-cloud-bigquery` client library
- [ ] Extract this SQL view directly into a `pandas` DataFrame
- [ ] Use `seaborn` and `matplotlib` to build a multi-variable scatter plot or heat map 
