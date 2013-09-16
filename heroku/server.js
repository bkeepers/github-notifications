var express = require('express');
var app = express();

function requireHTTPS(req, res, next) {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000');

  isSecure = req.secure || req.headers['x-forwarded-proto'] == 'https'

  if (!isSecure) {
    return res.redirect('https://' + req.get('host') + req.url);
  }
  next();
}

if(process.env.NODE_ENV == 'production') {
  app.use(requireHTTPS);
}

app.use(express.static(__dirname));
app.listen(process.env.PORT || 3000);
