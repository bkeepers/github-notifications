class app.Views.Notification extends Backbone.View
  tagName: 'li'
  className: 'notification'
  template: JST['app/scripts/templates/notification.ejs']

  initialize: ->
    @listenTo @model, 'selected', @select

  render: ->
    @$el.html @template(@model.toJSON())
    app.trigger 'render', @
    @

  select: =>
    $('#notifications .selected').removeClass('selected')
    @$el.addClass('selected');
