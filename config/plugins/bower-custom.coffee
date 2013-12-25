module.exports = (lineman) ->
  lineman.config.application.bower.install.options.bowerOptions =
    production: true
  {}
