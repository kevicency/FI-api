#!/usr/bin/env nodemon -e js,ls

require('LiveScript');

var app = require('./lib/app');
var server = app.createServer();

var port = process.env.PORT || 3000;
server.listen(port);
console.log("Listening on port " + port);
