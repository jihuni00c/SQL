CREATE DATABASE IF NOT EXISTS daumnews_crawling_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE daumnews_crawling_db;

CREATE TABLE IF NOT EXISTS tech_news (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(300) NOT NULL,
    link VARCHAR(300) NOT NULL
);

DESC tech_news;

SELECT * FROM tech_news;




