const express = require('express');
const mysql = require("mysql2")
const app = express();
const PORT = 3000;
app.use(express.json());

// Create a mysql connection pool
const pool = mysql.createPool({
    host: 'localhost', //MySQL server host
    user: 'root', //MySQL user,
    password: 'Cfg123.4', //MySQL password
    database: 'resale',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0 
});


//Check the server is running
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

//Upload an item
app.post('/upload-item', (req,res) => {
    const { name, price, size, item_cond } = req.body
    const sql = 'INSERT INTO sale_items (name, price, size, item_cond) VALUES (?, ?, ?, ?)'
    pool.query(sql, [name, price, size, item_cond], (err, result) => {
        if (err) {
            return res.status(500).json({error: `${err}`})
        }
        res.status(201).json({id:result.insertId, message: `${name} uploaded successfully`})
    })
});


//Get request to show all currently listed items
app.get('/items', (req, res) => {
    const sql = 'SELECT * FROM items'

})



