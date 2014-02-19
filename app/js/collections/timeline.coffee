class app.Collections.Timeline extends Backbone.Collection

  initialize: (models, options = {}) ->
    @last_read_at = options.last_read_at
    @collections = []

  comparator: (model) ->
    moment(model.get('created_at'))

  observe: (collection) ->
    @collections.push collection
    collection.on 'add',    (model) => @add(model)
    collection.on 'remove', (model) => @remove(model)

  fetch: (options) ->
    _.each @collections, (collection) ->
      collection.fetch() if collection.url
