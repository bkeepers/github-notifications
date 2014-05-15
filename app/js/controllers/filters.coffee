class App.Controllers.Filters
  constructor: (options) ->
    @filters = options.filters
    @repositories = options.repositories
    @notifications = options.notifications

    @filters.on 'selected', (model) =>
      @repositories.unselect()
      @select(model)

    @repositories.on 'selected', (model) =>
      @filters.unselect()
      @select(model)

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

  select: (filter) =>
    return unless filter
    @view.filter = filter
    @view.load filter.filterOptions()
