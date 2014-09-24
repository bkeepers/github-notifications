class App.Collections.Notifications extends Backbone.Collection
  model: App.Models.Notification
  pollInterval: 60 * 1000

  url: ->
    app.endpoints.api + 'notifications'

  # options.filter - a function that takes a model as an argument and returns
  #                  true if the model should be added to the collection.
  # options.data   - default params to use on the fetch request.
  initialize: (models, options = {}) ->
    @filter = options.filter if options.filter
    @data = options.data || {}
    @on 'reset', -> @select(undefined)
    @on 'sync', @savePollInterval

  # Default filter accepts all models
  filter: (model) -> true

  fetch: (options = {}) ->
    @oldestTimestamp = @donePaginating = null if options.reset
    options.data = _.extend({}, @data, options.data || {})
    # Only report success if response is modified
    options.ifModified = true

    # API uses If-Modified-Since to determine which notifications to fetch. We
    # want all of them if the collection is currently empty.
    unless @oldestTimestamp
      options.beforeSend = (xhr) =>
        xhr.setRequestHeader('If-Modified-Since', '')

    super

  # Mark each notification as read
  read: ->
    @invoke 'read'

  # Fetch the previous page of notifications
  #
  # Returns false if last request returned zero notifications
  paginate: ->
    return $.Deferred.reject() if @donePaginating
    data = before: @oldestTimestamp?.toISOString()
    @fetch(reset: false, remove: false, data: data).done(@checkIfPaginated)

  # Check for new notifications
  poll: =>
    clearTimeout @pollTimer
    @pollTimer = setTimeout @poll, @pollInterval

    @fetch(remove: false, reset: false)

  stopPolling: ->
    clearTimeout @pollTimer if @pollTimer

  checkIfPaginated: (data, options, xhr) =>
    @donePaginating = data.length == 0

  # Internal: Keep notifications in reverse-chronological order
  comparator: (model) ->
    -moment(model.get('updated_at')).valueOf()

  # Internal: Overriden to allow filtering out some models.
  _prepareModel: (attrs, options) ->
    model = super

    # Save timestamp of earliest notification we've seen, regardless of filter.
    updated_at = moment(model.get('updated_at'))
    if updated_at.isBefore(@oldestTimestamp || moment())
      @oldestTimestamp = updated_at

    model if @filter(model)

  # Internal: Save the poll interval returned from the API
  savePollInterval: (collection, _, options) ->
    if interval = options.xhr.getResponseHeader('X-Poll-Interval')
      @pollInterval = Number(interval) * 1000
