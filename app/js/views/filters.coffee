class App.Views.Filters extends Backbone.View
  el: '#filters'

  initialize: ->
    @addAll()

  add: (model) ->
    view = new App.Views.Filter(model: model)
    @$el.append view.render().el

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
