USE Graduation_Rate;
SELECT * FROM graduation_rate_table;
-- ***********************************
-- 1. Retrieve all records from the dataset.
SELECT * 
FROM graduation_rate_table;
-- 2.Count the total number of records in the dataset.
SELECT count(*)
FROM graduation_rate_table;
-- 3.Retrieve the average ACT composite score.
SELECT AVG(`ACT composite score`) -- to use column with white space, encapsulate it in `` 
FROM graduation_rate_table;
-- 4.Retrieve the highest SAT total score.
SELECT MAX(`SAT total score`)
FROM graduation_rate_table;
-- 5.Retrieve the lowest high school GPA.
SELECT MIN(`high school gpa`)
FROM graduation_rate_table;
-- 6.Retrieve records where parental income is above a certain threshold (e.g., $50,000).
-- --------- Method 1
SELECT * 
FROM graduation_rate_table
WHERE `parental income` > 50000;
-- --------- Method 2 with gorup by (although not effecient in this scenario and involves GROUPING) 
SELECT * 
FROM graduation_rate_table
group by `ACT composite score` -- just practicing
having `parental income` > 50000;
-- --------- Method 3: Using CTE (overcomplicating but will yield the desired result) -- just practicing 
WITH Treshold AS ( -- just practicing 
	SELECT * 
	FROM graduation_rate_table
	WHERE `parental income` > 50000)
SELECT *
FROM Treshold;
-- 7.Retrieve records where college GPA is greater than or equal to 3.5.
SELECT * 
FROM graduation_rate_table
WHERE `college gpa` >= 3.5
ORDER BY `college gpa`desc; -- just practicing (not required in this question)
-- -------- method 2: college gpa between 3.5 AND max gpa (with subquery)
SELECT * 
FROM graduation_rate_table
WHERE `college gpa` BETWEEN 3.5 AND (select max(`college gpa`) -- with BETWEEN clause you cannot use FUNCTIONS directly, must use subquery 
											FROM graduation_rate_table);

-- 8.Retrieve records where years to graduate is less than 4.

SELECT * 
FROM graduation_rate_table
WHERE `years to graduate` < 4
ORDER BY `college gpa` desc; -- aditional, just ordering by gpa

-- 9.Retrieve the distinct levels of parental education.
SELECT DISTINCT `parental level of education`
FROM graduation_rate_table;
-- ----------- alternative, grouping by parental levels --- not part of the problem, just practicing 
SELECT  `parental level of education`, AVG(`SAT total score`) AS avg_sat_scores
FROM graduation_rate_table
group by `parental level of education`;

-- 10.Retrieve the records sorted by ACT composite score in descending order.
SELECT * 
FROM graduation_rate_table
ORDER BY `ACT composite score` DESC;