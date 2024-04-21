use w3practice;
-- 7. Write a query to get the number of employees with the same job.
select job_id, count(*)
from employees 
group by job_id
order by count(*) desc;
-- ************************************************************************************************
-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
-- ************************************************************************************************
select manager_id, min(salary) 
from employees 
group by manager_id
ORDER BY MIN(salary) DESC;
-- ************************************************************************************************
-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
-- ************************************************************************************************
select department_id, avg(salary), count(distinct employee_id) 
from employees e
group by department_id
having count(distinct EMPLOYEE_ID) > 10; 
-- ************************************************************************************************
-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
-- ************************************************************************************************
select job_id, max(salary)
from employees 
group by job_id
having max(salary) >= 4000; 
-- ************************************************************************************************
-- ************************************************************************************************\
-- 1. Write a query to find the name (first_name, last_name) and the salary of the employees who 
-- have a higher salary than the employee whose last_name='Bull'.
select first_name, last_name, salary 
from employees e 
where salary > (select salary from employees e1 where last_name ='Bull');
-- ************************************************************************************************
-- 2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
-- ************************************************************************************************
select first_name, last_name, e.department_id
from employees e
inner join departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.DEPARTMENT_NAME = 'IT'; 
-- or subquery  ---- REVIEW THIS 
select first_name, last_name, department_id
from employees e
where department_id IN (select department_id from departments where DEPARTMENT_NAME = 'IT');
-- or derived table 
select first_name, last_name, department_id
from (select first_name, last_name, e.department_id
from employees e
inner join departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
where d.DEPARTMENT_NAME = 'IT') as derived; 
-- ************************************************************************************************
-- 3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked 
-- ************************************************************************************************
-- in a USA based department.
-- Without a join 
SELECT first_name, last_name 
FROM employees 
WHERE manager_id in ( select employee_id from employees where manager_id is not null and department_id in (select department_id from departments 
							where location_id IN (select distinct location_id from locations l where country_id = 'US')));
-- one join and subquery
select e.first_name, e.last_name, d.DEPARTMENT_NAME, d.location_id
from employees e 
inner join departments d on e.DEPARTMENT_ID = d.department_id 
where e.manager_id is not null AND d.location_id in (Select location_id from locations l where country_id = 'US'); 
-- with 2 joins 
Select distinct first_name, last_name from employees e
Inner join departments d on e.DEPARTMENT_ID = d.department_id 
Inner join locations l on d.location_id= l.location_id
where e.manager_id is NOT NULL AND l.country_id='US';
-- ************************************************************************************************
-- 4. Write a query to find the name (first_name, last_name) of the employees who are managers.
-- ************************************************************************************************
select e.first_name, e.last_name 
from employees e 
where e.EMPLOYEE_ID in (select manager_id from employees);
-- self_join
select distinct e.first_name, e.last_name 
from employees e, employees e2
where e.EMPLOYEE_ID = e2.MANAGER_ID; 
/* note: 
		If an employee (let's call them Employee A) has multiple direct reports (employees who have 
        Employee A's EMPLOYEE_ID as their MANAGER_ID), then each of these direct reports will be included 
        in the result set. This means that Employee A's first name and last name will appear multiple times 
        in the result set, once for each direct report.
Without DISTINCT, all these duplicate combinations of first name and last name will be returned. */ 
-- ************************************************************************************************
-- 5. Write a query to find the name (first_name, last_name), 
-- and salary of the employees whose salary is greater than the average salary.
-- ************************************************************************************************
select first_name, last_name, salary 
from employees 
where salary > (select avg(salary) from employees);
-- ************************************************************************************************
-- 6. Write a query to find the name (first_name, last_name), and salary of the 
-- employees whose salary is equal to the minimum salary for their job grade.
-- ************************************************************************************************
select first_name, last_name, salary
from employees e
where salary = (select min_salary from jobs j where e.job_id = j.job_id ); -- wihout join the salary would be compared to all the 
-- min salaries and would result in an error 

