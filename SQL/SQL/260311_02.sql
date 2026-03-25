-- VIEW 가상 (테이블을 만들어서) 쿼리문 (을 작성한 것)
-- 1) SQL 쿼리문 (복잡), 간소화 -> 테이블 // 서브쿼리, 상관쿼리, 조인 문법 -> 구문을 읽기가 매우 복잡
-- 서브쿼리 > 미리 가상 테이블로 하나 만들어놓고 필요에 따라 불러올 수 있음
-- 2) 데이터 보안
-- 회사 인사데이터 담당자 > 인사데이터 > 내부 인트라넷 병가, 휴가, 인센티브
-- 외주 개발팀 섭외 // 
-- VIEW => 원본 데이터를 가지고 있는 테이블에서 중요한, 민감한 데이터 필터링한 임시테이블

-- CREATE VIEW <생성하고자 하는 가상 테이블 이름> AS 쿼리문

CREATE OR REPLACE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

SELECT * FROM ActorInfo;

SHOW TABLES;

DROP VIEW ActorInfo;

CREATE OR REPLACE VIEW myview AS
SELECT * FROM customer
WHERE customer_id = 1;

/*
ActorInfo 가상테이블 생성. actor 테이블에서 first_name, last_name 컬럼모두 포함
actor_id가 50미만인 배우만 포험
*/

CREATE OR REPLACE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 50;

SHOW TABLES;

SELECT * FROM actorinfo LIMIT 10;

/*
film 테이블에서 렌탈비용이 2달러보다 높은 영화에 대한 VIEW 테이블 생성
VIEW 테이블 이름 : ExpensiveFilms, title, rental_rate 컬럼 포함
*/

CREATE OR REPLACE VIEW ExpensiveFilms AS
SELECT title, rental_rate
FROM film
WHERE rental_rate > 2.00;

SELECT *FROM ExpensiveFilms;

DROP VIEW ExpensiveFilms;

-- 이미 만들어진 ActorInfo 가상 테이블을 actor_id가 100미만인 배우만 포함하도록 수정해서 저장해주세요

CREATE OR REPLACE VIEW ActorInfo AS
SELECT first_name, last_name
FROM actor
WHERE actor_id < 100;

SHOW TABLES;

SELECT * FROM ActorInfo;

DROP VIEW ActorInfo;






