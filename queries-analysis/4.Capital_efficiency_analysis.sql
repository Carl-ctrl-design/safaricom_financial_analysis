-- ============================================================
-- QUERY 4: Capital efficiency analysis
-- Business question: Is Safaricom deploying capital efficiently?
-- Are shareholders getting good returns on invested capital?
-- ============================================================
SELECT
    fiscal_year,
    capex,
    total_revenue,
    ebitda,
    free_cash_flow,
    total_equity,
    -- Capex intensity (lower = more efficient)
    ROUND((capex / NULLIF(total_revenue,0)) * 100, 1)
        AS capex_intensity_pct,
    -- Return on equity
    ROUND((profit_after_tax / NULLIF(total_equity,0)) * 100, 1)
        AS roe_pct,
    -- FCF yield on equity
    ROUND((free_cash_flow / NULLIF(total_equity,0)) * 100, 1)
        AS fcf_yield_pct,
    -- Cash conversion: how much EBITDA becomes free cash
    ROUND((free_cash_flow / NULLIF(ebitda,0)) * 100, 1)
        AS cash_conversion_pct,
    -- Flag the FY22 Ethiopia capex anomaly
    CASE
        WHEN fiscal_year = 2022
        THEN 'ETHIOPIA LICENCE — ONE OFF'
        ELSE 'RECURRING'
    END AS capex_type
FROM safaricom_financials
ORDER BY fiscal_year;

-- The Headline: Safaricom remains world-class in capital discipline, despite the massive Ethiopia license investment.

-- Pre-Ethiopia Efficiency: Capex intensity fell to 13.2% by FY2021, while ROE (Return on Equity) peaked at a massive 51.5%.

-- The FY2022 Anomaly: Capex intensity spiked to 46.1% due to the Ethiopia license fee (KShs 96.3Bn).

-- Free Cash Flow (FCF): Despite the investment, FCF conversion hit its highest level ever in FY2025 (52.2%), proving the cash-generative power of the Kenya operation.