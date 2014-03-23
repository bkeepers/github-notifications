class App
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  ajax: $.ajax

  # FIXME: move to config
  endpoints:
    api: 'https://api.github.com/'
    web: 'https://github.com/'

  constructor: ->
    _.extend @, Backbone.Events

    $.ajaxSetup
      headers:
        'Accept': 'application/vnd.github.v3.html+json'

      # the Notifications API makes heavy use of the If-Modified-Since header for
      # determining what to respond with. This disables any HTTP caching until
      # proper local caching is implemented.
      cache: false

  # DOM is ready, initialize the App
  ready: =>
    $(document.body).addClass('standalone') if window.navigator.standalone
    @authenticate() unless window.jasmine?

  # Kick off authentication
  authenticate: ->
    new this.Models.Authentication @start

  # User is authenticated, start the main app.
  start: =>
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

  # Notifictions do not get marked as read when in development mode.
  isDevelopment: ->
    localStorage['dev']?

  toggleDevelopment: ->
    if localStorage['dev']
      localStorage.removeItem('dev')
      console.log 'Development mode disabled'
    else
      localStorage['dev'] = true
      console.log 'Development mode enabled'

window.app = new App()

# Initialize the app
$ app.ready
