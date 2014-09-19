class App.Views.Threads extends Backbone.View
  template: JST['app/templates/threads.us']
  className: 'loading'

  events:
    'change input[name=notifications-state]': 'stateChange'
    'click #mark-all-read': 'read'

  initialize: ->
    @listenTo @collection, 'add', @add
    @listenTo @collection, 'reset', @addAll
    @listenTo @collection, 'change:updated_at', @queueForSort

    @listenToOnce @collection, 'sync', =>
      # FIXME: this belongs somewhere else
      $('#toggle-lists').attr('checked', false) # Collapse the menu on mobile

    @listenTo @collection, 'request', @startPaginating
    @listenTo @collection, 'sync', @donePaginating

    @views = {}

  render: ->
    @$el.html @template()

    # Bind to scroll and non-standard mouse events to enable loading more when
    # content is not scrollable, such as when there are no notifications.
    @$content = @$('.content').on('scroll mousewheel DOMMouseScroll', _.debounce(@loadMore, 50))

    app.trigger 'render', @
    @$list = @$('.notification-list')
    @

  add: (model) ->
    # memoize view instances
    view = @views[model.id] ||= new App.Views.Notification(model: model).render()

    # Maintain view order by inserting it the new element before the element
    # that is currently in its place.
    sibling = @$list.children().eq(@collection.indexOf(model))
    if sibling.length
      sibling.before(view.el)
    else
      @$list.append(view.el)

  addAll: ->
    @$list.empty()
    @collection.each(@add, @)

  # When the collection is updated, the "change" event is fired on existing
  # models before the collection is sorted, so we wait for the "sort" event
  # before attempting to sort the views.
  queueForSort: (model) ->
    @collection.once 'sort', => @add(model)

  read: (e) ->
    e.preventDefault()
    if window.confirm("Are you sure you want to mark all these as read?")
      @collection.read()

  shouldShowAll: ->
    @$('input[name=notifications-state]:checked').val() == 'all'

  stateChange: ->
    @$el.addClass('loading')
    @collection.data.all = @shouldShowAll()
    @collection.fetch(reset: true).then(@loadMore)

  loadMore: =>
    return if @isLoading

    if @shouldPoll()
      @collection.poll()
    else if !@collection.donePaginating && @shouldPaginate()
      @collection.paginate().done(@loadMore)

  shouldPoll: ->
    @$content.scrollTop() == 0

  shouldPaginate: ->
    @$content.children().height() - @$content.scrollTop() < @$content.height() + 300

  hide: ->
    @$el.detach()
    @collection.stopPolling();

  show: ->
    @collection.data.all = @shouldShowAll()
    @collection.poll();

  startPaginating: (object) ->
    # Ignore model events
    return unless object == @collection

    @isLoading = true
    @$el.addClass('paginating')

  donePaginating: (object) ->
    # Ignore model events
    return unless object == @collection

    @isLoading = false
    @$el.removeClass('loading paginating')
