window.app = _.extend {}, Backbone.Events,
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
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

    new this.Views.Shortcuts(
      repositories: @repositories,
      notifications: @notifications
    )

    Backbone.history.start()
    Backbone.history.navigate 'all', trigger: true

  isDevelopment: ->
    localStorage['dev']?

  update: ->
    window.applicationCache.update()

$ ->
  app.init()

$.ajaxSetup
  headers:
    'Accept': 'application/vnd.github.v3.html+json'

  # the Notifications API makes heavy use of the If-Modified-Since header for
  # determining what to respond with. This disables any HTTP caching until
  # proper local caching is implemented.
  cache: false

# Update app cache every 60 seconds and when leaving the page
setInterval app.update, 60 * 1000
$(window).on 'beforeunload', app.update
