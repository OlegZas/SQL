use week1;
-- ********************* 10/1/25 *********************
-- ****************************************************
CREATE TABLE sales (
	"customer_id" varchar(1),
	"order_date" DATE,
	"product_id" INTEGER
	);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

/*
 * 1. What is the total amount each customer spent at the restaurant?
How many days has each customer visited the restaurant?
*/

SELECT CUSTOMER_ID CUSTOMER, SUM(PRICE) AS TOTALSPEND
FROM sales S 
LEFT JOIN MENU M ON M.PRODUCT_ID = S.PRODUCT_ID
GROUP BY CUSTOMER_ID
;

/*
 * 2. How many days has each customer visited the restaurant?
*/ 
SELECT CUSTOMER_ID CUSTOMER, order_date Date, count(1) 'Number of Days'
FROM sales S 
GROUP BY CUSTOMER_ID, order_date
order by CUSTOMER_id

SELECT customer_id, COUNT(DISTINCT order_date) as "Days_Visited"
FROM sales s
GROUP BY customer_id;
