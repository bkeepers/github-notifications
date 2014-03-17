class app.Collections.Notifications extends Backbone.Collection
  model: app.Models.Notification
  url: app.endpoints.api + 'notifications'

  initialize: ->
    @on 'reset', -> @select(undefined)

  # Mark all notifications as read
  read: (options = {}) ->
    options.data = '{}'
    @sync 'update', @, options unless app.isDevelopment()
    # Update the internal state of each notification
    @each (notification) -> notification.set 'unread', false
