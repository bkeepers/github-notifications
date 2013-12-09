class app.Views.Threads extends Backbone.View
  el: '#threads'
  template: JST['app/templates/threads.us']

  events:
    'change input[name=notifications-state]': -> @load(@options)
    'click #mark-all-read': 'read'

  initialize: =>
    @options = {}
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll

  load: (@options = {}) ->
    @options.data ||= {}
    @options.data.all = @shouldShowAll()

    @collection.fetch _.extend({reset: true}, @options)

    # Collapse the menu on mobile
    $('#toggle-lists').attr('checked', false) # FIXME: this belongs somewhere else

  shouldShowAll: ->
    @$('input[name=notifications-state]:checked').val() == 'all'

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @

  add: (notification) ->
    view = new app.Views.Notification(model: notification)
    @$('.notification-list').append(view.render().el)

  addAll: ->
    @$('.notification-list').empty()
    @collection.each(@add, @)

  read: (e) ->
    e.preventDefault()
    @collection.read(@options)
