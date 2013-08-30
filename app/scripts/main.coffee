window.notifications =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'

    @collection = new this.Collections.Notifications()
    @router = new this.Routers.Notifications(collection: @collection)
    new this.Views.Notifications(collection: @collection)

    Backbone.history.start()

$ ->
  'use strict'
  notifications.init()

# GitHub authentication token
token = ""

jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader 'Accept', 'application/vnd.github+json'
  xhr.setRequestHeader 'Authorization', "token #{token}"
