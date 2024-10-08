CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
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
