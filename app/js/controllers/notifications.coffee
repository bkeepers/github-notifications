class App.Controllers.Notifications
  # Cache for recently loaded notification views
  cache: new Cache(10)

  constructor: (@vent) ->
    _.extend @, Backbone.Events
    @listenTo @vent, 'notification:selected', @show
    # @listenTo @collection, 'unselected', @hide

  show: (notification) =>
    return unless notification

    view = @cache.fetch notification.cid,
      -> new App.Views.NotificationDetailsView(model: notification)
    # FIXME: replace with app layout
    $('#details').html(view.el)
    view.show()

  hide: (model) ->
    @cache.get(model.cid)?.hide()
