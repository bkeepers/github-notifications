class app.Routers.Notifications extends Backbone.Router
  initialize: (options) =>
    @collection = options.collection

  routes:
    '': 'index'
    'n/:id': 'show'

  index: ->
    new app.Views.Notifications(collection: @collection)

  show: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.NotificationDetailsView(model: model)
