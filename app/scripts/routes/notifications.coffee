class app.Routers.Notifications extends Backbone.Router
  initialize: (options) =>
    @collection = options.collection

  routes:
    'n/:id': 'notification'

  notification: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.NotificationDetailsView(model: model)
