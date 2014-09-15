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

  # An event aggrigator
  vent:  _.extend {}, Backbone.Events

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
      {id: 'everything', name: 'Everything', data: {}, octicon: 'inbox'},
      {id: 'participating', name: 'Participating', data: {participating: true}, reasons: ['mention', 'author', 'comment', 'state_change', 'assign'], octicon: 'mention'}
      {id: 'mentioned', name: 'Mentioned', data: {participating: true}, reasons: ['team_mention'], octicon: 'jersey'},
    ])

    @repositories = new App.Collections.Repositories()

    new App.Routers.Filters
      filters: @filters
      vent: @vent

    new App.Controllers.Filters
      filters: @filters
      repositories: @repositories
      vent: @vent

    new App.Routers.Notifications(@vent)
    new App.Controllers.Notification(@vent)

    new App.Views.Shortcuts(vent: @vent, repositories: @repositories)

    new App.Routers.Misc

    Backbone.history.start() unless Backbone.History.started

    Backbone.history.navigate 'everything', trigger: true

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
