-- 카테고리 (메인 + 서브)별 할인율 상위 20%
-- 1) 메인과 서브 카테고리가 모두 같은 상품들은 각각 개별적인 할인율
-- 2) 위 조건에 충족되는 상품들이 총 몇 개? -> 20%에 해당되는 갯수 얼마인지 계산
-- 3) 위에서 계산된 갯수만큼만 높은 할인율을 기준으로 조회.출력되도록

-- JOIN // 100개 상품가운데 기준값 -> 99개 -> 20개

USE bestproducts;
SELECT * FROM items LIMIT 10;
SELECT * FROM ranking LIMIT 10;

SELECT
	main_category,
    sub_category,
    COUNT(*)
FROM ranking
GROUP BY main_category, sub_category;

SELECT
	a.main_category,
	a.sub_category,
	a.item_ranking,
	a.item_code,
	a.title,
	a.discount_percent
FROM (
	SELECT
		r.main_category,
		r.sub_category,
		r.item_ranking,
		i.item_code,
		i.title,
		i.discount_percent
	FROM ranking r
	INNER JOIN items i ON r.item_code = i.item_code
) a
INNER JOIN (
	SELECT
		r.main_category,
		r.sub_category,
		CEIL(COUNT(*) * 0.2) top_k
	FROM ranking r
	GROUP BY r.main_category, r.sub_category
) c
ON a.main_category = c.main_category
AND a.sub_category = c.sub_category
LEFT JOIN (
	SELECT
		r.main_category,
        r.sub_category,
        r.item_ranking,
        i.item_code,
        i.discount_percent
    FROM ranking r
    INNER JOIN items i ON r.item_code = i.item_code
) b
ON a.main_category = b.main_category
AND a.sub_category = b.sub_category
AND (
	b.discount_percent > a.discount_percent
    OR (b.discount_percent = a.discount_percent AND b.item_rankig < a.item_ranking)
)
GROUP BY a.main_category, a.sub_category, a.item_ranking, a.item_code, a.title, a.discount_percent, c.top_k
HAVING COUNT(b.item_code) < c.top_k
ORDER BY a.main_category, a.sub_category, a.discount_percent DESC;