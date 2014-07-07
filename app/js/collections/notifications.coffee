class App.Collections.Notifications extends Backbone.Collection
  model: App.Models.Notification

  url: ->
    app.endpoints.api + 'notifications'

  # options.filter - a function that takes a model as an argument and returns
  #                  true if the model should be added to the collection.
  # options.data   - default params to use on the fetch request.
  initialize: (models, options = {}) ->
    @filter = options.filter if options.filter
    @data = options.data || {}
    @on 'reset', -> @select(undefined)

  # Default filter accepts all models
  filter: (model) -> true

  fetch: (options = {}) ->
    @oldestTimestamp = @donePaginating = null if options.reset
    options.data = _.extend({}, @data, options.data || {})
    super

  # Mark all notifications as read
  read: (options = {}) ->
    # FIXME: mark each notification read individually since collection is filtered
    options.data = '{}'
    @sync 'update', @, options unless app.isDevelopment()
    # Update the internal state of each notification
    @each (notification) -> notification.set 'unread', false

  # Fetch the previous page of notifications
  #
  # Returns false if last request returned zero notifications
  paginate: ->
    return $.Deferred.reject() if @donePaginating
    data = before: @oldestTimestamp?.toISOString()
    @fetch(reset: false, remove: false, data: data).done(@checkIfPaginated)

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
