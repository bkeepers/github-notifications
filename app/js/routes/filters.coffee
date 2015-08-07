class App.Routers.Filters extends Backbone.Router
  routes:
    'filter/new': -> @vent.trigger 'filter:new'
    'filter/:id': (id) -> @vent.trigger 'filter:select', id
    'r/:owner/:login': (owner, login) ->
      @vent.trigger 'repository:select', "#{owner}/#{login}"

  initialize: (options) ->
    @vent = options.vent

    @listenTo @vent, 'filter:selected', (model) =>
      @navigate "#filter/#{model.id}" if model

    @listenTo @vent, 'repository:selected', (model) =>
      @navigate "#r/#{model.get('full_name')}" if model
