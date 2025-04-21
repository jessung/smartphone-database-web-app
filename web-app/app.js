const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const mustacheExpress = require('mustache-express');
const env = require('dotenv').config();

const app = express();
const port = 3000;

app.engine('html', mustacheExpress());
app.set('view engine', 'html');
app.set('views', './templates');
app.use(bodyParser.urlencoded({ extended: true }));

var dbcon = mysql.createConnection({
    host: env.parsed.HOST,
    user: env.parsed.USER_NAME,
    password: env.parsed.PASSWORD,
    database: env.parsed.DATABASE
})

function templateRenderer(template, res) {
    return function (error, results, fields) {
        if (error)
            throw error;

        res.render(template, { data: results });
        console.log("hiii", results);
    }
}

app.get('/', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT * FROM models;`, templateRenderer('index', res));
    dbcon.end();
})

app.get('/model/:id', function (req, res) {
    dbcon.connect();
    dbcon.query(`
        SELECT m.model, m.price, m.rating, pb.brand, p.num_cores, p.speed, os.os,
        b.battery_capacity, mem.ram_capacity, mem.internal_memory, s.screen_size
        FROM models m
        JOIN processors p
        ON m.processor_id=p.id
        JOIN processor_brands pb
        ON p.brand_id=pb.id
        JOIN os
        ON m.os_id=os.id
        JOIN battery b
        ON m.battery_id=b.id
        JOIN memory mem
        ON m.memory_id=mem.id
        JOIN screen s
        ON m.screen_id=s.id
        WHERE m.id = ${req.params.id};
    `, templateRenderer('modelinfo', res));
    dbcon.end();
})

app.get('/brands', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT * FROM brands;`, templateRenderer('brands', res));
    dbcon.end();
})

app.get('/brands/:id', function (req, res) {
    dbcon.connect();
    console.log(req.params)
    dbcon.query(`SELECT brands.brand, models.model
        FROM brands
        JOIN models
        ON brands.id=models.brand_id
        WHERE brands.id = ${req.params.id};`,
        templateRenderer('modellist', res));
    dbcon.end();
})

app.get('/os', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT * FROM os;`, templateRenderer('os', res));
    dbcon.end();
})

app.get('/os/:id', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT models.model
        FROM os
        JOIN models
        ON os.id=models.os_id
        WHERE os.id = ${req.params.id};`,
        templateRenderer('modellist', res));
    dbcon.end();
})

app.get('/processorbrands', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT * FROM processor_brands;`, templateRenderer('brands', res));
    dbcon.end();
})

app.get('/processorbrands/:id', function (req, res) {
    dbcon.connect();
    dbcon.query(`SELECT pb.brand, models.model
        FROM processor_brands pb
        JOIN processors p
        ON pb.id=p.brand_id
        JOIN models
        ON models.processor_id=p.id
        WHERE pb.id = ${req.params.id};`,
        templateRenderer('modellist', res));
    dbcon.end();
})

app.listen(port, function () {
    console.log('The app is listening at http://localhost:' + port + '.');
})