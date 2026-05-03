-- ============================================================
-- FILE: 05_analytical_queries.sql
-- PURPOSE: Business insight queries for portfolio demonstration
--          and Page 5 dashboard narrative (Insights & Recommendations)
-- These queries answer real questions a CFO would ask
-- ============================================================


-- ============================================================
-- QUERY 1: Revenue transformation story
-- Business question: How has Safaricom's revenue mix shifted
-- from a voice-dependent telco to a fintech-led business?
-- ============================================================
SELECT
    fiscal_year,
    service_revenue,
    voice_revenue,
    mpesa_revenue,
    mobile_data_revenue,
    ROUND((voice_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS voice_pct,
    ROUND((mpesa_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS mpesa_pct,
    ROUND((mobile_data_revenue / NULLIF(service_revenue,0)) * 100, 1)
        AS data_pct,
    -- The inflection point: when did M-PESA overtake voice?
    CASE
        WHEN mpesa_revenue > voice_revenue
        THEN 'M-PESA LEADS'
        ELSE 'VOICE LEADS'
    END AS revenue_leader
FROM safaricom_financials
ORDER BY fiscal_year;


-- The Headline: 
-- M-PESA officially overtook Voice revenue in FY2021, marking a structural shift from a traditional telco to a fintech-led platform.

-- Voice Resilience (FY2015–2020): Voice revenue stayed above KShs 93Bn for years. It didn’t "collapse" but was diluted by faster-growing segments.

-- The Crossover (FY2021): M-PESA and Voice both hit 33.0% of service revenue. This was accelerated by COVID-19 zero-rating on M-PESA and accounting reclassifications in Voice.

-- M-PESA Dominance (FY2022–2025): M-PESA now nears 50% of all service revenue, while Voice has shrunk to 22.1% (less than half its 2015 share).

-- Data as the "Quiet Compounder": Mobile data doubled its revenue share from 9.5% to 21.1% without the volatility seen in other segments.

-- The Outcome: By FY2025, M-PESA and Data combined represent 64.5% of service revenue.