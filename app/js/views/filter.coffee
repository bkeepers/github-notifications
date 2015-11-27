class App.Views.Filter extends Backbone.View
  template: JST['app/templates/filters/list_item.us']

  className: 'list'
  tagName: 'li'

  initialize: (options) ->
    @listenTo @model, 'unselected', @unselected
    @listenTo @model, 'selected', @selected
    @listenTo @model, 'changed', @render


  render: =>
    @$el.html @template(@model.toJSON())
    @selected() if @model.isSelected()
    app.trigger 'render', @
    @

  unselected: ->
    @$('a').removeClass('selected')

  selected: ->
    @$('a').addClass('selected').scrollIntoView(100)
