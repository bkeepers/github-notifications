class app.Collections.Repositories extends Backbone.Collection
  model: app.Models.Repository
  url: 'https://api.github.com/notifications/repositories'

  parse: (response, options) ->
    for item in response
      item.repository.unread_count = item.unread_count
      item.repository
