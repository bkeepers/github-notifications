var express = require('express');
var app = express();

require('./config/server').drawRoutes(app);

app.use(express.static(__dirname + '/dist'));
app.listen(process.env.PORT || 3000);
