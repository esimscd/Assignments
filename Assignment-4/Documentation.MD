# Clothing resale API

## Overview of the API
This API allows a user to list items of clothing for sale, the database would be linked to a second-hand selling platform. The database contains four input fields for the user: name, price, size and item condition. The database also auto-increments id. The API has the basic functionality to let a user upload new items, update the price on an existing listing, search for a single item by ID and delete an item from the database. 

# Using the API
## How to set up
1. Clone the respository on local
2. Run SQL script to create the database in mySql 

        CREATE DATABASE IF NOT EXISTS resale;
   
        USE resale;

        CREATE TABLE IF NOT EXISTS sale_items (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        price DECIMAL (10,2) NOT NULL,
        size VARCHAR(10) NOT NULL,
        item_cond ENUM('New', 'Good', 'Fair', 'Poor')
        );

3. Run `npm init -y` in the terminal to install node and its dependencies locally
4. Rename `env.example` file to `.env` and fill in own credentials to link mySql, there is a template in the env_example file. More information on filling in each detail:

        DB_HOST= your host name
        USER_ID= your username/Id for mySql
        PASSWORD= your own password for mySql
        PORT= The port you'd like your server to run on 

    There shouldn't be any quotation marks, commas or spaces between the = and your input

5. To run the file and start the server run the command `npm start` in the terminal, you'll know it is running when it tells you which server it is running on

# Different endpoints and their use cases
## Get request
There are two routes through which a get request can be carried out. 

* The route `/items` can list all items currently uploaded on to the site

    ![Successful get request retreiving list of all items](<img/Screenshot 2025-03-09 at 15.34.51.png>)

* `/items/:id` can show full details of a specific item when searched for by ID

   ![Screenshot of search by ID](<img/Screenshot 2025-03-09 at 15.57.14.png>)



## Post request
Post request lets a user upload a new item to the database. 

![alt text](<img/Screenshot 2025-03-10 at 18.37.30.png>)

There is a validation condition to check all fields are filled in. User must input a name, price, size and item condition.

![post request with validation](<img/Screenshot 2025-03-10 at 18.18.58.png>)

## Put request
Put request lets the user update item price. This could be adapted to update all fiels but price seems to be the one you'd want to update on a live listing. 

![update price on item](<img/Screenshot 2025-03-10 at 18.20.15.png>)

Validation also checks price is a number above zero.

![Error showing issue with input number](<img/Screenshot 2025-03-10 at 18.20.02.png>)

## Delete request
Lets user remove an item from the database

![Screenshot of item removed through delete req](<img/Screenshot 2025-03-09 at 11.48.05.png>)
