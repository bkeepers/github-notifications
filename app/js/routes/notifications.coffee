class App.Routers.Notifications extends Backbone.Router
  routes:
    'n/:id': 'show'

  initialize: (@collection) ->
    @collection.on 'selected', (model) => @navigate "#n/#{model.id}" if model

  show: (id) ->
    @collection.get(id)?.select()
