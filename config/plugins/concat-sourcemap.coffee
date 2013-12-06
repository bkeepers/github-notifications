module.exports = (lineman) ->
  config:
    loadNpmTasks: lineman.config.application.loadNpmTasks.concat("grunt-concat-sourcemap")

    appendTasks:
      common: lineman.config.application.prependTasks.common.concat("concat_sourcemap")

    removeTasks:
      common: lineman.config.application.removeTasks.common.concat("concat")

    concat_sourcemap:
      options:
        sourcesContent: true
      js:
        src: [
          "<banner:meta.banner>",
          "<%= files.js.vendor %>",
          "<%= files.template.generated %>",
          "<%= files.js.app %>",
          "<%= files.coffee.generated %>"
        ]
        dest: "<%= files.js.concatenated %>"

      spec:
        src: [
          "<%= files.js.specHelpers %>",
          "<%= files.coffee.generatedSpecHelpers %>",
          "<%= files.js.spec %>",
          "<%= files.coffee.generatedSpec %>"
        ]
        dest: "<%= files.js.concatenatedSpec %>"

      css:
        src: [
          "<%= files.stylus.generatedVendor %>",
          "<%= files.css.vendor %>",
          "<%= files.stylus.generatedApp %>",
          "<%= files.css.app %>"
        ]
        dest: "<%= files.css.concatenated %>"


