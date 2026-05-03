-- ============================================================
-- FILE: 05_analytical_queries.sql
-- PURPOSE: Business insight queries for portfolio demonstration
--          and Page 5 dashboard narrative (Insights & Recommendations)
-- These queries answer real questions a CFO would ask
-- ============================================================

-- ============================================================
-- QUERY 2: Profitability trend and margin compression analysis
-- Business question: Is Safaricom becoming more or less
-- profitable as it scales? Where is margin pressure coming from?
-- ============================================================
SELECT
    fiscal_year,
    total_revenue,
    ebitda,
    ebit,
    profit_after_tax,
    ROUND((ebitda / NULLIF(total_revenue,0)) * 100, 1)
        AS ebitda_margin,
    ROUND((ebit / NULLIF(total_revenue,0)) * 100, 1)
        AS ebit_margin,
    ROUND((profit_after_tax / NULLIF(total_revenue,0)) * 100, 1)
        AS pat_margin,
    -- Depreciation as % of revenue — rising = capex catching up
    ROUND((depreciation / NULLIF(total_revenue,0)) * 100, 1)
        AS depreciation_intensity,
    -- Direct cost efficiency
    ROUND((direct_costs / NULLIF(service_revenue,0)) * 100, 1)
        AS direct_cost_ratio
FROM safaricom_financials
ORDER BY fiscal_year;


-- The Headline: Reported margin compression is an "Ethiopia Accounting Story," not a failure of the core Kenya business.

-- Peak Efficiency (FY2015–2020): EBITDA margins expanded from 43.6% to 52.6%.

-- The Ethiopia Shock (FY2022–2023): EBIT margin dropped from 36.6% to 27.3% in a single year.

-- Crucial Insight: This wasn't a trading failure. It was caused by accelerated depreciation and amortization of Ethiopia’s license and network assets.

-- The FY2024 Trough: Group PAT (Profit After Tax) margins hit a low of 12.2% due to peak Ethiopia startup losses.

-- Recovery (FY2025): Direction has reversed; EBITDA margins are recovering to 44.3% as Ethiopia’s initial write-downs moderate.