class app.Models.Repository extends Backbone.Model

  notifications: ->
    new app.Collections.Notifications([], url: @notifications_url())

  notifications_url: ->
    @get('notifications_url').replace(/\{.*\}/, '')
