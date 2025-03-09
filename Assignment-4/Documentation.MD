# Purpose of the API
This API allows a user to list items of clothing for sale, the database would be linked to a second-hand selling platform. The API has the basic functionality to let a user uploading new items, update the price on an existing listing, search for a single item by ID and delete an item from the database.

## Features and use case
* Get: list all items for sale
* Post: Upload an item
*

# Using the API
## How to set up
1. Clone the respository on to local machine 
2. Run SQL script to create the database in mySql 

        CREATE DATABASE IF NOT EXISTS resale;
   
        USE resale;

        CREATE TABLE IF NOT EXISTS sale_items (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        price DECIMAL (10,2) NOT NULL,
        size VARCHAR(10),
        item_cond ENUM('New', 'Good', 'Fair', 'Poor') NOT NULL
        );

3. Open the terminal inside the API folder
4. Run `npm init -y` in the terminal to install node and its dependencies locally
5. Rename env_example file to `.env` and fill in own credentials to link mySql, there is a template in the env_example file. More information on filling in each detail:

        DB_HOST= your host name
        USER_ID= your username/Id for mySql
        PASSWORD= your own password for mySql
        PORT= The port you'd like your server to run on 

There shouldn't be any quotation marks, commas

6. To run the file and start the server run the command `npm start` in the terminal, you'll know it is running when it tells you which server it is running on

## Different endpoints and their purpose
### Get request
There are two routes through which a get request can be carried out. 

* The route `/items` can list all items currently uploaded on to the site
    ![Successful get rquest retreiving list of all items](<Screenshot 2025-03-09 at 15.34.51.png>)

* `/items/:id` can show full details of a specific item when searched for by ID
    ![Screenshot of search by ID](<Screenshot 2025-03-09 at 15.57.14.png>)


### Post request
Post request lets a user upload a new item to the database and checks parameters for ENUM and DECIMAL

![Screenshot of post request](<Screenshot 2025-03-07 at 17.04.54.png>)

### Put 
