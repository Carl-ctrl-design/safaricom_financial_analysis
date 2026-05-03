# Safaricom PLC Financial Performance Analysis
## SQL Data Engineering & Analytics Portfolio Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-blue)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Data](https://img.shields.io/badge/Data-Primary%20Source-orange)
![Years](https://img.shields.io/badge/Coverage-FY2015--FY2025-purple)

> **This is not a Kaggle dataset project.**  
> Every number in this database traces back to a specific page  
> of a specific audited document published by Safaricom PLC.

---

## Project Overview

This project builds a clean, analysis-ready financial database from
10 years of Safaricom PLC primary source financial statements,
then runs 6 analytical SQL queries answering questions a CFO would
actually ask. Raw data was manually extracted from audited PDF
Results Booklets published on Safaricom's investor relations page,
transformed using PostgreSQL 17, and loaded into a structured
relational schema that powers a connected Power BI executive
dashboard.

The result is a complete financial intelligence pipeline:
Audited PDF Documents (Safaricom IR Page)
↓
Manual Data Extraction
(11 years × 30+ financial metrics)
↓
PostgreSQL 17 Database
(4 tables, 3 analytical views)
↓
6 Business Insight Queries
(Revenue, Margins, M-PESA, Capital,
Ethiopia, 10-Year Scorecard)
↓
Power BI Executive Dashboard
(Project 4b — see connected repo)

---

## Business Context

Safaricom PLC is Kenya's largest telecommunications company and
the operator of M-PESA, Africa's leading mobile money platform.
Listed on the Nairobi Securities Exchange (NSE: SCOM), the company
reports under IFRS in KShs Millions with fiscal years ending
31 March.

This dataset covers FY2015 to FY2025 — capturing the full
transformation of Safaricom from a voice-led telco to a
purpose-led technology company. The decade includes:

- The rise of M-PESA from growth product to dominant revenue driver
- COVID-19 impact year (FY2021) — the only revenue decline in the dataset
- Ethiopia greenfield expansion from FY2022 — Africa's most ambitious
  telco expansion in a generation
- Four major accounting standard transitions (IFRS 15, IFRS 16,
  IAS 29 hyperinflation, Vodafone Group format adoption)

---

## Key Findings

| Metric | FY2015 | FY2025 | 10-Year CAGR |
|---|---|---|---|
| Service Revenue | KShs 156.3Bn | KShs 371.4Bn | **9.0%** |
| M-PESA Revenue | KShs 32.6Bn | KShs 161.1Bn | **17.3%** |
| EBIT | KShs 45.6Bn | KShs 104.1Bn | **8.6%** |
| Free Cash Flow | KShs 27.5Bn | KShs 89.9Bn | **12.6%** |
| EBITDA Margin | 43.6% | 44.3% | Stable |

**Five headline insights from the analysis:**

**1. M-PESA overtook Voice as primary revenue driver in FY2019.**
M-PESA compounded at 17.3% CAGR — nearly double overall revenue
growth. By FY2025 M-PESA and Data combined represent 64.5% of
service revenue. Voice has shrunk from 55.9% to 22.1% share.

**2. Reported margin compression is an Ethiopia accounting story,
not a trading failure.**
EBIT margin dropped from 36.6% to 27.3% in FY2022-FY2024.
The cause was accelerated depreciation of Ethiopia licence and
network assets — not Kenya operational deterioration. Kenya
standalone profitability remained strong throughout.

**3. FY2021 was the only revenue decline year — and it was
policy-driven.**
M-PESA revenue fell 2.1% due to government-mandated zero-rating
of P2P transactions April–December 2020 during COVID-19. This
was a regulatory intervention, not a competitive or structural
problem.

**4. Safaricom funded Ethiopia without diluting shareholders.**
Even at peak Ethiopia spending (FY2022 capex of KShs 137.3Bn
including KShs 96.3Bn licence), Debt-to-EBITDA reached only
0.66x — extremely conservative by global telco standards.
No rights issue was required.

**5. FCF conversion is the highest it has ever been.**
Despite absorbing KShs 49.8Bn of Ethiopia losses at group level
in FY2025, free cash flow conversion hit 52.2% of EBITDA —
the best in the dataset. The underlying Kenya cash engine has
never been stronger.

---

## Database Schema

### Tables

**`safaricom_financials`** — Core annual financials (PRIMARY TABLE)
11 rows × 30 columns covering full P&L, balance sheet, and cash
flow statement. Includes accounting basis flags for IFRS transitions.

**`safaricom_revenue_detail`** — Segment breakdown
Kenya vs Ethiopia vs Group revenue lines from FY2022 when segment
reporting became mandatory.

**`safaricom_data_notes`** — Anomaly and accounting change log
11 documented notes covering one-offs, restatements, accounting
changes, and missing data — with impact direction flags.
This table is what separates professional data work from amateur
data work.

**`safaricom_mpesa_detail`** — M-PESA sub-revenue (FY2022–FY2025)
Consumer payments, withdrawals, business payments, global
payments, and financial services breakdown.

### Analytical Views (Power BI connects to these)

**`vw_annual_performance`** — Primary KPI view
All P&L, balance sheet, and cash flow lines plus 10 calculated
metrics: EBITDA margin, EBIT margin, net profit margin, direct
cost ratio, M-PESA share, data share, voice share, net debt,
net debt-to-EBITDA, FCF conversion, capex intensity.

**`vw_yoy_growth`** — Year-on-year growth rates
Calculates YoY growth for all major lines in SQL using LAG()
joins — revenue, profitability, cash flow, and margin changes
in percentage points. Logic is version-controlled, tested, and
documented rather than delegated to DAX.

**`vw_revenue_breakdown`** — Revenue mix evolution
Absolute values and percentage share of service revenue for
every revenue line across all 11 years. Powers the revenue
transformation story on Page 2 of the dashboard.

---

## Analytical Queries

6 queries answering real CFO-level business questions:

### Query 1 — Revenue Transformation Story
**Business question:** How has Safaricom shifted from a
voice-dependent telco to a fintech-led business?

Tracks voice, M-PESA, and data share of service revenue across
all 11 years. Identifies the exact inflection point when M-PESA
overtook voice. Uses CASE WHEN to label each year's revenue
leader dynamically.

**Finding:** M-PESA officially crossed voice in FY2019. By FY2025
the transformation is structural and irreversible.

---

### Query 2 — Profitability and Margin Compression Analysis
**Business question:** Is Safaricom becoming more or less
profitable as it scales?

Calculates EBITDA, EBIT, and PAT margins across all years plus
depreciation intensity and direct cost ratio to isolate the
source of any margin pressure.

**Finding:** Core EBITDA margins expanded from 43.6% to 52.6%
between FY2015 and FY2020. Post-FY2022 compression is entirely
explained by Ethiopia depreciation — not operating deterioration.

---

### Query 3 — M-PESA Deep Dive
**Business question:** What is M-PESA's CAGR and what does
its trajectory mean for the business?

Uses LAG() window function and POWER() function to calculate
rolling YoY growth, 10-year CAGR from FY2015 base, and revenue
multiple versus the base year.

**Finding:** 17.3% CAGR over 10 years. Current growth driven by
business payments (Pochi la Biashara, B2B merchant services)
as P2P matures. M-PESA is evolving from transfer tool to
business platform.

---

### Query 4 — Capital Efficiency Analysis
**Business question:** Is Safaricom deploying capital efficiently?

Calculates capex intensity, return on equity, FCF yield on equity,
and cash conversion ratio. Flags the FY2022 Ethiopia licence as
a one-off to prevent distortion of the efficiency trend.

**Finding:** Pre-Ethiopia ROE peaked at 51.5% in FY2021 —
exceptional by any standard. FCF conversion reached 52.2% in
FY2025 despite absorbing Ethiopia losses.

---

### Query 5 — Ethiopia Drag Analysis
**Business question:** How much is Ethiopia costing the group
and is the trajectory improving?

Joins financials with data_notes to surface one-off flags.
Calculates net debt, gross debt-to-EBITDA, and approximates
Kenya standalone PAT from FY2022 onwards using segment
disclosures.

**Finding:** Ethiopia absorbed KShs 49.8Bn of group profits in
FY2025. Break-even guided for March 2027. Once reached, group
profitability is expected to surge materially.

---

### Query 6 — 10-Year Growth Scorecard
**Business question:** What is the executive summary of
Safaricom's decade performance?

Uses CTE pattern with endpoint anchoring to calculate total
growth, 10-year CAGR, and margin comparison between FY2015
and FY2025 for every major metric in a single result set.

**Finding:** 9.0% service revenue CAGR. 17.3% M-PESA CAGR.
12.6% FCF CAGR. Funded a continent-scale expansion using
internal cash flow. The Kenya business is the strongest it
has ever been.

---

## Accounting Transparency

This project documents every accounting complexity that affects
comparability across the 11-year dataset. A full log lives in
`safaricom_data_notes`. Key issues:

| Issue | Years | Treatment |
|---|---|---|
| Billions to Millions conversion | FY2015–FY2019 | Multiplied ×1,000 |
| IFRS 15 transition | FY2019 | IAS 18 basis used for comparability |
| IFRS 16 lease adoption | FY2020+ | Lease liabilities separated |
| Vodafone Group format adoption | FY2021+ | Creates false cliff in voice trend |
| M-PESA brand acquisition gain | FY2020 | KShs 3.3Bn one-off — flagged |
| COVID M-PESA zero-rating | FY2021 | Policy-driven decline — flagged |
| Ethiopia licence capex spike | FY2022 | KShs 96.3Bn one-off — separated |
| Ethiopia hyperinflation (IAS 29) | FY2023+ | Monetary gain flagged |
| Ethiopia losses absorbed | FY2025 | KShs 49.8Bn group PAT drag |

Ignoring these issues would produce misleading trend analysis.
Documenting them is what turns data processing into financial
analysis.

---

## File Structure
safaricom-financial-analysis/
├── schema/
│       └── 01_create_tables.sql      Table definitions
├── data/
│       └── 02_insert_data.sql        11 years of financial data
├── cleaning/
│       └── 03_data_notes.sql         Anomaly documentation
├── views/
│       └── 04_create_views.sql       3 analytical views
├── analysis/
│       └── 05_analytical_queries.sql 6 business insight queries
└── README.md

---

## How to Reproduce

```sql
-- 1. Install PostgreSQL 17 and pgAdmin 4
-- 2. Create the database
CREATE DATABASE safaricom_dashboard;

-- 3. Run scripts in order
-- schema/01_create_tables.sql
-- data/02_insert_data.sql
-- cleaning/03_data_notes.sql
-- views/04_create_views.sql
-- analysis/05_analytical_queries.sql

-- 4. Connect Power BI Desktop
-- Host: localhost
-- Port: 5432
-- Database: safaricom_dashboard
-- Import the three views as separate tables
```

---

## Data Sources

All data extracted from primary source documents:

**Source:** Safaricom PLC Investor Relations  
**URL:** https://www.safaricom.co.ke/investor-relations-landing/reports/financial-report/financial-results  
**Auditor:** Ernst & Young LLP (FY2020–FY2025)

Documents used:
- FY2025 Results Booklet (audited)
- FY2024 Results Booklet (audited)
- FY2023 Results Booklet (audited)
- FY2022 Results Booklet (audited)
- FY2021 Results Booklet (audited)
- FY2020 Results Booklet (audited)
- FY2019 Press Commentary
- FY2018 Press Commentary
- FY2017 Press Commentary
- FY2016 Press Commentary (contains FY2015 comparatives)

---

## Connected Project

**Project 4b — Power BI Financial Dashboard**  
This SQL database is the data foundation for a connected
Power BI executive dashboard covering revenue transformation,
profitability trends, M-PESA growth, capital efficiency,
and strategic recommendations.

[Link to Power BI repository — add when published]

---

## Portfolio Context

This is the fourth project in a structured data analytics
portfolio built toward a remote Data Analyst career:

| # | Project | Tools |
|---|---|---|
| 1 | Superstore Sales Analysis | Excel, PivotTables, KPI Dashboard |
| 2 | Olist E-Commerce SQL Analysis | PostgreSQL 17, CTEs, Window Functions |
| 3 | Olist Power BI Dashboard | Power BI, DAX, PostgreSQL live connection |
| **4a** | **Safaricom Financial Analysis** | **PostgreSQL 17, Primary Source Data** |
| 4b | Safaricom Power BI Dashboard | Power BI, DAX (in progress) |

---

## Author

**Carl Waiti**  
BSc Economics and Finance — Kenyatta University (Final Year)  
Google Data Analytics Professional Certificate

GitHub: [Carl-ctrl-design](https://github.com/Carl-ctrl-design)  
Portfolio: [carl-ctrl-design.github.io/C.Waiti](https://carl-ctrl-design.github.io/C.Waiti/)
