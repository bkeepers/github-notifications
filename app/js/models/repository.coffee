class app.Models.Repository extends Backbone.Model

  notifications: ->
    new app.Collections.Notifications([], url: @notifications_url())

  notifications_url: ->
    @get('notifications_url').replace(/\{.*\}/, '')

  unread_count: ->
    count = @get('unread_count')
    count = '∞' if count > 999
    count

  toJSON: ->
    _.extend super, unread_count: @unread_count()
