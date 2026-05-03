# Safaricom PLC Financial Performance Analysis
## SQL Data Engineering & Analytics Portfolio Project

**Author:** Carl Waiti  
**Tools:** PostgreSQL 17, pgAdmin 4  
**Data Source:** Safaricom PLC Audited Results Booklets & Press Commentaries (FY2015–FY2025)  
**Status:** Complete — connected to Power BI dashboard (see Project 4b)

---

## Project Overview

This project builds a clean, analysis-ready financial database from 
10 years of Safaricom PLC primary source financial statements. 
Raw data was extracted manually from audited PDF documents published 
on Safaricom's investor relations page, transformed using PostgreSQL, 
and loaded into a structured schema that powers a Power BI executive 
dashboard.

This is not a Kaggle dataset project. Every number traces back to 
a specific page of a specific audited document.

---

## Business Context

Safaricom PLC is Kenya's largest telecommunications company and the 
operator of M-PESA, Africa's leading mobile money platform. The company 
is listed on the Nairobi Securities Exchange (NSE: SCOM) and reports 
under IFRS in KShs Millions.

The dataset covers FY2015 to FY2025 (fiscal years ending 31 March), 
capturing the full transformation of Safaricom from a voice-led telco 
to a purpose-led technology company — including the launch of M-PESA 
as a dominant revenue driver, the COVID-19 impact year (FY2021), and 
the ongoing Ethiopia expansion from FY2022.

---

## Key Findings

- Service revenue grew at a **9.0% CAGR** over 10 years 
  (KShs 156.3Bn → KShs 371.4Bn)
- M-PESA revenue compounded at **17.3% CAGR**, nearly double 
  overall revenue growth
- M-PESA overtook voice as the primary revenue driver in **FY2019**
- Free cash flow grew at **12.6% CAGR** 
  (KShs 27.5Bn → KShs 89.9Bn)
- EBIT margin remained stable at ~27% despite Ethiopia expansion drag
- FY2021 was the only down year in the dataset — COVID-driven 
  M-PESA revenue decline of 2.1% due to government-mandated 
  zero-rating of P2P transactions

---

## Database Schema
safaricom_financials      — Core annual P&L, balance sheet, cash flow
safaricom_revenue_detail  — Segment breakdown Kenya vs Ethiopia
safaricom_data_notes      — Anomaly flags and accounting change log
safaricom_mpesa_detail    — M-PESA sub-revenue detail (FY2022–FY2025)

**Views (Power BI connects to these):**
vw_annual_performance     — KPIs and calculated margins
vw_yoy_growth             — Year-on-year growth rates
vw_revenue_breakdown      — Revenue mix with % contributions

---

## File Structure
safaricom-financial-analysis/
├── schema/
│   └── 01_create_tables.sql       Schema definition
├── data/
│   └── 02_insert_data.sql         All 11 years of financial data
├── cleaning/
│   └── 03_data_notes.sql          Data anomaly documentation
├── views/
│   └── 04_create_views.sql        Analytical views for Power BI
├── analysis/
│   └── 05_analytical_queries.sql  Business insight queries
└── README.md                      This file

---

## Key Accounting Notes

| Issue | Years Affected | Treatment |
|---|---|---|
| Billions to Millions conversion | FY2015–FY2019 | Multiplied by 1,000 |
| IFRS 15 transition | FY2019 | IAS 18 basis used for comparability |
| IFRS 16 lease adoption | FY2020+ | Lease liabilities separated |
| Revenue reclassification | FY2021+ | Vodafone Group format adopted |
| Ethiopia hyperinflation (IAS 29) | FY2023+ | Flagged in data notes |
| FY2022 capex spike | FY2022 | Ethiopia licence KShs 96.3Bn one-off |
| COVID M-PESA decline | FY2021 | Zero-rated P2P transactions Apr–Dec 2020 |

---

## How to Reproduce

1. Install PostgreSQL 17 and pgAdmin 4
2. Create database: `safaricom_dashboard`
3. Run scripts in order: 01 → 02 → 03 → 04 → 05
4. Connect Power BI Desktop via PostgreSQL connector
5. Import the three views as separate tables

---

## Connected Project

**Project 4b — Power BI Dashboard:**  
[Link to Power BI repo — add when published]

---

## Data Sources

All data extracted from primary source documents published at:  
https://www.safaricom.co.ke/investor-relations-landing/reports/financial-report/financial-results

Documents used:
- FY2025 Results Booklet (audited, Ernst & Young LLP)
- FY2024 Results Booklet
- FY2023 Results Booklet
- FY2022 Results Booklet
- FY2021 Results Booklet
- FY2020 Results Booklet
- FY2019 Press Commentary
- FY2018 Press Commentary
- FY2017 Press Commentary
- FY2016 Press Commentary (contains FY2015 comparatives)