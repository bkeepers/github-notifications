class app.Collections.Comments extends PaginatedCollection
  model: app.Models.Comment

  initialize: (models, options = {}) ->
    @last_read_at = options.last_read_at
