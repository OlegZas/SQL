
-- 9/16/25
--  SQL Exercises — ozSQL_AWS_RDS
--  Users, Orders & Products

-- 1. List all users who have never placed an order.
select *
from ozSQL_AWS_RDS.users U 
LEFT JOIN ozSQL_AWS_RDS.orders O ON U.user_id = O.user_id 
WHERE O.user_id is null; 
-- 2. Find the top 3 users who spent the most in total.
-- Show their name, email, and total spent.
SELECT * 
from ozSQL_AWS_RDS.users U 
INNER JOIN 
	(SELECT USER_ID, SUM(AMOUNT) AS TOTAL
	FROM ozSQL_AWS_RDS.orders O 
	GROUP BY user_id
	ORDER BY SUM(AMOUNT) DESC
	LIMIT 3 )
	O ON U.user_id = O.user_id 

-- 3. Get the average order amount for each product.
-- Show product name and average amount.
SELECT P.name ,AVG(AMOUNT) AS AVERAGE_AMOUNT
FROM ozSQL_AWS_RDS.orders O 
INNER JOIN ozSQL_AWS_RDS.products P ON O.product_id = P.product_id 
GROUP BY O.product_id 
ORDER BY AVG(AMOUNT) DESC
	
-- 4. List all users who ordered both a Laptop and a Smartphone.
SELECT P.product_id, U.user_id, U.name 
FROM ozSQL_AWS_RDS.users U
INNER JOIN ozSQL_AWS_RDS.orders ORD ON U.user_id = ORD.user_id 
INNER JOIN ozSQL_AWS_RDS.products P ON ORD.product_id = P.product_id AND P.product_id IN(1001, 1002)

-- 9/17/25
-- 5. List users who placed their first order within 2 days of signing up.
SELECT U.user_id, U.signup_date, min(ORD.purchase_date )
FROM ozSQL_AWS_RDS.users U
INNER JOIN ozSQL_AWS_RDS.orders ORD ON U.user_id = ORD.user_id 
GROUP BY U.USER_ID, U.signup_date 
HAVING MIN(day(purchase_date)) - day(U.signup_date ) < 2;
-- 6. Find users who signed up in the same country.
SELECT SELECT DISTINCT U.name AS USER1, U.country, U.signup_date, U2.name AS USER2, U2.country, U2.signup_date
FROM ozSQL_AWS_RDS.users U
INNER JOIN ozSQL_AWS_RDS.users U2 ON U.user_id < U2.user_id AND U.country = U2.country  ; 
