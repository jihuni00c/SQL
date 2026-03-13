
-- 2026-03-06 미션
CREATE DATABASE IF NOT EXISTS bookstoscrape
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE bookstoscrape;

SHOW TABLES;

SELECT
    b.book_id,
    b.title,
    p.price_id,
    p.price_info
FROM books b
JOIN prices p ON b.book_id = p.book_id;



CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    category_id INT
);

CREATE TABLE IF NOT EXISTS prices (
    price_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    price_info VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    stock_count INT NOT NULL
);





