class App.Routers.Filters extends Backbone.Router
  routes:
    'r/:id': (id) -> @vent.trigger 'repository:select', id

  initialize: (options) ->
    @filters = options.filters
    @vent = options.vent

    @route(new RegExp("^(#{@filters.pluck('id').join('|')})$"), 'filter')
    @route(/^([\w\.\-]+\/[\w\.\-]+)$/, 'repository')

    @listenTo @vent, 'filter:selected', (model) =>
      @navigate "##{model.id}" if model

    @listenTo @vent, 'repository:selected', (model) =>
      @navigate "#/#{model.get('full_name')}" if model

  filter: (id) ->
    @vent.trigger 'filter:select', id
