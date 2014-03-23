class App.Routers.Notifications extends Backbone.Router
  # Cache for recently loaded notification views
  viewCache: new Cache(10)

  routes:
    'participating': 'participating'
    'all': 'all'
    'r/:id': 'repository'
    'n/:id': 'show'
    'feedback': 'feedback'

  initialize: (options)->
    @collection = options.notifications
    @repositories = options.repositories

    @on 'route', @selectItem

    @view = new App.Views.Threads(collection: @collection)
    @view.render()

  participating: ->
    @view.load(data: {participating: true})

  all: ->
    @view.load()

  repository: (id) ->
    model = @repositories.get(id)
    return unless model
    model.select()
    @view.load(url: model.notifications_url())

  show: (id) ->
    model = @collection.get(id)
    return unless model
    @notification?.hide()

    model.select()
    @notification = @viewCache.fetch model.cid,
      -> new App.Views.NotificationDetailsView(model: model)
    $('#details').html(@notification.el)
    @notification.show()

  feedback: ->
    view = new App.Views.Feedback
    view.render()

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    if (item = $('#lists').find("a[href='#{window.location.hash}']")).length
      $('#lists').find('.selected').removeClass('selected')
      item.addClass('selected')
