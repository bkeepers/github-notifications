window.app = _.extend {}, Backbone.Events,
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  ajax: $.ajax

  init: ->
    @auth()

  auth: ->
    new this.Models.Authentication()

  ready: ->
    $('#app').show()
    @repositories = new this.Collections.Repositories()
    @notifications = new this.Collections.Notifications()

    new this.Views.Lists(repositories: @repositories)
    new this.Routers.Notifications(
      notifications: @notifications,
      repositories: @repositories
    )

    new this.Views.Shortcuts(
      repositories: @repositories,
      notifications: @notifications
    )

    Backbone.history.start() unless Backbone.History.started

    Backbone.history.navigate 'all', trigger: true

  isDevelopment: ->
    localStorage['dev']?

  update: ->
    applicationCache.update() unless applicationCache.status == applicationCache.UNCACHED

# Initialize the app
$ -> app.init() unless window.jasmine?

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
