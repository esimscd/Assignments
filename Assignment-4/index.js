const express = require('express');
const mysql = require("mysql2")
const app = express();
const PORT = 3000;
app.use(express.json());

// Create a mysql connection pool
const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.USER_ID,
    password: process.env.PASSWORD,
    database: 'resale',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0 
});

//Check the server is running
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Get request to show all currently listed items
app.get('/items', (req, res) => {
    const sql = 'SELECT * FROM sale_items'
    pool.query(sql, (err, results) => {
        if (err) { 
            return res.status(500).json({error: `${err.message}`})
        }
        return res.status(200).json(results)
    })
});

//Get request for full info on a single item by Id
app.get('/items/:id', (req, res) => {
    const itemId = req.params.id
    const sql = 'SELECT * FROM sale_items WHERE id = ?'
    pool.query(sql, [itemId], (err, result) => {
        if (err) {
            return res.status(500).json({error:`${err}`})
        }
        if (result.length === 0){
            return res.status(404).json({error: `Item with ID ${itemId} does not exist`})
        }
        res.status(200).json(result[0])
    })
});

//Upload an item
app.post('/upload-item', (req,res) => {
    const { name, price, size, item_cond } = req.body
    if (!name || !price || !size || !item_cond) {
        return res.status(400).json({error: 'All fields are required'})
    }
    const sql = 'INSERT INTO sale_items (name, price, size, item_cond) VALUES (?, ?, ?, ?)'
    pool.query(sql, [name, price, size, item_cond], (err, result) => {
        if (err) {
            return res.status(500).json({error: `${err}`})
        }
        res.status(201).json({id:result.insertId, message: `${name} uploaded successfully`})
    })
});

//Put request to update price on a listed item 
app.put('/update-price/:id', (req, res) => {
    const itemId = req.params.id
    const { price } = req.body
    if (typeof price !== "number" || price <= 0){
        return res.status(400).json({error: 'Price must be a number over zero'});
    } // Check price input by user is a number above zero before running sql query 
    const sql = 'UPDATE sale_items set price = ? WHERE id = ?'
    pool.query(sql, [price, itemId], (err, result) => {
        if (err) {
            return res.status(500).json({error: `${err}`});
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({error: 'Item does not exist'});
        }
        res.status(200).json({message: `Price successfully updated to ${price} on item with ID: ${itemId}`})
    } )
});

//Delete request to remove single item by Id
app.delete('/delete-item/:id', (req, res) => {
    const itemId = req.params.id
    const sql = 'DELETE FROM sale_items WHERE id = ?'
    pool.query(sql, [itemId], (err, result) => {
        if (err) {
            return res.status(500).json({error:`${err}`})
        }
        else if (result.affectedRows === 0){
            return res.status(404).json({error: `Item with ID ${itemId} does not exist`})
        }
        res.status(200).json({message: `Item with ID ${itemId} removed`})
    })
});
