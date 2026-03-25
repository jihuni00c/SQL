/*
rental과 inventory 테이블을 join하고, film 테이블에 있는 replacement_cost가 $20달러 이상인 영화를
대여한 고객의 이름을 찾아서 출력해주세요. 단, 고객의 이름은 소문자로 출력
*/
SELECT * FROM rental; -- inventory_id
SELECT * FROM inventory; -- inventory_id, film_id, store_id
SELECT * FROM film; -- film_id
SELECT * FROM customer LIMIT 10; -- 고객 이름 등 정보 등 / customer_id > first_name, last_nam

SELECT
	C.first_name, C.last_name,
    LOWER(CONCAT(C.first_name, " ", C.last_name)) Full_name
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id 
JOIN film F ON I.film_id = F.film_id
WHERE F.replacement_cost >= 20;

/*
영화 등급이 PG-13인 영화들 중, 영화의 설명문구의 길이가 평균 이상인 영화들의 제목만 찾아서 출력해주세요.
*/

SELECT title
FROM film
WHERE rating = "PG-13" AND LENGTH(description) > (
	SELECT AVG(LENGTH(description))
	FROM film
	WHERE rating = "PG-13"
	LIMIT 10
);

/*
2005년 8월에 대여된 모든 DVD 중 "R" 둥급에 해당하는 영화만 추출해서 해당 영화들의 제목과
그 영화를 대여한 고객들의 이메일을 찾아서 출력해주세요
*/

SELECT * FROM rental; -- inventory_id
SELECT * FROM inventory; -- inventory_id, film_id, store_id
SELECT * FROM film; -- film_id

SELECT F.title, C.email
FROM customer C
JOIN rental R ON C.customer_id = R.customer_id
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
WHERE
	MONTH(R.rental_date) = 8
    AND YEAR(R.rental_date) = 2005
    AND F.rating = "R";

SELECT F.title, C.email
FROM customer C
JOIN rental R USING(customer_id)
JOIN inventory I USING(inventory_id)
JOIN film F USING(film_id)
WHERE
	MONTH(R.rental_date) = 8
    AND YEAR(R.rental_date) = 2005
    AND F.rating = "R";



/*
각 고객별 가장 마지막에 결제한 날짜에서 30일 이전까지의 모든 결제내역을 찾고
해당 결제 내역에 대해서 총 결제 금액의 합과 평균 결제 금액의 평균값을 소수점 둘째자리에서 반올림해서 출력해주세요
*/

-- 결과 2번째줄
SELECT
	customer_id,
    ROUND(SUM(amount), 1),
    ROUND(AVG(amount), 1)
FROM payment
GROUP BY customer_id;

-- 
SELECT
	customer_id,
    ROUND(SUM(amount), 1) customer_sum,
    ROUND(AVG(amount), 1) customer_avg
FROM payment
WHERE payment_date >= DATE_SUB(
	(SELECT MAX(payment_date) FROM payment), INTERVAL 30 DAY
)
GROUP BY customer_id;

/*
영화 장르 중 공상과학영화 장르에 출연한 영화배우의 이름을 찾아서 출력해주세요. 출력 시
배우의 이름은 성과 이름을 연결해서 대문자로 출력
*/
SHOW TABLES;
SELECT * FROM film; -- actor_id
SELECT * FROM film_actor; -- actor_id, film_id
SELECT * FROM film_category; -- film_id, category_id
SELECT * FROM category; -- category_id

SELECT
	UPPER(CONCAT(A.first_name, " ", A.last_name)) actor_name
FROM actor A
JOIN film_actor USING(actor_id)
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE name = "Sci-Fi";



