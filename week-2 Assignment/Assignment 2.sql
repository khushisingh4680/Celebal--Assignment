Create database Ecommerce;
USE Ecommerce;
CREATE TABLE customers ( 
customer_id INT PRIMARY KEY, 
first_name VARCHAR(50) NOT NULL, 
last_name VARCHAR(50) NOT NULL, 
email VARCHAR(100) UNIQUE NOT NULL, 
city VARCHAR(50) NOT NULL, 
state VARCHAR(50) NOT NULL, 
join_date DATE NOT NULL, 
is_premium BOOLEAN DEFAULT FALSE );
CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state); 
CREATE TABLE products ( 
product_id INT PRIMARY KEY, 
product_name VARCHAR(100) NOT NULL, 
category VARCHAR(50) NOT NULL, 
brand VARCHAR(50) NOT NULL, 
unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0), 
stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0) 
);
CREATE INDEX idx_products_category ON products(category); 
CREATE TABLE orders ( 
order_id  INT PRIMARY KEY, 
customer_id INT NOT NULL, 
order_date DATE NOT NULL, 
status VARCHAR(20) NOT NULL DEFAULT 'Pending' 
CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0), 
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);
CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status); 
CREATE TABLE order_items ( 
item_id INT PRIMARY KEY, 
order_id INT NOT NULL, 
product_id INT NOT NULL, 
quantity INT NOT NULL CHECK (quantity > 0), 
unit_price DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
discount_pct DECIMAL(5,2) DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
FOREIGN KEY (order_id)  REFERENCES orders(order_id), 
FOREIGN KEY (product_id) REFERENCES products(product_id) 
);
INSERT INTO customers VALUES 
(101, 'Aarav', 'Sharma', 'aarav.s@email.com', 'Mumbai', 'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya', 'Patel', 'priya.p@email.com', 'Ahmedabad', 'Gujarat', '2024-02-20', FALSE), 
(103, 'Rohan', 'Gupta', 'rohan.g@email.com', 'Delhi', 'Delhi', '2024-03-10', TRUE), 
(104, 'Sneha', 'Reddy', 'sneha.r@email.com', 'Hyderabad', 'Telangana', '2024-04-05', FALSE), 
(105, 'Vikram','Singh', 'vikram.s@email.com', 'Jaipur', 'Rajasthan', '2024-05-12', TRUE), 
(106, 'Ananya','Iyer',  'ananya.i@email.com', 'Chennai','Tamil Nadu', '2024-06-18', FALSE), 
(107, 'Karan', 'Mehta', 'karan.m@email.com', 'Pune', 'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya', 'Nair', 'divya.n@email.com', 'Kochi', 'Kerala', '2024-08-30', FALSE);
SELECT * FROM customers;
INSERT INTO products VALUES 
(201, 'Wireless Earbuds', 'Electronics', 'BoAt', 1499.00, 250), 
(202, 'Cotton T-Shirt', 'Clothing', 'Levis', 799.00, 500), 
(203, 'Smart Watch', 'Electronics', 'Noise', 2999.00, 150), 
(204, 'Running Shoes', 'Clothing', 'Nike', 4599.00, 120), 
(205, 'Bluetooth Speaker', 'Electronics', 'JBL', 3499.00, 200), 
(206, 'Bedsheet Set', 'Home', 'Spaces', 1299.00, 300), 
(207, 'Laptop Stand', 'Electronics', 'AmazonBasics', 899.00, 180), 
(208, 'Cushion Covers (Set)', 'Home', 'HomeCenter', 599.00, 400);
SELECT * FROM products;
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered', 4498.00), 
(1002, 102, '2024-08-03', 'Delivered', 799.00), 
(1003, 103, '2024-08-05', 'Shipped', 7498.00), 
(1004, 101, '2024-08-10', 'Delivered', 3499.00), 
(1005, 104, '2024-08-12', 'Cancelled', 2999.00), 
(1006, 105, '2024-08-15', 'Delivered', 5898.00), 
(1007, 106, '2024-08-18', 'Pending', 1299.00), 
(1008, 103, '2024-08-20', 'Delivered', 899.00), 
(1009, 107, '2024-08-25', 'Shipped', 6098.00), 
(1010, 108, '2024-08-28', 'Delivered', 1598.00);
SELECT * FROM orders;
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00, 10), 
(5003, 1002, 202, 1, 799.00, 0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00, 0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00, 15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00, 0);
SELECT * FROM order_items;
#Q1. Write a query to display all columns and rows from the customer's table.
SELECT * FROM customers;

