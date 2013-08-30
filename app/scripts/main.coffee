window.notifications =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'

    @collection = new this.Collections.NotificationsCollection()
    @router = new this.Routers.NotificationsRouter(collection: @collection)
    new this.Views.NotificationsView(collection: @collection)

    Backbone.history.start()

$ ->
  'use strict'
  notifications.init()

# GitHub authentication token
token = ""

jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader 'Accept', 'application/vnd.github+json'
  xhr.setRequestHeader 'Authorization', "token #{token}"
