class App.Routers.Filters extends Backbone.Router
  routes:
    'r/:id': 'repository'

  initialize: (options) ->
    @route /^(all|participating)$/, 'filter'

    @filters = options.filters
    @repositories = options.repositories

    @filters.on 'selected', (model) => @navigate "##{model.id}" if model
    @repositories.on 'selected', (model) => @navigate "#r/#{model.id}" if model

  filter: (id) ->
    @filters.get(id)?.select()

  repository: (id) ->
    @repositories.get(id)?.select()
