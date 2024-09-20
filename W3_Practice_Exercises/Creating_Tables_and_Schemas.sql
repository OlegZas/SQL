CREATE TABLE IF NOT EXISTS COUNTRIES2 (
COUNTRY_ID int PRIMARY KEY, 
COUNTRY_NAME varchar(250), 
REGION_ID INT); 
-- 3. Duplicate the Countries table 
CREATE TABLE IF NOT EXISTS dup_countries AS 
	SELECT * 
    FROM COUNTRIES2;
-- alternative: 
CREATE TABLE dup_countries2 
	LIKE CATEGORY; 
-- 5. Write a MySQL query to create a table countries set a constraint NULL.
CREATE TABLE IF NOT EXISTS countries3(
	countryId int NOT NULL PRIMARY KEY, 
	populaiton int NOT NULL, 
    meidanAge int NOT NUll);
-- 6. Write a MySQL query to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeding the upper limit 25000.
CREATE TABLE IF NOT EXISTS JOBS2 (
	JOB_ID INT, 
    JOB_TITLE VARCHAR(50), 
    MIN_SALARY INT ,
    MAX_SALARY INT,
    CHECK (MAX_SALARY > 25000)
);
-- 7. Write a MySQL query to create a table named countries including columns country_id, country_name and region_id and make 
-- sure that no countries except Italy, India and China will be entered in the table.
CREATE TABLE IF NOT EXISTS COUNTRIES4 (
	country_id int,
    country_name varchar(50), 
    region_id int,
    check (country_name in('Italy', 'India', 'China'))
    );
-- 8. 8. Write a MySQL query to create a table named job_histry including columns employee_id, start_date, end_date, 
-- job_id and department_id and make sure that the value against column end_date will be entered at the time of 
-- insertion to the format like '--/--/----'.
CREATE TABLE IF NOT EXISTS JOB_HISTORY2 (
	EMPLOYEE_ID INT, 
    START_DATE DATE, 
    END_DATE DATE, 
    JOB_ID DECIMAL, 
    DEPARTMENT_ID FLOAT, 
    CHECK(END_DATE LIKE '--/--/----'));
-- 9. 9. Write a MySQL query to create a table named countries including columns country_id,country_name and 
-- region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.
CREATE TABLE IF NOT EXISTS COUNTRY (
	COUNTRY_ID DECIMAL NOT NULL UNIQUE, 
    COUNTRY_NAME VARCHAR(55) NOT NULL, 
    REGION_ID INT );
/* 10. Write a MySQL query to create a table named jobs including columns job_id, job_title, 
min_salary and max_salary, and make sure that, the default value for job_title is blank and 
min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if
 no value assigned for the specified columns. */ 
CREATE TABLE JOBS44 (
	JOB_ID INT PRIMARY KEY,
    JOB_TITLE VARCHAR(50) DEFAULT 'NULL ',
    MIN_SALARY INT DEFAULT 8000, 
    MAX_SALARY INT DEFAULT NULL); 
