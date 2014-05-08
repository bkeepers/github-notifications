class App.Collections.Comments extends PaginatedCollection
  model: App.Models.Comment

  initialize: (models, options = {}) ->
    @subject = options.subject
