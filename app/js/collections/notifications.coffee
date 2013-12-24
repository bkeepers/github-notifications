class app.Collections.Notifications extends Backbone.Collection
  model: app.Models.Notification
  url: app.endpoints.api + 'notifications'

  initialize: ->
    @on 'reset', -> @select(undefined)
    @starred = new app.Collections.Starred()
    @starred.fetch()

  read: (options = {}) ->
    options.data = '{}'
    @sync 'update', @, options unless app.isDevelopment()
    @each (notification) -> notification.set 'unread', false
