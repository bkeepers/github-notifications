class app.Views.Shortcuts extends Backbone.View
  el: document.body

  keyboardEvents:
    'j': 'next'
    'down': 'next'
    'k': 'prev'
    'up': 'prev'
    'g u': -> Backbone.history.navigate 'unread', trigger: true
    'g p': -> Backbone.history.navigate 'participating', trigger: true
    'g a': -> Backbone.history.navigate 'all', trigger: true

  next: (e) ->
    e.preventDefault()
    @select @collection.next() || @collection.first()

  prev: (e) ->
    e.preventDefault()
    @select @collection.prev() || @collection.last()

  select: (notification) ->
    Backbone.history.navigate "#n/#{notification.id}", trigger: true
