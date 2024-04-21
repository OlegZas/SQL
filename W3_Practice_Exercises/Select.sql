use w3practice;
-- Simple_Select
-- 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
select first_name, last_name, salary, salary * 0.15 AS PF
from employees;
desc employees;
-- 6. Write a query to get the total salaries payable to employees.
select round(sum(salary),2) as Total_Salaries_payable
from employees; 
-- 8. Write a query to get the average salary and number of employees in the employees table.
SELECT avg(salary), count(employeeid)
FROM employees;
-- 10. Write a query to get the number of jobs available in the employees table.
select count(distinct title)
from employees;
-- 12. Write a query to get the first 3 characters of first name from employees table.
select SUBSTRING(First_name, 1, 3), first_name 
from employeeS; 
-- alternative 
select left(firstname, 3) from employees;
-- 13. Write a query to calculate 171*214+625.
SELECT 171*43-43 Result;
-- 15. Write a query to get first name from employees table after removing white spaces from both side.
SELECT TRIM(first_name) From employees;
-- 17. Write a query to check if the first_name fields of the employees table contains numbers.
SELECT *
FROM EMPLOYEES
WHERE first_name RLIKE '[0-9]';
-- 18. Write a query to select first 10 records from a table.
select *
from employees 
limit 10;
-- alternative 
select *, row_number() over(order by employee_id) as numbers
from employees
limit 10;
-- alternative 
select *
from (select *, row_number() over(order by employee_id) as numbers
		from employees limit 10) as derived;
-- alternative
with derived AS(select *, row_number() over(order by employee_id) as numbers
		from employees limit 10)
select * 
from derived;
-- 19. Write a query to get monthly salary (round 2 decimal places) of each and every employee
-- Note : Assume the salary field provides the 'annual salary' information.
SELECT Round(salary/12,2) 
FROM employees;