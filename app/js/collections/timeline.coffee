class App.Collections.Timeline extends Backbone.Collection

  initialize: (models = [], options = {}) ->
    @subject = options.subject
    @collections = []

  comparator: (model) ->
    moment(model.get('created_at'))

  observe: (collection) ->
    @collections.push collection
    collection.on 'add',    (model) => @add(model)
    collection.on 'remove', (model) => @remove(model)

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
