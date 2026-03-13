/*
1) 가상 테이블 생성 방법 : VIEW
2) 가상 테이블 생성 방법 : WITH 
> VIEW : 임시 (목적성) 가상 테이블 생성 -> 데이터가 로컬 컴퓨터 메모리 기록
> WITH : 메모리 공간 x, 먼저 선 쿼리구문을 실행 가져오는 형식 -> 쿼리구문이 종료 x
WITH => CTE 구문 = Common Table Expression

*/

SELECT * FROM film LIMIT 10;
SELECT * FROM inventory LIMIT 10;



SELECT F.film_id, F.title
FROM film F
JOIN (SELECT DISTINCT I.film_id FROM inventory I) IV
ON F.film_id = IV.film_id;


SELECT F.film_id, F.title
FROM film F
JOIN (SELECT DISTINCT I.film_id FROM inventory I) IV
USING (film_id);

-----------------------------------------------------------------

WITH FilmInventory AS (
	SELECT DISTINCT I.film_id FROM inventory I
)
SELECT F.film_id, F.title
FROM film F
JOIN FilmInventory FI USING (film_id);























