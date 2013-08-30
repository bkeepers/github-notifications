window.notifications =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'
    new this.Views.NotificationsView
      collection: new this.Collections.NotificationsCollection()

$ ->
  'use strict'
  notifications.init()

# GitHub authentication token
token = ""

jQuery.ajaxPrefilter (options, originalOptions, xhr) ->
  xhr.setRequestHeader 'Accept', 'application/vnd.github+json'
  xhr.setRequestHeader 'Authorization', "token #{token}"
