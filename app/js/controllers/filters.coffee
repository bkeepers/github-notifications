class App.Controllers.Filters
  constructor: (options) ->
    @filters = options.filters
    @repositories = options.repositories
    @notifications = options.notifications

    @filters.on 'selected', @select
    @repositories.on 'selected', @select

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

  select: (filter) =>
    return unless filter
    @view.filter?.unselect()
    @view.filter = filter
    @view.load filter.filterOptions()
