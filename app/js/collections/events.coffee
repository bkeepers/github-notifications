class App.Collections.Events extends PaginatedCollection
  model: App.Models.Event

  initialize: (models = [], options = {}) ->
    @subject = options.subject
