-- ============================================================
-- ShopSphere SQL Case Study
-- File: 05_exploratory_analysis.sql
-- Purpose: Exploratory Data Analysis (EDA)
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Dataset Overview
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT COUNT(*) AS total_payments
FROM payments;

SELECT COUNT(*) AS total_reviews
FROM reviews;


-- ============================================================
-- 2. Order Date Range
-- ============================================================

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM orders;


-- ============================================================
-- 3. Customer Signup Date Range
-- ============================================================

SELECT
    MIN(signup_date) AS first_signup_date,
    MAX(signup_date) AS latest_signup_date
FROM customers;


-- ============================================================
-- 4. Order Status Distribution
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================
-- 5. Payment Status Distribution
-- ============================================================

SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;


-- ============================================================
-- 6. Payment Method Distribution
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;


-- ============================================================
-- 7. Customers by Gender
-- ============================================================

SELECT
    gender,
    COUNT(*) AS total_customers
FROM customers
GROUP BY gender
ORDER BY total_customers DESC;


-- ============================================================
-- 8. Customers by State
-- ============================================================

SELECT
    state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY state
ORDER BY total_customers DESC;


-- ============================================================
-- 9. Products by Category
-- ============================================================

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_products DESC;


-- ============================================================
-- 10. Product Price Range
-- ============================================================

SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    ROUND(AVG(price), 2) AS average_price
FROM products;


-- ============================================================
-- 11. Order Item Quantity Statistics
-- ============================================================

SELECT
    MIN(quantity) AS minimum_quantity,
    MAX(quantity) AS maximum_quantity,
    ROUND(AVG(quantity), 2) AS average_quantity
FROM order_items;


-- ============================================================
-- 12. Discount Statistics
-- ============================================================

SELECT
    ROUND(MIN(discount), 2) AS minimum_discount,
    ROUND(MAX(discount), 2) AS maximum_discount,
    ROUND(AVG(discount), 2) AS average_discount
FROM order_items;


-- ============================================================
-- 13. Review Rating Distribution
-- ============================================================

SELECT
    rating,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY rating
ORDER BY rating;


-- ============================================================
-- 14. Average Product Rating
-- ============================================================

SELECT
    ROUND(AVG(rating), 2) AS overall_average_rating
FROM reviews;


-- ============================================================
-- 15. Orders by Year
-- ============================================================

SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- ============================================================
-- 16. Monthly Order Trend
-- ============================================================

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


-- ============================================================
-- 17. Basic Revenue Overview
-- ============================================================

SELECT
    ROUND(
        SUM((quantity * unit_price) - discount),
        2
    ) AS total_revenue
FROM order_items;


-- ============================================================
-- 18. Average Order Value
-- ============================================================

SELECT
    ROUND(
        SUM((quantity * unit_price) - discount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM order_items;