class App.Views.Filters extends View
  el: '#filters'

  initialize: ->
    @addAll()

  add: (model) ->
    @subview view = new App.Views.Filter(model: model)
    @$el.append view.render().el

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
