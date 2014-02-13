class app.Views.Repositories extends Backbone.View
  el: '#repositories'

  initialize: =>
    @collection.fetch()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  add: (repository) ->
    view = new app.Views.Repository(model: repository)
    @$el.append view.render().el

  addAll: ->
    @collection.each(@add, @)
