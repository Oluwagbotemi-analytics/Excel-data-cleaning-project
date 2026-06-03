-- ============================================================
--   GO SALES BUSINESS ANALYTICS — SQL QUERIES
--   Author  : Oluwagbotemi Olanrewaju
--   Dataset : GO Sales (go_daily_sales, go_products,
--             go_retailers, go_method)
--   Tool    : MySQL
-- ============================================================


-- ============================================================
--   SECTION 1: SALES VOLUME & REVENUE ANALYSIS
-- ============================================================

-- 1.1 Total revenue by day of the week
--     Identifies which days generate the most sales activity
SELECT dayname(date)                              AS Days_Of_Week,
       ROUND(SUM(quantity * `unit sale price`), 2) AS Total_Daily_Revenue
FROM   go_daily_sales
GROUP  BY dayname(date)
ORDER  BY Total_Daily_Revenue DESC;


-- 1.2 Revenue and sales volume by retailer (branch)
--     Reveals which branches are the strongest revenue contributors
SELECT `Retailer name`,
       SUM(quantity)                                    AS Total_Quantity,
       ROUND(SUM(quantity * s.`unit sale price`), 2)    AS Total_Revenue
FROM   go_daily_sales s
JOIN   go_products  p USING (`product number`)
JOIN   go_retailers r USING (`retailer code`)
GROUP  BY `Retailer name`
ORDER  BY Total_Revenue DESC;


-- 1.3 Top-selling products by units sold and revenue
--     Determines which products drive the most volume and value
SELECT product,
       `product brand`,
       SUM(quantity)                                    AS Unit_Quantity,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Revenue
FROM   go_daily_sales s
JOIN   go_products    p USING (`product number`)
GROUP  BY product, `product brand`
ORDER  BY Revenue DESC;


-- ============================================================
--   SECTION 2: ORDER METHOD PERFORMANCE
-- ============================================================

-- 2.1 Total revenue contribution by order method
--     Shows which sales channels (Web, Email, etc.) generate the most revenue
SELECT `Order method type`,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Revenue
FROM   go_daily_sales s
JOIN   go_method USING (`Order method code`)
GROUP  BY `Order method type`
ORDER  BY Revenue DESC;


-- 2.2 Average sale value per transaction by order method
--     Identifies which channels produce the highest-value individual transactions
SELECT `Order method type`,
       ROUND(AVG(quantity * `unit sale price`), 2)      AS Avg_Sale_Per_Transaction
FROM   go_daily_sales
JOIN   go_method USING (`Order method code`)
GROUP  BY `Order method type`
ORDER  BY Avg_Sale_Per_Transaction DESC;


-- 2.3 Seasonal trends in order method usage by month
--     Uncovers whether customer channel preferences shift across the year
SELECT MONTHNAME(date)                                  AS Month,
       `Order method type`,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Revenue
FROM   go_daily_sales
JOIN   go_method USING (`Order method code`)
GROUP  BY MONTHNAME(date), `Order method type`
ORDER  BY Revenue DESC;


-- ============================================================
--   SECTION 3: PRODUCT DEMAND & TRENDS
-- ============================================================

-- 3.1 Daily demand per product over time
--     Tracks how demand for individual products fluctuates day to day
SELECT date,
       product,
       SUM(quantity)                                    AS Daily_Demand
FROM   go_daily_sales s
JOIN   go_products    p USING (`Product number`)
GROUP  BY date, product
ORDER  BY date, Daily_Demand DESC;


-- 3.2 Monthly units sold per product
--     Surfaces products with strong growth or seasonal decline patterns
SELECT MONTHNAME(date)                                  AS Month,
       product,
       SUM(quantity)                                    AS Total_Units_Sold
FROM   go_daily_sales s
JOIN   go_products    p USING (`Product number`)
GROUP  BY MONTHNAME(date), product
ORDER  BY Total_Units_Sold DESC;


