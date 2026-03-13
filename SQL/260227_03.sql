-- HAVING 절 + GROUP bT
-- 집계함수를 가지고 조건비교를 할 때, 사용alter
-- 기본적인 조건절 문법 (WHERE) -> 테이블 -> 컬럼속에서 조건을 적용에 복수 상품 랭크?


-- GMARKET 인기판매 Top 상품들
-- 능력있는 상품 판매없체라면, 인기판매 상품 리스트에 복수 상품 랭크?
DROP DATABASE IF EXISTS bestproduct;
CREATE DATABASE IF NOT EXISTS bestproducts;
USE bestproducts;
SELECT COUNT(*) FROM items, # 10201개 상품 : 크롤링
SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;

SELECT provider, COUNT(*) provider_items
FROM items
WHERE
	provider <> "스마일배송" AND
    provider <> ""
GROUP BY provider HAVING COUNT(*) >= 100
ORDER BY provider_items DESC
LIMIT 5;