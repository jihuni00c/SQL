# RANK(), DENSE_RANK(), ROW_NUMBER()
# PARTITION : 칸막이
# UNBOUNDED PRECEDING : 파티션처리가 되어있는 부분집합(그룹) 내 첫 번째 행부터~
# UNBOUNDED FOLLOWING : 파티션처리가 되어있는 부분집합(그룹) 내 마지막 행까지
# CURRENT ROW : 파티션처리가 되어있는 부분집합(그룹) 내부에 위치한 각각의 값 순회
# n PRECEDING/FOLLOWING : 현재 순회중인 해당 값을 기준으로 n번째 앞 또는 n번째 뒤

# 집계함수의 대표 : SUM() -> 특정 컬럼 안에 있는 값을 모두 더하기 위한
# SUM(), SUM(), OVER()

WITH genre_revenue AS (
	SELECT
		C.name genre,
        SUM(P.amount) revenue
    FROM payment P
		JOIN rental R USING(rental_id)
		JOIN inventory I USING(inventory_id)
		JOIN film F ON I.film_id = F.film_id -- USING(film_id)
		JOIN film_category FC ON F.film_id = FC.film_id -- USING(film_id)
		JOIN category C USING(category_id)
	GROUP BY C.name
)
SELECT
	genre, revenue,
    SUM(revenue) OVER(
		ORDER BY revenue DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) cumulative_revenue,
    revenue / SUM(revenue) OVER() revenue_ratio
FROM genre_revenue
ORDER BY revenue DESC;

# RANK(), DENSE_RANK(), ROW_NUMBER()
# PARTITION : 칸막이
# UNBOUNDED PRECEDING : 파티션처리가 되어있는 부분집합(그룹) 내 첫 번째 행부터~
# UNBOUNDED FOLLOWING : 파티션처리가 되어있는 부분집합(그룹) 내 마지막 행까지
# CURRENT ROW : 파티션처리가 되어있는 부분집합(그룹) 내부에 위치한 각각의 값 순회
# n PRECEDING/FOLLOWING : 현재 순회중인 해당 값을 기준으로 n번째 앞 또는 n번째 뒤

# 집계함수의 대표 : SUM() -> 특정 컬럼 안에 있는 값을 모두 더하기 위한
# SUM(), SUM(), OVER()
# LEAD() : 특정 열을 기준으로 n번째 뒤에 있는 값을 가져올 때
# LAG() : 특정 열을 기준으로 n번째 앞에 있는 값을 가져올 때
# FIRST_VALUE() : 특정 열 > 파티션된 요소 안에서 첫번째 값을 가져올 때
# LAST_VALUE() : 특정 열 > 파티션된 요소 안에서 마지막 값을 가져올 때
# DATEDIFF() : 서로 다른 2개의 날짜의 갭 차이를 확인하고자 할 때
# PERCENT_RANK() : 각 행의 백분위 순위를 계산 (0 ~ 1) -> 전체를 기준으로 구간 위치
# CUME_DIST() : 각 행의 누적분포를 계산 (0 ~ 1) -> cumulative(누적된) distribution(분포)
# NTILE() : 각 행을 n개의 그룹으로 분할, 각 그룹에는 거의 같은 수가 분포

SELECT
	rental_id,
    rental_date,
    LAG(rental_id, 1, 0) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id, 1, 0) OVER (ORDER BY rental_date) next_rental
FROM rental;

SELECT
	DISTINCT I.film_id,
    FIRST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date) first_rental,
    LAST_VALUE(R.rental_date) OVER (PARTITION BY I.film_id ORDER BY R.rental_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) last_rental
FROM rental R
JOIN inventory I USING(inventory_id);

SELECT
	customer_id,
    rental_id,
    rental_date,
    DATEDIFF(
		rental_date,
        LAG(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date)
    ) days_since_last_rental
FROM rental
ORDER BY customer_id, rental_date;

SELECT
	title, length,
    PERCENT_RANK() OVER (ORDER BY Length) percent,
    CUME_DIST() OVER (ORDER BY Length) cume,
    NTILE(4) OVER (ORDER BY Length) group_movie
FROM film;

SELECT
	customer_id,
    CONCAT(first_name, " ", last_name) customer_name,
    NTILE(4) OVER (ORDER BY customer_id) customer_group
FROM customer;





