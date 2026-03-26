/*
1. 고객별 결제 날짜에 따른 누적 결제 금액을 출력. 출력 시, 나타나야 하는 값 :
결제 id, 고객 id, 결제 날짜, 결제 금액, 누적 결제 금액
*/
SELECT * FROM payment;

SELECT
    payment_id,
    customer_id,
    payment_date,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) total_amount
FROM payment;

/*
2. 영화 등급별 대여기간의 평균을 출력. 출력 시, 나타나야 하는 값 :
영화 id, 등급, 평균대여기간(대여시점~ 반납시점)
*/
SELECT * FROM film;

SELECT
    f.film_id,
    f.rating,
    AVG(TIMESTAMPDIFF(DAY, r.rental_date, r.return_date)) avg_rental
FROM film f
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
WHERE r.return_date IS NOT NULL
GROUP BY f.film_id, f.rating;

/*
3. 각 직원별 대여날짜에 따른 대여횟수, 누적 대여횟수를 구하세요. 출력 시 나타나야 하는 값:
대여 id, 직원 id, 대여날짜, 대여횟수, 누적 대여횟수
*/







