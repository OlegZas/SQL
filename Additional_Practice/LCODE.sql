# Write your MySQL query statement below
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
