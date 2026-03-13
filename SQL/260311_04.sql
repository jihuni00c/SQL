/*
CASE WHEN : ~할 때
*/

SELECT * FROM film LIMIT 10;

SELECT title,
CASE
	WHEN rental_rate < 1 THEN "Cheap"
    WHEN rental_rate BETWEEN 1 AND 3 THEN "Moderate"
    ELSE "Expensive"
END AS price_category
FROM film;

-- WITH 절 활용, 각 등급별 영화 상영시간의 평균길이를 출력하세요

WITH avgfilmlength AS (
	SELECT rating, AVG(LENGTH(length))
	FROM film GROUP BY rating
)
SELECT * FROM avgfilmlength;

-- customer 테이블의 고객별 active 여부에 따라 Active 혹은 Inactive로 출력

SELECT * FROM customer LIMIT 10;

SELECT customer_id,
	CASE
		WHEN active = 1 THEN "Active"
        ELSE "Inactive"
	END AS customer_status
FROM customer;


-- 영화 등급별, 평균 대여기간을 WITH 가상 테이블을 활용해서 계산 및 출력해주세요!

SELECT * FROM film;
SELECT * FROM rental;
SELECT * FROM payment;
SELECT * FROM customer;

WITH avgRentalDuration AS (
	SELECT rating, AVG(rental_duration)
	FROM film
    GROUP BY rating
)
SELECT * FROM avgRentalDuration;

-- WITH절을 사용해서, 고객별 총 결제액을 계산 후 해당 결제금액 구간에 따라 다음과 같이 카테고리를 분류
-- 0 ~ 50 : LOW / 51 ~ 100 : Medium / 100초과 : High

SELECT * FROM payment;

WITH customerPayments AS (
	SELECT
		customer_id, SUM(amount) AS total_payment
	FROM payment
	GROUP BY customer_id
)
SELECT
	customer_id, total_payment,
    CASE
		WHEN total_payment BETWEEN 0 AND 50 THEN "LOW"
        WHEN total_payment BETWEEN 51 AND 100 THEN "Medium"
        ELSE "High"
	END AS payment_status
FROM customerPayments;








