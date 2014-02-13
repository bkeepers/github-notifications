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
      "app/js/app.coffee",
      "app/js/lib/*.coffee"
      "app/js/models/subject.coffee",
      "app/js/models/**/*.coffee",
      # FIXME: should be able to remove this next line before merging this branch
      "app/js/views/comment.coffee",
      "app/js/views/subject.coffee",
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
      "vendor/bower/backbone.localStorage/backbone.localStorage.js",
      "vendor/bower/jQuery.scrollIntoView/jquery.scrollIntoView.js",
      "vendor/bower/fastclick/lib/fastclick.js",
      "vendor/js/**/*.js"
    ]
    app: ["app/js/**/*.js"]

  css:
    vendor: [
      "vendor/bower/normalize-css/normalize.css",
      "vendor/css/**/*.css"
    ]

  webfonts:
    root: "css"
