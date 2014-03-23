class App.Views.Shortcuts extends Backbone.View
  template: JST['app/templates/shortcuts.us']

  shortcuts:
    'Next Notification':
      keys: ['j', 'down']
      action: 'next'

    'Previous Notification':
      keys: ['k', 'up']
      action: 'prev'

    'Go to All notifications':
      key: 'g a'
      action: -> Backbone.history.navigate 'all', trigger: true

    'Go to Participating notifications':
      key: 'g p'
      action: -> Backbone.history.navigate 'participating', trigger: true

    'Open help for keyboard shortcuts':
      key: '?'
      action: 'help'

    'Next Repository':
      key: 'J'
      action: 'nextRepo'

    'Previous Repository':
      key: 'K'
      action: 'prevRepo'

    'Send Feedback':
      key: '!'
      action: -> Backbone.history.navigate 'feedback', trigger: true

  # Put undocumented shortcuts here
  keyboardEvents:
    'ctrl+`': 'toggleDevelopmentMode'

  initialize: (options) ->
    @setElement document.body # otherwise it won't capture all the shortcuts

    @repositories = options.repositories
    @notifications = options.notifications

    for description, options of @shortcuts
      options.keys ||= [options.key]
      @keyboardEvents[key] = options.action for key in options.keys

    @render()

  next: (e) ->
    e.preventDefault()
    @select @notifications.next() || @notifications.first()

  prev: (e) ->
    e.preventDefault()
    @select @notifications.prev() || @notifications.last()

  nextRepo: (e) ->
    e.preventDefault()
    repo = @repositories.next() || @repositories.first()
    Backbone.history.navigate "#r/#{repo.id}", trigger: true

  prevRepo: (e) ->
    e.preventDefault()
    repo = @repositories.prev() || @repositories.last()
    Backbone.history.navigate "#r/#{repo.id}", trigger: true

  select: (notification) ->
    notification?.select()

  render: ->
    @$('#shortcuts').html(@template(@))
    @

  help: ->
    @$('#shortcuts').toggle()

  toggleDevelopmentMode: ->
    app.toggleDevelopment()
