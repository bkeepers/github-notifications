class notifications.Collections.Notifications extends Backbone.Collection
  model: notifications.Models.Notification
  url: 'https://api.github.com/notifications'
