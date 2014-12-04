class App.Views.Repositories extends View
  el: '#repositories'

  initialize: =>
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  add: (repository) ->
    @subview view = new App.Views.Repository(model: repository)
    @$el.append view.render().el

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
