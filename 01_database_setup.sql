-- ============================================================
-- ShopSphere SQL Case Study
-- File: 01_database_setup.sql
-- Purpose: Database and table setup
-- Database: shopsphere
-- ============================================================


-- Create database
CREATE DATABASE IF NOT EXISTS shopsphere;

-- Select database
USE shopsphere;


-- ============================================================
-- 1. Categories
-- ============================================================

CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);


-- ============================================================
-- 2. Customers
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    gender VARCHAR(20),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);


-- ============================================================
-- 3. Numbers
-- Helper table used for generating records
-- ============================================================

CREATE TABLE IF NOT EXISTS numbers (
    n INT PRIMARY KEY
);


-- ============================================================
-- 4. Products
-- ============================================================

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    cost DECIMAL(10,2),
    stock_quantity INT,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);


-- ============================================================
-- 5. Orders
-- ============================================================

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    order_status VARCHAR(30),
    shipping_city VARCHAR(50),
    shipping_state VARCHAR(50),
    delivery_date DATE,
    expected_delivery_date DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- ============================================================
-- 6. Order Items
-- ============================================================

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(10,2) DEFAULT 0.00,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- ============================================================
-- 7. Payments
-- ============================================================

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    amount DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


-- ============================================================
-- 8. Reviews
-- ============================================================

CREATE TABLE IF NOT EXISTS reviews (
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT,
    review_date DATE,
    review_text TEXT,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


-- ============================================================
-- Verify tables
-- ============================================================

SHOW TABLES;