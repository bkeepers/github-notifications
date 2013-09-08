class app.Views.Notification extends Backbone.View
  tagName: 'li'
  className: 'notification'
  template: JST['app/scripts/templates/notification.ejs']

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
    scroller = @$el.closest('#threads') # FIXME: replace with .scrollable class

    change = if (topOffset = @$el.offset().top) < 0
      topOffset
    else if (bottomOffset = topOffset + @$el.height() - scroller.height()) > 0
      bottomOffset

    scroller.scrollTop scroller.scrollTop() + change if change
