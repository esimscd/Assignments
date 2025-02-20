CREATE DATABASE online_retailer;
CREATE TABLE customers (
	customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    );
    
CREATE TABLE products (
);

CREATE TABLE orders (
	order_ID INT AUTO_INCREMENT PRIMARY KEY,
    customer_ID INT NOT NULL,
    product_ID INT NOT NULL,
    order_total DECIMAL(5,2),
    order_status 
    );
    