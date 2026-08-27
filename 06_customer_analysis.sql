-- ============================================================
-- ShopSphere SQL Case Study
-- File: 06_customer_analysis.sql
-- Purpose: Analyze customer behavior, spending and demographics
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Top 10 Customers by Total Spending
-- ============================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 10;


-- ============================================================
-- 2. Customers With the Most Orders
-- ============================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_orders DESC
LIMIT 10;


-- ============================================================
-- 3. Customer Average Order Value
-- ============================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_spent,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY average_order_value DESC
LIMIT 10;


-- ============================================================
-- 4. Orders by Customer Gender
-- ============================================================

SELECT
    c.gender,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.gender
ORDER BY total_orders DESC;


-- ============================================================
-- 5. Revenue by Customer Gender
-- ============================================================

SELECT
    c.gender,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_revenue,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.gender
ORDER BY total_revenue DESC;


-- ============================================================
-- 6. Customer Signups by Year
-- ============================================================

SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS new_customers
FROM customers
GROUP BY YEAR(signup_date)
ORDER BY signup_year;


-- ============================================================
-- 7. Top Customers: Spending + Orders + AOV
-- ============================================================

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_spent,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 10;