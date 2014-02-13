class app.Views.Repositories extends Backbone.View
  el: '#repositories'
  template: JST['app/templates/repository.us']

  initialize: =>
    @collection.fetch()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenTo @collection, 'change', @addAll

  add: (repository) ->
    @$el.append @template(repository.toJSON())

  addAll: ->
    @$el.empty()
    @collection.each(@add, @)
