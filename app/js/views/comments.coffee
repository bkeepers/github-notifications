# Manage list of comment views
class app.Views.Comments extends Backbone.View
  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @collection.on 'sync', @scroll
    @collection.fetch(reset: false, remove: false)
    @addAll()

  # Render the given commment
  add: (comment) ->
    view = new app.Views.Comment(model: comment)
    @$el.append(view.render().el)

  # Render all comments in the collection
  addAll: ->
    @collection.each(@add, @)

  # Scroll to the first unread comment
  scroll: =>
    return if @collection.selected
    if unread = @collection.detect((comment) -> comment.isUnread())
      unread.select(scroll: true)

