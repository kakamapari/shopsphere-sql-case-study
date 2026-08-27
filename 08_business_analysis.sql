-- Question 1: Total number of orders

SELECT COUNT(*) AS total_orders
FROM orders;


-- Question 2: Orders by status

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Question 3: Total Revenue

SELECT
    SUM((quantity * unit_price) - discount) AS total_revenue
FROM order_items;


-- Question 4: Average Order Value

SELECT
    ROUND(
        SUM((quantity * unit_price) - discount)
        / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM order_items;


-- Question 5: Revenue by Category

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
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;

-- Question 6: Top-Selling Products by Quantity

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;




-- Question 7: Top Customers by Spending

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


-- Question 8: Monthly Revenue

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    ROUND(
        SUM((oi.quantity * oi.unit_price) - oi.discount),
        2
    ) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;


-- Question 9: Profit by Product

SELECT
    p.product_name,
    ROUND(
        SUM(
            ((oi.quantity * oi.unit_price) - oi.discount)
            - (oi.quantity * p.cost)
        ),
        2
    ) AS total_profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC;

-- Question 10: Profit by Category

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


-- Question 11: Payment Method Analysis

SELECT
    payment_method,
    COUNT(*) AS total_payments,
    ROUND(SUM(amount), 2) AS total_payment_amount
FROM payments
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

-- Question 12: Payment Status Analysis

SELECT
    payment_status,
    COUNT(*) AS total_payments,
    ROUND(SUM(amount), 2) AS total_payment_amount
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;

-- Question 13: Customers with Most Orders

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
-- Question 14: Average Rating by Product

SELECT
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN products p
    ON r.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_rating DESC;

-- Question 15: Delivery Date Data Quality

SELECT
    order_status,
    COUNT(*) AS total_orders,
    SUM(delivery_date IS NULL) AS missing_delivery_dates,
    ROUND(
        SUM(delivery_date IS NULL) * 100.0 / COUNT(*),
        2
    ) AS missing_percentage
FROM orders
GROUP BY order_status
ORDER BY missing_percentage DESC;

-- Question 16: Orders by Shipping City

SELECT
    shipping_city,
    COUNT(*) AS total_orders
FROM orders
GROUP BY shipping_city
ORDER BY total_orders DESC;

-- Question 17: Orders by Shipping State

SELECT
    shipping_state,
    COUNT(*) AS total_orders
FROM orders
GROUP BY shipping_state
ORDER BY total_orders DESC;

-- Question 18: Order Status vs Payment Status

SELECT
    o.order_status,
    p.payment_status,
    COUNT(*) AS total_orders,
    ROUND(SUM(p.amount), 2) AS total_payment_amount
FROM orders o
JOIN payments p
    ON o.order_id = p.order_id
GROUP BY
    o.order_status,
    p.payment_status
ORDER BY
    o.order_status,
    total_orders DESC;

-- Question 19: Customer Average Order Value

SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price) - oi.discount
        ),
        2
    ) AS total_spent,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price) - oi.discount
        ) / COUNT(DISTINCT o.order_id),
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

-- Question 20: Product Profit Margin

SELECT
    p.product_name,
    ROUND(
        SUM(
            (oi.quantity * oi.unit_price) - oi.discount
        ),
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
        (
            SUM(
                (oi.quantity * oi.unit_price)
                - oi.discount
                - (oi.quantity * p.cost)
            )
            /
            SUM(
                (oi.quantity * oi.unit_price) - oi.discount
            )

-- Question 21: Orders by Customer Gender

SELECT
    c.gender,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.gender
ORDER BY total_orders DESC;


        ) * 100,
        2
    ) AS profit_margin_percent
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY profit_margin_percent DESC;

-- Question 22: Revenue by Customer Gender

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

-- Question 22: Revenue by Customer Gender

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

-- Question 23: Customer Signups by Year

SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS new_customers
FROM customers
GROUP BY YEAR(signup_date)
ORDER BY signup_year;


-- Question 24: Revenue by Shipping State

SELECT
    o.shipping_state,
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
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.shipping_state
ORDER BY total_revenue DESC;


-- Question 25: Discount Impact by Product

SELECT
    p.product_name,
    ROUND(SUM(oi.discount), 2) AS total_discount,
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

-- Question 26: Discount Rate by Product

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

-- Question 27: Revenue by Order Status

SELECT
    o.order_status,
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
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_revenue DESC;

-- Question 28: Monthly Order Volume

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

-- Question 29: Yearly Revenue Comparison

SELECT
    YEAR(o.order_date) AS order_year,
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
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY order_year;

-- Question 30: Order Status Distribution

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders),
        2
    ) AS order_percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Question 31: Cancellation Rate by State

SELECT
    shipping_state,
    COUNT(*) AS total_orders,
    SUM(order_status = 'Cancelled') AS cancelled_orders,
    ROUND(
        SUM(order_status = 'Cancelled') * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_percent
FROM orders
GROUP BY shipping_state
ORDER BY cancellation_rate_percent DESC;

-- Question 32: Revenue by Payment Method

SELECT
    payment_method,
    COUNT(*) AS total_payments,
    ROUND(SUM(amount), 2) AS total_payment_amount,
    ROUND(AVG(amount), 2) AS average_payment_amount
FROM payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

-- Question 33: Top Customers by Spending

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

-- Question 34: Category Revenue and Profit

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

-- Question 35: Top Products by Revenue and Profit

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
ORDER BY total_profit DESC
LIMIT 10;noo