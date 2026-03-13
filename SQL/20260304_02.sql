-- SubQuery = 서브쿼리
-- SQL 구문안에 또 하나의 SQL 구문을 작성하는 것
-- 1) 동일한 테이블 안에서 조건식을 생성하고자 하는데, 조건의 기준값을
-- 먼저 만들어 놓고 시작해야하는 경우
-- 10사람의 나이값을 가지고 있는 테이블 존재
-- 전체 나이 평균값을 기준으로 많은가, 적은가 판단!!!

SELECT *
FROM users
WHERE age > (
	SELECT AVG(age) FROM users
);

-- 대부분의 구문이 JOIN & SubQuery가 모두 통용되는 경우
-- INNER JOIN -> 모두 다 합친 후 해당 테이블에서 값을 찾아낸다
-- A : 20개 // B : 50개 => A + B => 특정조건 매칭값 

-- 서로 다른 2개 테이블에서 특정 1개 컬럼을 교집합으로 간주하고, 조건에 맞는 컬럼을 찾아온다
-- 서브쿼리가 단순히 1~2, 3~4 => 상관서브쿼리
-- 문법의 가독성이 매우 안좋아짐 

USE bestproducts;
SHOW TABLES;

SELECT * FROM items LIMIT 1;
SELECT DISTINCT sub_category FROM ranking;

SELECT title
FROM items I
INNER JOIN ranking R ON I.item_code = R.item_code
WHERE R.sub_category = "여성신발";




-- SELECT title
-- FROM items
-- WHERE 
-- (SELECT item_code FROM ranking);



SELECT * FROM items
WHERE item_code IN
	("102425348", "104914497", "106332300");
    
    
-- 102425348
-- 104914497
-- 106332300

-- DESC items;

SELECT MAX(dis_price)
FROM items I
WHERE item_code IN
	(SELECT item_code FROM ranking
    WHERE sub_category = "여성신발");

USE sakila;
SHOW TABLES;

SELECT * FROM film_category LIMIT 10;
DESC film_category;

SELECT * FROM category LIMIT 10;
DESC film_category;

SELECT * FROM film_category LIMIT 10;

SELECT category_id, COUNT(*) Film_count
FROM film_category FC
WHERE FC.category.id >
	(SELECT C.category_id FROM category C
    WHERE name = "Comedy")
GROUP BY FC.category_id;

-- bestproducts
-- 메인카테고리 내 카테고리별 할인가격이 10만원 이상인 상품이 몇개 있는지 출력
-- JOIN으롷 문제 풀기

USE bestproducts;

SELECT * FROM items;

SELECT main_category, COUNT(*) item_count
FROM ranking R
INNER JOIN items I ON R.item_code = I.item_code
WHERE I.dis_price >= 100000
GROUP BY main_category
ORDER BY item_count DESC;

-- 방금 위 문제를 서브쿼리로 해결해주세요
SELECT main_category, COUNT(*) item_count
FROM ranking R
WHERE R.item_code IN
	(SELECT I.item_code FROM items
    WHERE I.dis_price >= 100000)
GROUP BY R.main_category;

-- dis_price 20만원 이상인 아이템들의 개수를 sub_category별로 취합해서 출력
-- JOIN // 서브쿼리

SELECT * FROM items;
SELECT * FROM ranking;

SELECT sub_category, COUNT(*) item_count
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE I.dis_price >= 200000
GROUP BY sub_category;

SELECT sub_category, COUNT(*) item_count 
FROM ranking R
WHERE R.item_code IN
	(SELECT I.item_code FROM items
    WHERE I.dis_price >= 200000)
GROUP BY R.sub_category;

-- 메인카테고리 & 서브카테고리별 평균할인가격과 평균할인율을 출력해주세요
SELECT *
FROM ranking R
JOIN items I ON R.item_code = I.item_code;
WHERE (SELECT ranking AVG(discount) FROM ranking)
GROUP BY sub_category;

SELECT * FROM ranking LIMIT 1;

SELECT
	R.main_category,
	R.sub_category,
    ROUND(AVG(dis_price), 2) avg_price,
    ROUND(AVG(discount_percent), 2) avg_discount
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, R.sub_category;

-- 판매자별 베스트상품갯수, 평균할인가격, 평균할인률을 내림차순으로 출력
SELECT * FROM ranking;
SELECT * FROM items;

SELECT
	provider,
	COUNT(*) item_count,
    ROUND(AVG(dis_price), 2) dis_price,
    ROUND(AVG(discount_percent), 2) dis_percent
FROM items I
WHERE provider <> "" AND provider IS NOT NULL
GROUP BY provider
ORDER BY item_count DESC;

-- SQL -> NULL (결측치) -> IS NULL | IS NOT NULL

-- 메인 카테고리별 상품갯수가 20개 이상인 판매자의 판매자별 평균할인가격, 평균할인율, 상품갯수 출력
SELECT * FROM ranking;
SELECT * FROM items;

-- 메인 카테고리별 상품갯수가 20개 이상
SELECT R.main_category, COUNT(*) item_count
FROM ranking R 
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category
HAVING item_count >= 20;

-- 
SELECT
	R.main_category,
    ROUND(AVG(dis_price)) dis_price,
    ROUND(AVG(discount_percent)) dis_percent,
    COUNT(*) item_count
FROM ranking R 
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, provider
HAVING item_count >= 20;

-- dis_price가 5만원 이상인 상품들 중 main_category별 dis_price, discount_percent 출력
SELECT * FROM ranking;
SELECT * FROM items;

SELECT
	main_category,
    dis_price
FROM items I
JOIN ranking R ON I.item_code = R.item_code
WHERE I.dis_price >= 50000
GROUP BY main_category;

SELECT
	main_category,
    ROUND(AVG(dis_price)) dis_price,
    ROUND(AVG(discount_percent)) dis_percent
FROM items I
JOIN ranking R ON I.item_code = R.item_code
WHERE I.dis_price >= 50000
GROUP BY R.main_category;

USE bestproducts;
SELECT * FROM items;
SELECT * FROM ranking;



SELECT
	R.main_category,
    R.sub_category
FROM items I
JOIN ranking R ON I.item_code = R.item_code
GROUP BY  R.main_category, R.sub_category;

ORDER BY I.discount_percent DESC


SELECT
	R.main_category,
	R.sub_category,
    I.discount_percent
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, R.sub_category;

-- 메인카테고리 & 서브카테고리별 평균할인가격과 평균할인율을 출력해주세요
SELECT
	R.main_category,
	R.sub_category,
    ROUND(AVG(dis_price), 2) avg_price,
    ROUND(AVG(discount_percent), 2) avg_discount
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, R.sub_category;



SELECT
    R.main_category,
    R.sub_category,
    I.discount_percent
FROM ranking R
JOIN items I ON R.item_code = I.item_code
ORDER BY I.discount_percent DESC LIMIT 3;


SELECT
    R.main_category,
    R.sub_category,
    MAX(I.discount_percent) max_discount
FROM ranking R
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category, R.sub_category
ORDER BY max_discount DESC;

LIMIT 3;

