_.extend Backbone.Collection.prototype,
  select: (model) ->
    previous = @selected
    @selected = model
    previous.trigger 'unselected' if previous
    model.trigger 'selected' if model
    @trigger 'selected', model, previous

  next: ->
    index = @indexOf(@selected)
    @at index + 1 if index >= 0

  prev: ->
    index = @indexOf(@selected)
    @at index - 1


_.extend Backbone.Model.prototype,
  select: ->
    @collection.select(@) if @collection
