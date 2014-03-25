class App.Views.Repositories extends Backbone.View
  el: '#repositories'

  initialize: =>
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  add: (repository) ->
    view = new App.Views.Repository(model: repository)
    @$el.append view.render().el

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
