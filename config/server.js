var dotenv = require("dotenv")
dotenv.load({path: ".env.local", silent: true}) // Load .env.local if it exists
dotenv.load()                                   // Get defaults from .env

module.exports = {
  drawRoutes: function(app) {
    if(process.env.NODE_ENV == 'production') {
      app.use(requireHTTPS);
    }

    app.get('/config', function(req, res) {
      res.json({
        api_url: process.env.API_URL,
        web_url: process.env.WEB_URL,
        client_id: process.env.OAUTH_CLIENT_ID,
        scope: process.env.OAUTH_SCOPE,
      });
    });

    app.post('/authenticate/:code', function(req, res) {
      authenticate(req.params.code, function(err, token) {
        if(err || !token) {
          res.status(406);
          res.json({"error": "bad_code"});
        } else {
          res.json({"token": token});
        }
      });
    });
  }
}

function requireHTTPS(req, res, next) {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000');

  var isSecure = req.secure || req.headers['x-forwarded-proto'] == 'https';

  if(isSecure) {
    return next();
  } else {
    return res.redirect("https://" + req.get('host') + req.url);
  }
}

var fs = require('fs');

var https = process.env.OAUTH_PORT == 443 ? require('https') : require('http'),
    qs = require('querystring');

function authenticate(code, cb) {
  var data = qs.stringify({
    client_id: process.env.OAUTH_CLIENT_ID,
    client_secret: process.env.OAUTH_CLIENT_SECRET,
    code: code
  });

  var reqOptions = {
    host: process.env.OAUTH_HOST,
    port: process.env.OAUTH_PORT,
    path: process.env.OAUTH_PATH,
    method: process.env.OAUTH_METHOD,
    headers: {
      'content-length': data.length
    }
  };

  var body = "";
  var req = https.request(reqOptions, function(res) {
    res.setEncoding('utf8');
    res.on('data', function(chunk) { body += chunk; });
    res.on('end', function() { cb(null, qs.parse(body).access_token); });
  });

  req.write(data);
  req.end();
  req.on('error', function(e) { cb(e.message); });
}
