class @App
  @Models: {}
  @Collections: {}
  @Controllers: {}
  @Views: {}
  @Routers: {}

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
    new App.Models.Authentication @start

  # User is authenticated, start the main app.
  start: =>
    $('#app').show()

    @filters = new App.Collections.Filters([
      {id: 'all', name: 'All', data: {}, octicon: 'inbox'},
      {id: 'participating', name: 'Participating', data: {participating: true}, octicon: 'mention'}
    ])
    @repositories = new App.Collections.Repositories()
    @notifications = new App.Collections.Notifications()

    new App.Routers.Filters
      filters: @filters
      repositories: @repositories
    new App.Controllers.Filters
      filters: @filters
      repositories: @repositories
      notifications: @notifications

    new App.Routers.Notifications(@notifications)
    new App.Controllers.Notifications(@notifications)

    new App.Views.Shortcuts(
      repositories: @repositories,
      notifications: @notifications
    )

    new App.Routers.Misc

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
