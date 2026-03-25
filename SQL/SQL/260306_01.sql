/*
DDL
DML
DCL
JOIN / INNER JOIN / LEFT JOIN / RIGHT JOIN
문자열 / 날짜 / 숫자
서브쿼리 (SubQuery) : 어떤 쿼리문을 작성하는데 있어서 사전에 필요한 자료를 독립적으로 취합함으로써
					전체 쿼리문의 가독성을 높여주는 문법이다 (연결성 x, 독립적 o)

상관 = 연결 (Correlated) 서브쿼리 : 쿼리문안에 별도의 쿼리문

*/

-- 각 고객 > DVD렌탈, 결제금액 지불 // 그동안 결제한 금액 평균값보다 큰 금액으로 결제한 정보를 찾고 싶음

USE sakila;
SHOW TABLES;
SELECT * FROM payment LIMIT 10;

SELECT p1.customer_id, p1.amount, p1.payment_date
FROM payment p1
WHERE p1.amount > (
	SELECT AVG(amount)
	FROM payment p2
	WHERE p2.customer_id = p1.customer_id
);

SELECT p1.customer_id, p1.amount, p1.payment_date
FROM payment p1;

-- film 테이블에서 영화길이 (length)의 평균값을 구해서 해당 영화길이보다 긴 영화들의 제목(title)을 찾아주세요

SELECT title, length
FROM film
WHERE length > (
	SELECT AVG(length)
    FROM film
);

-- rental 테이블에서 고객별 평균 대여 횟수보다 더 많은 대여를 한 고객들의 이름을 출력해주세요.
SELECT * FROM customer LIMIT 10;
SELECT * FROM rental LIMIT 10;


SELECT
	first_name, last_name,
    CONCAT(first_name, " ",last_name) Full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT
			AVG(rental_count)
		FROM (
			SELECT COUNT(*) rental_count
			FROM rental
			GROUP BY customer_id
		) rental_counts
    )
);


-- 가장 많은 영화를 대여한 고객의 이름을 찾아보세요!
SELECT
	CONCAT(first_name, " ", last_name) Full_name
FROM customer
WHERE customer_id = (
	SELECT customer_id
    FROM (
		SELECT customer_id, COUNT(*) rental_count
		FROM rental
		GROUP BY customer_id
		ORDER BY rental_count DESC
		LIMIT 1
    ) t
);

-- 각 고객별, 자신이 대여한 영화들의 평균 상영시간보다 긴 영화 제목들의 제목을 찾아서 출력
-- 왕사남 => DVD => 렌탈가게 // 본사 -> 지점 -> 강남점, 영등포점, 신림점
-- 동일한 타이틀의 DVD => 매장별로 몇개씩 재고 보유 // 재고관리, 렌탈
--
SHOW TABLES;

SELECT * FROM customer LIMIT 10; -- 고객 이름 등 정보 등 / customer_id
SELECT * FROM rental LIMIT 10; -- 렌탈관련 정보 / customer_id, rental_id, inventory_id, 
SELECT * FROM inventory LIMIT 10; -- 재고 관련 정보 / inventory_id, film_id, 
SELECT * FROM film LIMIT 10; -- 영화 제목, 상영시간 등 / film_id 


SELECT C.first_name, C.last_name, F.title
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
	FROM customer CUS
	JOIN rental REN ON CUS.customer_id = REN.customer_id
	JOIN inventory INV ON REN.inventory_id = INV.inventory_id
	JOIN film FIL ON INV.film_id = FIL.film_id
    WHERE CUS.customer_id = REN.customer_id
);

/*
1) 서브쿼리 : 쿼리문 안에 쿼리문 > 내부 쿼리문 작성 시, 독립적으로 쿼리문을 작성한다
2) 상관서브쿼리 : 쿼리문 안에 쿼리문 > 내부 쿼리문 작성 시, 외부 쿼리문의 값을 참조 (상관)

*/







