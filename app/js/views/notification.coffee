class app.Views.Notification extends Backbone.View
  tagName: 'li'
  className: 'notification'
  template: JST['app/templates/notification.us']

  initialize: ->
    @listenTo @model, 'unselected', @unselect
    @listenTo @model, 'selected', @select
    @listenTo @model, 'change', @render

  render: ->
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @

  unselect: ->
    @$el.removeClass('selected')

  select: ->
    @$el.addClass('selected')
    @scrollIntoView()

  scrollIntoView: =>
    @$el.scrollIntoView(100)
