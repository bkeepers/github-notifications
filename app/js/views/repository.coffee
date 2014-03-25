class App.Views.Repository extends Backbone.View
  template: JST['app/templates/repository.us']
  className: 'list'
  tagName: 'li'

  # Initialize the view
  #
  # Required options:
  # model - a comment
  initialize: (options) ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'unselected', @unselected
    @listenTo @model, 'selected', @selected

  render: =>
    @$el.html @template(@model.toJSON())
    @selected() if @model.isSelected()
    app.trigger 'render', @
    @

  unselected: ->
    @$('a').removeClass('selected')

  selected: ->
    @$('a').addClass('selected').scrollIntoView(100)
