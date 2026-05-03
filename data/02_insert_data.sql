-- ============================================================
-- FILE: 02_insert_data.sql
-- PURPOSE: Load all Safaricom annual financial data FY2015-FY2025
-- Source: Safaricom PLC audited Results Booklets & Press Commentaries
-- Units: KShs Millions
-- Accounting notes:
--   FY15-FY19: IAS 17/18 basis, numbers reported in Kshs Billions x 1000
--   FY20+: IFRS 15/16 basis
--   FY21+: Revenue lines reclassified to Vodafone Group format
--   net_finance_cost: positive = expense, negative = income
-- ============================================================

INSERT INTO safaricom_financials (
    fiscal_year,
    voice_revenue, mobile_incoming_revenue, mpesa_revenue,
    mobile_data_revenue, messaging_revenue, fixed_revenue,
    other_service_revenue, service_revenue, handset_other_revenue,
    total_revenue, direct_costs, ecl_expense, ebitda, depreciation,
    ebit, net_finance_cost, profit_before_tax, income_tax,
    profit_after_tax, total_assets, total_equity, total_borrowings,
    lease_liabilities, cash, operating_cash_flow, capex,
    free_cash_flow, ifrs16_applied, revenue_reclassified, data_quality
)
VALUES

-- FY2015
-- Source: FY16 Press Commentary comparative column
-- total_assets not available in condensed format
(2015,
 87370.0, NULL, 32630.0,
 14820.0, 15670.0, 3130.0,
 2630.0, 156250.0, 7110.0,
 163360.0, 56710.0, NULL, 71190.0, 25570.0,
 45620.0, -220.0, 46160.0, 14280.0,
 31870.0, NULL, 104280.0, 10640.0,
 NULL, 11920.0, 41150.0, 33700.0,
 27520.0, FALSE, FALSE, 'PARTIAL'),

-- FY2016
-- Source: FY16 Press Commentary
-- total_assets not available; borrowings nil (zero gearing)
(2016,
 90800.0, NULL, 41500.0,
 21150.0, 17330.0, 3820.0,
 3180.0, 177780.0, 8620.0,
 195680.0, 62300.0, NULL, 83070.0, 27940.0,
 55130.0, -510.0, 55760.0, 17660.0,
 38100.0, NULL, 116740.0, 0.0,
 NULL, 6110.0, 45500.0, 33340.0,
 30360.0, FALSE, FALSE, 'PARTIAL'),

-- FY2017
-- Source: FY17 Press Commentary
-- total_assets derived: non-current 136,530 + current 25,160 = 161,690
(2017,
 93460.0, NULL, 55080.0,
 29290.0, 16680.0, 5240.0,
 4360.0, 204110.0, 8700.0,
 212890.0, 66750.0, NULL, 103610.0, 33230.0,
 70380.0, -230.0, 70630.0, 22190.0,
 48440.0, 161690.0, 107490.0, 16540.0,
 NULL, 5960.0, 67010.0, 35330.0,
 43510.0, FALSE, FALSE, 'VERIFIED'),

-- FY2018
-- Source: FY18 Press Commentary
-- total_assets derived: non-current 139,980 + current 27,460 = 167,440
(2018,
 95640.0, NULL, 62910.0,
 36360.0, 17720.0, 6670.0,
 5240.0, 224540.0, 9180.0,
 233720.0, 70550.0, NULL, 112830.0, 33560.0,
 79270.0, -630.0, 79910.0, 24620.0,
 55290.0, 167440.0, 123910.0, 4040.0,
 NULL, 9500.0, 80920.0, 36400.0,
 55390.0, FALSE, FALSE, 'VERIFIED'),

-- FY2019
-- Source: FY19 Press Commentary, IAS 18 basis
-- total_assets derived: non-current 141,550 + current 47,880 = 189,430
(2019,
 95940.0, NULL, 74990.0,
 38690.0, 17500.0, 8190.0,
 5000.0, 240300.0, 10660.0,
 250960.0, 71820.0, NULL, 124940.0, 35330.0,
 89610.0, -2240.0, 91860.0, 28460.0,
 63400.0, 189430.0, 143240.0, 5660.0,
 NULL, 20030.0, 88450.0, 37250.0,
 63110.0, FALSE, FALSE, 'VERIFIED'),

