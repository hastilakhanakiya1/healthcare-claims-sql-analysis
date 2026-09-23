# Healthcare Claims SQL Analysis

## Project Overview

This project simulates a healthcare insurance claims analysis workflow using SQL.

The goal is to analyze synthetic member, eligibility, provider, and claims data to identify claim denial patterns, validate member eligibility, calculate claims KPIs, evaluate provider-level trends, and perform basic data-quality checks.

All data used in this project is fictional and was created specifically for portfolio and SQL practice purposes.

## Business Questions

The analysis focuses on the following questions:

1. Was each member eligible for coverage on the date of service?
2. What are the primary reasons for claim denials?
3. What percentage of claims were denied?
4. Which providers have the highest denial rates?
5. What dollar amount is associated with denied claims?
6. Are there records that may require additional data-quality review?

## Database Structure

The project uses four relational tables:

- **Members** – Member demographic information
- **Eligibility** – Coverage start/end dates and plan type
- **Providers** – Provider type, location, and network status
- **Claims** – Service dates, claim amounts, claim status, and denial reasons

The tables are connected using `member_id` and `provider_id`.

## SQL Skills Demonstrated

- SELECT statements
- INNER JOINs
- CASE expressions
- WHERE filtering
- GROUP BY
- ORDER BY
- COUNT and SUM
- Percentage calculations
- Relational data analysis
- Eligibility validation
- Claims KPI analysis
- Data-quality checks

## Key Findings

The synthetic dataset contains 8 claims with a total submitted claim amount of **$7,705**.

- 4 claims were approved
- 3 claims were denied
- 1 claim was pending
- The dataset denial rate was **37.5%**

### Eligibility Finding

One claim occurred after the member's coverage had ended.

The member's coverage ended on **August 31, 2026**, while the service occurred on **September 10, 2026**. The claim was appropriately recorded as denied for member ineligibility.

### Denial Analysis

Two claims were denied because of the project's simplified out-of-network rule, representing **$1,825** in submitted claim amounts.

One eligibility-related denial represented **$2,100**.

This demonstrates why both denial frequency and associated dollar value are useful when analyzing claims.

### Provider Analysis

In this synthetic dataset, the out-of-network specialist provider had 2 claims and both were denied, producing a **100% denial rate within the sample**.

Because this is a small synthetic dataset, these percentages should not be interpreted as real-world healthcare benchmarks.

## Data Quality Validation

Rule-based SQL checks were used to compare claim outcomes against eligibility dates, network status, and denial-reason completeness.

The current synthetic records were consistent with the simplified business rules defined for this project.

> Note: Out-of-network services are not universally denied in real healthcare claims processing. Coverage depends on plan benefits and other factors. Network status is used here as a simplified portfolio-project rule.

## Project Files

- `01_database_setup.sql` – Creates the tables and loads synthetic data
- `02_claims_analysis.sql` – Contains eligibility, denial, KPI, provider, and data-quality analysis

## Tools

- SQL
- SQLite
- DB Fiddle
- GitHub

## Future Enhancements

Future versions could include:

- Larger synthetic claims datasets
- Procedure and diagnosis codes
- Claim processing turnaround analysis
- Monthly denial trends
- Provider performance metrics
- Data visualization using Power BI or Tableau
