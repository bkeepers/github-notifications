class app.Collections.Repositories extends Backbone.Collection
  model: app.Models.Repository
  url: app.endpoints.api + 'notifications/repositories'

  parse: (response, options) ->
    for item in response
      item.repository.unread_count = item.unread_count
      item.repository

  poll: =>
    @fetch remove: false

  startPolling: (interval = 60 * 1000) ->
    setInterval @poll, interval
