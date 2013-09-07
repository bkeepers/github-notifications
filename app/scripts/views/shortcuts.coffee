class app.Views.Shortcuts extends Backbone.View
  keyboardEvents:
    'j': 'next'
    'down': 'next'
    'k': 'prev'
    'up': 'prev'

  next: (e) ->
    e.preventDefault()
    @select @collection.next() || @collection.first()

  prev: (e) ->
    e.preventDefault()
    @select @collection.prev() || @collection.last()

  select: (notification) ->
    Backbone.history.navigate "#n/#{notification.id}", trigger: true
