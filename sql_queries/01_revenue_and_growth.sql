-- 1. Month-over-Month (MoM) Revenue Growth
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(total_amount) AS current_month_revenue
    FROM Orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    order_month,
    current_month_revenue,
    LAG(current_month_revenue) OVER (ORDER BY order_month) AS previous_month_revenue,
    ROUND(
        (current_month_revenue - LAG(current_month_revenue) OVER (ORDER BY order_month)) 
        / LAG(current_month_revenue) OVER (ORDER BY order_month) * 100, 
        2
    ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY order_month ASC;

-- 2. Average Order Value (AOV) Trend
WITH monthly_aov AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        ROUND(AVG(total_amount), 2) AS avg_order_value,
        COUNT(order_id) AS total_orders
    FROM Orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    order_month,
    avg_order_value,
    total_orders,
    ROUND(avg_order_value - LAG(avg_order_value) OVER (ORDER BY order_month), 2) AS aov_delta_vs_prior_month
FROM monthly_aov
ORDER BY order_month ASC;
