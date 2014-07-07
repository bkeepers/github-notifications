class App.Views.Threads extends Backbone.View
  template: JST['app/templates/threads.us']
  className: 'pane loading'

  events:
    'change input[name=notifications-state]': 'stateChange'
    'click #mark-all-read': 'read'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenTo @collection, 'request', @startPaginating
    @listenTo @collection, 'sync', @donePaginating

    @listenToOnce @collection, 'sync', =>
      # FIXME: this should be bound in #render, but for some reason the scroll
      # event doesn't work when this is there.
      @$content = @$('.content').on('scroll', _.debounce(@paginate, 50))

      # FIXME: this belongs somewhere else
      $('#toggle-lists').attr('checked', false) # Collapse the menu on mobile

    @stateChange()

  render: ->
    @$el.html @template()
    app.trigger 'render', @
    @$list = @$('.notification-list')
    @

  add: (notification) ->
    view = new App.Views.Notification(model: notification)
    @$list.append(view.render().el)

  addAll: ->
    @$list.empty()
    @collection.each(@add, @)

  read: (e) ->
    e.preventDefault()
    if window.confirm("Are you sure you want to mark all these as read?")
      @collection.read()

  shouldShowAll: ->
    @$('input[name=notifications-state]:checked').val() == 'all'

  stateChange: ->
    @$el.addClass('loading')
    @collection.data.all = @shouldShowAll()
    @collection.fetch(reset: true).then(@paginate)

  paginate: =>
    return if @isPaginating || @collection.donePaginating || !@shouldPaginate()
    @collection.paginate().done(@paginate)

  shouldPaginate: ->
    @$content.children().height() - @$content.scrollTop() < @$content.height() + 300

  hide: ->
    @$el.detach()

  show: ->

  startPaginating: ->
    @isPaginating = true
    @$el.addClass('paginating')

  donePaginating: ->
    @isPaginating = false
    @$el.removeClass('loading paginating')
