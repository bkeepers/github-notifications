# A single Comment view
class app.Views.Comment extends Backbone.View
  template: JST['app/templates/comment.us']
  className: 'conversation-comment'

  keyboardEvents:
    'space': 'toggle'

  events:
    'click .conversation-meta': 'toggle'
    'focusin': 'select'
    'focusout': 'unselect'

  # Initialize the view
  #
  # Required options:
  # notification - the notification for this conversation
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

  # Returns true if comment was created since the notification was last read
  unread: ->
    last_read_at = @notification.get('last_read_at')
    !last_read_at || moment(last_read_at) < moment(@model.get('created_at'))

  # Toggle the expanded or collapsed state of the comment
  toggle: (e) ->
    e.preventDefault()
    @$el.toggleClass('collapsed expanded').scrollIntoView(20)

  # Select this comment
  select: ->
    @model.select()

  # Unselect this comment
  unselect: ->
    @model.collection.select null

  # This comment was selected
  selected: (previous) ->
    @bindKeyboardEvents()
    @$el.addClass('selected')

    if previous
      # Scroll into view if a previous comment was already selected
      @$el.scrollIntoView(20)
    else if @model != @model.collection.first()
      # Scroll to top if no previous comment was selected
      @$el.closest('.subject').prop 'scrollTop', @$el.position().top

  # This comment was unselected
  unselected: ->
    @unbindKeyboardEvents()
    @$el.removeClass('selected')

  # Only bind keyboard events if model is selected
  bindKeyboardEvents: ->
    super if @model.isSelected()
