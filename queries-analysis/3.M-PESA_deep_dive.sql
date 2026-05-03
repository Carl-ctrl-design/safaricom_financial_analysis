-- QUERY 3: M-PESA deep dive — the fintech growth engine
-- Business question: What is M-PESA's compound annual growth
-- rate and what does its trajectory mean for the business?
-- ============================================================
WITH mpesa_growth AS (
    SELECT
        fiscal_year,
        mpesa_revenue,
        LAG(mpesa_revenue) OVER (ORDER BY fiscal_year)
            AS prev_year_mpesa,
        FIRST_VALUE(mpesa_revenue) OVER (ORDER BY fiscal_year)
            AS base_mpesa  -- FY2015 base
    FROM safaricom_financials
)
SELECT
    fiscal_year,
    mpesa_revenue,
    prev_year_mpesa,
    ROUND(((mpesa_revenue - prev_year_mpesa)
        / NULLIF(prev_year_mpesa,0)) * 100, 1)
        AS yoy_growth_pct,
    -- CAGR from FY2015 base
    ROUND((
        POWER(
            (mpesa_revenue / NULLIF(base_mpesa, 0)),
            (1.0 / NULLIF(fiscal_year - 2015, 0))
        ) - 1
    ) * 100, 1) AS cagr_from_fy15_pct,
    -- Multiple on invested base
    ROUND(mpesa_revenue / NULLIF(base_mpesa, 0), 1)
        AS revenue_multiple_vs_fy15
FROM mpesa_growth
ORDER BY fiscal_year;


-- Findings
-- The Headline: A 17.3% CAGR over 10 years has turned a KShs 32.6Bn business into a KShs 161.1Bn powerhouse.

-- Phase 1 (Hypergrowth): Driven by agent scaling and the launch of M-Shwari/KCB M-PESA.

-- Phase 2 (COVID Dip): Only one year of negative growth (-2.1% in FY2021) due to zero-rated P2P transactions.

-- Phase 3 (Business Payments): Current growth is fueled by Pochi la Biashara and B2B merchant services.

-- The Shift: P2P is maturing, but business payments grew 27.4% in FY2025. M-PESA is evolving from a "transfer tool" to a "business platform."