class App.Controllers.Notifications
  # Cache for recently loaded notification views
  cache: new Cache(10)

  constructor: (@collection) ->
    @collection.on 'selected', @show

  show: (notification) =>
    return unless notification
    @selected?.hide()

    # notification.select()
    @selected = @cache.fetch notification.cid,
      -> new App.Views.NotificationDetailsView(model: notification)
    # FIXME: replace with app layout
    $('#details').html(@selected.el)
    @selected.show()
