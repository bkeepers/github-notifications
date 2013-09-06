window.app = _.extend {}, Backbone.Events,
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    new this.Views.Authenticate()

  ready: ->
    $('#app').show()
    @repositories = new this.Collections.Repositories()

    new this.Views.Lists(repositories: @repositories)
    new this.Routers.Notifications(repositories: @repositories)

    Backbone.history.start()
    Backbone.history.navigate 'unread', trigger: true

$ ->
  'use strict'
  app.init()

$.ajaxSetup
  headers:
    'Accept': 'application/vnd.github.v3.html+json'
