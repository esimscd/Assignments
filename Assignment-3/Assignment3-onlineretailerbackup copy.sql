/* I work for a small online fashion retailer so I was thinking about the way that databases would be 
used in this industry and playing around with retreiving and manipulating data to complete essential tasks.
I kept it simple by not having lots of sizes for each product and just having one of each product ID, I've 
also kept it so that each order has only one product on it

*/

CREATE DATABASE online_shop;
CREATE TABLE customers (
	customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50),
    email VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    -- constraint to check valid email 
    CONSTRAINT chk_email CHECK (email LIKE "%@")
    );
    
CREATE TABLE products (
	product_ID VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE NOT NULL,
    price DECIMAL (5,2) NOT NULL
);

CREATE TABLE orders (
	order_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_ID INT NOT NULL,
    product_ID INT NOT NULL,
    order_total DECIMAL(10,2),
    order_date DATE,
    -- order table uses two foreign keys to link customers and products tables
    CONSTRAINT fk_customers FOREIGN KEY (customer_ID) REFERENCES customers(customer_ID),
    CONSTRAINT fk_products FOREIGN KEY (products_ID) REFERENCES products(product_ID)
    );
    
    
INSERT INTO customers (firstname, lastname, email, shipping_address) 
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

INSERT INTO products (product_ID, product_name, price) 
VALUES 
	("SK001", "Pink maxi skirt", 25.99),
    ("SK002", "Green skirt", 25.99),
    ("TO001", "Black top", 20.99),
    ("DR001", "Black dress", 29.99),
    ("DR002", "Pink dress", 29.99),
    ("DR003", "Black maxi dress", 35.99),
    ("TO002", "Green vest", 19.99),
    ("TO003", "Black vest", 19.99)
    ;
    
INSERT INTO orders (customer_ID, product_ID, 


	
    
    