Create database Graduation_Rate;
CREATE TABLE IF NOT EXISTS `Graduation_Rate`.`graduation_rate_table` (
  `ACT composite score` INT NULL DEFAULT NULL,
  `SAT total score` INT NULL DEFAULT NULL,
  `parental level of education` TEXT NULL DEFAULT NULL,
  `parental income` INT NULL DEFAULT NULL,
  `high school gpa` INT NULL DEFAULT NULL,
  `college gpa` DOUBLE NULL DEFAULT NULL,
  `years to graduate` INT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

Select * from graduation_rate_table;
use graduation_rate;

-- import the data from 'Dictionary.csv'

