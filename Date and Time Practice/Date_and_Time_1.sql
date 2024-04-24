-- Date and Time w3 practice 
use `w3practice`;
/*
1. Write a query to display the first day of the month (in datetime format) three months before the current month.
Sample current date : 2014-09-03
Expected result : 2014-06-01
*/ -- %%%%%%%%%%%%%%%%%%%%%% review %%%%%%%%%%%%%%
SELECT DATE_FORMAT(DATE_SUB(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), INTERVAL DAYOFMONTH(DATE_SUB(CURDATE(), INTERVAL 3 MONTH))-1 DAY), '%Y-%m-%d') as `First Day of the Month before Current` ;

-- ************* Alternative 
SELECT DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), '%Y-%m-01') as `First Day of the Month before Current`;
-- ************* Alternative 
SELECT 
date(((PERIOD_ADD -- Calculates a period by adding a specified number of months to a given period.
    (EXTRACT(YEAR_MONTH -- Extracts the year and month from the current date (CURDATE()).
    FROM CURDATE()) -- Specifies the current date.
    ,-3)*100)+1)) as `First Day of the Month before Current` ; -- Subtracts three months from the current date, then multiplies by 100 to convert it to a period, and finally adds 1 to convert it back to a date. 
-- ******************************************************************************************************************************************************
/* 
2. Write a query to display the last day of the month (in datetime format) three months before the current month.
*/
select date_sub(date_sub(curdate(), interval 3 month), INTERVAL DAYOFMONTH(DATE_SUB(CURDATE(), INTERVAL 3 MONTH))-21 DAY) as `Last day of the month`;
/*
-- ******************************************************************************************************************************************************
-- ******************************************************************************************************************************************************
-- ******************************************************************************************************************************************************
*/
USE `datetime`;
-- *************************************************************** Extract 
select extract(year from date)
from dt_table;
-- **************************************************************** Date_add and ADDDAE
select d.date,date_add(d.date, INTERVAL -3 day) from dt_table d;
select adddate(d.date, interval 5 year) from dt_table d;
SELECT LOCALTIME();
select curdate();
select now();
select period_add(201701, 3) from dt_table d;
select period_diff(2201, 2109);
SELECT PERIOD_ADD(1103, 5);   
-- *******************************************************************
-- *******************************************************************
-- 1. Display all records of today's date
select * from dt_table where year(date) = year(curdate()); -- curent year, today's date just 1 record 
-- 2. Display all records of yesterday
select * from dt_table where date = date_sub(curdate(),interval 1 day);
-- 3. Display all records of tomorrow
select * from dt_table where date = date_add(curdate(), interval 1 day);
-- 4. Display all records of yesterday, today and tomorrow
select * from dt_table where date in( curdate(), 
			date_add(curdate(), interval 1 day), 
            subdate(curdate(), interval 1 day));
-- 5. Display all records of last 2 days ( no future dates )
select * from dt_table d
where d.date  in(subdate(curdate(), interval 2 day),subdate(curdate(), interval 1 day));
-- alternative  -- wihtout SUBDATE function
select * from dt_table d 
where d.date between  curdate()-interval 2 day AND curdate()-interval 1 day ;
-- 6. Display all records of next 3 days ( no previous dates )
select * from dt_table d where d.date BETWEEN current_date()+1 AND adddate(curdate(), interval 3 day);
-- Alternative 
select * from dt_table d where d.date BETWEEN current_date()+1 AND curdate()+3;
-- 7. Display all records of Previous 10 days to previous 5 days
select * from dt_table d
where d.date Between curdate()-interval 10 day AND current_date()-INTERVAL 5 DAY;
-- 8. Display all records of next 5 days to next 10 days
select * from dt_table d
where d.date between curdate()+interval 5 day AND current_date()+interval 10 day;
-- 9.Display all records of current month .
select *, monthname(d.date)AS `Current Month` from dt_table d 
where month(d.date) = month(current_date());
-- 10.Display all records of current month and current year .
select *, month(d.date) AS 'Month', year(d.date) as 'Year' from dt_table d
where month(d.date) = month(current_date()) AND year(d.date) = year(curdate());
-- 11. Display all records of previous month of current year
select *, day(d.date),dayname(d.date), monthname(d.date) AS 'Month', year(d.date) as 'Year' from dt_table d
where month(d.date) = month(current_date()-interval 1 month) AND year(d.date) = year(curdate());
-- 13. Display all records of current month till today
-- includes future 
select *, day(date) as 'Day', dayname(date) AS 'Weekday' from dt_table d
where month(date) = month(curdate()) AND day(date) <= day(curdate())
ORDER BY day(date) desc, year(`month-year`) desc;
-- ALTERNATIVE SOLUTION (worse) -
-- doesn't include future, only past 
select *, day(date) as 'Day', dayname(date) AS 'Weekday' from dt_table d
where date between date_format(curdate(), '0-%m-01') AND curdate() AND month(date) = month(curdate())
;
-- 14.  Display all records of current week
select *, weekday(date) as `Weekday number 0 -6`, dayname(date), dayofweek(date)AS `Index 1-7` from dt_table 
where week(date) = week(curdate());
-- 15: select the first day of the previous week 
select *, weekday(date) as `Weekday number 0 -6`, dayname(date) from dt_table 
where week(date) = week(curdate()-interval 1 week) AND weekday(date) = 0;
-- 16. Display all records of first week of the year
select record_id, date, WEEK(date) AS Week, DAYOFWEEK(MIN(date)) AS StartDayOfWeek, dayname(MIN(date)) from dt_table 
where week(date) = 1
GROUP BY record_id, date, Week(date);
-- 17. Display all records of working days ( Monday to Friday ) of current week of the year
select *, dayname(date) from dt_table 
where weekday(date) Between 0 AND 4
Order by weekday(date);
-- 18. Display all records of working days till today of current week of the year
select *, dayname(date) from dt_table 
where weekday(date) Between 0 AND 4 AND week(date) = week(curdate()) AND date <= curdate()
Order by weekday(date);