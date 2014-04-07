class App.Controllers.Filters
  constructor: (options) ->
    @vent = options.vent
    @filters = options.filters
    @repositories = options.repositories

    @filters.on 'selected', @selectFilter
    @repositories.on 'selected', @selectRepository

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

    options.vent.on 'notification:select', @select
    options.vent.on 'notification:next', @next
    options.vent.on 'notification:prev', @prev

  selectFilter: (filter) =>
    return unless filter
    @repositories.unselect()
    @load filter.notifications

  selectRepository: (model) =>
    return unless model
    @filters.unselect()
    @load model.notifications

# FIXME: everything below this belongs in another controller
  next: =>
    model = @notifications.next() || @notifications.first()
    model?.select()

  prev: =>
    model = @notifications.prev() || @notifications.last()
    model?.select()

  select: (id) =>
    @notifications?.get(id)?.select()

  load: (@notifications) ->
    @notifications.on 'selected', (model) =>
      @vent.trigger 'notification:selected', model

    # @view?.remove()
    @view = new App.Views.Threads(collection: @notifications)
    @view.render()



    @view.on 'state', => @load(@notifications)

    @notifications.fetch reset: true, data: {all: @view.shouldShowAll()}
