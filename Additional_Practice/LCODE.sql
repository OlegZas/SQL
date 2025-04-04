--1. 
/*Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
Return the result table in any order.
The result format is in the following example.
--*/
SELECT activity_date as day, COUNT(distinct user_id) active_users 
FROM Activity 
WHERE activity_date BETWEEN  DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27' 
GROUP BY  activity_date
ORDER BY day

-- 2.
/*
Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".
Return the result table in any order.
The result format is in the following example. */ 

select t1.name 
from SalesPerson t1
where t1.sales_id not in (
    select t3.sales_id 
    from Company t2 join Orders t3
    on t2.com_id = t3.com_id and t2.name = "RED"
)

-- 11/19/24
--3. 
/*
Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
Return the result table in any order.
The result format is in the following example.
*/
 
 SELECT user_id, MAX(time_stamp) AS last_stamp          
 FROM Logins 
 WHERE YEAR(time_stamp) = 2020
 GROUP BY user_id
 ;
--4. 
/*
Write a solution to calculate the total time in minutes spent by each employee on each day at the office. Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.
Return the result table in any order.
The result format is in the following example.
*/

SELECT event_day as day, emp_id , SUM(out_time - in_time) as total_time
FROM Employees 
GROUP BY emp_id, event_day ;

--5. 
/* Write a solution to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.
Return the result table ordered by employee_id.
The result format is in the following example. */

SELECT employee_id, CASE 
                        WHEN employee_id %2 <> 0 AND name not like 'M%' THEN salary 
                        ELSE 0
                    END AS bonus 
FROM Employees 
ORDER BY employee_id;

-- 11/20/24
--6. 
/* 
Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
The result format is in the following example.
*/

SELECT MAX(salary) SecondHighestSalary 
FROM Employee
WHERE salary NOT IN(SELECT MAX(salary) FROM Employee) 


-7. 
/*Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.
The result format is in the following example.*/

SELECT score, DENSE_RANK()OVER(ORDER BY Score desc) AS `rank`
FROM Scores 

--8. 
/*Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
Return the result table in any order.
The result format is in the following example.*/

SELECT Email
FROM Person 
GROUP BY Email
Having COUNT(1) > 1;

-- 11/21/24
--9.
/*Write a solution to report the Capital gain/loss for each stock.
The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
Return the result table in any order.
The result format is in the following example.*/

SELECT stock_name, 
	   SUM(CASE WHEN operation = 'Sell' THEN price
		   ELSE -price END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name
	
--10.
/*Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.
The result format is in the following example.*/

SELECT *
FROM Cinema 
WHERE description <> 'boring' AND id%2 != 0
ORDER BY rating desc 

-- 11/22/24
--11. 
/*For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.
Return the result table in any order.
The result format is in the following example.*/

SELECT date_id, make_name , COUNT(DISTINCT lead_id) AS unique_leads, COUNT(DISTINCT partner_id) AS unique_partners 
FROM DailySales
GROUP BY date_id, make_name;

--12. 
/*The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.
Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.
Return the result table in any order.
The result format is in the following example.*/

SELECT request_at AS DAY,  ROUND(sum(case when status like '%cancelled%' then 1 else 0 end )/ count(*),2) AS `Cancellation Rate`
FROM Trips t
INNER JOIN USERS u ON u.users_id = client_id AND u.role = 'client' AND u.banned = 'No'
INNER JOIN USERS m ON m.users_id = driver_id AND m.role = 'driver ' AND  m.banned ='No'
-- Inner JOIN Users u ON (CASE 
--                             WHEN u.role = "client" THEN t.client_id = users_id else t.driver_id = u.users_id end) 
GROUP BY request_at                        
HAVING request_at BETWEEN '2013-10-01' AND '2013-10-03'

--11/25/24
-- 13.
/*Write a solution to find the ids of products that are both low fat and recyclable. Return the result table in any order. The result format is in the following example.*/

SELECT product_id as product_id
FROM Products p
WHERE low_fats = 'Y' AND recyclable = 'Y'
--14. 
/*Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.
The result format is in the following example.*/

SELECT name 
FROM Customer
WHERE referee_id != 2 OR referee_id is null
ORDER BY id

--15. 
/*A country is big if: it has an area of at least three million (i.e., 3000000 km2), or it has a population of at least twenty-five million (i.e., 25000000). Write a solution to find the name, population, and area of the big countries. Return the result table in any order. The result format is in the following example.*/
SELECT name, population, area 
FROM World 
WHERE area >= 3000000 OR population >= 25000000

--16.# Write your MySQL query statement below
/* Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
Return the result table in any order.
The result format is in the following example.
*/
SELECT product_id,
       COALESCE(
           (SELECT new_price 
            FROM PRODUCTS P2
            WHERE P2.product_id = P.product_id 
              AND P2.change_date <= DATE '2019-08-16'
            ORDER BY P2.change_date DESC
            LIMIT 1), 10) AS price
FROM PRODUCTS P
GROUP BY product_id;
