class App.Models.Filter extends Backbone.Model

  initialize: ->
    @notifications = new App.Collections.Notifications([], filter: @reasonFilter, data: @get('data'))

  reasonFilter: (model) =>
    !@get('reasons') || model.get('reason') in @get('reasons')
