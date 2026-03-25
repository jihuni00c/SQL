USE sakila;

-- 13. 최근 젊은 가족단위의 매출이 저조해서, 가족들이 볼만한 영화들을 추려서
-- 마케팅을 하려고 합니다. 현재 우리가 가지고 있는 영화들 중에서 장르가
-- 가족 인 영화리스트만 조회 & 출력! -> 장르가 가족인 영화들을 조회(영화제목), 출력 

SHOW TABLES;

SELECT * FROM film LIMIT 10; -- film_id
SELECT * FROM film_category LIMIT 10; -- film_id, category_id
SELECT * FROM category LIMIT 10; -- category_id

SELECT F.title
FROM film F
JOIN film_category FC USING(film_id)
JOIN category CA USING(category_id)
WHERE CA.name = "Family";

/*
14. 현재 우리가 가지고 있는 영화들 중 가장 인기가 많은 영화 100개만 조회.출력
-> 인기가 많다 : 대여가 많이 발생되었다
-> 출력대상 : 영화제목, 대여횟수
*/

SELECT * FROM film LIMIT 10; -- film_id
SELECT * FROM inventory LIMIT 10; -- film_id, inventory_id
SELECT * FROM rental LIMIT 10; -- inventory_id

SELECT F.title, COUNT(*) rentals
FROM film F
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
GROUP BY F.film_id
ORDER BY rentals DESC
LIMIT 100;

/*
15. 연말이 되었습니다. 각 국가 내 도시 매장별 매출에 따라서 인센티브를 제공하려고 합니다.
국가 > 도시 매장별 총 매출을 기준으로 데이터를 조회.출력
출력대상 : 국가 & 도시 / 총 매출액
*/

SHOW TABLES;

-- SELECT * FROM country LIMIT 10; -- country_id
-- SELECT * FROM city LIMIT 10; -- country_id, city_id
-- SELECT * FROM address LIMIT 10; -- city_id, address_id
-- SELECT * FROM staff LIMIT 10; -- address_id, staff_id, store_id
-- SELECT * FROM payment LIMIT 10; -- staff_id, 
-- SELECT * FROM store LIMIT 10; -- address_id, store_id

SELECT * FROM payment LIMIT 10; -- staff_id, 
SELECT * FROM staff LIMIT 10; -- staff_id, store_id
SELECT * FROM store LIMIT 10; -- store_id, address_id
SELECT * FROM address LIMIT 10; -- address_id, city_id
SELECT * FROM city LIMIT 10; -- city_id, country_id
SELECT * FROM country LIMIT 10; -- country_id


SELECT
	CONCAT(CO.country, " ", CI.city) zone,
    SUM(P.amount) totalsales
FROM payment P
JOIN staff STA USING(staff_id)
JOIN store STO USING(store_id)
JOIN address A ON A.address_id = STO.address_id
JOIN city CI USING(city_id)
JOIN country CO USING(country_id)
GROUP BY STO.store_id;

/*
16. 지금까지의 렌탈한 기록을 기준으로 최상위 주요고객 10명에게 감사의 선물을 발신할 예정입니다.
최상위 주요고객의 주소, 이메일, 해당 고객의 렌탈결제 총 금액 조회.출력
최상위 주요고객 자격기준 : 그동안 렌탈한 결제 금액 순 (내림차순)

고객
렌탈금액
주소
*/

SHOW TABLES;

SELECT * FROM payment LIMIT 10; -- customer_id
SELECT * FROM customer LIMIT 10; -- customer_id, address_id
SELECT * FROM address LIMIT 10; -- address_id

SELECT 
	CONCAT(C.first_name, " ", C.last_name) full_name,
	A.address,
	SUM(P.amount) total_amount
FROM payment P
JOIN customer C USING(customer_id)
JOIN address A USING(address_id)
GROUP BY P.customer_id
ORDER BY total_amount DESC
LIMIT 10;

/*
17. 영어를 모국어로 사용중인 영화 중, 영화제목이 K 또는 Q로 시작하는 영화의 제목을 조회.출력
*/

SELECT * FROM film LIMIT 10; -- language_id
SELECT * FROM language LIMIT 10; -- language_id
SHOW TABLES;

SELECT F.title
FROM film F
JOIN language L USING(language_id)
WHERE L.name = "English" AND (F.title LIKE "K%" OR F.title LIKE "Q%");
-- L_ : _ 갯수만큼 / L% : 뒤에 갯수와 무관하게 L







