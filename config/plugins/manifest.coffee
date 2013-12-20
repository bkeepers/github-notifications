module.exports = (lineman) ->
  config:
    loadNpmTasks: lineman.config.application.loadNpmTasks.concat("grunt-manifest")

    appendTasks:
      dist: lineman.config.application.appendTasks.dist.concat("manifest")

    manifest:
      generate:
        options:
          basePath: './dist'
          hash: true
          verbose: false
          timestamp: false
          master: ['index.html']
        src: ["**/*.*"]
        dest: 'dist/manifest.appcache'
