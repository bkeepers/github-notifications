class App.Views.Timeline extends Backbone.View
  keyboardEvents:
    'n': 'selectNext'
    'p': 'selectPrevious'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @collection.on 'add sync', @scroll
    @addAll()

  add: (model) ->
    view = @viewFor(model)
    return unless view

    view.render()

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
      @collection.select unread, scroll: true

  viewFor: (model) ->
    view = if model instanceof App.Models.Event
      App.Views["TimelineEvent"]
    else if model instanceof App.Models.Subject.Commit
      App.Views.Timeline.Commit
    else if model.get('body_html')
      App.Views.Comment

    new view(model: model) if view

  selectNext: ->
    item = if @collection.selected
      @collection.next()
    else
      @collection.first()

    @collection.select item, scroll: true if item

  selectPrevious: ->
    item = if @collection.selected
      @collection.prev()
    else
      @collection.last()

    @collection.select item, scroll: true if item
