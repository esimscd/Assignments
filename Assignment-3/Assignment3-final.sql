/* I work for a small online fashion retailer so I was thinking about the way that databases would be 
used in this industry and playing around with retreiving and manipulating data to complete essential task
This is currently a very simplified version in which there are not different sizes of each item and each
order contains only one item but I'd like to be able to make it more complex

*/

CREATE DATABASE online_shop;
USE online_shop;
CREATE TABLE customers (
	customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(50) NOT NULL,
    -- constraint to check valid email 
    CONSTRAINT chk_email CHECK (email LIKE "%@%")
    );
    

CREATE TABLE products (
	product_ID VARCHAR(50) PRIMARY KEY,
    product_type VARCHAR(50) NOT NULL,
    colour VARCHAR(50) NOT NULL,
    price DECIMAL (5,2) NOT NULL
);

CREATE TABLE orders (
	order_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_ID INT NOT NULL,
    product_ID VARCHAR(50) NOT NULL,
    order_total DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    -- order table uses two foreign keys to link customers and products tables
    CONSTRAINT fk_customers FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID),
    CONSTRAINT fk_products FOREIGN KEY (product_ID) REFERENCES products(product_ID)
    );
    
    
INSERT INTO customers (firstname, lastname, email, location) 
VALUES 
		("Bethany", "Jones", "bethj@example.co.uk", "London, UK"),
        ("Grace", "Holmes", "gh1@example.com", "Berlin, Germany"),
        ("Jack", "Miller", "jack@example.com", "Manchester, UK"),
        ("Olivia", "Dean", "o.dean@example.co.uk", "London, UK"),
        ("Lucas", "Baker", "lucas@example.com", "Boston, USA"),
        ("Sophia", "Turner", "turner@example.com", "Stockholm, Sweden"),
        ("Olivia", "Murphy", "olivia.murphy@example.com", "Manchester, UK"),
        ("Sami", "Fadhel", "samif@example.co.uk", "London, UK")
        ;


INSERT INTO products (product_ID, product_type, colour, price) 
VALUES 
	("SK001", "Maxi skirt", "Pink", 25.99),
    ("SK002", "Mini skirt", "Green",  25.99),
    ("TO001", "Top", "Black", 20.99),
    ("DR001", "Mini dress", "Black", 29.99),
    ("DR002", "Mini dress", "Pink" , 29.99),
    ("DR003", "Maxi dress", "Black" , 35.99),
    ("TO002", "Vest", "Green", 19.99),
    ("TO003", "Vest", "Black" , 19.99)
    ;
    

INSERT INTO orders (customer_ID, product_ID, order_total, order_date) 
VALUES 
	(2, "SK002", 27.99, "2024-05-20"),
    (4, "SK001", 28.99, "2024-06-16"),
    (4, "DR003", 40.00, "2024-07-05"),
    (1, "TO002", 25.99, "2024-03-16"), 
    (5, "SK002", 35.99, "2024-10-27"),
    (6, "DR003", 39.99, "2024-10-15"),
    (7, "DR002", 32.99, "2025-01-15"),
    (6, "TO001", 22.50, "2024-11-29")
    ;

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

SELECT *
FROM products
ORDER BY product_id;
