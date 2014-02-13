class app.Views.Repository extends Backbone.View
  template: JST['app/templates/repository.us']
  className: 'list'
  tagName: 'li'

  # Initialize the view
  #
  # Required options:
  # model - a comment
  initialize: (options) ->
    @listenTo @model, 'change', @render

  render: =>
    @$el.html @template(@model.toJSON())
    console.log 'huh?', @model.isSelected() 
    @$('a').addClass 'selected' if @model.isSelected()

    app.trigger 'render', @
    @
