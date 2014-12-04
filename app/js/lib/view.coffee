class @View extends Backbone.View
  constructor: ->
    @subviews = []
    super

  # Add a subview
  subview: (view) =>
    @subviews.push view
    view

  # Remove this view and all subviews
  remove: ->
    view.remove() for view in @subviews
    super

  # Hide this view and all subviews
  #
  # Triggers a "hide" event.
  hide: ->
    view.hide?() for view in @subviews
    @unbindKeyboardEvents()
    @trigger('hide', @)

  # Show this view and all subviews
  #
  # Triggers a "show" event.
  show: ->
    view.show?() for view in @subviews
    @bindKeyboardEvents()
    @trigger('show', @)
