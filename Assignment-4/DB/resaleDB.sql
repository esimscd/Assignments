CREATE DATABASE IF NOT EXISTS resale;

USE resale;

CREATE TABLE IF NOT EXISTS sale_items (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL (10,2) NOT NULL,
    size VARCHAR(10),
    item_cond ENUM('New', 'Good', 'Fair', 'Poor') NOT NULL
 );

SELECT * FROM sale_items;