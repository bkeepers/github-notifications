class App.Views.Threads extends Backbone.View
  el: '#threads'
  template: JST['app/templates/threads.us']

  events:
    'change input[name=notifications-state]': 'stateChange'
    'click #mark-all-read': 'read'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenTo @collection, 'sync', ->
      # FIXME: this belongs somewhere else
      $('#toggle-lists').attr('checked', false) # Collapse the menu on mobile

  render: ->
    @$el.html @template()
    app.trigger 'render', @
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
