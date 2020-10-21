const sql = require('./db.js');
const dateformat = require('dateformat');

create = (reqBody, result) => {
    var date = dateformat(new Date, "yyyy-mm-dd");
    var rct = reqBody.rct;
    var description = reqBody.description;
    var quantity = reqBody.quantity;
    var unit_price = reqBody.unitprice;
    var total = quantity * unit_price;
    var vat = total * 0.18;
    sql.query("INSERT INTO sales_table set date = ?, rct = ?, description = ?, quantity = ?, unit_price = ?, total_amount = ?, vat = ?", 
        [date, rct, description, quantity, unit_price, total, vat]
    , (err, res) => {
        if(err){
            console.log(err);
            result(err, null);
            return;
        }
        result(null, {id: res.insertId});
    });
};

getAll = result =>{
    sql.query("SELECT * FROM sales_table", (err, res) => {
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

getUpdatesTable = result =>{
    sql.query("SELECT * FROM updates_table", (err, res) => {
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};
deleteOne = (id, result) => {
    sql.query("DELETE FROM sales_table where id = ?", id, (err, res) => {
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }
        if(res.affectedRows == 0){
            result({kind: "not_found"}, null);
            return;
        }
        console.log("Deleted successfully");
        result(null, res);
    });
};

update = (reqBody, id, result) => {
    var date = dateformat(new Date, "yyyy-mm-dd");
    var rct = reqBody.rct;
    var description = reqBody.description;
    var quantity = reqBody.quantity;
    var unit_price = reqBody.unitprice;
    var total = quantity * unit_price;
    var vat = total * 0.18;
    sql.query("UPDATE sales_table set date = ?, rct = ?, description = ?, quantity = ?, unit_price = ?, total_amount = ?, vat = ? WHERE id = ?", 
    [date, rct, description, quantity, unit_price, total, vat, id], (err, res) => {
        if(err){
            result(err, null);
        }
        result(null, res);
    });
};

module.exports = {create, getAll, deleteOne, update, getUpdatesTable};