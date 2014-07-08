module.exports = {
  drawRoutes: function(app) {
    if(process.env.NODE_ENV == 'production') {
      app.use(requireHTTPS);
    }

    app.get('/authenticate', function(req, res) {
      res.json({client_id: config.oauth_client_id, scope: config.oauth_scope});
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

var url = require('url'),
    https = require('https'),
    qs = require('querystring');
var fs = require('fs');

// Load config defaults from JSON file.
// Environment variables override defaults.
function loadConfig() {
  var local = __dirname + '/local.json',
      defaults = __dirname + '/defaults.json',
      path = fs.existsSync(local) ? local : defaults,
      config = JSON.parse(fs.readFileSync(path, 'utf-8'));

  for (var i in config) {
    config[i] = process.env[i.toUpperCase()] || config[i];
  }
  return config;
}

var config = loadConfig();

function authenticate(code, cb) {
  var data = qs.stringify({
    client_id: config.oauth_client_id,
    client_secret: config.oauth_client_secret,
    code: code
  });

  var reqOptions = {
    host: config.oauth_host,
    port: config.oauth_port,
    path: config.oauth_path,
    method: config.oauth_method,
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
