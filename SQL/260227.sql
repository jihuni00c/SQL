-- 현업에서 데이터를 취급하는 포지션에 입사
-- 중고신입 : OJT = On The Job Training
-- 취업과열 // 공급과잉 // 신입기대 능력치
-- 주요대기업 -> 신입사원 근속연수 짧음
-- 데이터 분야는 특히 신입/경력
-- A회사 => 데이터
-- AI / 인터넷검색 / 분야(도메인) 서칭, 특징, 요소
-- 데이터 스캐닝 -> 각 테이블당 컬럼들간 상관관계 분석 -> 컬럼 내 결측치 -> 어떤 타입 변환 (EDA)
-- 과거에 DVD (영화) 렌탈 비즈니스 모델

USE sakila;

SHOW TABLES;

DESC country;

-- 국가 정보
SELECT *
FROM country
LIMIT 5;

-- 영화 정보
SELECT * FROM film LIMIT 10;

-- 내 눈으로는 코드를 보고 있는데, 마치 내가 책을 읽고 있는 것 같은 느낌이 드는 코드
-- 집계 함수 = 수치형 데이터 (숫자형태의 데이터를 분류, 집계 -> COUNT())
-- 데이터를 여러가지 관점으로 바라볼 수 있음
-- 시간의 흐름에 따라서 데이터를 바라볼 수도 있음
-- 일반적으로 데이터를 크게 2개의 부류로 나눠보세요!!
-- 1) 수치형 (1, 2, 1.1) 2) 범주형 (남 / 여, 10대, 20대)
-- 범주형 데이터 -> 중복되는 값을 최대한 경계
-- 복수의 정답 // 상황에 따라서 외우고 싶어요 -> 

SELECT COUNT(*) FROM film;

SELECT DISTINCT rating FROM film;

SELECT DISTINCT release_year FROM film;

SELECT COUNT(*) FROM rental;

SELECT * FROM rental LIMIT 10;

-- 어떤 데이터를 수집.생성 => 식별값이 필요 => id 가 보편
-- 검색조건 빠르게, 인덱싱 & 삭제, 업데이트 

SELECT * FROM inventory LIMIT 10;

-- 조건절 // 파이썬 => if // WHERE절
-- 쿼리문을 학습방법
-- WHERE절 = 조건문
-- 문장.미션 세워놓고 -> 해결하기 위해서 어떤 구문을 어떤 순서대로 사용할지를 머리속 정리 학습
-- 많은 문제를 경험하는 것 -> 좌절. 실망. 자책. 고민
-- 4~5번 문제


SELECT * FROM rental
WHERE inventory_id = 367;

SELECT * FROM customer LIMIT 10;
SELECT COUNT(*) FROM customer;

-- 셜록홈즈 : 2006년, 약 1만6천여개의 DVD 렌탈 데이터 정보, 실제 대여고객수는 599명

-- 데이터 2개 : 수치형 / 범주형
-- 수치형 데이터 : 집계함수
-- 집계함수 : COUNT(), SUM(), AVG(), MAX(), MIN()
-- 범주형 데이터 : DISTINCT

SELECT * FROM customer LIMIT 10;
SELECT COUNT(*) FROM customer;
SELECT MIN(customer_id) FROM customer;
SELECT MAX(customer_id) FROM customer;
SELECT AVG(customer_id) FROM customer;
SELECT SUM(customer_id) FROM customer;

SELECT * FROM payment LIMIT 10;

-- 아래 컬럼 내 정보값을 보면서 구두로 설명 => 데이터를 읽어내려감 => 데이터 리터러시 능력
-- 다양한 도메인 기초정보 & 지식 => 데이터 무엇을 이야기하는가 => 수치를 보고 어떤 문제를 제기 => 해결책 제안

SELECT
	SUM(amount), AVG(amount),
    MAX(amount), MIN(amount)
FROM payment;

-- SFW

SELECT * FROM rental
WHERE inventory_id = 367 AND staff_id = 1;

-- 그룹핑 => 그룹화하는 것 // 특정 조건에 따라서 부류를 나눠야 하는 상황
-- GROUP BY

-- SELECT 컬럼 
-- FROM 테이블명
-- WHERE 조건
-- GROUP BY 컬럼 
-- ORDER BY 컬럼
-- LIMIT 출력할 갯수 (위에서부터)

-- GROUP BY vs DISTINCT
SELECT rating, COUNT(*) FROM film
GROUP BY rating;
-- 중복해서 노출된 데이터들을 공통된 패턴에 따라 하나의 그룹(폴더)에 담아놓은 상태

SELECT DISTINCT rating  FROM film;
-- 중복된 값이라고 판단되는 요소들을 한 번씩만 출력하자 (나머지는 제거)

SELECT
	rating, COUNT(*)
FROM film
WHERE rating = "PG" OR rating = "G"
GROUP BY rating;

SELECT title, rating FROM film
WHERE rating = "G" OR rating = "PG"
ORDER BY rating DESC;

SELECT MIN(title), rating FROM film
WHERE rating = "G" OR rating = "PG"
GROUP BY rating
ORDER BY rating DESC;

-- GROUP BY를 통해서 특정 컬럼을 그룹화했다면, 해당 컬럼 외 값을 출력하고자 할 때, 그 요소 역시 집계함수로 설정해줘야!
-- 만약, 출력하고자 하는 값들에 집계함수를 사용하지 않을 경우, 굳이 그룹화가 불필요함!

SELECT title FROM film
WHERE
	(rating = "G" OR rating = "PG") AND
	(release_year = 2006 OR release_year = 2007);

-- film 테이블에서 각 등급별 그룹화 후 해당 등급별 영화 갯수 평균 렌탈비용 같이 출력

SELECT
	rating, COUNT(*), AVG(rental_rate)
FROM film
GROUP BY rating;

SELECT * FROM film LIMIT 10;

-- 모든 학습 : 인과관계
-- 내가 많은 시간 & 공부 -> 이해 // 실력
-- 예외 : 정말로 그 분야 천부적인 소질 = 타고났다 = 적성 (예체능, 전문 기술직종)
-- 예외 (100% -> 정말 소수)
-- 학습 : 뒤쳐진다 -> 비교대상 (예외그룹, 소수)
-- 어렵고, 이해, 힘들다
-- 아닌것 같다 : 옆에있는 친구, 나만 유독 못따라간다
-- 그 친구는 내가 보지 않는 곳에서 열심히 함 (반 x, 인강 파이썬, IT 국비)
-- 나만 혼자 집에 복습, 학원 -> 옆에 (순수)

-- 정렬 (내림 | 오름) -> DESC / MySQL -> SQL 기본적으로 오름차순 DEFAULT
-- alias (별명, 약어)

SELECT
	rating,
    COUNT(*) AS total_films,
    AVG(rental_rate) AS avg_rental_rate
FROM film
WHERE release_year = 2006 OR release_year = 2007 
GROUP BY rating
ORDER BY avg_rental_rate DESC;

-- AS x, 되고 안되고

--
-- FROM
-- WHERE
-- GROUP BY
-- HAVING 그룹화된 요소의 조건
-- SELECT
-- ORDER BY (SELECT AS)

-- SELECT : 절대 AS -> x

-- HAVING -> 예외

-- 각 등급별 영화의 길이가 130분 이상인 영화의 갯수와 등급을 출력해주세요!
SELECT rating, COUNT(*) AS film_count
FROM film
WHERE length >= 130
GROUP BY rating
ORDER BY film_count DESC;

-- 문법을 아는것보다 더 중요한 것은 논리적인 사고 & 문제해결 능력



