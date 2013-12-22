class app.Collections.Repositories extends Backbone.Collection
  model: app.Models.Repository
  url: app.api_endpoint + 'notifications/repositories'

  parse: (response, options) ->
    for item in response
      item.repository.unread_count = item.unread_count
      item.repository