#Q2. Retrieve only the first_name, last_name, and city of all customers. 
SELECT first_name, last_name, city from customers;

#Q3. List all unique categories available in the products table. 
SELECT DISTINCT category FROM products;

#Q4. Identify the Primary Key of each table in the schema. Explain why a Primary Key must be unique and NOT NULL.
DESCRIBE customers;
# customer_id is a primary key
DESCRIBE orders;
#order_id is a primary key
DESCRIBE products;
#product_id is a primary key
DESCRIBE order_items;
#items_id is a primary key
# A primary key must be unique because it provides a unique value to each entry and it must have to be NOT NULL because each entry must have an identifier.

#Q5. What constraints are applied to the email column in the customers table? What would happen if you tried to insert a duplicate email? 
#UNIQUE and NOT NULL constraints are used in email so that every entry should be unique no one can use the same email id and it is mendatory to fill the email id due to NOT NULL constraint. If we enter duplicate email id, an error is generated for entering duplicate value.

#Q6. Try inserting a product with unit_price = -50. What happens and which constraint prevents it? Write both the INSERT statement and explain the error. 
INSERT INTO products (product_id, product_name, category, brand, unit_price, stock_qty) VALUES
(209, "AC", "Electronics", "Blue Star", -50, 200);
#It gives an error (Error Code: 3819. Check Constraint 'products_chk_1' is violated). This happens because there is a CHECK constraint on the unit_price column (CHECK (unit_price > 0)) and we have entered -50 which do not satisfy the condition, so it gives the error.

#Q7. Retrieve all orders with status = 'Delivered'.
SELECT * FROM orders WHERE status = 'Delivered';

#Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
SELECT * FROM products WHERE category = 'Electronics' AND unit_price > 2000;

#Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'.
SELECT * FROM customers WHERE YEAR(join_date) = 2024;

#Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled. 
SELECT * FROM orders WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'AND status <> 'Cancelled';

#Q11. Explain what the index idx_orders_date does. How would it improve the performance of a query that filters orders by order_date? Write a sample query that would benefit from this index. 
# The idx_orders_date index is used on the order_date column. It helps MySQL find orders by date faster. Because of the index, MySQL does not need to check every row in the table, which saves time
SELECT * FROM orders WHERE order_date = '2024-08-10';

#Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024; — would the index on join_date be used? Explain why or why not, and rewrite the query to be index-friendly (SARGable).
#No, the index on join_date will not be used because the YEAR() function is applied to the column. MySQL has to calculate the year for every row before checking the condition.
SELECT * FROM customers WHERE join_date BETWEEN '2024-01-01' AND '2024-04-05';

#Q13. Count the total number of orders in the orders table.
SELECT COUNT(order_id) FROM orders;

#Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders.
SELECT SUM(total_amount) AS TotalRevenue FROM orders WHERE status = 'Delivered';

#Q15. Calculate the average unit_price of products in each category.
SELECT AVG(unit_price) AS "AVG Price", category from products GROUP BY category;

#Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order. 
SELECT COUNT(order_id), SUM(total_amount) AS Total_revenue, status FROM orders GROUP BY status ORDER BY Total_revenue DESC;

#Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 
SELECT MAX(unit_price), MIN(unit_price) FROM products
GROUP BY category;

#Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause) 
SELECT category, AVG(unit_price) AS AVG_PRICE FROM products GROUP BY category HAVING AVG_PRICE > 2000;

#Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. Show: order_id, order_date, first_name, last_name, total_amount.
SELECT c.first_name,
c.last_name, 
o.order_id, 
o.order_date, 
o.total_amount 
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

#Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). Customers with no orders should still appear with NULL values for order columns.
SELECT * FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

#Q21. Write a query using JOINs across three tables (orders → order_items → products) to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 
SELECT o.order_id,
p.product_name,
oi.quantity,
oi.unit_price,
oi.discount_pct
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN products AS p
ON oi.product_id = p.product_id;

#Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When would you use a FULL OUTER JOIN? 
#LEFT JOIN is used to return all the values from the left table and matching values from the right table, if there is no match then it will return NULL value for the right columns.
SELECT c.customer_id, 
c.first_name, 
o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

#RIGHT JOIN is used to return all the values from the right table and matching values from the left table, if there is no match then it will return NULL value for the left columns.
SELECT c.customer_id, 
c.first_name, 
o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

#FULL OUTER JOIN is used when we want to return all the values from both right and left tables whether there is a match or not. For example if we want to see all customers and all orders including customers with no orders and orders with no matching customer then we will use FULL OUTER JOIN

#Q23. Identify all Foreign Key relationships in the schema. Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).
SELECT TABLE_NAME AS child_table,
COLUMN_NAME AS foreign_key_column,
REFERENCED_TABLE_NAME AS parent_table,
REFERENCED_COLUMN_NAME AS referenced_column
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME IS NOT NULL
AND TABLE_SCHEMA = DATABASE();
INSERT INTO orders VALUES(1011, 999, '2024-08-25', 'Shipped', 6098.00);
#When I tried to insert an order with customer_id = 999, MySQL generated an error: Error Code: 1452 - Cannot add or update a child row: a foreign key constraint fails. This happened because customer_id = 999 does not exist in the customers table.

#Q24. Write a query using CASE to classify products into price tiers: 
  #• 'Budget'    → unit_price < 1000 
 # • 'Mid-Range' → unit_price BETWEEN 1000 AND 3000 
  #• 'Premium'   → unit_price > 3000 
#Display: product_name, unit_price, price_tier. 
SELECT product_name, unit_price,
CASE 
WHEN unit_price<1000 THEN 'Budget'
WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
ELSE 'Premium'
END AS price_tier
FROM products;

#Q25. Using a CASE statement inside an aggregate function, count how many orders are 'Delivered' vs 'Not Delivered' (all other statuses). Display the result in a single row.
SELECT SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS Delivered_Orders,
SUM(CASE WHEN status != 'Delivered' THEN 1 ELSE 0 END) AS Not_Delivered_Orders
FROM orders;

#Q26. Explain each letter of ACID: 
  #• A – Atomicity 
  #• C – Consistency 
  #• I – Isolation 
  #• D – Durability 
# Give a real-world example (e.g., bank transfer) showing why each property is important. 
 #A - Atomicity
-- Atomicity means a transaction is completed fully or not done at all. If any part of the transaction fails, all changes are rolled back.
-- Example: When transferring ₹1000 from Account A to Account B, if the amount is deducted from A but cannot be added to B due to an error, the deduction is cancelled. This prevents loss of money.
#C - Consistency
-- Consistency ensures that the database remains valid before and after a transaction. All rules and constraints must be followed.
-- Example: After transferring ₹1000 from one account to another, the total money in the bank system should remain the same. No extra money should be created or lost.
#I - I – Isolation
-- Isolation means multiple transactions can run at the same time without affecting each other. One transaction should not interfere with another.
-- Example: If two people are transferring money at the same time, each transaction is processed independently so that the account balances remain correct.
#D - Durability
-- Durability means once a transaction is completed and saved, it will remain saved even if the system crashes.
-- Example: If a bank transfer is successful and the computer suddenly shuts down, the transaction will still be stored in the database when the system restarts.

#Q27. Write a SQL transaction that does the following atomically: 
  #1. Insert a new order (order_id=1011, customer_id=102, today's date, 'Pending', 1598.00) 
  #2. Insert two order items for that order 
  #3. Update the stock_qty of the purchased products 
 # 4. If any step fails, ROLLBACK the entire transaction. Otherwise, COMMIT. 
# Write the complete BEGIN...COMMIT/ROLLBACK block. 
START TRANSACTION;

INSERT INTO orders
VALUES (1011, 102, CURDATE(), 'Pending', 1598.00);

INSERT INTO order_items
VALUES (5016, 1011, 201, 1, 999.00, 0);

INSERT INTO order_items
VALUES (5017, 1011, 207, 1, 599.00, 0);

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 201;

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 207;

COMMIT;