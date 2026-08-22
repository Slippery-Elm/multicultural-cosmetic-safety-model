# Multicultural Cosmetic Safety Index (MCSI): Database Schema & Analysis

This document contains the core SQL used to build and query the MCSI toxic compound database, written in **Google BigQuery Standard SQL**. It follows the standard three-part SQL workflow: define the table structure (DDL), clean and standardize the data (DML), then analyze it (DQL).

---

## DDL: Table Schema

This creates the master table that holds every tracked compound. Each column includes an inline description using BigQuery's `OPTIONS()` syntax, which self-documents the schema directly in BigQuery rather than relying on a separate document to explain what each field means. `cas_number` (the compound's Chemical Abstracts Service Registry Number) is used as the primary identifier rather than an arbitrary ID, since it's the real-world standardized way chemicals are referenced in regulatory and scientific contexts. `melanin_interaction` and `chronic_skin_trigger` are included specifically because they're central to the "multicultural" focus of this index — general hazard scores alone don't capture how a compound's effects can vary across skin types.

```sql
CREATE OR REPLACE TABLE cosmetic_safety.toxic_compound_master (
    cas_number STRING OPTIONS(description="Chemical Abstracts Service Unique Registry Number"),
    chemical_name STRING OPTIONS(description="Standardized INCI Name"),
    chemical_class STRING OPTIONS(description="Functional Category: Preservative, Dye, Metal, etc."),
    ewg_hazard_score INT64 OPTIONS(description="Environmental Working Group Score 1-10"),
    melanin_interaction STRING OPTIONS(description="Known interaction effects with melanin-rich skin"),
    chronic_skin_trigger STRING OPTIONS(description="Association with chronic skin conditions (e.g., lichen planus, eczema)"),
    regulatory_status_eu STRING OPTIONS(description="SCCS Status: Banned, Restricted, Allowed"),
    regulatory_status_fda STRING OPTIONS(description="FDA Status: Prohibited, Restricted, Unregulated"),
    risk_weight_multiplier FLOAT64 OPTIONS(description="Quantitative Disparity Weight"),
    primary_health_concern STRING OPTIONS(description="Endocrine Disruptor, Carcinogen, Allergen")
);
```

---

## DML: Data Cleaning & Standardization

Real-world entries are rarely consistent — text fields get entered in different cases, and some fields may be left blank. These two statements standardize casing across text fields (so later comparisons in the DQL section actually match correctly) and fill in a sensible default for any missing risk weight, rather than leaving it null and breaking downstream calculations.

```sql
-- Standardize text casing across string attributes so later queries match consistently
UPDATE cosmetic_safety.toxic_compound_master
SET
    chemical_name = INITCAP(TRIM(chemical_name)),
    chemical_class = INITCAP(TRIM(chemical_class)),
    regulatory_status_eu = UPPER(TRIM(regulatory_status_eu)),
    regulatory_status_fda = UPPER(TRIM(regulatory_status_fda))
WHERE cas_number IS NOT NULL;

-- Default missing risk weight multipliers to 1.0 (neutral weight) rather than leaving them null
UPDATE cosmetic_safety.toxic_compound_master
SET risk_weight_multiplier = 1.0
WHERE risk_weight_multiplier IS NULL;
```

**Why `UPPER()` for regulatory status but `INITCAP()` for names?** Regulatory status values (`BANNED`, `RESTRICTED`, `UNREGULATED`) are treated like fixed category codes, so making them fully uppercase keeps every comparison in the DQL section predictable. Chemical names and classes, on the other hand, are meant to be human-readable in a report or dashboard, so `INITCAP()` (proper case) is the better fit there.
