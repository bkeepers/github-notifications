class App.Views.Timeline extends Backbone.View
  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @collection.on 'add sync', @scroll
    @addAll()

  add: (model) ->
    view = @viewFor(model).render()

    sibling = @$el.children().eq(@collection.indexOf(model))

    if sibling.length
      sibling.before(view.el)
    else
      @$el.append(view.el)

  addAll: ->
    @collection.each(@add, @)

  # Scroll to the first unread item
  scroll: =>
    return if @collection.selected
    if unread = @collection.detect((model) -> model.isUnread())
      unread.select(scroll: true)

  viewFor: (model) ->
    view = App.Views["Timeline" + model.constructor.name] || App.Views.Comment
    new view(model: model)
