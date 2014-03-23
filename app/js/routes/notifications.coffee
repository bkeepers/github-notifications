class app.Routers.Notifications extends Backbone.Router
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

    @view = new app.Views.Threads(collection: @collection)
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
    view = @viewCache.fetch model.cid,
      -> new app.Views.NotificationDetailsView(model: model)
    $('#details').html(view.el)

  feedback: ->
    view = new app.Views.Feedback
    view.render()

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    if (item = $('#lists').find("a[href='#{window.location.hash}']")).length
      $('#lists').find('.selected').removeClass('selected')
      item.addClass('selected')
