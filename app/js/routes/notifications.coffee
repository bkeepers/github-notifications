class App.Routers.Notifications extends Backbone.Router
  routes:
    'n/:id': 'show'

  initialize: (@vent) ->
    @listenTo @vent, 'notification:selected', (model) => @navigate "#n/#{model.id}" if model

  show: (id) ->
    @vent.trigger 'notification:select', id