-- 3.3 Top 5 products by quantity — share of total sales (%)
--     Measures revenue concentration: how much of total sales the top 5 own
SELECT product,
       SUM(quantity)                                    AS Total_Quantity,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Revenue,
       ROUND(
         SUM(quantity * `unit sale price`) /
         (SELECT SUM(quantity * `unit sale price`) FROM go_daily_sales) * 100
       , 2)                                             AS Sales_Percent
FROM   go_daily_sales
JOIN   go_products USING (`Product number`)
GROUP  BY product
ORDER  BY Total_Quantity DESC
LIMIT  5;


-- ============================================================
--   SECTION 4: RETAILER (BRANCH) INSIGHTS
-- ============================================================

-- 4.1 Monthly revenue and volume per retailer
--     Identifies retailers showing consistent growth over time
SELECT `Retailer name`,
       MONTHNAME(date)                                  AS Month,
       SUM(quantity)                                    AS Total_Quantity,
       ROUND(SUM(quantity * `Unit sale price`), 2)      AS Total_Revenue
FROM   go_daily_sales
JOIN   go_retailers USING (`Retailer code`)
GROUP  BY `Retailer name`, MONTHNAME(date)
ORDER  BY Total_Revenue DESC;


-- 4.2 Retailers with consistently low revenue by month
--     Flags underperforming branches that may need strategic intervention
SELECT `Retailer code`,
       MONTHNAME(date)                                  AS Month,
       ROUND(SUM(quantity * `Unit sale price`), 2)      AS Total_Revenue
FROM   go_daily_sales
JOIN   go_retailers USING (`Retailer code`)
GROUP  BY `Retailer code`, MONTHNAME(date)
ORDER  BY Total_Revenue ASC;


-- 4.3 Monthly revenue ranking per retailer
--     Ranks all retailers by revenue each month for comparative analysis
SELECT `Retailer name`,
       MONTHNAME(date)                                  AS Month,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Revenue
FROM   go_daily_sales
JOIN   go_retailers USING (`Retailer code`)
GROUP  BY `Retailer name`, MONTHNAME(date)
ORDER  BY Revenue DESC;


-- ============================================================
--   SECTION 5: PROFITABILITY & MARGIN ANALYSIS
-- ============================================================

-- 5.1 Average profit margin per product
--     Calculates margin as: (sale price - unit cost) / sale price × 100
SELECT product,
       ROUND(AVG((`unit sale price` - `unit cost`) / `unit sale price` * 100), 2) AS Profit_Margin_Pct
FROM   go_daily_sales s
JOIN   go_products    p USING (`Product number`)
GROUP  BY product
ORDER  BY Profit_Margin_Pct DESC;


-- 5.2 Profit margin by product and order method combination
--     Reveals which product-channel pairings are most and least profitable
SELECT product,
       `Order method type`,
       ROUND(AVG((`unit sale price` - `unit cost`) / `unit sale price` * 100), 2) AS Profit_Margin_Pct
FROM   go_daily_sales s
JOIN   go_products p USING (`Product number`)
JOIN   go_method   USING (`Order method code`)
GROUP  BY product, `Order method type`
ORDER  BY Profit_Margin_Pct DESC;


-- ============================================================
--   SECTION 6: PEAK SALES PATTERNS & SEASONALITY
-- ============================================================

-- 6.1 Peak revenue days of the week
--     Determines which weekdays consistently generate the highest sales
SELECT DAYNAME(date)                                    AS Day_Of_Week,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Total_Revenue
FROM   go_daily_sales
GROUP  BY DAYNAME(date)
ORDER  BY Total_Revenue DESC;


-- 6.2 Monthly and quarterly seasonality in total sales
--     Identifies high and low revenue months to inform planning and forecasting
SELECT MONTHNAME(date)                                  AS Month,
       ROUND(SUM(quantity * `unit sale price`), 2)      AS Total_Revenue
FROM   go_daily_sales
GROUP  BY MONTHNAME(date)
ORDER  BY Total_Revenue DESC;
