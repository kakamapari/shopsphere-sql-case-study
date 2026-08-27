-- ============================================================
-- ShopSphere SQL Case Study
-- File: 02_data_generation.sql
-- Purpose: Generate synthetic e-commerce data
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Insert Categories
-- ============================================================

INSERT INTO categories (category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen'),
(4, 'Beauty'),
(5, 'Sports'),
(6, 'Books'),
(7, 'Toys');


-- ============================================================
-- 2. Insert Products
-- ============================================================

INSERT INTO products
(product_id, product_name, category_id, price, cost, stock_quantity)
VALUES
(101, 'Wireless Headphones', 1, 2499.00, 1500.00, 120),
(102, 'Smart Watch', 1, 4999.00, 3000.00, 80),
(103, 'Bluetooth Speaker', 1, 1999.00, 1100.00, 150),
(104, 'USB-C Charger', 1, 899.00, 450.00, 250),

(201, 'Running T-Shirt', 2, 799.00, 350.00, 200),
(202, 'Denim Jeans', 2, 1799.00, 900.00, 100),
(203, 'Casual Sneakers', 2, 2499.00, 1400.00, 90),

(301, 'Coffee Maker', 3, 5499.00, 3500.00, 60),
(302, 'Non-Stick Cookware Set', 3, 3999.00, 2400.00, 70),
(303, 'Electric Kettle', 3, 1499.00, 800.00, 130),

(401, 'Face Wash', 4, 499.00, 220.00, 300),
(402, 'Moisturizer', 4, 699.00, 300.00, 250),
(403, 'Sunscreen SPF 50', 4, 899.00, 400.00, 180),

(501, 'Running Shoes', 5, 3999.00, 2400.00, 75),
(502, 'Yoga Mat', 5, 999.00, 450.00, 180),
(503, 'Dumbbell Set', 5, 2999.00, 1800.00, 60),

(601, 'SQL for Beginners', 6, 699.00, 350.00, 100),
(602, 'Data Analytics Handbook', 6, 999.00, 500.00, 80),

(701, 'Building Blocks Set', 7, 1299.00, 650.00, 100),
(702, 'Educational Puzzle', 7, 599.00, 250.00, 150);


-- ============================================================
-- 3. Generate Numbers Helper Table
-- ============================================================

INSERT INTO numbers (n)
SELECT ones.n
     + tens.n * 10
     + hundreds.n * 100
     + thousands.n * 1000
     + 1 AS n
FROM
(
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9
) ones
CROSS JOIN
(
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9
) tens
CROSS JOIN
(
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9
) hundreds
CROSS JOIN
(
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9
) thousands
ORDER BY n;

-- ============================================================
-- 4. Generate 1,000 Synthetic Customers
-- ============================================================

INSERT INTO customers
(
    customer_id,
    first_name,
    last_name,
    email,
    gender,
    date_of_birth,
    city,
    state,
    signup_date
)
SELECT
    n AS customer_id,

    ELT(
        1 + MOD(n * 7, 15),
        'Amit', 'Priya', 'Rahul', 'Neha', 'Vikram',
        'Isha', 'Rohan', 'Pooja', 'Aditya', 'Meera',
        'Nikhil', 'Ananya', 'Karan', 'Arjun', 'Sneha'
    ) AS first_name,

    ELT(
        1 + MOD(n * 11, 10),
        'Sharma', 'Patel', 'Singh', 'Verma', 'Iyer',
        'Joshi', 'Mehta', 'Shah', 'Kumar', 'Gupta'
    ) AS last_name,

    CONCAT('customer', n, '@shopsphere.com') AS email,

    ELT(
        1 + MOD(n * 5, 3),
        'Male', 'Female', 'Other'
    ) AS gender,

    DATE_ADD(
        '1975-01-01',
        INTERVAL MOD(n * 137, 10950) DAY
    ) AS date_of_birth,

    ELT(
        1 + MOD(n * 7, 10),
        'Mumbai',
        'Delhi',
        'Bengaluru',
        'Chennai',
        'Hyderabad',
        'Pune',
        'Kolkata',
        'Ahmedabad',
        'Jaipur',
        'Lucknow'
    ) AS city,

    ELT(
        1 + MOD(n * 11, 9),
        'Maharashtra',
        'Delhi',
        'Karnataka',
        'Tamil Nadu',
        'Telangana',
        'West Bengal',
        'Gujarat',
        'Rajasthan',
        'Uttar Pradesh'
    ) AS state,

    DATE_ADD(
        '2023-01-01',
        INTERVAL MOD(n * 29, 1095) DAY
    ) AS signup_date

FROM numbers
WHERE n <= 1000;

-- ============================================================
-- 6. Generate 5,000 Synthetic Orders
-- ============================================================

INSERT INTO orders
(
    order_id,
    customer_id,
    order_date,
    order_status,
    shipping_city,
    shipping_state,
    delivery_date,
    expected_delivery_date
)
SELECT
    n AS order_id,

    1 + MOD(n * 47, 1000) AS customer_id,

    DATE_ADD(
        '2024-01-01',
        INTERVAL MOD(n * 37, 731) DAY
    ) AS order_date,

    CASE
        WHEN MOD(n, 100) < 80 THEN 'Delivered'
        WHEN MOD(n, 100) < 98 THEN 'Cancelled'
        WHEN MOD(n, 100) < 100 THEN 'Returned'
        ELSE 'Processing'
    END AS order_status,

    ELT(
        1 + MOD(n * 7, 10),
        'Mumbai',
        'Delhi',
        'Bengaluru',
        'Chennai',
        'Hyderabad',
        'Pune',
        'Kolkata',
        'Ahmedabad',
        'Jaipur',
        'Lucknow'
    ) AS shipping_city,

    ELT(
        1 + MOD(n * 11, 9),
        'Maharashtra',
        'Delhi',
        'Karnataka',
        'Tamil Nadu',
        'Telangana',
        'West Bengal',
        'Gujarat',
        'Rajasthan',
        'Uttar Pradesh'
    ) AS shipping_state,

    NULL AS delivery_date,

    DATE_ADD(
        DATE_ADD(
            '2024-01-01',
            INTERVAL MOD(n * 37, 731) DAY
        ),
        INTERVAL (3 + MOD(n, 8)) DAY
    ) AS expected_delivery_date

FROM numbers
WHERE n <= 5000;


-- ============================================================
-- 8. Generate 10,000 Synthetic Order Items
-- ============================================================

INSERT INTO order_items
(
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    discount
)
SELECT
    n AS order_item_id,

    1 + MOD(n - 1, 5000) AS order_id,

    p.product_id,

    1 + MOD(n * 3, 3) AS quantity,

    p.price AS unit_price,

    ROUND(
        MOD(n * 17, 30000) / 100,
        2
    ) AS discount

FROM numbers num

JOIN products p
    ON p.product_id = CASE 1 + MOD(num.n - 1, 20)

        WHEN 1 THEN 101
        WHEN 2 THEN 102
        WHEN 3 THEN 103
        WHEN 4 THEN 104

        WHEN 5 THEN 201
        WHEN 6 THEN 202
        WHEN 7 THEN 203

        WHEN 8 THEN 301
        WHEN 9 THEN 302
        WHEN 10 THEN 303

        WHEN 11 THEN 401
        WHEN 12 THEN 402
        WHEN 13 THEN 403

        WHEN 14 THEN 501
        WHEN 15 THEN 502
        WHEN 16 THEN 503

        WHEN 17 THEN 601
        WHEN 18 THEN 602

        WHEN 19 THEN 701
        WHEN 20 THEN 702
    END

WHERE num.n <= 10000;

-- ============================================================
-- 10. Generate 5,000 Synthetic Payments
-- ============================================================

INSERT INTO payments
(
    payment_id,
    order_id,
    payment_date,
    payment_method,
    payment_status,
    amount
)
SELECT
    o.order_id AS payment_id,
    o.order_id,

    o.order_date AS payment_date,

    ELT(
        1 + MOD(o.order_id * 7, 6),
        'UPI',
        'Credit Card',
        'Debit Card',
        'Net Banking',
        'Wallet',
        'Cash on Delivery'
    ) AS payment_method,

    CASE
        WHEN o.order_status = 'Cancelled' THEN 'Failed'
        WHEN o.order_status = 'Returned' THEN 'Refunded'
        ELSE 'Completed'
    END AS payment_status,

    ROUND(
        COALESCE(SUM(
            (oi.quantity * oi.unit_price) - oi.discount
        ), 0),
        2
    ) AS amount

FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id

GROUP BY
    o.order_id,
    o.order_date,
    o.order_status;


-- ============================================================
-- 11. Generate 2,000 Synthetic Reviews
-- ============================================================

INSERT INTO reviews
(
    review_id,
    customer_id,
    product_id,
    order_id,
    rating,
    review_date,
    review_text
)
SELECT
    n AS review_id,

    o.customer_id,

    oi.product_id,

    o.order_id,

    1 + MOD(n * 7, 5) AS rating,

    DATE_ADD(
        DATE(o.order_date),
        INTERVAL (5 + MOD(n, 30)) DAY
    ) AS review_date,

    CASE 1 + MOD(n * 11, 5)
        WHEN 1 THEN 'Excellent product, very satisfied.'
        WHEN 2 THEN 'Good quality and worth the price.'
        WHEN 3 THEN 'Average product, could be better.'
        WHEN 4 THEN 'Not very satisfied with the product.'
        WHEN 5 THEN 'Poor experience with this product.'
    END AS review_text

FROM numbers num

JOIN orders o
    ON o.order_id = 1 + MOD(num.n * 13, 5000)

JOIN order_items oi
    ON oi.order_item_id = 1 + MOD(num.n * 17, 10000)

WHERE num.n <= 2000;


-- ============================================================
-- 12. Final Dataset Verification
-- ============================================================

SELECT COUNT(*) AS categories
FROM categories;

SELECT COUNT(*) AS products
FROM products;

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

SELECT COUNT(*) AS numbers
FROM numbers;