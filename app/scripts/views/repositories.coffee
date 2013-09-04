class app.Views.Repositories extends Backbone.View
  el: '#repositories'
  template: JST['app/scripts/templates/repositories.ejs']

  events:
    'change select': 'change'

  initialize: =>
    @collection.fetch()
    @render()
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @

  add: (repository) ->
    @$('select').append("<option value='#{repository.id}'>#{repository.get("full_name")}</option>")

  addAll: ->
    @collection.each(@add, @)

  change: (e) ->
    Backbone.history.navigate "r/#{@$('select').val()}", trigger: true
