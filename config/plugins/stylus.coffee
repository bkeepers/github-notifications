module.exports = (lineman) ->
  config:
    loadNpmTasks: lineman.config.application.loadNpmTasks.concat("grunt-contrib-stylus")

    prependTasks:
      common: lineman.config.application.prependTasks.common.concat("stylus")

    stylus:
      compile:
        use: [require("nib")]
        src: "app/css/app.styl"
        dest: "<%= files.stylus.generatedApp %>"

    clean:
      bower:
        src: "vendor/bower"

    bower:
      install:
        options:
          targetDir: "vendor/bower"
          cleanBowerDir: true

  files:
    stylus:
      main: "app/css/main.styl"
      vendor: "vendor/css/**/*.styl"
      app: "app/css/**/*.styl"
      import: "app/css"
      generatedVendor: "generated/css/vendor.styl.css"
      generatedApp: "generated/css/app.styl.css"
