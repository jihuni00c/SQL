-- JOIN : 가입하다, 결합하다
-- 서로다른 테이블을 결합
-- A테이블 "키" B테이블 
-- 왜 이렇게 굳이 테이블 나눠서 관리?!
-- 비효율적으로 너무 많은 컬럼을 사용하지 않기 위함
-- 데이터 갯수 몇 만 ~ 몇 십만, 백만 데이터 => row
-- 컬럼 20 ~ 50
-- 50 * 100만
-- SQL 쿼리언어 : 데이터 활용을 위한 관점 학습
-- SQL 데이터 저장 x
-- MySQL : 프론트엔드 & 백엔드 개발 // 유튜브 플랫폼 클론코딩
-- 회원가입 -> 아이디, 패스워드 입력 회원가입 -> 운영서버 아이디, 패스워드
-- 로그인 -> DB > Table -> 아이디, 패스워드
-- 사용자 전용 화면 구현 -> 풀스택
-- JOIN -> 풀스택 개발 구현 -> 서버단에서 테이블을 조회하는데 걸리는 시간이 불필요하게 많이 적용
-- 데이터영역 학습 -> SQLD -> JOIN 뛰어난 기능


-- JOIN은 2가지 종류
-- INNER JOIN
-- OUTER JOIN : LEFT OUTER JOIN / RIGHT OUTER JOIN 

SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;

SELECT * FROM items AS A
JOIN ranking AS B
ON A.item_code = B.item_code
WHERE main_category = "ALL";

-- ORDER BY, HAVING, JOIN 
-- INNER JOIN 에서 WHERE -> 컬럼 내 조건을 따지고자 할 때, 원칙적으로 어떤 테이블의 컬럼인지 작성하는 것이 맞지만
-- 만약, 해당 컬럼이 특정 테이블 한 곳에서만 사용중이었다라면, 굳이 어떤 테이블인지를 작성하지 않아도 된다

-- 메인 카테고리가 ALL인 상품을 기준으로 판매자별 상품 갯수 출력하기!
-- psudo code
-- 내가 위 정답을 찾아오기 위해서 무엇?
-- 문장 먼저 작성 -> 코드

-- 테이블확인
SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;
SELECT * FROM category LIMIT 10;

-- 메인 카테고리가 ALL인 상품을 기준으로 판매자별 상품 갯수 출력하기!
SELECT provider, COUNT(*) provider_count
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE main_category = "ALL"
GROUP BY provider
ORDER BY provider_count DESC;

-- 메인카테고리가 패션의류, 판매자별 상품갯수가 5이상인 경우, 판매자 이름, 상품갯수 출력
SELECT *
FROM ranking
JOIN items ON 
WHERE main_category = "패션의류" AND item_ranking >= 5;
--
SELECT provider, COUNT(*) provider_items
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE main_category = "패션의류"
GROUP BY provider HAVING provider_items >= 5
ORDER BY provider_items DESC;

-- 메인카테고리, 신발/잡화 | 판매자별 상품갯수가 10개 이상 | 판매자명, 상품갯수 내림차순 출력
SELECT provider, COUNT(*) provider_items
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE main_category = "신발/잡화"
GROUP BY provider HAVING provider_items >= 10
ORDER BY provider_items DESC;

-- 메인카테고리 화장품/헤어, 평균할인가격, 최대할인가격, 최소할인가격 출력
SELECT ori_price, dis_price
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE main_category = "화장품/헤어";

SELECT
	ROUND(AVG(dis_price), 2) avg_price,
    MAX(dis_price) max_price,
    MIN(dis_price) min_price
FROM ranking R
JOIN items I ON R.item_code = I.item_code
WHERE main_category = "화장품/헤어";


