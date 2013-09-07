class app.Collections.Notifications extends Backbone.Collection
  model: app.Models.Notification
  url: 'https://api.github.com/notifications'

  initialize: ->
    @on 'reset', -> @select(undefined)

  select: (model) ->
    @selected = model
    @trigger 'selected', model

  next: ->
    index = @indexOf(@selected)
    @at index + 1 if index >= 0

  prev: ->
    index = @indexOf(@selected)
    @at index - 1
