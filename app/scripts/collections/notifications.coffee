class app.Collections.Notifications extends Backbone.Collection
  model: app.Models.Notification
  url: 'https://api.github.com/notifications'

  initialize: ->
    @on 'reset', -> @select(undefined)

  select: (model) ->
    previous = @selected
    @selected = model
    previous.trigger 'unselected' if previous
    @trigger 'selected', model, previous

  next: ->
    index = @indexOf(@selected)
    @at index + 1 if index >= 0

  prev: ->
    index = @indexOf(@selected)
    @at index - 1
