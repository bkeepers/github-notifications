# A single Comment view
class App.Views.Comment extends Backbone.View
  template: JST['app/templates/comment.us']
  className: 'conversation-comment'

  keyboardEvents:
    'space': 'toggle'

  events:
    'click .conversation-meta': 'toggle'
    'focusin':  -> @model.select()
    'focusout': -> @model.unselect()

  # Initialize the view
  #
  # Required options:
  # model - a comment
  initialize: (options) ->
    @listenTo @model, 'selected', @selected
    @listenTo @model, 'unselected', @unselected

  render: =>
    @$el.html @template(@model.toJSON())
    @$el.addClass if @model.isUnread() then 'expanded' else 'collapsed'
    @$el.attr('tabindex', 0) # Make it focusable
    app.trigger 'render', @
    @

  # Toggle the expanded or collapsed state of the comment
  toggle: (e) ->
    e.preventDefault()
    @$el.toggleClass('collapsed expanded')

  # This comment was selected
  selected: (model, previous, options = {}) ->
    @bindKeyboardEvents()
    @$el.addClass('selected')
    @scrollIntoView(previous) if options.scroll

  # This comment was unselected
  unselected: ->
    @unbindKeyboardEvents()
    @$el.removeClass('selected')

  # Only bind keyboard events if model is selected
  bindKeyboardEvents: ->
    super if @model.isSelected()

  # Scroll the comment into view.
  #
  # previous - the comment that was previously selected.
  scrollIntoView: (previous) ->
    if previous
      # Scroll into view if a previous comment was already selected
      @$el.scrollIntoView(50)
    else if @model != @model.collection.first()
      # Scroll to top if no previous comment was selected
      @$el.closest('.subject').prop 'scrollTop', @$el.position().top
