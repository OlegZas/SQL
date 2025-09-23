-- 9/16/25
-- ✅ SQL Exercises — ozSQL_AWS_RDS
-- 🔹 Users, Orders & Products

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

--- ------------ 9/18/25
-- 7. Which countries have the most users who made purchases?
-- Return country and total spending.
SELECT U.country, count(ORD.order_id) as `Most Orders`
FROM ozSQL_AWS_RDS.users U
INNER JOIN ozSQL_AWS_RDS.orders ORD ON U.user_id = ORD.user_id 
GROUP BY U.country
;

-- 8. Which product generated the highest total revenue?
SELECT P.name ,SUM(AMOUNT) AS HIGHEST_AMOUNT
FROM ozSQL_AWS_RDS.orders O 
INNER JOIN ozSQL_AWS_RDS.products P ON O.product_id = P.product_id 
GROUP BY O.product_id 
ORDER BY SUM(AMOUNT) DESC
LIMIT 1
;

-- 9. List users who made more than one order on the same day.
SELECT U.name, ORD.user_id  
FROM ozSQL_AWS_RDS.users U
INNER JOIN 
(SELECT O.user_id 
FROM ozSQL_AWS_RDS.orders O 
GROUP BY O.user_id, O.purchase_date  
HAVING COUNT(O.purchase_date )>1 ) ORD  ON U.user_id = ORD.user_id

-- *************** 9/19/25***************************************
-- 10. Which users have duplicate records (same name and email) in the users table?
-- List all duplicates.
WITH rowsn AS (
SELECT name,USER_ID, ROW_NUMBER ()OVER(PARTITION BY name order by user_id asc) as rn
FROM ozSQL_AWS_RDS.users U
)
select USER_ID
FROM rowsn
WHERE rowsn.rn != 1

-- 11. Delete all duplicate records from the users table,
-- keeping only the one with the lowest user_id.
DELETE FROM ozSQL_AWS_RDS.users U
WHERE user_id in(select USER_ID
FROM (SELECT USER_ID, ROW_NUMBER ()OVER(PARTITION BY name order by user_id asc) as rn
FROM ozSQL_AWS_RDS.users U
) rowsn
WHERE rowsn.rn != 1)

SELECT * FROM ozSQL_AWS_RDS.users U

-- //////////////// 9/22/25 ////////////////
-- 12. Find users present in users table but not in users2.
-- Match on email.
SELECT *
FROM ozSQL_AWS_RDS.users u
left join ozSQL_AWS_RDS.users2 u2 ON u.USER_ID = u2.USER_ID AND u.name = u2.name
WHERE u2.user_id is null 
-- 13. Find users that exist in both users and users2, but have different countries.
SELECT *
FROM ozSQL_AWS_RDS.users u
inner join ozSQL_AWS_RDS.users2 u2 ON u.USER_ID = u2.USER_ID AND u.name = u2.name AND u.country <> u2.country 


-- 14. Insert users from users2 into users if their email does not already exist in users.

-- 15. Identify users who made purchases of more than 200 in a single order.
-- List their name, order ID, and amount.

-- 16. Which users bought the same product more than once?
-- List user name, product name.

-- 17. List the number of users who signed up each month.
-- Hint: Extract MONTH(signup_date) or use DATE_TRUNC() if supported.

-- 18. List products that have never been ordered.

-- 19. Update the email of all users in users
-- whose email ends with @example.com to end with @ozsql.com instead.

-- 20. Delete users from the users table if their email is not found in users2.

-- 🧩 Bonus Challenge:
-- 🔹 Combine business logic:
-- “Which 3 countries have the highest total order value per user
-- (average order value per user in that country)?”
