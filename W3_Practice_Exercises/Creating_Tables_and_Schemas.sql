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
