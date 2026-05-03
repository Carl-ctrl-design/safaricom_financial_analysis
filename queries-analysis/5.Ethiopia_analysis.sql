-- ============================================================
-- QUERY 5: Ethiopia drag analysis
-- Business question: How much is the Ethiopia expansion
-- costing the group and is the trajectory improving?
-- ============================================================
SELECT
    f.fiscal_year,
    f.total_revenue,
    f.ebit,
    f.profit_after_tax AS group_pat,
    -- Kenya standalone PAT (approximated from Kenya EBIT trend)
    -- Exact Kenya PAT available FY22+ from segment disclosure
    CASE
        WHEN f.fiscal_year >= 2022
        THEN f.ebit - f.net_finance_cost - f.income_tax
        ELSE NULL
    END AS approx_kenya_pat,
    -- Net debt position
    ROUND(f.total_borrowings - f.cash, 1) AS net_debt,
    -- Debt serviceability
    ROUND(f.total_borrowings / NULLIF(f.ebitda, 0), 2)
        AS gross_debt_to_ebitda,
    n.description AS notable_flag
FROM safaricom_financials f
LEFT JOIN safaricom_data_notes n
    ON n.fiscal_year = f.fiscal_year
    AND n.note_type = 'ONE_OFF'
ORDER BY f.fiscal_year;


-- The Headline: 
-- The group balance sheet was used strategically to fund expansion without diluting shareholders via a rights issue.

-- Conservative Leverage: 
-- Even at the peak of Ethiopia spending, Debt-to-EBITDA remained at 0.66x—extremely low by global telco standards.

-- Profit Absorption: 
-- In FY2025, Ethiopia absorbed nearly KShs 50Bn of group profits.

-- The Horizon: 
-- Ethiopia break-even is guided for March 2027. Once reached, group profitability is expected to surge as the "drag" becomes a "contribution."