-- FY2020
-- Source: FY20 Results Booklet, IFRS 15/16 basis
-- PBT includes KShs 3,300M one-off M-PESA brand acquisition gain
(2020,
 94450.0, NULL, 84440.0,
 40670.0, 17190.0, 8970.0,
 5500.0, 251220.0, 11340.0,
 262560.0, 74700.0, 1670.0, 138040.0, 36550.0,
 101490.0, -920.0, 105770.0, 32120.0,
 73660.0, 213220.0, 143080.0, 8000.0,
 13640.0, 26760.0, 135820.0, 36100.0,
 70270.0, TRUE, FALSE, 'VERIFIED'),

-- FY2021
-- Source: FY21 Results Booklet
-- Revenue lines reclassified to Vodafone format from this year
-- mobile_incoming_revenue populated for first time
-- COVID year: M-PESA declined YoY due to zero-rated P2P transactions
(2021,
 82552.0, 9470.0, 82647.0,
 44793.0, 13602.0, 9507.0,
 7779.0, 250352.0, 13675.0,
 264027.0, 80015.0, 3010.0, 134129.0, 37964.0,
 96165.0, 2022.0, 93636.0, 24959.0,
 68676.0, 230629.0, 137635.0, 14772.0,
 17542.0, 26736.0, 127900.0, 34960.0,
 64516.0, TRUE, TRUE, 'VERIFIED'),

-- FY2022
-- Source: FY22 Results Booklet
-- Capex spike: KShs 96,300M Ethiopia licence acquisition included
(2022,
 83211.8, 9848.2, 107691.8,
 48441.0, 10876.7, 11242.5,
 9795.3, 281107.3, 16970.6,
 298077.9, 91467.8, NULL, 149061.9, 39933.3,
 109128.6, 6439.2, 102213.4, 34717.3,
 67496.1, 346798.6, 179700.9, 65310.8,
 NULL, 30779.6, 110700.5, 137346.3,
 74880.6, TRUE, TRUE, 'VERIFIED'),

-- FY2023
-- Source: FY23 Results Booklet
-- PBT > EBIT due to KShs 10,383M hyperinflationary monetary gain (Ethiopia)
(2023,
 81053.9, 8109.5, 117192.2,
 53952.4, 11375.6, 13457.9,
 10550.8, 295692.3, 15212.5,
 310904.8, 92232.1, NULL, 139862.4, 54865.0,
 84997.4, 7087.1, 88345.2, 35862.4,
 52482.8, 509207.0, 263365.9, 85542.3,
 NULL, 22098.1, 116151.1, 71474.2,
 65819.7, TRUE, TRUE, 'VERIFIED'),

-- FY2024
-- Source: FY25 Results Booklet comparative column (Group)
(2024,
 80541.1, 8567.6, 140006.7,
 67404.3, 12319.2, 14962.2,
 11552.0, 335353.1, 10540.3,
 349447.2, 97046.9, 5807.4, 163292.6, 82947.8,
 80344.8, 16641.5, 84687.4, 42029.0,
 42658.4, 641164.3, 335747.9, 108146.8,
 NULL, 22868.2, 107923.6, 66636.1,
 76127.1, TRUE, TRUE, 'VERIFIED'),

-- FY2025
-- Source: FY25 Results Booklet (Group column)
(2025,
 81958.9, 8136.7, 161131.2,
 78521.4, 12559.4, 16798.7,
 12309.1, 371415.4, 13018.0,
 388688.9, 101081.3, 11146.0, 172150.9, 68100.8,
 104050.1, 20909.4, 93210.5, 47453.3,
 45757.2, 515284.2, 224021.1, 107430.4,
 NULL, 29995.7, 137693.9, 60792.7,
 89944.2, TRUE, TRUE, 'VERIFIED');