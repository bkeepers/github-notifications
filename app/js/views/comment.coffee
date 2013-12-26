class app.Views.Comment extends Backbone.View
  template: JST['app/templates/comment.us']
  className: 'conversation-comment'

  keyboardEvents:
    'space': 'toggle'

  events:
    'click .conversation-meta': 'toggle'
    'focusin': 'select'
    'focusout': 'unselect'

  initialize: (options) ->
    @notification = options.notification
    @listenTo @model, 'selected', @selected
    @listenTo @model, 'unselected', @unselected

  render: =>
    @$el.html @template(@model.toJSON())
    @$el.addClass if @unread() then 'expanded' else 'collapsed'
    @$el.attr('tabindex', 0) # Make it focusable
    app.trigger 'render', @
    @

  unread: ->
    last_read_at = @notification.get('last_read_at')
    !last_read_at || moment(last_read_at) < moment(@model.get('created_at'))

  # Only bind keyboard events if model is selected
  bindKeyboardEvents: ->
    super if @model.isSelected()

  toggle: (e) ->
    e.preventDefault()
    @$el.toggleClass('collapsed expanded')

  selected: ->
    @bindKeyboardEvents()
    @$el.addClass('selected')
    @$el.scrollIntoView(20)

  unselected: ->
    @unbindKeyboardEvents()
    @$el.removeClass('selected')

  select: ->
    @model.collection.select @model

  # Unselect model
  unselect: ->
    @model.collection.select null
