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
    @notifications = new app.Collections.Notifications()

    new this.Views.Lists(repositories: @repositories)
    new this.Routers.Notifications(
      notifications: @notifications,
      repositories: @repositories
    )

    new this.Views.Shortcuts(collection: @notifications)

    Backbone.history.start()
    Backbone.history.navigate 'unread', trigger: true

  isDevelopment: ->
    localStorage['dev']?

$ ->
  'use strict'
  app.init()

$.ajaxSetup
  headers:
    'Accept': 'application/vnd.github.v3.html+json'
  # the Notifications API makes heavy use of the If-Modified-Since header for
  # determining what to respond with. This disables any HTTP caching until
  # proper local caching is implemented.
  cache: false
