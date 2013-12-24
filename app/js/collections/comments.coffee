class app.Collections.Comments extends Backbone.Collection
  model: app.Models.Comment

  initialize: (options) ->
    @url = options.url
