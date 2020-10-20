const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const Sale = require('./models/sale.model.js');

const app = express();

app.use(bodyParser.urlencoded({extended: true}));

app.get("/", (req, res) =>{
    res.sendFile(path.join(__dirname+ '/index.html'));
});

app.post("/getAll", (req, res) => {
    Sale.getAll((err, data) => {
        res.send(data);
    });
});

app.post("/sales", (req, res) => {
    Sale.deleteOne(req.body.id, (err, data) => {
        if(err){
            if(err.kind === "not_found"){
                res.status(404).send({errorMsg: "Not found."});
            }else{
                res.status(500).send({
                    errorMsg: "Could not delete"
                });
            } 
        }else{
            res.send({success: true});
        }
    });
});

app.listen(3000, () =>{
    console.log("Server is running on port 3000");
});