const dbConfig = require('../config/db.config.js');
const mysql = require('mysql');


var con = mysql.createConnection({
    host: dbConfig.HOST,
    user: dbConfig.USER,
    password: dbConfig.PASSWORD,
    database: dbConfig.DB
});

con.connect(err =>{
    if(err) throw err;
    console.log("Succesfully connected");
});

module.exports = con;