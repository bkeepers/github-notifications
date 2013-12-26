# The view for a single notification in the list
class app.Views.Notification extends Backbone.View
  tagName: 'li'
  className: 'notification'
  template: JST['app/templates/notification.us']

  # Required options:
  # model - a notification object
  initialize: ->
    @listenTo @model, 'unselected', @unselected
    @listenTo @model, 'selected', @selected
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @

  unselected: ->
    @$el.removeClass('selected')

  selected: ->
    @$el.addClass('selected').scrollIntoView(100)
