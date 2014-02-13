class app.Routers.Notifications extends Backbone.Router
  routes:
    'participating': 'participating'
    'starred': 'starred'
    'all': 'all'
    'r/:id': 'repository'
    'n/:id': 'show'

  initialize: (options)->
    @collection = options.notifications
    @repositories = options.repositories

    @on 'route', @selectItem

    @view = new app.Views.Threads(collection: @collection)
    @view.render()

  participating: ->
    @view.load(data: {participating: true})

  starred: ->
    @collection.reset(@collection.starred.toJSON())

  all: ->
    @view.load()

  repository: (id) ->
    model = @repositories.get(id)
    return unless model
    model.select()
    @view.load(url: model.notifications_url(), repository: model)

  show: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.NotificationDetailsView(model: model)

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    if (item = $('#lists').find("a[href='#{window.location.hash}']")).length
      $('#lists').find('.selected').removeClass('selected')
      item.addClass('selected')