select makedate(year(now()),55);
call Practicing1;
-- ************************************************************************************************
-- 7. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
-- ************************************************************************************************
-- 1. Using join 
select e.first_name, e.last_name, e.salary 
from employees e
join departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
where d.DEPARTMENT_NAME like '%IT%'  AND e.salary > (select avg(salary) from employees);
-- 2. Using 2 subqueries without a join 
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN 
(SELECT department_id FROM departments WHERE department_name LIKE '%IT%') 
AND salary > (SELECT avg(salary) FROM employees);
-- *********************************************************************************************************************************************
-- 8. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.
-- *********************************************************************************************************************************************
SELECT first_name, last_name, salary 
from employees e
where salary > (select salary from employees where last_name = 'Bell')
order by first_name;
-- *********************************************************************************************************************************************
-- 9. Write a MySQL query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
-- *********************************************************************************************************************************************
select first_name, last_name, salary 
from employees e
where salary in (select min(salary) from employees);  

/* *********************************************************************************************************************************************
11. Write a MySQL query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of 
-- all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.
********************************************************************************************************************************************* */ 
SELECT first_name, last_name, salary 
from employees e
where salary > ALL(select salary from employees where job_id = 'SH_CLERK')
order by salary;
-- or max 
SELECT first_name, last_name, salary 
from employees e
where salary > (select max(salary) from employees where job_id = 'SH_CLERK')
order by salary;
/* *********************************************************************************************************************************************
12. Write a MySQL query to find the name (first_name, last_name) of the employees who are not supervisors.
********************************************************************************************************************************************* */ 
SELECT first_name, last_name, salary 
from employees e
where e.employee_id not in (select MANAGER_ID from employees); 
-- or 
SELECT first_name, last_name, salary 
from employees e
where not exists ( select 1 from employees b where e.employee_id = b.manager_id) ;
/* *********************************************************************************************************************************************
13. Write a MySQL query to display the employee ID, first name, last name, and department names of all employees.
********************************************************************************************************************************************* */ 
SELECT first_name, last_name, employee_id, d.DEPARTMENT_NAME
from employees e
join departments d on e.department_id = d.department_id;
-- method 2: with subquery (less efecient) 
SELECT first_name, last_name, employee_id, (select d.DEPARTMENT_NAME from departments d where e.department_id = d.department_id) as dd
from employees e; 
-- method 3: cte 
WITH cte AS (
    SELECT d.DEPARTMENT_NAME AS dname, d.department_id AS did 
    FROM departments d
)
SELECT e.first_name, e.last_name, e.employee_id, cte.dname
FROM employees e
JOIN cte ON cte.did = e.department_id; -- must join cte unless it is used in the from clause 
/* *********************************************************************************************************************************************
14. Write a MySQL query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
********************************************************************************************************************************************* */ 
SELECT first_name, last_name, salary 
from employees e
where salary > (select avg(salary) from employees e2 where e2.DEPARTMENT_ID = e.DEPARTMENT_ID ); 
-- with derived tables and window function ---------------------------- REVIEW THIS ONE 
SELECT first_name, last_name, salary
FROM (
    SELECT e.*, AVG(salary) OVER (PARTITION BY e.department_id) AS dept_avg_salary
    FROM employees e
) AS sub
WHERE salary > dept_avg_salary;
-- 
select department_id, avg(salary) from employees group by department_id;
select department_id, avg(salary) over (partition by department_id) from employees; 
/* *********************************************************************************************************************************************
15. Write a MySQL query to fetch even numbered records from employees table.
********************************************************************************************************************************************* */ 
-- row_number where MOD() = 0 -- check mod function 
-- ex: MOD function is the remainder (18,4) = 2

select * 
from (select *, row_number () over () as rn from employees) as der 
where rn%2 = 0; 
-- Method 2: cte 
WITH cte AS ( 
	select *, row_number () over () as rn 
    from employees
    
)
select * 
from cte 
where rn%2 = 0
;
-- Method 3: by creating a custom function or user-defined variable 
 -- define a variable with @ - used to denote user-defined variables in mysql
 SET @i = 0;
 select i,employee_id
 from (select @i := @i + 1 AS i, employee_id FROM employees) a 
  where MOD(a.i, 2) = 0
;
set @i = null; -- assinges null to user-defined variable since you cannot directly delete it 
-- METHOD 4. using MOD scalar function 
select * 
from (select *, row_number () over (order by employee_id ) as rn from employees) as der 
where MOD(rn,2) = 0; 
-- METHOD 5: Only even idnumbers: if we want only even employee_id numbers 
select *
from employees 
where (employee_id % 2 != 0);
-- MOD(employee_id,2) != 0; 
