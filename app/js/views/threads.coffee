class App.Views.Threads extends Backbone.View
  template: JST['app/templates/threads.us']
  className: 'pane'

  events:
    'change input[name=notifications-state]': 'stateChange'
    'click #mark-all-read': 'read'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenToOnce @collection, 'sync', =>
      # Fetch more if filtered notifications don't fill the screen.
      setTimeout(@paginate, 1)

      # FIXME: this belongs somewhere else
      $('#toggle-lists').attr('checked', false) # Collapse the menu on mobile

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$content = @$('.content').on('scroll', _.debounce(@paginate, 50))
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
    return if @paginating || @collection.donePaginating || !@shouldPaginate()
    @paginating = true
    @collection.paginate().then(=> @paginating = false).done(@paginate)

  shouldPaginate: ->
    @$content.children().height() - @$content.scrollTop() < @$content.height() + 200
