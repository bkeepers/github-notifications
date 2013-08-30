class notifications.Collections.NotificationsCollection extends Backbone.Collection
  model: notifications.Models.NotificationModel
  url: 'https://api.github.com/notifications'
