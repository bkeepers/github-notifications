class App.Controllers.Filters
  constructor: (options) ->
    @repositories = options.repositories
    @notifications = options.notifications

    @repositories.fetch()
    @repositories.startPolling()
    @repositories.on 'selected', @repository

    @view = new App.Views.Threads(collection: @notifications)
    @view.render()

    new App.Views.Lists(repositories: @repositories)

  participating: ->
    @view.load(data: {participating: true})

  all: ->
    @view.load()

  repository: (model) =>
    return unless model
    @view.load(url: model.notifications_url())
