-- ============================================================
-- SAFARICOM FINANCIAL DASHBOARD DATABASE
-- Schema Version 1.0
-- All monetary values in KShs Millions
-- Fiscal year = year ending 31 March (e.g. 2025 = FY ending 31 March 2025)
-- ============================================================

-- TABLE 1: Core financials
CREATE TABLE safaricom_financials (
    fiscal_year             SMALLINT        PRIMARY KEY,
    
    -- Income Statement
    voice_revenue           NUMERIC(12,1),
    mobile_incoming_revenue NUMERIC(12,1),   -- separate from FY21 reclassification
    mpesa_revenue           NUMERIC(12,1),
    mobile_data_revenue     NUMERIC(12,1),
    messaging_revenue       NUMERIC(12,1),
    fixed_revenue           NUMERIC(12,1),
    other_service_revenue   NUMERIC(12,1),
    service_revenue         NUMERIC(12,1),
    handset_other_revenue   NUMERIC(12,1),
    total_revenue           NUMERIC(12,1),
    direct_costs            NUMERIC(12,1),
    ecl_expense             NUMERIC(12,1),   -- NULL for FY15-FY19
    ebitda                  NUMERIC(12,1),
    depreciation            NUMERIC(12,1),
    ebit                    NUMERIC(12,1),
    net_finance_cost        NUMERIC(12,1),   -- positive = cost, negative = income
    profit_before_tax       NUMERIC(12,1),
    income_tax              NUMERIC(12,1),
    profit_after_tax        NUMERIC(12,1),
    
    -- Balance Sheet
    total_assets            NUMERIC(12,1),   -- NULL for FY15-FY16 (not in press release)
    total_equity            NUMERIC(12,1),
    total_borrowings        NUMERIC(12,1),   -- bank debt only, excludes lease liabilities
    lease_liabilities       NUMERIC(12,1),   -- NULL pre-IFRS16 (FY15-FY19)
    cash                    NUMERIC(12,1),
    
    -- Cash Flow
    operating_cash_flow     NUMERIC(12,1),
    capex                   NUMERIC(12,1),
    free_cash_flow          NUMERIC(12,1),
    
    -- Accounting basis flags
    ifrs16_applied          BOOLEAN         DEFAULT FALSE,
    revenue_reclassified    BOOLEAN         DEFAULT FALSE,  -- TRUE from FY21
    data_quality            VARCHAR(10)     DEFAULT 'VERIFIED'
                            CHECK (data_quality IN ('VERIFIED','ESTIMATED','PARTIAL'))
);

-- TABLE 2: Revenue detail (for Page 2 of dashboard)
CREATE TABLE safaricom_revenue_detail (
    fiscal_year             SMALLINT        REFERENCES safaricom_financials(fiscal_year),
    segment                 VARCHAR(20)     CHECK (segment IN ('KENYA','ETHIOPIA','GROUP')),
    voice_revenue           NUMERIC(12,1),
    mpesa_revenue           NUMERIC(12,1),
    mobile_data_revenue     NUMERIC(12,1),
    messaging_revenue       NUMERIC(12,1),
    fixed_revenue           NUMERIC(12,1),
    other_revenue           NUMERIC(12,1),
    service_revenue         NUMERIC(12,1),
    PRIMARY KEY (fiscal_year, segment)
);

-- TABLE 3: Data notes (exceptions, anomalies, sources)
CREATE TABLE safaricom_data_notes (
    note_id                 SERIAL          PRIMARY KEY,
    fiscal_year             SMALLINT        REFERENCES safaricom_financials(fiscal_year),
    field_affected          VARCHAR(50),
    note_type               VARCHAR(20)     CHECK (note_type IN (
                                'ONE_OFF','RESTATEMENT','ACCOUNTING_CHANGE',
                                'MISSING_DATA','ESTIMATION','SEGMENT_CHANGE')),
    description             TEXT,
    impact_direction        VARCHAR(10)     CHECK (impact_direction IN (
                                'OVERSTATED','UNDERSTATED','NEUTRAL','UNKNOWN')),
    created_at              TIMESTAMP       DEFAULT NOW()
);

-- TABLE 4: M-PESA sub-revenue detail (FY22-FY25)
CREATE TABLE safaricom_mpesa_detail (
    fiscal_year             SMALLINT        REFERENCES safaricom_financials(fiscal_year),
    consumer_payments       NUMERIC(12,1),
    withdrawals             NUMERIC(12,1),
    business_payments       NUMERIC(12,1),
    global_payments         NUMERIC(12,1),
    financial_services      NUMERIC(12,1),
    total_mpesa_revenue     NUMERIC(12,1),
    PRIMARY KEY (fiscal_year)
);