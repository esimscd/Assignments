-- adding a new order placed by an existing customer
INSERT INTO orders (customer_ID, product_ID, order_total, order_date) 
VALUES (4, "DR001", 32.99, "2025-02-16");

-- check this has added successfully and display orders newest to oldest
SELECT *
FROM orders
ORDER BY order_date desc;

-- querying the orders table to find customers who have placed more than one order using aggregate function
SELECT customer_ID, COUNT(*) AS order_count
FROM orders
GROUP BY customer_ID
HAVING order_count > 1 
ORDER BY order_count;

-- using concatonate and Lcase to create product descriptions from item details
SELECT *, CONCAT(colour, " ", LCASE(product_type)) AS product_description
FROM products;

-- INNER JOIN of all 3 tables to show which customer IDs have placed orders, where from and what for
SELECT c.customer_ID, c.firstname, c.lastname, c.location, o.order_ID, o.order_total, p.product_type, p.colour
FROM orders o
INNER JOIN customers c 
ON o.customer_ID = c.customer_ID
INNER JOIN products p
ON o.product_ID = p.product_ID
ORDER BY customer_ID;

-- left join to find out which customers have signed up but not placed an order to send out promo code
SELECT c.customer_ID, c.firstname, c.lastname, c.email, o.order_ID
FROM customers c
LEFT JOIN orders o 
ON c.customer_ID = o.customer_ID
WHERE order_ID IS NULL
ORDER BY c.customer_ID;

-- left join to show which products have been ordered the most and to find which ones have not been ordered at all 
SELECT p.product_id, p.product_type, p.colour, COUNT(o.order_id) AS order_count
FROM products p 
LEFT JOIN orders o
ON p.product_id = o.product_ID
GROUP BY product_ID
ORDER BY order_count DESC;

-- we'll like want to calculate gross income at regular intervals so created a function to do so
DELIMITER //

CREATE FUNCTION gross_Income()
RETURNS DECIMAL(10,2)
DETERMINISTIC
	BEGIN
	DECLARE total_income DECIMAL(10,2);
	SELECT SUM(order_total)
	INTO total_income
	FROM orders;
	RETURN total_income;
END //

DELIMITER ;

-- call function to return gross income
SELECT gross_income() AS gross_income;

-- adding a new order 
INSERT INTO orders (customer_ID, product_ID, order_total, order_date) 
VALUES (8, "DR002", 34.99, "2025-02-20");

-- running again to see update
SELECT gross_income() AS gross_income;

-- checking most recent order number
SELECT *
FROM orders 
ORDER BY order_ID desc;

-- cancelling and deleting most recent order
DELETE FROM orders 
WHERE order_ID = 10;

-- the product range is growing quickly so a stored procedure could be useful to simplify the process of updating the products table
DELIMITER //

CREATE PROCEDURE addNewProduct (
IN product_ID VARCHAR(50),
IN product_type VARCHAR(50),
IN colour VARCHAR(50),
IN price DECIMAL(5,2)
)
BEGIN
INSERT INTO products (product_ID, product_type, colour, price)
VALUES (product_ID, product_type, colour, price);
END //

DELIMITER ;

-- testing function and inputing values
CALL addNewProduct ("DR004", "Midi dress", "White", 35.99);

-- seeing that new item was added
SELECT *
FROM products
ORDER BY product_id;