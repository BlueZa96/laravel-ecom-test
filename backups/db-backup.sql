-- PostgreSQL migration script for ecommerce database

-- Disable notices
SET client_min_messages TO WARNING;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS cache CASCADE;
DROP TABLE IF EXISTS cache_locks CASCADE;
DROP TABLE IF EXISTS failed_jobs CASCADE;
DROP TABLE IF EXISTS job_batches CASCADE;
DROP TABLE IF EXISTS jobs CASCADE;
DROP TABLE IF EXISTS migrations CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS password_reset_tokens CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS sessions CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create cache table
CREATE TABLE cache (
    key VARCHAR(255) NOT NULL,
    value TEXT NOT NULL,
    expiration INTEGER NOT NULL,
    PRIMARY KEY (key)
);

-- Create cache_locks table
CREATE TABLE cache_locks (
    key VARCHAR(255) NOT NULL,
    owner VARCHAR(255) NOT NULL,
    expiration INTEGER NOT NULL,
    PRIMARY KEY (key)
);

-- Create failed_jobs table
CREATE TABLE failed_jobs (
    id BIGSERIAL PRIMARY KEY,
    uuid VARCHAR(255) NOT NULL UNIQUE,
    connection TEXT NOT NULL,
    queue TEXT NOT NULL,
    payload TEXT NOT NULL,
    exception TEXT NOT NULL,
    failed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create job_batches table
CREATE TABLE job_batches (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    total_jobs INTEGER NOT NULL,
    pending_jobs INTEGER NOT NULL,
    failed_jobs INTEGER NOT NULL,
    failed_job_ids TEXT NOT NULL,
    options TEXT,
    cancelled_at INTEGER DEFAULT NULL,
    created_at INTEGER NOT NULL,
    finished_at INTEGER DEFAULT NULL
);

-- Create jobs table
CREATE TABLE jobs (
    id BIGSERIAL PRIMARY KEY,
    queue VARCHAR(255) NOT NULL,
    payload TEXT NOT NULL,
    attempts SMALLINT NOT NULL,
    reserved_at INTEGER DEFAULT NULL,
    available_at INTEGER NOT NULL,
    created_at INTEGER NOT NULL
);
CREATE INDEX jobs_queue_index ON jobs (queue);

-- Create migrations table
CREATE TABLE migrations (
    id SERIAL PRIMARY KEY,
    migration VARCHAR(255) NOT NULL,
    batch INTEGER NOT NULL
);

-- Insert migrations data
INSERT INTO migrations (id, migration, batch) VALUES 
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_27_173153_create_products_table', 2),
(5, '2025_03_27_173421_create_orders_table', 2),
(6, '2025_03_27_173430_create_order_items_table', 2);

-- Create orders table
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL
);

-- Create products table
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL
);

-- Insert product data
INSERT INTO products (id, name, price, quantity, created_at, updated_at) VALUES 
(1, 'Смартфон Apple iPhone 13', 599.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(2, 'Ноутбук Lenovo ThinkPad X1', 1299.50, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(3, 'Беспроводные наушники Sony WH-1000XM4', 349.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(4, 'Умные часы Samsung Galaxy Watch 4', 249.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(5, 'Портативная колонка JBL Flip 6', 129.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(6, 'Планшет iPad Pro 11', 799.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(7, 'Игровая консоль PlayStation 5', 499.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(8, 'Фотоаппарат Canon EOS R6', 2399.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(9, 'Робот-пылесос Roomba i7+', 799.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(10, 'Монитор LG UltraFine 4K', 599.50, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(11, 'Геймпад Xbox Wireless', 59.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(12, 'Внешний SSD Samsung T7 1TB', 139.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(13, 'Bluetooth-гарнитура AirPods Pro', 249.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(14, 'Электронная книга Kindle Paperwhite', 139.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(15, 'Умная колонка Amazon Echo', 99.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(16, 'Графический планшет Wacom Intuos', 199.50, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(17, 'Экшн-камера GoPro HERO9', 349.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(18, 'Квадрокоптер DJI Mini 2', 449.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(19, 'Смарт-часы Garmin Fenix 6', 649.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(20, 'Внешний аккумулятор Anker PowerCore', 59.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(21, 'Игровая мышь Razer DeathAdder', 79.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(22, 'Механическая клавиатура Logitech G513', 149.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(23, 'Externes Grafikkartenmodul eGPU', 399.50, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(24, 'Bluetooth-трекер Apple AirTag', 29.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(25, 'Кофемашина Nespresso Vertuo', 199.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(26, 'Умный термостат Nest Learning', 249.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(27, 'Беспроводное зарядное устройство Anker', 39.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(28, 'Электрическая зубная щетка Oral-B iO', 299.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(29, 'Проектор BenQ TH685', 799.00, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06'),
(30, 'VR-гарнитура Oculus Quest 2', 399.99, 1, '2025-03-27 17:57:06', '2025-03-27 17:57:06');

-- Create order_items table
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL,
    CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT order_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Create password_reset_tokens table
CREATE TABLE password_reset_tokens (
    email VARCHAR(255) PRIMARY KEY,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NULL
);

-- Create sessions table
CREATE TABLE sessions (
    id VARCHAR(255) PRIMARY KEY,
    user_id BIGINT DEFAULT NULL,
    ip_address VARCHAR(45) DEFAULT NULL,
    user_agent TEXT,
    payload TEXT NOT NULL,
    last_activity INTEGER NOT NULL
);
CREATE INDEX sessions_user_id_index ON sessions (user_id);
CREATE INDEX sessions_last_activity_index ON sessions (last_activity);

-- Insert sessions data
INSERT INTO sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES 
('Lvi8uco9mqFw6pZhNX65msBYvjxr0MGY9VYhXzhi', NULL, '172.19.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQngxdHJTbjhMRU1IV2tOeDFzWVNHRlZtTGMwTGlvN2l4a21ycDN2YiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly9sb2NhbGhvc3Q6OTAwMC9jYXJ0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo0OiJjYXJ0IjthOjE6e2k6MTthOjM6e3M6NDoibmFtZSI7czoxMDoiaWxsdW0gZnVnYSI7czo1OiJwcmljZSI7czo2OiIyNjEuNzMiO3M6ODoicXVhbnRpdHkiO3M6MToiMSI7fX19', 1743100639);

-- Create users table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    email_verified_at TIMESTAMP DEFAULT NULL,
    password VARCHAR(255) NOT NULL,
    remember_token VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT NULL
);

-- Reset sequences for id columns
SELECT setval('migrations_id_seq', (SELECT MAX(id) FROM migrations));
SELECT setval('products_id_seq', (SELECT MAX(id) FROM products));