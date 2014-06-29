class App.Controllers.Filters
  constructor: (options) ->
    @vent = options.vent
    @filters = options.filters
    @repositories = options.repositories

    @filters.on 'selected', (model) =>
      @repositories.unselect()
      @load(model)

    @repositories.on 'selected', (model) =>
      @filters.unselect()
      @load(model)

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

    @vent.on 'notification:select', @select
    @vent.on 'notification:next', @next
    @vent.on 'notification:prev', @prev

# FIXME: everything below this belongs in another controller
  next: =>
    model = @notifications.next() || @notifications.first()
    model?.select()

  prev: =>
    model = @notifications.prev() || @notifications.last()
    model?.select()

  select: (id) =>
    @notifications?.get(id)?.select()

  load: (filter) ->
    next unless filter
    @notifications = filter.notifications

    @notifications.on 'selected', (model) =>
      @vent.trigger 'notification:selected', model

    # TODO: cache views
    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

    @view.on 'state', => @load(filter)

    @notifications.fetch reset: true, data: {all: @view.shouldShowAll()}
