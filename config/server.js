module.exports = {
  drawRoutes: function(app) {
    if(process.env.NODE_ENV == 'production') {
      app.use(requireHTTPS);
    }
  }
}

function requireHTTPS(req, res, next) {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000');

  var isSecure = req.secure || req.headers['x-forwarded-proto'] == 'https';

  if(isSecure) {
    return next();
  } else {
    return res.redirect("https://#{req.get('host')}#{req.url}");
  }
}
