class App.Controllers.Filters
  constructor: (options) ->
    @filters = options.filters
    @repositories = options.repositories
    @notifications = options.notifications

    @filters.on 'selected', @selectFilter
    @repositories.on 'selected', @selectRepository

    @repositories.fetch()
    @repositories.startPolling()

    new App.Views.Lists(repositories: @repositories, filters: @filters)

    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

  selectFilter: (filter) =>
    return unless filter
    @repositories.unselect()
    @view.load data: filter.get('data')

  selectRepository: (model) =>
    return unless model
    @filters.unselect()
    @view.load(url: model.notifications_url())
