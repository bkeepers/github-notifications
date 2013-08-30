class app.Collections.Notifications extends Backbone.Collection
  model: app.Models.Notification
  url: 'https://api.github.com/notifications'
