var express = require('express');
var app = express();

function requireHTTPS(req, res, next) {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000');

  if (!req.secure) {
    return res.redirect('https://' + req.get('host') + req.url);
  }
  next();
}

app.use(requireHTTPS);
app.use(express.static(__dirname));
app.listen(process.env.PORT || 3000);
