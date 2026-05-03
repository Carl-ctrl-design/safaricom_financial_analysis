-- ============================================================
-- FILE: 03_data_notes.sql
-- PURPOSE: Document all data anomalies and accounting changes
-- ============================================================

INSERT INTO safaricom_data_notes 
    (fiscal_year, field_affected, note_type, description, impact_direction)
VALUES

(2015, 'total_assets', 'MISSING_DATA',
 'Total assets not available in condensed press commentary format. Full balance sheet available in FY15 Annual Report if needed.',
 'UNKNOWN'),

(2016, 'total_assets', 'MISSING_DATA',
 'Total assets not available in condensed press commentary format.',
 'UNKNOWN'),

(2019, 'service_revenue', 'ACCOUNTING_CHANGE',
 'FY19 transition year for IFRS 15. IAS 18 basis used for comparability with FY15-FY18. IFRS 15 service revenue was KShs 237,400M vs IAS 18 KShs 240,300M.',
 'UNDERSTATED'),

(2020, 'profit_before_tax', 'ONE_OFF',
 'PBT includes KShs 3,300M gain on acquisition of M-PESA brand (JV share). Normalised PBT = KShs 102,470M. Distorts PAT growth trend.',
 'OVERSTATED'),

(2020, 'total_borrowings', 'ACCOUNTING_CHANGE',
 'IFRS 16 adopted from 1 April 2019. Lease liabilities now recognised on balance sheet. lease_liabilities column populated from FY20.',
 'OVERSTATED'),

(2021, 'voice_revenue', 'RESTATEMENT',
 'From FY21 Safaricom aligned to Vodafone Group reporting format. Voice revenue excludes incoming voice (now in mobile_incoming_revenue). Messaging excludes bulk/incoming SMS. Mobile data excludes visitor data. Creates false cliff in voice trend FY20-FY21.',
 'UNDERSTATED'),

(2021, 'mpesa_revenue', 'ONE_OFF',
 'M-PESA revenue declined 2.1% YoY — only decline since M-PESA launch. Caused by government-mandated zero-rating of P2P transactions April-December 2020 during COVID.',
 'UNDERSTATED'),

(2022, 'capex', 'ONE_OFF',
 'Capex KShs 137,346M includes KShs 96,300M Ethiopia telecommunications licence acquisition. Recurring capex was approximately KShs 41,000M. Distorts capex trend significantly.',
 'OVERSTATED'),

(2023, 'profit_before_tax', 'ACCOUNTING_CHANGE',
 'PBT exceeds EBIT due to KShs 10,383M hyperinflationary monetary gain from Ethiopia (IAS 29). Not an operating gain — Ethiopia declared hyperinflationary economy from December 2022.',
 'OVERSTATED'),

(2024, 'depreciation', 'ONE_OFF',
 'Depreciation jumped to KShs 82,948M vs KShs 54,865M in FY23 — driven by accelerated amortisation of Ethiopia intangible assets. Suppresses EBIT margin significantly in FY24.',
 'OVERSTATED'),

(2025, 'profit_after_tax', 'ACCOUNTING_CHANGE',
 'Group PAT (45,757M) significantly below Kenya-only PAT (95,471M) due to Ethiopia losses of KShs 49,774M absorbed at group level.',
 'UNDERSTATED');