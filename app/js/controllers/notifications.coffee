class App.Controllers.Notifications
  constructor: (@vent, @notifications) ->
    _.extend @, Backbone.Events

    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

  next: ->
    model = @notifications.next() || @notifications.first()
    model?.select()

  prev: ->
    model = @notifications.prev() || @notifications.last()
    model?.select()

  select: (id) ->
    @notifications?.get(id)?.select()

  show: ->
    @listenTo @notifications, 'selected', (model) =>
      @vent.trigger 'notification:selected', model
    @listenTo @notifications, 'unselected', (unselected, selected) =>
      @vent.trigger 'notification:unselected', unselected, selected

    @listenTo @vent, 'notification:select', @select
    @listenTo @vent, 'notification:next', @next
    @listenTo @vent, 'notification:prev', @prev

    $('#threads').html(@view.el) # FIXME: replace with app layout
    @view.show()

  hide: ->
    @stopListening()
    @view.hide()
