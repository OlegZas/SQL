****************************************************************************
8/5/2024
1.
-- Reformat the table such that there is a department id column and a revenue column for each month.
-- Return the result table in any order.
-- The result format is in the following example.
select
id,
sum(if(month = 'Jan', revenue, null)) as Jan_Revenue,
sum(if(month = 'Feb', revenue, null)) as Feb_Revenue,
sum(if(month = 'Mar', revenue, null)) as Mar_Revenue,
sum(if(month = 'Apr', revenue, null)) as Apr_Revenue,
sum(if(month = 'May', revenue, null)) as May_Revenue,
sum(if(month = 'Jun', revenue, null)) as Jun_Revenue,
sum(if(month = 'Jul', revenue, null)) as Jul_Revenue,
sum(if(month = 'Aug', revenue, null)) as Aug_Revenue,
sum(if(month = 'Sep', revenue, null)) as Sep_Revenue,
sum(if(month = 'Oct', revenue, null)) as Oct_Revenue,
sum(if(month = 'Nov', revenue, null)) as Nov_Revenue,
sum(if(month = 'Dec', revenue, null)) as Dec_Revenue
from Department
group by id;

2.
-- Write a solution to report the products that were only sold in the first quarter of 2019. 
-- That is, between 2019-01-01 and 2019-03-31 inclusive.
select product_id,product_name
from product natural join sales
group by product_id
having min(sale_date)>='2019-01-01' and max(sale_date)<='2019-03-31'
****************************************************************************
****************************************************************************
****************************************************************************
8/6/24
1.
# Write a solution to find the first login date for each player.
# select player_id and first_login where first_login = min 
select player_id, min(event_date) as first_login 
from Activity
group by player_id

2.
-- Write a solution to rearrange the Products table so that each row has (product_id, store, price). 
If a product is not available in a store, do not include a row with that product_id and store 
combination in the result table.

select product_id, 'store1' as store ,  store1 as price
from Products 
where store1 is not null
union all 
select product_id,'store2' as store, store2 as price
from Products 
where store2 is not null
union all 
select product_id,'store3' as store,store3 as price 
from products
where store3 is not null
3.
-- For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.
select date_id, make_name, count(distinct lead_id) as "unique_leads", count(distinct partner_id) as "unique_partners"
from DailySales
group by date_id, make_name 


-- 8/13/24
/*
1. Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
*/
Select max(e.salary) as SecondHighestSalary 
from employee e
where e.salary not in (select max(salary) from employee em)

-- 8/14/24
/* 1. 
Write a solution to report the distance traveled by each user.
Return the result table ordered by travelled_distance in descending order,
if two or more users traveled the same distance, order them by their name in ascending order. */ 

SELECT 
    u.name, 
    CASE
        WHEN r.distance > 0 THEN SUM(r.distance)
        ELSE 0
    END AS travelled_distance
FROM 
    users u
LEFT JOIN 
    rides r ON u.id = r.user_id  
GROUP BY 
    u.id
ORDER BY 
    travelled_distance DESC, 
    u.name;
-- 2. 
/*Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.*/
SELECT patient_id, patient_name, conditions    
FROM Patients 
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'
-- 3. 
/*Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase. Return the result table ordered by user_id. */
SELECT user_id, CONCAT(UPPER(SUBSTR(name,1,1)), LOWER(SUBSTR(name,2))) AS name
FROM Users 
ORDER BY user_id