-- 1. Customer Acquisition Velocity (First Purchase Month)
WITH customer_acquisition AS (
    SELECT 
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS cohort_first_touch_month
    FROM Orders
    GROUP BY customer_id
)
SELECT 
    cohort_first_touch_month,
    COUNT(customer_id) AS new_customers_acquired
FROM customer_acquisition
GROUP BY cohort_first_touch_month
ORDER BY cohort_first_touch_month ASC;

-- 2. Repeat Purchase Frequency Distribution
WITH customer_order_frequencies AS (
    SELECT 
        customer_id,
        COUNT(order_id) AS lifetime_orders
    FROM Orders
    GROUP BY customer_id
)
SELECT 
    lifetime_orders,
    COUNT(customer_id) AS total_customers,
    ROUND(COUNT(customer_id) * 100.0 / SUM(COUNT(customer_id)) OVER (), 2) AS pct_of_customer_base
FROM customer_order_frequencies
GROUP BY lifetime_orders
ORDER BY lifetime_orders ASC;

-- 3. Top Geographic Locations
SELECT 
    location,
    COUNT(customer_id) AS customer_count,
    ROUND(COUNT(customer_id) * 100.0 / SUM(COUNT(customer_id)) OVER (), 2) AS geographic_share_pct
FROM Customers
GROUP BY location
ORDER BY customer_count DESC
LIMIT 5;
