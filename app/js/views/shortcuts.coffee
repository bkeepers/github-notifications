class App.Views.Shortcuts extends Backbone.View
  template: JST['app/templates/shortcuts.us']

  shortcuts:
    'Next Notification':
      keys: ['j', 'down']
      action: 'next'

    'Previous Notification':
      keys: ['k', 'up']
      action: 'prev'

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
    options.filters.each (filter) =>
      @shortcuts["Go to #{filter.get("name")}"] =
        key: "g #{filter.id.substr(0, 1)}"
        action: -> filter.select()

    @setElement document.body # otherwise it won't capture all the shortcuts

    @repositories = options.repositories
    @vent = options.vent

    for description, options of @shortcuts
      options.keys ||= [options.key]
      @keyboardEvents[key] = options.action for key in options.keys

    @render()

  next: (e) ->
    e.preventDefault()
    @vent.trigger 'notification:next'

  prev: (e) ->
    e.preventDefault()
    @vent.trigger 'notification:prev'

  nextRepo: (e) ->
    e.preventDefault()
    @vent.trigger 'repo:next'
    repo = @repositories.next() || @repositories.first()
    repo?.select()

  prevRepo: (e) ->
    e.preventDefault()
    @vent.trigger 'repo:prev'
    repo = @repositories.prev() || @repositories.last()
    repo?.select()

  select: (notification) ->
    notification?.select()

  render: ->
    @$('#shortcuts').html(@template(@))
    @

  help: ->
    @$('#shortcuts').toggle()

  toggleDevelopmentMode: ->
    app.toggleDevelopment()
