USE sakila;

-- 1. 한 번도 대여되지 않은 영화 찾기
SELECT
	F.title,
    F.film_id
FROM film F
JOIN inventory I USING(film_id)
LEFT JOIN rental R USING(inventory_id)
WHERE R.rental_id IS NULL
GROUP BY F.title, F.film_id;

SELECT * FROM inventory LIMIT 10; -- inventory_id, film_id
SELECT * FROM rental LIMIT 10; -- rental_id, inventory_id

-- 고객별 누적 결제금액을 등급 분류 & 등급별 상위 3명씩만 조회,출력
-- 총결제액 100 이상 : vip / 100미만 50이하 : GOLD / 50미만 : SILVER

SELECT * FROM customer LIMIT 10; -- customer_id
SELECT * FROM payment LIMIT 10; -- customer_id

-- 총 결제금액
SELECT
	CONCAT(first_name, " ", last_name) full_name,
    SUM(P.amount) total_payment
FROM customer C
JOIN payment P USING(customer_id)
GROUP BY C.customer_id;

--
-- 1. 한 번도 대여되지 않은 영화 찾기
SELECT
    F.title,
    F.film_id
FROM film F
JOIN inventory I USING(film_id)
LEFT JOIN rental R USING(inventory_id)
WHERE R.rental_id IS NULL
GROUP BY F.title, F.film_id;

SELECT * FROM inventory LIMIT 10; -- inventory_id, film_id
SELECT * FROM rental LIMIT 10; -- rental_id, inventory_id

-- 고객별 누적 결제금액을 등급 분류 & 등급별 상위 3명씩만 조회,출력
-- 총결제액 100 이상 : vip / 100미만 50이하 : GOLD / 50미만 : SILVER

SELECT * FROM customer LIMIT 10; -- customer_id
SELECT * FROM payment LIMIT 10; -- customer_id

-- 총 결제금액
SELECT
    CONCAT(first_name, " ", last_name) full_name,
    SUM(P.amount) total_payment
FROM customer C
JOIN payment P USING(customer_id)
GROUP BY C.customer_id;

--
SELECT
    t.customer_id,
    t.full_name,
    t.total_payment,
    t.grade,
    (
        SELECT COUNT(*)
        FROM (
            SELECT
                C.customer_id,
                SUM(P.amount) total_payment,
                CASE
                    WHEN SUM(P.amount) >= 100 THEN "VIP"
                    WHEN SUM(P.amount) >= 50 THEN "GOLD"
                    ELSE "SILVER"
                END grade
            FROM customer C
            JOIN payment P USING(customer_id)
            GROUP BY C.customer_id
        ) t2
        WHERE t2.grade = t.grade AND t2.total_payment > t.total_payment
    ) + 1 grade_rank
FROM (
    SELECT
        C.customer_id,
        CONCAT(C.first_name, " ", C.last_name) full_name,
        SUM(P.amount) total_payment,
        CASE
            WHEN SUM(P.amount) >= 100 THEN "VIP"
            WHEN SUM(P.amount) >= 50 THEN "GOLD"
            ELSE "SILVER"
        END grade
    FROM customer C
    JOIN payment P USING(customer_id)
    GROUP BY C.customer_id
) t
HAVING grade_rank <= 3
ORDER BY grade, grade_rank;




-- 어떤 값을 조회, 기본 베이스를 만들어놓고, 해당 베이스를 기반으로 비교!
-- 상관서브쿼리 (외부서브쿼리의 값을 참조, 내부서브쿼리의 연산)
