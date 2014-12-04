class @View extends Backbone.View
  constructor: ->
    @subviews = []
    super

  subview: (view) =>
    @subviews.push view
    view

  remove: ->
    super
    view.remove() for view in @subviews

  hide: ->
    @unbindKeyboardEvents()
    view.hide?() for view in @subviews
    @trigger('hide')

  show: ->
    @bindKeyboardEvents()
    view.show?() for view in @subviews
    @trigger('show')
