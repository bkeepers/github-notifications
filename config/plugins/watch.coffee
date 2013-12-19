module.exports = (lineman) ->
  config:
    watch:
      js:
        files: ["<%= files.js.vendor %>", "<%= files.js.app %>"]
        tasks: ["concat_sourcemap:js"]

      coffee:
        files: "<%= files.coffee.app %>"
        tasks: ["coffee", "concat_sourcemap:js"]

      jsSpecs:
        files: ["<%= files.js.specHelpers %>", "<%= files.js.spec %>"]
        tasks: ["concat_sourcemap:spec"]

      coffeeSpecs:
        files: ["<%= files.coffee.specHelpers %>", "<%= files.coffee.spec %>"]
        tasks: ["coffee", "concat_sourcemap:spec"]

      css:
        files: ["<%= files.css.vendor %>", "<%= files.css.app %>"]
        tasks: ["concat_sourcemap:css"]

      stylus:
        files: ["<%= files.stylus.vendor %>", "<%= files.stylus.app %>"]
        tasks: ["stylus", "concat_sourcemap:css"]

      handlebars:
        tasks: ["handlebars", "concat_sourcemap:js"]

      underscore:
        tasks: ["jst", "concat_sourcemap:js"]
