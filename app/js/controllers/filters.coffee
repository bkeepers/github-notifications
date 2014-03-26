class App.Controllers.Filters
  constructor: (options) ->
    @loadOptions = {}

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

    @view.on 'state', => @load(@loadOptions)
    @view.on 'read', => @notifications.read(@loadOptions)

  load: (@loadOptions = {}) ->
    @loadOptions.data ||= {}
    @loadOptions.data.all = @view.shouldShowAll()
    @notifications.fetch _.extend({reset: true}, @loadOptions)

  selectFilter: (filter) =>
    return unless filter
    @repositories.unselect()
    @load data: filter.get('data')

  selectRepository: (model) =>
    return unless model
    @filters.unselect()
    @load(url: model.notifications_url())
