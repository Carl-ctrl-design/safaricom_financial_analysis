-- ============================================================
-- FILE: 04_create_views.sql
-- PURPOSE: Analytical views for Power BI connection
-- These views are what Power BI imports — never the raw tables
-- ============================================================

-- VIEW 1: Main annual performance view
-- This is the primary view Power BI uses for all KPI cards,
-- trend charts, and margin analysis
CREATE OR REPLACE VIEW vw_annual_performance AS
SELECT
    f.fiscal_year,
    
    -- Revenue lines
    f.voice_revenue,
    f.mobile_incoming_revenue,
    f.mpesa_revenue,
    f.mobile_data_revenue,
    f.messaging_revenue,
    f.fixed_revenue,
    f.other_service_revenue,
    f.service_revenue,
    f.total_revenue,
    
    -- Cost lines
    f.direct_costs,
    f.ecl_expense,
    f.ebitda,
    f.depreciation,
    f.ebit,
    f.net_finance_cost,
    f.profit_before_tax,
    f.income_tax,
    f.profit_after_tax,
    
    -- Balance sheet
    f.total_assets,
    f.total_equity,
    f.total_borrowings,
    f.lease_liabilities,
    f.cash,
    
    -- Cash flow
    f.operating_cash_flow,
    f.capex,
    f.free_cash_flow,
    
    -- Calculated margins (rounded to 1 decimal place)
    ROUND((f.ebitda / NULLIF(f.total_revenue, 0)) * 100, 1)
        AS ebitda_margin_pct,
    ROUND((f.ebit / NULLIF(f.total_revenue, 0)) * 100, 1)
        AS ebit_margin_pct,
    ROUND((f.profit_after_tax / NULLIF(f.total_revenue, 0)) * 100, 1)
        AS net_profit_margin_pct,
    ROUND((f.direct_costs / NULLIF(f.service_revenue, 0)) * 100, 1)
        AS direct_cost_ratio_pct,
    ROUND((f.mpesa_revenue / NULLIF(f.service_revenue, 0)) * 100, 1)
        AS mpesa_share_of_service_pct,
    ROUND((f.mobile_data_revenue / NULLIF(f.service_revenue, 0)) * 100, 1)
        AS data_share_of_service_pct,
    ROUND((f.voice_revenue / NULLIF(f.service_revenue, 0)) * 100, 1)
        AS voice_share_of_service_pct,
    
    -- Net debt (positive = net debt, negative = net cash)
    ROUND((f.total_borrowings - f.cash), 1)
        AS net_debt,
    ROUND(((f.total_borrowings - f.cash) / NULLIF(f.ebitda, 0)), 2)
        AS net_debt_to_ebitda,
    
    -- Free cash flow conversion
    ROUND((f.free_cash_flow / NULLIF(f.ebitda, 0)) * 100, 1)
        AS fcf_conversion_pct,
    
    -- Capex intensity
    ROUND((f.capex / NULLIF(f.total_revenue, 0)) * 100, 1)
        AS capex_intensity_pct,
    
    -- Accounting flags
    f.ifrs16_applied,
    f.revenue_reclassified,
    f.data_quality

FROM safaricom_financials f;


-- VIEW 2: Year-on-year growth rates
-- Power BI can calculate YoY in DAX but doing it in SQL
-- means the logic is documented, tested, and version controlled
CREATE OR REPLACE VIEW vw_yoy_growth AS
SELECT
    curr.fiscal_year,
    
    -- Revenue growth rates
    ROUND(((curr.service_revenue - prev.service_revenue)
        / NULLIF(prev.service_revenue, 0)) * 100, 1)
        AS service_revenue_growth_pct,
    ROUND(((curr.total_revenue - prev.total_revenue)
        / NULLIF(prev.total_revenue, 0)) * 100, 1)
        AS total_revenue_growth_pct,
    ROUND(((curr.mpesa_revenue - prev.mpesa_revenue)
        / NULLIF(prev.mpesa_revenue, 0)) * 100, 1)
        AS mpesa_growth_pct,
    ROUND(((curr.mobile_data_revenue - prev.mobile_data_revenue)
        / NULLIF(prev.mobile_data_revenue, 0)) * 100, 1)
        AS mobile_data_growth_pct,
    ROUND(((curr.voice_revenue - prev.voice_revenue)
        / NULLIF(prev.voice_revenue, 0)) * 100, 1)
        AS voice_growth_pct,
    ROUND(((curr.fixed_revenue - prev.fixed_revenue)
        / NULLIF(prev.fixed_revenue, 0)) * 100, 1)
        AS fixed_revenue_growth_pct,
        
    -- Profitability growth rates
    ROUND(((curr.ebitda - prev.ebitda)
        / NULLIF(prev.ebitda, 0)) * 100, 1)
        AS ebitda_growth_pct,
    ROUND(((curr.ebit - prev.ebit)
        / NULLIF(prev.ebit, 0)) * 100, 1)
        AS ebit_growth_pct,
    ROUND(((curr.profit_after_tax - prev.profit_after_tax)
        / NULLIF(prev.profit_after_tax, 0)) * 100, 1)
        AS pat_growth_pct,
    
    -- Cash flow growth
    ROUND(((curr.free_cash_flow - prev.free_cash_flow)
        / NULLIF(prev.free_cash_flow, 0)) * 100, 1)
        AS fcf_growth_pct,
    
    -- Margin changes (in percentage points)
    ROUND(
        ((curr.ebitda / NULLIF(curr.total_revenue, 0)) * 100) -
        ((prev.ebitda / NULLIF(prev.total_revenue, 0)) * 100)
    , 1) AS ebitda_margin_change_ppt,
    ROUND(
        ((curr.ebit / NULLIF(curr.total_revenue, 0)) * 100) -
        ((prev.ebit / NULLIF(prev.total_revenue, 0)) * 100)
    , 1) AS ebit_margin_change_ppt,
    ROUND(
        ((curr.profit_after_tax / NULLIF(curr.total_revenue, 0)) * 100) -
        ((prev.profit_after_tax / NULLIF(prev.total_revenue, 0)) * 100)
    , 1) AS net_margin_change_ppt

FROM safaricom_financials curr
LEFT JOIN safaricom_financials prev
    ON prev.fiscal_year = curr.fiscal_year - 1;


-- VIEW 3: Revenue breakdown with percentage contributions
-- Powers the revenue mix charts on Page 2 of the dashboard
CREATE OR REPLACE VIEW vw_revenue_breakdown AS
SELECT
    fiscal_year,
    service_revenue,
    
    -- Absolute values
    voice_revenue,
    mobile_incoming_revenue,
    mpesa_revenue,
    mobile_data_revenue,
    messaging_revenue,
    fixed_revenue,
    other_service_revenue,
    
    -- Share of service revenue (%)
    ROUND((voice_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS voice_pct,
    ROUND((mpesa_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS mpesa_pct,
    ROUND((mobile_data_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS data_pct,
    ROUND((messaging_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS messaging_pct,
    ROUND((fixed_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS fixed_pct,
    ROUND((other_service_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS other_pct,
    
    -- Non-voice revenue total and share
    ROUND((mpesa_revenue + mobile_data_revenue + fixed_revenue)
        / NULLIF(service_revenue,0) * 100, 1)
        AS non_voice_core_pct

FROM safaricom_financials
ORDER BY fiscal_year;