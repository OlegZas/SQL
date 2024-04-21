-- Stored_Procedures _________VIEWS_________INDEXES_________TRIGGERS____ TRANSACTIONS_________ARRAYS

-- **********************STORED PROCEDURES ***************************
use w3practice;
delimiter //
create procedure `second` () -- not a quotation marks 
begin 
	select first_name from employees;
end//
delimiter ;
call second();
-- to get the info about existing procedures
SELECT 
    routine_name as procedures
FROM
    information_schema.routines
WHERE
    routine_type = 'PROCEDURE'
        AND routine_schema = 'w3practice' ;  
-- ------------------------ GET BACK TO THIS, its wrong  https://www.w3resource.com/mysql/mysql-procedure.php

delimiter //
CREATE PROCEDURE `salary1` (INout first_name varchar(30), INout salary INT) 
begin 
	case 
		when salary > 20000 
			then (select first_name into first_name, salary  from employees where month(hire_date) = 6);
		else 
			set salary = 50000;
	end case ;
end //
delimiter ;
drop procedure salary1;
call salary1;
*/
-- *********************************************** CREATING FUNCTIONS ********************************************
delimiter //
CREATE FUNCTION square2(x INT) RETURNS INT
DETERMINISTIC
BEGIN
    RETURN x*x;
END //
delimiter ;
select square2(5);
-- ******************************************** CREATING a TRIGGER ********************************************
Delimiter // 
create trigger updating 
before insert ON testtable 
for each row
	BEGIN 
		set new.description = upper(new.description); 
	end //
delimiter ;
drop trigger updating;
insert into testtable values( 'cat');
select * from testtable;
-- ********************************************* CREATING VIEW ********************************************
CREATE VIEW employee_salary AS 
	select first_name, salary from employees;
select * from employee_salary; 

-- ******************************************** CREATING INDEX ********************************************
Create index myindex On 
employees(salary); 
create index myindex2 on employees(salary, first_name, last_name);


-- ******************************************** CREATING a TRANSACTION ********************************************
BEGIN; 
savepoint TransactionTesting1; 
insert into testtable values ('Meche'), ('Phone'), ('More'); 
ALTER TABLE testtable 
	ADD column money int;
savepoint TransactionTesting2; 
select * from testtable;
ALTER TABLE testtable drop column description;
rollback to savepoint TransactionTesting2;
commit;
select * from testtable;

ALTER TABLE testtable ADD column description varchar(30);
desc testtable;
INSERT INTO `testtable` (`description`) VALUES
('^5[@·˜,IÜç¦Éý'),
('Ô£^]Žþª_‹m'),
('ÿ»(õ 2ñ«QèªöjD¸=ËTú9Ž!');
select * from testtable;