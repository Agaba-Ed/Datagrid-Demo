const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const mysql=require('mysql');
const dbConfig = require('./config/db.config.js');

//Creating connection
var con = mysql.createConnection({
    host: dbConfig.HOST,
    user: dbConfig.USER,
    password: dbConfig.PASSWORD,
    database: dbConfig.DB
});

//Obtaining database connection
con.connect(err =>{
    if(err) throw err;
    console.log("Succesfully connected");
});

const app=express();
app.use(bodyParser.urlencoded({extended: true}));

app.get("/", (req, res) =>{
    res.sendFile(path.join(__dirname+ '/index.html'));
});


//Creating new item..
app.post('/create',(req,res)=>{
    let sql='INSERT INTO sales_table SET ?';
    con.query(sql,req.body,(err,result)=>{
        if(err) throw err;
        console.log("Item added successfully..");
        res.send(result);
    }

    );
});

//Updating sales table
app.post('/sales/sale/',(req,res)=>{
    var row=req.body;
    var id=req.query.id;
    let sql='UPDATE sales_table SET ? WHERE id=?';
    con.query(sql,[row,id],(err,result)=>{
        if(err) throw err;
        console.log("Item updated successfully..");
        res.send(result);
    }

    );
});

//Getting all table data
//Searching if request has body
app.post('/getAll',(req,res)=>{
    var sql;
    var queryArray;
    if(req.body.startdate || req.body.description){
        var date_from = req.body.startdate;
        var date_to = req.body.enddate;
        var description = req.body.description;
        if(description === ''){
            sql = 'SELECT * FROM sales_table WHERE date BETWEEN ? AND ?';
            queryArray = [date_from, date_to];
        }else{
            sql = date_from === ''? 'SELECT * FROM sales_table WHERE DESCRIPTION LIKE ?':
                                    'SELECT * FROM sales_table WHERE DESCRIPTION LIKE ? AND date BETWEEN ? AND ?';
            queryArray = [description, date_from, date_to];
        }
        con.query(sql, queryArray, (err,result)=>{
        if(err) throw err;
        console.log("Date range data selected...");
        res.send(result);
        });
    }else{
        var sql ='SELECT * FROM sales_table';
        con.query(sql,(err,result)=>{
            if(err) throw err;
            console.log("Table 1 data selected..");
            var total = 0;
            var vatTotal = 0;
            result.forEach(element => {
                var el = element.total_amount;
                var vat = element.vat;
                total += el;
                vatTotal += vat;
            });
            result.push({quantity: "total", total_amount: total, vat: vatTotal});
            res.send(result);
        });
    }
});


app.post("/tableTwo", (req, res) => {
    let sql='SELECT * FROM updates_table';
    con.query(sql,(err,result)=>{
        if(err) throw err;
        console.log("Table 2 data selected..");
        res.send(result);
    }

    );
});

//Deleting item 
app.post("/sales", (req, res) => {
    let sql='DELETE FROM sales_table WHERE id=?';
    con.query(sql,req.body.id,(err,result)=>{
        if(err) throw err;
        console.log("Item deleted successfully...");
        res.send(result);
    }

    );
});

//Server connection...
app.listen(3000, () =>{
    console.log("Server is running on port 3000");
});
