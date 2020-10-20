const sql = require('./db.js');

const Sale = function(sale){
    this.date = sale.date;
    this.rct = sale.rct;
    this.description = sale.description;
    this.quantity = sale.quantity;
    this.unit_price = sale.total_amount;
    this.vat = sale.vat;
};


Sale.create = {

};

Sale.getAll = result =>{
    sql.query("SELECT * FROM sales_table", (err, res) => {
        if(err){
            console.log("error: ", err);
            result(err, null);
            return;
        }
        result(null, res);
    });
};

Sale.deleteOne = (id, result) => {
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

module.exports = Sale;