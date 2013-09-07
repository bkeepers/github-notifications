class app.Views.Shortcuts extends Backbone.View
  el: document.body # otherwise it won't capture all the shortcuts
  template: JST['app/scripts/templates/shortcuts.ejs']

  shortcuts:
    'Next Notification':
      keys: ['j', 'down']
      action: 'next'

    'Previous Notification':
      keys: ['k', 'up']
      action: 'prev'

    'Go to Unread notifications':
      key: 'g u'
      action: -> Backbone.history.navigate 'unread', trigger: true

    'Go to Participating notifications':
      key: 'g p'
      action: -> Backbone.history.navigate 'participating', trigger: true

    'Go to All notifications':
      key: 'g a'
      action: -> Backbone.history.navigate 'all', trigger: true

    'Open help for keyboard shortcuts':
      key: '?'
      action: 'help'

  initialize: ->
    @keyboardEvents = {}
    for description, options of @shortcuts
      options.keys ||= [options.key]
      @keyboardEvents[key] = options.action for key in options.keys

    @render()

  next: (e) ->
    e.preventDefault()
    @select @collection.next() || @collection.first()

  prev: (e) ->
    e.preventDefault()
    @select @collection.prev() || @collection.last()

  select: (notification) ->
    Backbone.history.navigate "#n/#{notification.id}", trigger: true

  render: ->
    @$('#shortcuts').html(@template(@))
    @

  help: ->
    @$('#shortcuts').toggle()
