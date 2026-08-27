-- ============================================================
-- ShopSphere SQL Case Study
-- File: 03_data_validation.sql
-- Purpose: Validate data quality and integrity
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Check Row Counts
-- ============================================================

SELECT COUNT(*) AS total_categories
FROM categories;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT COUNT(*) AS total_order_items
FROM order_items;

SELECT COUNT(*) AS total_payments
FROM payments;

SELECT COUNT(*) AS total_reviews
FROM reviews;

SELECT COUNT(*) AS total_numbers
FROM numbers;


-- ============================================================
-- 2. Check Duplicate Customer Emails
-- ============================================================

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. Check NULL Values in Important Customer Fields
-- ============================================================

SELECT
    SUM(first_name IS NULL) AS missing_first_name,
    SUM(last_name IS NULL) AS missing_last_name,
    SUM(email IS NULL) AS missing_email,
    SUM(gender IS NULL) AS missing_gender,
    SUM(city IS NULL) AS missing_city,
    SUM(state IS NULL) AS missing_state,
    SUM(signup_date IS NULL) AS missing_signup_date
FROM customers;


-- ============================================================
-- 4. Check NULL Values in Orders
-- ============================================================

SELECT
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(order_date IS NULL) AS missing_order_date,
    SUM(order_status IS NULL) AS missing_order_status,
    SUM(shipping_city IS NULL) AS missing_shipping_city,
    SUM(shipping_state IS NULL) AS missing_shipping_state,
    SUM(delivery_date IS NULL) AS missing_delivery_date,
    SUM(expected_delivery_date IS NULL)
        AS missing_expected_delivery_date
FROM orders;


-- ============================================================
-- 5. Check Valid Order Status Values
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================
-- 6. Check Payment Status Values
-- ============================================================

SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;


-- ============================================================
-- 7. Check Payment Method Values
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_method
ORDER BY total_payments DESC;


-- ============================================================
-- 8. Check Invalid Product Prices or Costs
-- ============================================================

SELECT *
FROM products
WHERE price <= 0
   OR cost < 0
   OR cost > price;


-- ============================================================
-- 9. Check Invalid Order Item Quantities
-- ============================================================

SELECT *
FROM order_items
WHERE quantity <= 0;


-- ============================================================
-- 10. Check Invalid Discounts
-- ============================================================

SELECT *
FROM order_items
WHERE discount < 0
   OR discount > (quantity * unit_price);


-- ============================================================
-- 11. Check Invalid Review Ratings
-- ============================================================

SELECT *
FROM reviews
WHERE rating < 1
   OR rating > 5;


-- ============================================================
-- 12. Check Orders With Missing Customers
-- ============================================================

SELECT o.*
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================================
-- 13. Check Order Items With Missing Orders
-- ============================================================

SELECT oi.*
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- ============================================================
-- 14. Check Order Items With Missing Products
-- ============================================================

SELECT oi.*
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 15. Check Payments With Missing Orders
-- ============================================================

SELECT p.*
FROM payments p
LEFT JOIN orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;


-- ============================================================
-- 16. Check Reviews With Missing Customers
-- ============================================================

SELECT r.*
FROM reviews r
LEFT JOIN customers c
    ON r.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


-- ============================================================
-- 17. Check Reviews With Missing Products
-- ============================================================

SELECT r.*
FROM reviews r
LEFT JOIN products p
    ON r.product_id = p.product_id
WHERE p.product_id IS NULL;


-- ============================================================
-- 18. Check Suspicious Delivery Dates
-- ============================================================

SELECT
    order_id,
    order_date,
    expected_delivery_date
FROM orders
WHERE expected_delivery_date < DATE(order_date);


-- ============================================================
-- 19. Check Delivery Date Availability by Order Status
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders,
    SUM(delivery_date IS NULL) AS missing_delivery_date
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;