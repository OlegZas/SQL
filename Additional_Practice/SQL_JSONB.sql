-- 1. DDL: Create the table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    attributes JSONB
);

-- 2. DML: Insert the sample data
INSERT INTO products (name, category, attributes) VALUES
('SuperPhone X', 'electronics', '{"brand": "TechCorp", "storage": "256GB", "features": ["5G", "waterproof"], "price": 899}'),
('Retro Game Console', 'electronics', '{"brand": "NostalgiaCo", "color": "grey", "features": ["HDMI", "wireless controllers"], "price": 150}'),
('Ergo Chair', 'furniture', '{"brand": "ComfortPlus", "material": "mesh", "adjustable": true, "weight_capacity": 300}'),
('Smart Watch', 'electronics', '{"brand": "TechCorp", "battery_life": "7 days", "features": ["heart rate", "GPS"], "price": 250}');

-- Question 1: The Basics
-- Return the name of the product, and extract the "brand" from the JSONB column as standard text.
SELECT name, attributes ->>'brand' as brand
from products 

--Question 2: Filtering by a JSON text value
-- Find all products (return all columns) where the "brand" inside the JSONB column is exactly 'TechCorp'.
select * 
from products 
where attributes @> '{"brand":"TechCorp"}'

--Question 3: Checking for a specific key
--The attributes column is inconsistent. Write a query to find only the products that have a 
--"price" key in their JSON. (Hint: Look into the ? operator or check if the extracted text is not null).

select *
from products 
where attributes ? 'price'

--Question 4: Working with Arrays in JSONB
---Find all products that include "5G" inside their "features" array. (Hint: The @> containment operator is your best friend here, 
--as it can check if the entire JSON blob contains a specific key-value pair or array element).
select *
from products 
where attributes @> '{"features":["5G"]}'

--Question 5: Casting JSON text to SQL numbers
--Find the names of all products where the "price" inside the JSON is greater than 200. (Hint: Because ->> returns text, you will need to cast
--it to an integer or numeric type using ::numeric or CAST() before you can do math on it).
SELECT name 
FROM products 
WHERE (attributes ->> 'price')::numeric > 200;
