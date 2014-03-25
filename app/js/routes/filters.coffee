class App.Routers.Filters extends Backbone.Router
  routes:
    'participating': 'participating'
    'all': 'all'
    'r/:id': 'repository'

  initialize: (@collection) ->
    @collection.on 'selected', (model) => @navigate "#r/#{model.id}" if model

  repository: (id) ->
    @collection.get(id)?.select()
