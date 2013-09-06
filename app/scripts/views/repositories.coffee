class app.Views.Repositories extends Backbone.View
  el: '#repositories'
  template: JST['app/scripts/templates/repository.ejs']

  initialize: =>
    @collection.fetch()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  add: (repository) ->
    @$el.append @template(repository.toJSON())

  addAll: ->
    @collection.each(@add, @)
