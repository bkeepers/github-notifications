class app.Collections.Comments extends Backbone.Collection
  model: app.Models.Comment

  initialize: (models, options = {}) ->
    @last_read_at = options.last_read_at
