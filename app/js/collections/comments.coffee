class App.Collections.Comments extends PaginatedCollection
  model: App.Models.Comment

  initialize: (models, options = {}) ->
    @last_read_at = options.last_read_at
