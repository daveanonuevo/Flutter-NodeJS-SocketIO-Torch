const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const socket_io = require('socket.io');

const indexRouter = require('./routes/index');

const app = express();

const io = socket_io();
app.io = io;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use( (req, res, next) =>{
    res.header("Access-Control-Allow-Origin", "*"); // Tells browser to accept input from all domains
    next();
});

io.on("connection", (socket) => {
    console.log("SocketIO Connected");
    socket.emit("Connected");
});

app.use('/', indexRouter);

module.exports = {app, io};