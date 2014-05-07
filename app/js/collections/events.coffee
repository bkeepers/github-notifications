class App.Collections.Events extends Backbone.Collection
  model: App.Models.Event

  initialize: (models = [], options = {}) ->
    @subject = options.subject
