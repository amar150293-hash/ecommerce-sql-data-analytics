-- 1. Category-Wise Customer Penetration
SELECT 
    p.category,
    COUNT(DISTINCT o.customer_id) AS unique_purchasing_customers,
    ROUND(
        COUNT(DISTINCT o.customer_id) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM Customers), 
        2
    ) AS catalog_penetration_pct
FROM Products p
INNER JOIN OrderDetails od ON p.product_id = od.product_id
INNER JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.category
ORDER BY unique_purchasing_customers DESC;

-- 2. Low Penetration Products (<40% Customer Base Reach)
WITH total_customer_base AS (
    SELECT COUNT(DISTINCT customer_id) AS total_customers FROM Customers
)
SELECT 
    p.product_id,
    p.name AS product_name,
    p.category,
    COUNT(DISTINCT o.customer_id) AS customer_reach,
    ROUND(COUNT(DISTINCT o.customer_id) * 100.0 / tcb.total_customers, 2) AS penetration_pct
FROM Products p
CROSS JOIN total_customer_base tcb
LEFT JOIN OrderDetails od ON p.product_id = od.product_id
LEFT JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.name, p.category, tcb.total_customers
HAVING COUNT(DISTINCT o.customer_id) < (0.40 * tcb.total_customers)
ORDER BY customer_reach ASC;

-- 3. Top Moving Products (High Sales Velocity)
SELECT 
    p.product_id,
    p.name AS product_name,
    COUNT(od.order_id) AS transaction_frequency,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.quantity * od.price_per_unit) AS total_gross_revenue
FROM OrderDetails od
INNER JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY transaction_frequency DESC
LIMIT 5;
