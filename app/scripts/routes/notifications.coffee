class app.Routers.Notifications extends Backbone.Router
  routes:
    'unread': 'index'
    'participating': 'participating'
    'starred': 'starred'
    'all': 'all'
    'r/:id': 'repository'
    'n/:id': 'show'

  initialize: (options)->
    @collection = options.notifications
    @repositories = options.repositories

    @on 'route', @selectItem

    @view = new app.Views.Notifications(collection: @collection)
    @view.render()

  index: ->
    @collection.fetch reset: true

  participating: ->
    @collection.fetch reset: true, data: {participating: true, all: false}

  starred: ->
    @collection.reset(@collection.starred.toJSON())

  all: ->
    @collection.fetch reset: true, data: {all: true}

  show: (id) ->
    model = @collection.get(id)
    return unless model
    new app.Views.NotificationDetailsView(model: model)

  repository: (id) ->
    model = @repositories.get(id)
    return unless model
    @collection.fetch reset: true, url: model.notifications_url()

  # FIXME: total hack, but can't think of a better way to do it
  selectItem: ->
    if (item = $('#lists').find("a[href='#{window.location.hash}']")).length
      $('#lists').find('.selected').removeClass('selected')
      item.addClass('selected')
