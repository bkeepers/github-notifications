class App.Views.Filters extends Backbone.View
  el: '#filters'
  template: JST['app/templates/filters.us']

  initialize: ->
    @render()

  render: ->
    @$el.html @template(filters: @collection.toJSON())
