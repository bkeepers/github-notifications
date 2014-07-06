# Override lineman's webfonts config to pull fonts from bower
module.exports = (lineman) ->
  config:
    webfonts:
      files:
        "vendor/bower/octicons/octicons/": "vendor/bower/octicons/octicons/octicons.{ttf,eot,woff,svg}"
      root: "css"
