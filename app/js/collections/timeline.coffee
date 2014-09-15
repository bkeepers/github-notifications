class App.Collections.Timeline extends Backbone.Collection

  initialize: (models = [], options = {}) ->
    @subject = options.subject
    @collections = []

  comparator: (model) ->
    moment model.createdAt?() || model.get('created_at')

  observe: (collection) ->
    @collections.push collection
    collection.on 'add',    (model) => @add(model, silent: true)
    collection.on 'remove', (model) => @remove(model, silent: true)

    # Propagate all events
    collection.on 'all', => @trigger.apply(@, arguments)

    @on 'add',    (model) => @listenTo model, 'selected', @select
    @on 'remove', (model) => @stopListening model

  select: (model, options) =>
    super unless @selected == model

  fetch: (options) ->
    _.each @collections, (collection) ->
      collection.fetch() if collection.url

  # Don't add models to the timeline that don't want to be in it.
  _prepareModel: ->
    model = super
    return false if model.hideInTimeline?()
    model
