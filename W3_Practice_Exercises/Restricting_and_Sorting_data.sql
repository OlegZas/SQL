use w3practice;
-- ************************************************************************************************
-- 3. Write a query to display the name (first_name, last_name) 
-- and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
-- ************************************************************************************************
select first_name, last_name, salary, department_id 
from employees 
where salary not between 10000 AND 15000 AND department_id IN (30,100);
desc employees;
-- alternative 
select *
from (select first_name, last_name, salary, department_id from employees 
where salary not between 10000 AND 15000 AND department_id IN (30,100)) as derived;
-- alternative using EXISTS and subquery 
select first_name, last_name, salary, department_id
from employees e1
where exists(select 1 from employees e2
where salary not between 10000 AND 15000 AND department_id IN (30,100) 
	and e2.employee_id = e1.employee_id ); -- MUSt refer subquery rows to corresponding rows in outer query 
-- CTE: 
With cte AS(
select first_name, last_name, salary, department_id 
from employees 
where salary not between 10000 AND 15000 AND department_id IN (30,100)
)
select * 
from cte;
-- ************************************************************************************************
-- 4. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
-- ************************************************************************************************
SELECT first_name, hire_date
from employees 
-- where year(hire_date) = 1987; -- alternative 
where year(hire_date) LIKE('1987%') or year(hire_date) = 1990;
-- ************************************************************************************************
-- 5. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
-- ************************************************************************************************
select first_name 
from employees 
where first_name like('%b%') AND first_name like ('%c%');
-- where first_name RLIKE'[bc]'; -- b or c 
-- ************************************************************************************************
-- 6. Write a query to display the last name, job, and salary for all employees whose job is that of 
-- a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.
-- ************************************************************************************************
select last_name, job_id, salary
from employees 
where job_id rlike'it_PROG|sh_CLERK' and SALARY NOT IN(4500, 10000, 15000); 
-- ************************************************************************************************
-- 7. Write a query to display the last name of employees whose names have exactly 6 characters.
-- ************************************************************************************************
SELECT LAST_NAME 
FROM EMPLOYEES 
WHERE length(last_NAME)=6;
-- alternative 
select last_name
from employees 
where last_name like '____'; -- 4 charactes 
