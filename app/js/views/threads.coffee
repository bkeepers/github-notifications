class App.Views.Threads extends Backbone.View
  template: JST['app/templates/threads.us']
  className: 'pane'

  events:
    'change input[name=notifications-state]': 'stateChange'
    'click #mark-all-read': 'read'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenTo @collection, 'sync', ->
      # FIXME: this belongs somewhere else
      $('#toggle-lists').attr('checked', false) # Collapse the menu on mobile

    # Fetch more if filtered notifications don't fill the screen.
    @listenToOnce @collection, 'sync', @paginate

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$('.content').on 'scroll', _.debounce(@paginate, 50)
    @

  add: (notification) ->
    view = new App.Views.Notification(model: notification)
    @$('.notification-list').append(view.render().el)

  addAll: ->
    @$('.notification-list').empty()
    @collection.each(@add, @)

  read: (e) ->
    e.preventDefault()
    if window.confirm("Are you sure you want to mark all these as read?")
      @collection.read()

  shouldShowAll: ->
    @$('input[name=notifications-state]:checked').val() == 'all'

  stateChange: (e) ->
    @trigger 'state', $(e.target).val()

  paginate: =>
    @collection.paginate().done?(@paginate) if @shouldPaginate()

  shouldPaginate: ->
    content = @$('.content')
    content.children().height() - content.scrollTop() < content.height() + 200
