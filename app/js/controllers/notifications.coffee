class App.Controllers.Notifications
  # Cache for recently loaded notification views
  cache: new Cache(10)

  constructor: (@vent) ->
    @vent.on 'notification:selected', @show

  show: (notification) =>
    return unless notification
    @selected?.hide()

    @selected = @cache.fetch notification.cid,
      -> new App.Views.NotificationDetailsView(model: notification)
    # FIXME: replace with app layout
    $('#details').html(@selected.el)
    @selected.show()
