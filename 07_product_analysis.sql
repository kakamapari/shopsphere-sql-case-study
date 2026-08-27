-- ============================================================
-- ShopSphere SQL Case Study
-- File: 07_product_analysis.sql
-- Purpose: Analyze product sales, profitability,
--          discounts and customer ratings
-- Database: shopsphere
-- ============================================================

USE shopsphere;


-- ============================================================
-- 1. Total Quantity Sold by Product
-- ============================================================

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC;


-- ============================================================
-- 2. Product Revenue
-- ============================================================

SELECT
    p.product_name,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 3. Product Profit
-- ============================================================

SELECT
    p.product_name,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        ),
        2
    ) AS total_profit
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_profit DESC;


-- ============================================================
-- 4. Product Revenue, Profit and Profit Margin
-- ============================================================

SELECT
    p.product_name,

    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        ),
        2
    ) AS total_profit,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        )
        / SUM((oi.quantity * oi.unit_price) - oi.discount)
        * 100,
        2
    ) AS profit_margin_percent

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY total_profit DESC;


-- ============================================================
-- 5. Total Discount by Product
-- ============================================================

SELECT
    p.product_name,

    ROUND(
        SUM(oi.discount),
        2
    ) AS total_discount,

    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS net_revenue

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY total_discount DESC;


-- ============================================================
-- 6. Product Discount Rate
-- ============================================================

SELECT
    p.product_name,

    ROUND(
        SUM(oi.quantity * oi.unit_price),
        2
    ) AS gross_sales,

    ROUND(
        SUM(oi.discount),
        2
    ) AS total_discount,

    ROUND(
        SUM(oi.discount)
        / SUM(oi.quantity * oi.unit_price)
        * 100,
        2
    ) AS discount_rate_percent

FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY discount_rate_percent DESC;


-- ============================================================
-- 7. Product Ratings and Review Count
-- ============================================================

SELECT
    p.product_name,

    ROUND(
        AVG(r.rating),
        2
    ) AS average_rating,

    COUNT(r.review_id) AS total_reviews

FROM reviews r
JOIN products p
    ON r.product_id = p.product_id

GROUP BY
    p.product_id,
    p.product_name

ORDER BY average_rating DESC;


-- ============================================================
-- 8. Revenue by Category
-- ============================================================

SELECT
    c.category_name,

    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_revenue

FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id

GROUP BY
    c.category_id,
    c.category_name

ORDER BY total_revenue DESC;


-- ============================================================
-- 9. Category Profit
-- ============================================================

SELECT
    c.category_name,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        ),
        2
    ) AS total_profit

FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id

GROUP BY
    c.category_id,
    c.category_name

ORDER BY total_profit DESC;


-- ============================================================
-- 10. Category Revenue, Profit and Profit Margin
-- ============================================================

SELECT
    c.category_name,

    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        ),
        2
    ) AS total_profit,

    ROUND(
        SUM(
            (oi.quantity * oi.unit_price)
            - oi.discount
            - (oi.quantity * p.cost)
        )
        / SUM((oi.quantity * oi.unit_price) - oi.discount)
        * 100,
        2
    ) AS profit_margin_percent

FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id

GROUP BY
    c.category_id,
    c.category_name

ORDER BY total_profit DESC;