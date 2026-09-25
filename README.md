# Healthcare Claims SQL Analysis

## Project Overview

This project simulates a healthcare insurance claims analysis workflow using PostgreSQL.

The goal is to analyze synthetic member, provider, and claims data to validate member eligibility, identify denial patterns, evaluate provider and network trends, calculate claims KPIs, and perform basic data-quality checks.

All data used in this project is fictional and was created specifically for portfolio and SQL practice purposes.

## Business Questions

This project answers questions such as:

1. Was each member eligible for coverage on the date of service?
2. What percentage of claims were denied?
3. What were the most common denial reasons?
4. How did denial rates differ between in-network and out-of-network providers?
5. Which providers accounted for the highest total claim amounts?
6. Which providers had the highest denial rates?
7. Were there claims that required data-quality review?
8. Which claims were still pending?

## Database Structure

The project uses three relational tables:

- `members`
- `providers`
- `claims`

The tables are connected using primary and foreign keys.

## SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `COUNT`
- `SUM`
- `ROUND`
- `CASE WHEN`
- Primary keys
- Foreign keys
- Data validation
- Eligibility checks
- Denial analysis
- Provider analysis
- Network analysis
- KPI calculation

## Key Findings

Based on the synthetic sample dataset:

- 8 claims were analyzed.
- Total claim amount was $7,705.
- 4 claims were approved.
- 3 claims were denied.
- 1 claim was pending.
- Overall denial rate was 37.5%.
- Out-of-Network was the most common denial reason.
- Both Out-of-Network claims in the sample were denied.
- One claim was identified where the service date occurred 10 days after member coverage ended.
- Charlotte Medical Center had the highest total claim amount at $5,000 across 3 claims.
- Piedmont Specialist Center had 2 claims, both denied as Out-of-Network.
- Data-quality logic was created to flag denied claims with missing denial reasons and other claim inconsistencies.

Because this is a small synthetic dataset, these findings demonstrate SQL analysis techniques and should not be generalized to real healthcare populations.

## Project Files

### `01_database_setup.sql`
Creates the relational database structure and inserts the synthetic member, provider, and claims data.

### `02_claims_analysis.sql`
Contains SQL for eligibility validation, denial analysis, KPI calculations, provider analysis, and data-quality checks.

### `03_business_insights.sql`
Contains business-focused reporting queries for claims summary, denial rates, provider performance, network analysis, eligibility exceptions, and pending claims.

## Tools Used

- PostgreSQL
- DB Fiddle
- SQL
- Microsoft Excel

## Excel Analysis

The same claims dataset was also analyzed in Excel to create summary metrics and visualizations for:

- Claim status distribution
- Denial reasons
- Network denial rate
- Provider claim amounts
- Provider denial rates
- Eligibility validation

## Portfolio Purpose

This project demonstrates how SQL can be used in a healthcare claims environment to combine relational data, validate business rules, identify data-quality issues, and translate claim-level data into useful business insights.
