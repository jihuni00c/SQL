/*
8. Comedy, Sports, Family 카테고리에 해당되는 영화들의 렌탈 횟수를 조회.출력
출력 시, 카테고리 이름, 렌탈횟수 출력되어야 함
*/

USE sakila;

SHOW TABLES;

SELECT * FROM rental;

-- 카테고리 가져오기 
SELECT name
FROM category
WHERE name in ("Comedy", "Sports", "Family")
GROUP BY category_id;
--
-- 
SELECT
	C.name, COUNT(*) category_count
FROM category C
JOIN film_category F USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
WHERE name in ("Comedy", "Sports", "Family")
GROUP BY C.category_id
ORDER BY category_count DESC;

SELECT * FROM film_category; -- category_id, film_id
SELECT * FROM inventory; -- film_id, inventory_id
SELECT * FROM rental; -- inventory_id 연결

-- 9. Comedy 카테고리 영화들의 렌탈횟수 조회.출력 (단, 서브쿼리로 해결)
SELECT COUNT(*)
FROM rental
WHERE inventory_id IN (
	SELECT inventory_id FROM inventory
	WHERE film_id IN (
		SELECT film_id FROM film_category
		WHERE category_id IN (
			SELECT category_id FROM category
			WHERE name = "Comedy"
		)
	)
);

SELECT *
FROM rental;

SELECT name
FROM category
WHERE name in ("Comedy")
GROUP BY category_id;



-- 서브쿼리 (SELECT > SELECT 구문)
-- 어떤 조건안에서 특정 값을 찾아와야 하는 경우, JOIN vs SubQuery
-- JOIN : 컬럼의 갯수가 무한정 늘어나는 단점, 직관적으로 테이블 연결
-- SubQuery : 먼저 특정 조건과 관련한 쿼리문을 실행시킨 후, 외부쿼리문을 통해서
-- 연결고리를 찾는 과정을 거치기 때문에 데이터 조회하는데, 시간이 그렇게 많이 걸리지 장점

-- 10. Comedy 카테고리 영화의 갯수를 조회.출력해주세요. (단, INNER JOIN으로 사용)


SELECT COUNT(*) comedy_films
FROM film_category F
JOIN category C USING(category_id)
WHERE name = "Comedy";


-- 11. address 테이블에는 address_id가 존재하지만 , customer 테이블에는 address_id가
-- 존재하지 않는 데이터 갯수 출력


/*
1. 카테고리별 대여횟수 TOP3인 영화 조회.찾기
2. 월별 매출에 따른 증감률 구해서 출력
*/

SELECT c.name, COUNT(*)
FROM category c
JOIN film_category f USING(category_id)
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
GROUP BY c.category_id;

SELECT * FROM film_category; -- category_id, film_id
SELECT * FROM inventory; -- film_id, inventory_id
SELECT * FROM rental; -- inventory_id 연결







