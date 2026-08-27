-- ============================================================
-- ShopSphere SQL Case Study
-- File: 04_data_cleaning.sql
-- Purpose: Data cleaning and quality handling
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Remove Leading/Trailing Spaces From Customer Data
-- ============================================================

UPDATE customers
SET
    first_name = TRIM(first_name),
    last_name = TRIM(last_name),
    email = TRIM(email),
    gender = TRIM(gender),
    city = TRIM(city),
    state = TRIM(state);


-- ============================================================
-- 2. Clean Product and Category Names
-- ============================================================

UPDATE products
SET product_name = TRIM(product_name);

UPDATE categories
SET category_name = TRIM(category_name);


-- ============================================================
-- 3. Clean Order Location and Status Fields
-- ============================================================

UPDATE orders
SET
    order_status = TRIM(order_status),
    shipping_city = TRIM(shipping_city),
    shipping_state = TRIM(shipping_state);


-- ============================================================
-- 4. Clean Payment Text Fields
-- ============================================================

UPDATE payments
SET
    payment_method = TRIM(payment_method),
    payment_status = TRIM(payment_status);


-- ============================================================
-- 5. Replace NULL Discounts With Zero
-- ============================================================

UPDATE order_items
SET discount = 0
WHERE discount IS NULL;


-- ============================================================
-- 6. Identify Invalid Discounts
-- Do not automatically modify these records.
-- ============================================================

SELECT *
FROM order_items
WHERE discount < 0
   OR discount > (quantity * unit_price);


-- ============================================================
-- 7. Identify Invalid Product Values
-- ============================================================

SELECT *
FROM products
WHERE price <= 0
   OR cost < 0
   OR stock_quantity < 0;


-- ============================================================
-- 8. Identify Invalid Ratings
-- ============================================================

SELECT *
FROM reviews
WHERE rating < 1
   OR rating > 5;


-- ============================================================
-- 9. Identify Invalid Expected Delivery Dates
-- ============================================================

SELECT
    order_id,
    order_date,
    expected_delivery_date
FROM orders
WHERE expected_delivery_date < DATE(order_date);


-- ============================================================
-- 10. Identify Missing Delivery Dates
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS total_orders,
    SUM(delivery_date IS NULL) AS missing_delivery_dates
FROM orders
GROUP BY order_status;


-- ============================================================
-- 11. Check Duplicate Customer Emails
-- ============================================================

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- ============================================================
-- 12. Final Cleaning Verification
-- ============================================================

SELECT COUNT(*) AS customers
FROM customers;

SELECT COUNT(*) AS orders
FROM orders;

SELECT COUNT(*) AS order_items
FROM order_items;

SELECT COUNT(*) AS payments
FROM payments;

SELECT COUNT(*) AS reviews
FROM reviews;