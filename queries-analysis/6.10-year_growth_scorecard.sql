-- ============================================================
-- QUERY 6: 10-year growth scorecard
-- Business question: What is the summary performance of
-- Safaricom over the full decade FY2015 to FY2025?
-- This is your executive summary — the opening slide number
-- ============================================================
WITH endpoints AS (
    SELECT
        MIN(fiscal_year) AS start_year,
        MAX(fiscal_year) AS end_year
    FROM safaricom_financials
),
start_vals AS (
    SELECT * FROM safaricom_financials WHERE fiscal_year = 2015
),
end_vals AS (
    SELECT * FROM safaricom_financials WHERE fiscal_year = 2025
)
SELECT
    '10-Year Growth Scorecard FY2015 to FY2025' AS report_title,
    
    -- Revenue
    sv.service_revenue                          AS fy15_service_rev,
    ev.service_revenue                          AS fy25_service_rev,
    ROUND(((ev.service_revenue - sv.service_revenue)
        / sv.service_revenue) * 100, 1)         AS service_rev_total_growth_pct,
    ROUND((POWER(ev.service_revenue / sv.service_revenue,
        0.1) - 1) * 100, 1)                    AS service_rev_cagr_10yr,
    
    -- M-PESA
    sv.mpesa_revenue                            AS fy15_mpesa,
    ev.mpesa_revenue                            AS fy25_mpesa,
    ROUND((POWER(ev.mpesa_revenue / sv.mpesa_revenue,
        0.1) - 1) * 100, 1)                    AS mpesa_cagr_10yr,
    
    -- Profitability
    sv.ebit                                     AS fy15_ebit,
    ev.ebit                                     AS fy25_ebit,
    ROUND((POWER(ev.ebit / sv.ebit,
        0.1) - 1) * 100, 1)                    AS ebit_cagr_10yr,
    
    -- Margins then vs now
    ROUND((sv.ebit / sv.total_revenue) * 100, 1)   AS fy15_ebit_margin,
    ROUND((ev.ebit / ev.total_revenue) * 100, 1)   AS fy25_ebit_margin,
    
    -- Free cash flow
    sv.free_cash_flow                           AS fy15_fcf,
    ev.free_cash_flow                           AS fy25_fcf,
    ROUND((POWER(ev.free_cash_flow / sv.free_cash_flow,
        0.1) - 1) * 100, 1)                    AS fcf_cagr_10yr

FROM start_vals sv, end_vals ev;


-- Revenue: 9% overall CAGR.
-- M-PESA: 17.3% CAGR.

-- Management Quality: Successfully funded a massive greenfield expansion (Ethiopia) using internal cash flow and conservative debt while maintaining Kenya’s market dominance.

-- The Bottom Line: The underlying Kenya business is the strongest it has ever been; Safaricom’s current valuation is essentially a bet on Ethiopia reaching break-even on schedule.
