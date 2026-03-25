/*
1. comedy, sports, family 카테고리의 카테고리 아이디를 찾아서 카테고리명과 아이디를 같이 출력!
*/

SELECT
	name,
	category_id
FROM category
WHERE name IN ("Comedy", "Sports", "Family");

	name = "Comedy" OR
    name = "Sports" OR
    name = "Family";

/*
2. film_category 테이블 안에서 film_id가 2인 영화의 카테고리 아이디를 조회해서 출력해주세요
*/

SELECT category_id
FROM film_category
WHERE film_id = 2;

/*
3. film_category 테이블에서 카테고리 ID별 영화 수 조회 및 출력
*/
SELECT category_id, COUNT(*) category_count FROM film_category
GROUP BY category_id;

/*
4. 카테고리가 코메디인 영화 갯수 조회,출력
*/
SELECT COUNT(*) 
FROM category C
JOIN film_category F USING(category_id)
WHERE name = "Comedy";

SELECT COUNT(*) comedy_count FROM film_category
WHERE category_id IN (
	SELECT category_id FROM category
	WHERE name = "Comedy"
);

/*
5. Comedy, Sports, Family 각각의 카테고리별 영화 갯수 조회,출력
*/
SELECT
	C.name, COUNT(*) category_count
FROM category C
JOIN film_category F USING(category_id)
WHERE C.name IN ("Comedy", "Sports", "Family")
GROUP BY C.category_id;

SELECT
	C.name,
    COUNT(*)
FROM (
	SELECT category_id, name
	FROM category
	WHERE name IN ("Comedy", "Sports", "Family")
) C
JOIN film_category F USING(category_id)
GROUP BY C.category_id, C.name;


/*
6. 각 카테고리별 영화의 수가 70개 이상인 카테고리명을 조회,출력
*/
SELECT C.name, COUNT(*) category_count
FROM category C
JOIN film_category F USING(category_id)
GROUP BY C.category_id
HAVING category_count >= 70;

/*
7. 각 카테고리별 영화들의 렌탈 횟수 조회.출력
*/
SELECT
	C.name, COUNT(*) rental_count
FROM category C
JOIN film_category F USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
GROUP BY C.category_id
ORDER BY rental_count DESC;

SELECT * FROM category; -- category_id
SELECT * FROM rental; -- customer_id, inventory_id, rental_id
SELECT * FROM film_category; -- category_id, film_id
SELECT * FROM inventory; -- inventory_id, film_id
/*

*/

/*
1. Sakila DB > 한 번도 대여되지 않은 영화 찾기
2. 고객별 누적 결제금액을 등급 분류 & 등급별 상위 3명씩만 조회.출력
총 결제액 100이상 : VIP / 100미만 50이하 : GOLD / 50미만 : SILVER
JOIN (INNER), SubQuery, 상관 SubQuery, WITH, VIEW 어떤 것을 사용해도 무관함!!!
*/

SELECT
    f.film_id,
    f.title
FROM film f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE i.film_id = f.film_id
);

SELECT * FROM film; -- film_id
SELECT * FROM film_category; -- film_id
SELECT * FROM customer; -- customer_id 
SELECT * FROM rental; -- inventory_id, rental_id, customer_id

SELECT C.name, COUNT(*)
FROM category C
JOIN film_category F USING(category_id)
JOIN inventory I USING(film_id)
JOIN rental R USING(inventory_id)
GROUP BY C.category_id;

SELECT * FROM category; -- category_id
SELECT * FROM film_category; -- category_id, film_id
SELECT * FROM inventory; -- inventory_id, film_id
SELECT * FROM rental; -- inventory_id, rental_id

SELECT * FROM 



/*
카테고리별 대여횟수 -> "0"이면 출력
*/


/*

*/


/*

*/











