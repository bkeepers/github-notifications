window.app = _.extend {}, Backbone.Events,
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    Backbone.history.start()
    @auth()

  auth: ->
    new this.Views.Authenticate()

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

    Backbone.history.navigate 'all', trigger: true

  isDevelopment: ->
    localStorage['dev']?

$ ->
  app.init()

$.ajaxSetup
  headers:
    'Accept': 'application/vnd.github.v3.html+json'

  # the Notifications API makes heavy use of the If-Modified-Since header for
  # determining what to respond with. This disables any HTTP caching until
  # proper local caching is implemented.
  cache: false

$(window).ajaxError (ev, xhr) ->
  # unset the token if the API responds with a 401, and try to re-authenticate.
  if xhr.status is 401
    localStorage['token'] = ""
    window.app.auth()
