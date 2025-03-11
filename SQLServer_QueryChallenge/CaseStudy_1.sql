-- Create Schema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dannys_diner')
BEGIN
    EXEC('CREATE SCHEMA dannys_diner');
END;

-- Create Sales Table
CREATE TABLE dannys_diner.sales (
  customer_id CHAR(1),  -- CHAR is commonly used for fixed-length strings in SQL Server
  order_date DATE,
  product_id INT
);

-- Insert into Sales Table
INSERT INTO dannys_diner.sales (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', 1),
  ('A', '2021-01-01', 2),
  ('A', '2021-01-07', 2),
  ('A', '2021-01-10', 3),
  ('A', '2021-01-11', 3),
  ('A', '2021-01-11', 3),
  ('B', '2021-01-01', 2),
  ('B', '2021-01-02', 2),
  ('B', '2021-01-04', 1),
  ('B', '2021-01-11', 1),
  ('B', '2021-01-16', 3),
  ('B', '2021-02-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-01', 3),
  ('C', '2021-01-07', 3);

-- Create Menu Table
CREATE TABLE dannys_diner.menu (
  product_id INT,
  product_name VARCHAR(50),  -- VARCHAR length can be larger to fit the name
  price DECIMAL(10, 2)  -- DECIMAL used for price, with precision and scale
);

-- Insert into Menu Table
INSERT INTO dannys_diner.menu (product_id, product_name, price)
VALUES
  (1, 'sushi', 10),
  (2, 'curry', 15),
  (3, 'ramen', 12);

-- Create Members Table
CREATE TABLE dannys_diner.members (
  customer_id CHAR(1),
  join_date DATE
);

-- Insert into Members Table
INSERT INTO dannys_diner.members (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');

  -- 9/3/2024
--1. What is the total amount each customer spent at the restaurant?
SELECT customer_id, sum(price)
FROM dannys_diner.sales s
join dannys_diner.menu m on s.product_id = m.product_id 
group by customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date)
FROM dannys_diner.sales s
GROUP BY customer_id;

--3. What was the first item from the menu purchased by each customer?
With Rank as
(
Select S.customer_id, 
       M.product_name, 
       S.order_date,
       row_number() OVER (PARTITION BY S.Customer_ID Order by S.order_date) as rank
From dannys_diner.menu m
join dannys_diner.sales s
On m.product_id = s.product_id
group by S.customer_id, M.product_name,S.order_date
)
Select Customer_id, product_name
From Rank
Where rank = 1

  -- 9/5/2024
/*4. What is the most purchased item on the menu and how many times was it purchased by all customers?*/ 

WITH most_purchased_item AS (
  SELECT
    s.product_id,
    COUNT(s.product_id) AS total_purchases
  FROM
    dannys_diner.sales s
  GROUP BY
    s.product_id
  ORDER BY
    total_purchases DESC
  LIMIT 1
)
SELECT
  s.customer_id,
  m.product_name,
  COUNT(s.product_id) AS customer_purchases
FROM
  dannys_diner.sales s
JOIN
  most_purchased_item mpi ON s.product_id = mpi.product_id
JOIN
 dannys_diner.menu m ON s.product_id = m.product_id
GROUP BY
  s.customer_id, m.product_name
ORDER BY
  customer_purchases DESC;

-- 3/10/25
--5. Which item was the most popular for each customer?

-- sold the most; group by customer 
-- SELECT PRODUCT_NAME WHERE 
WITH ranking AS(
  SELECT CUSTOMER_ID, PRODUCT_ID, RANK()OVER(PARTITION BY CUSTOMER_ID ORDER BY COUNT(PRODUCT_ID )DESC) AS RANKS, COUNT(PRODUCT_ID) AS COUNTING
  FROM dannys_diner.SALES 
  GROUP BY CUSTOMER_ID, PRODUCT_ID
)
SELECT M.PRODUCT_NAME, customer_id, COUNTING
FROM RANKING R
INNER JOIN dannys_diner.MENU M ON R.PRODUCT_ID = M.PRODUCT_ID AND RANKS = 1
