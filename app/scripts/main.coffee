window.app =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    new this.Views.Authenticate()

  ready: ->
    $('#app').show()
    @collection = new this.Collections.Notifications()
    @router = new this.Routers.Notifications(collection: @collection)
    new this.Views.Notifications(collection: @collection)
    Backbone.history.start()

$ ->
  'use strict'
  app.init()

jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader 'Accept', 'application/vnd.github+json'
