# Exports an object that defines
#  all of the paths & globs that the project
#  is concerned with.
#
# The "configure" task will require this file and
#  then re-initialize the grunt config such that
#  directives like <config:files.js.app> will work
#  regardless of the point you're at in the build
#  lifecycle.
#
# You can find the parent object in: node_modules/lineman/config/files.coffee
module.exports = require(process.env["LINEMAN_MAIN"]).config.extend "files",
  coffee:
    app: [
      "app/js/lib/*.coffee",
      "app/js/app.coffee",
      "app/js/models/**/*.coffee",
      "app/js/views/comment.coffee",
      "app/js/**/*.coffee"
    ]

  js:
    vendor: [
      "vendor/bower/jquery/jquery.js",
      "vendor/bower/underscore/underscore.js",
      "vendor/bower/backbone/backbone.js",
      "vendor/bower/moment/moment.js",
      "vendor/bower/mousetrap/mousetrap.js",
      "vendor/bower/backbone.mousetrap/backbone.mousetrap.js",
      "vendor/bower/jQuery.scrollIntoView/jquery.scrollIntoView.js",
      "vendor/bower/fastclick/lib/fastclick.js",
      "vendor/bower/webcomponentsjs/CustomElements.js",
      "vendor/bower/time-elements/time-elements.js",
      "vendor/js/**/*.js"
    ]
    app: ["app/js/**/*.js"]

  css:
    vendor: [
      "vendor/bower/octicons/octicons/octicons.css",
      "vendor/bower/normalize-css/normalize.css",
      "vendor/css/**/*.css"
    ]
