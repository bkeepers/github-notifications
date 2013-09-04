class app.Routers.Repositories extends Backbone.Router
  initialize: (options) =>
    @collection = options.collection

  routes:
    'r/all': 'redirectToNotificationsIndex'
    'r/:id': 'show'

  redirectToNotificationsIndex: ->
    Backbone.history.navigate "", trigger: true

  show: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.Notifications(collection: model.notifications())
