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
    @notifications = new this.Collections.Notifications()
    new this.Routers.Notifications(collection: @notifications)

    @repositories = new this.Collections.Repositories()
    new this.Routers.Repositories(collection: @repositories)
    new this.Views.Repositories(collection: @repositories)

    Backbone.history.start()
    Backbone.history.navigate '', trigger: true

$ ->
  'use strict'
  app.init()

jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader 'Accept', 'application/vnd.github+json'
