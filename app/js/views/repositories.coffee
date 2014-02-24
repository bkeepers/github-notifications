class app.Views.Repositories extends Backbone.View
  el: '#repositories'

  initialize: =>
    @collection.fetch()
    @collection.startPolling()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  add: (repository) ->
    view = new app.Views.Repository(model: repository)
    @$el.append view.render().el

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
