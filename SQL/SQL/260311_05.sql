/*
중급 문법 마지막
> CONACT() : 컬럼간 문자열 하나로 합쳐서 새로운 컬럼으로 출력
> GROUP_CONCAT() : 1개의 컬럼 내 여러개의 행이 존재하는 경우, 그 각각의 행에 존재하는 문자열을 하나의 셀 안으로 합치고자 할 때

*/

SELECT
	c.customer_id,
    CONCAT(c.first_name, " ", c.last_name) customer_name,
    GROUP_CONCAT(f.title ORDER BY f.title ASC) rented_movies
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY c.customer_id;

SELECT
	c.customer_id,
    CONCAT(c.first_name, " ", c.last_name) customer_name,
    GROUP_CONCAT(f.title ORDER BY f.title ASC SEPARATOR " / ") rented_movies
FROM customer c
JOIN rental r USING(customer_id)
JOIN inventory i USING(inventory_id)
JOIN film f USING(film_id)
GROUP BY c.customer_id;

-- 각 배우들이 출연한 영화제목을 세미콜론을 구분자로 구분하여 하나의 셀에 출력
-- 최종 출력 > 영화배우아이디, 이름, 출연작

SELECT * FROM film; -- film_id
SELECT * FROM film_actor; -- film_id & actor_id
SELECT * FROM actor; -- actor_id

-- 여기는 이름까지
SELECT
	A.actor_id,
    CONCAT(A.first_name, " ", A.last_name) full_name
FROM actor A
JOIN film_actor FA USING(actor_id)
JOIN film F USING(film_id)
GROUP BY actor_id;

-- 끝까지
SELECT
	A.actor_id,
    CONCAT(A.first_name, " ", A.last_name) full_name,
    GROUP_CONCAT(F.title ORDER BY F.title SEPARATOR " , ") films
FROM actor A
JOIN film_actor FA USING(actor_id)
JOIN film F USING(film_id)
GROUP BY actor_id;









