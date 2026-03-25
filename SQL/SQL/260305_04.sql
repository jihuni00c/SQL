/*
1. 문자열 함수 : LENGTH(), UPPER(), LOWER(), CONCAT(), SUBSTRING()
2. 날짜/시간 함수 : NOW(), CURDATE(),CURTIME(), DATE_ADD(date, INTERVAL unit), DATE_SUB(date, INTERVAL unit),
				EXTRACT(field FROM source) - 뭘 뽑겠다/FROM/여기에서 | YEAR(), MonTH(), DAY(), HOUR(), MINUTE(), SECOND()
				DAYOFWEEK(), TIMESTAMPDIFF(단위, start_datetime시작날짜, end_datetime끝나는날짜), DATE_FORMAT(date, format)
- INTERVAL UNIT : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
- DAYOFWEEK : 일요일 = 1, 월요일 = 2...
- TIMESTAMPDIFF: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
- DATE_FORMAT : 날짜 또는 시간 데이터를 특정 양식의 문자열로 반환
- %Y : 4자리 연도수 표기 (2026)
- %y : 2자리 연도수 표기 (26)
- %M : 영문 월 이름 표기 (March)
- %m : 월을 2자릿수 표기 (01 ~ 12)
- %C : 월을 1자리수 표기 (1 ~ 12)
- %D : 일을 2자리수 + 영문 접미사 표기 (1st, 21st)
- %d : 일을 2자리수 (01~31)
- %H : 시간을 24시간 형식으로 2자리 (00~23)
- %h : 시간을 12시간 형식으로 2자리 (01~12)
- %I : 시간을 12시간 형식으로 1자리수 (1~12)
- %i : 분을 2자리 (00~59)
- %s : 초를 2자리 (00~59)
3. 숫자 함수 : ABS(number), CEIL(number), FLOOR(number), ROUND(number, decimals)
4. (중첩)서브쿼리
> 특정 컬럼 안에 있는 값을 어떤 연산 및 비교를 통해서 새로운 값을 도출하려고 할 때,
연산 및 비교해야할 대상이 필요! -> 해당 대상을 먼저 생성하고자 할 때

*/

SELECT ABS(-1) abs_num;

SELECT
	amount,
	CEIL(ABS(amount)),
    FLOOR(ABS(amount)),
    ROUND(amount, 1)
FROM payment
LIMIT 10;

SELECT SQRT(4);

-- payment 테이블에서 결제금액(amount)이 5 이하인 모든 결제건에 대해서 해당 결제금액을 절대값 적용 출력

SELECT
	CEIL(ABS(amount))
FROM payment
WHERE amount <= 5;

/*
film 테이블에서 영화상영시간이 120분 이상인 모든 영화에 대해서
영화상영시간의 제곱근을 계산해서 출력

*/

SELECT
	ROUND(SQRT(length), 2) sqrt_number
FROM film
WHERE length >= 120;

-- 평균 결제 금액보다 더 많은 결제를 한 고객의 전체이름을 찾아서 출력 (customer, payment)

SELECT * FROM customer LIMIT 10;
SELECT * FROM payment LIMIT 10;

-- amount 금액의 평균이 먼저 나와있어야 함
-- 그래야 각각의 amount값을 평균과 비교해볼 수 있음

SELECT
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
	WHERE amount > (
		SELECT AVG(amount) FROM payment
	)
);

-- 평균 결제 횟수보다 더 많은 결제를 한 고객을 찾아서 출력해주세요

SELECT
    CONCAT(first_name, " ", last_name)
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(payment_count)
		FROM (
			SELECT COUNT(*) payment_count
			FROM payment
			GROUP BY customer_id
		) payment_counts
    )
);

-- 위 쿼리문을 통해서 찾은 고객들을 VIP 고객

-- 가장 많은 결제 횟수를 기록하 ㄴ고객

SELECT
	CONCAT(first_name, " ", last_name)
FROM customer
WHERE customer_id IN (
	SELECT customer_id
    FROM (
		SELECT customer_id, COUNT(*) payment_count
		FROM payment
		GROUP BY customer_id
    ) payment_counts
    ORDER BY payment_count DESC
) LIMIT 1;



SELECT
	customer_id,
    COUNT(customer_id) top
FROM payment
GROUP BY customer_id
ORDER BY top DESC
LIMIT 1;

DESC payment;


-- 판매자별 판매중인 상품 가운데, 가장 랭킹(숫자 낮은게 높은것)이 높은 상품을 찾아서 출력해주세요
USE bestproducts;

SELECT
    I.provider,
    I.title,
    top_rank
FROM items I
JOIN ranking R ON R.item_code = I.item_code
JOIN (
    SELECT
        I.provider,
        MIN(R.item_ranking) top_rank
    FROM items I
    JOIN ranking R ON R.item_code = I.item_code
    GROUP BY I.provider
) top
GROUP BY I.provider, R.item_ranking
ORDER BY I.provider, R.item_ranking ASC;


ON top.provider = I.provider
AND top.top_rank = R.item_ranking

SELECT
    I.provider,
    MIN(R.item_ranking) top_rank
FROM items I
JOIN ranking R ON R.item_code = I.item_code

ORDER BY top_rank ASC;

-- 메인 카테고리별 상품갯수가 20개 이상
SELECT R.main_category, COUNT(*) item_count
FROM ranking R 
JOIN items I ON R.item_code = I.item_code
GROUP BY R.main_category
HAVING item_count >= 20;














----------------
SELECT
	provider,
	COUNT(*) item_count,
    ROUND(AVG(dis_price), 2) dis_price,
    ROUND(AVG(discount_percent), 2) dis_percent
FROM items I
WHERE provider <> "" AND provider IS NOT NULL
GROUP BY provider
ORDER BY item_count DESC;
