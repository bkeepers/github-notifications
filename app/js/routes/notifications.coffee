class App.Routers.Notifications extends Backbone.Router
  routes:
    'n/:id': 'show'

  initialize: (@vent) ->
    @listenTo @vent, 'notification:selected', (model) => @navigate "#n/#{model.id}" if model
    @listenTo @vent, 'notification:unselected', (model, selectedAnotherModel) =>
      @navigate "#n" unless selectedAnotherModel

  show: (id) ->
    @vent.trigger 'notification:select', id
