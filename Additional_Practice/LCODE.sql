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
